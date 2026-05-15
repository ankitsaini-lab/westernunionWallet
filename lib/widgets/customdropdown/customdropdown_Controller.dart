import 'package:get/get.dart';

class CustomdropdownController extends GetxController {
 var isOpen = false.obs;
  var selected = ''.obs;
  var searchText = ''.obs;

  List<String> options = [];

  List<String> get filteredOptions {
    final filtered = options
        .where((item) =>
            item.toLowerCase().contains(searchText.value.toLowerCase()))
        .toList();

    return filtered;
  }

  void toggleDropdown() {
    isOpen.value = !isOpen.value;
  }

  void selectItem(String value) {
    selected.value = value;
    isOpen.value = false;
    searchText.value = '';
  }

  void clearSelection() {
    selected.value = '';
    isOpen.value = false;
    searchText.value = '';
  }

  void setOptions(List<String> data) {
    options = data;
  }
}