import 'package:flutter/material.dart';
 
class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String placeholder;
  final Function(String)? onChanged;

  const CustomDropdown({
    super.key,
    required this.options,
    this.placeholder = "Select...",
    this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  String selected = "";
  String search = "";

  /// 🔁 Toggle Dropdown
  void toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      closeDropdown();
    }
  }

  /// ❌ Close
  void closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// 🧠 Create Overlay
  OverlayEntry _createOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: closeDropdown, // close on outside tap
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                offset: Offset(0, size.height + 6),
                child: Material(
                  color: Colors.transparent,
                  child: _buildDropdown(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🎨 Dropdown UI
  Widget _buildDropdown() {
    final filtered = widget.options
        .where((e) => e.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔍 Search
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (v) {
                setState(() => search = v);
              },
              decoration: InputDecoration(
                hintText: "Search...",
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// 🧹 Clear
          if (selected.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() => selected = "");
                  widget.onChanged?.call("");
                  closeDropdown();
                },
                child: const Text("Clear"),
              ),
            ),

          const Divider(height: 1),

          /// 📋 Options
          SizedBox(
            height: 160,
            child: filtered.isEmpty
                ? const Center(child: Text("No results"))
                : ListView.builder(
                    itemCount: filtered.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, i) {
                      final item = filtered[i];
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() => selected = item);
                          widget.onChanged?.call(item);
                          closeDropdown();
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Input Field
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: toggleDropdown,
        child: Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selected.isEmpty ? widget.placeholder : selected,
                style: TextStyle(
                  color: selected.isEmpty ? Colors.grey : Colors.black,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }
}