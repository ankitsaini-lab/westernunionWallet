import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/products/Contact%20Support%20screen/contact_Support_screen_Controller.dart';
import 'package:transwallet/widgets/custombutton.dart';

class ContactSupportScreenView extends GetView<ContactSupportScreenController> {
  const ContactSupportScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ContactSupportScreenController());
    const Color primaryRed = Color(0xFFE53935);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Customer Support",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.ticketCreated.value) {
            return _buildTicketSuccessScreen(context);
          }

          return _buildSupportFormScreen(context, primaryRed);
        }),
      ),
    );
  }

  Widget _buildSupportFormScreen(BuildContext context, Color primaryRed) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header visual - Pulsing Support Representative Agent Bubble
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const _PulsingSupportRing(),
                    Container(
                      height: 84,
                      width: 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryRed.withOpacity(0.08),
                        border: Border.all(
                          color: primaryRed.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.support_agent_rounded,
                        color: primaryRed,
                        size: 42,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Help Center",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF111111),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "We typically reply within 5–15 minutes",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Support Channels Horizontal List
          const Text(
            "Quick Channels",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF111111),
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 96,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                _buildChannelCard(
                  Icons.chat_bubble_outline_rounded,
                  "Live Chat",
                  "Active 24/7",
                  Colors.green,
                  () => _showQuickChannelSnackbar(
                    "Live Chat",
                    "Launching live chat session...",
                  ),
                ),
                _buildChannelCard(
                  Icons.email_outlined,
                  "Email Support",
                  "2 hour response",
                  Colors.blue,
                  () => _showQuickChannelSnackbar(
                    "Email",
                    "Opening compose email draft...",
                  ),
                ),
                _buildChannelCard(
                  Icons.phone_in_talk_outlined,
                  "Call Helpline",
                  "9 AM - 6 PM",
                  Colors.purple,
                  () => _showQuickChannelSnackbar(
                    "Helpline",
                    "Dialing customer care helpline...",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Message/Query Ticket Form Section
          const Text(
            "Create a Support Ticket",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF111111),
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFECECEC)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SELECT CATEGORY",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),

                // Category Chips List
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: controller.categories.map((category) {
                    return Obx(() {
                      final bool isSelected =
                          controller.selectedCategory.value == category;
                      return GestureDetector(
                        onTap: () {
                          controller.selectedCategory.value = category;
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.black
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 1.0,
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF4B5563),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
                const SizedBox(height: 24),

                const Text(
                  "EXPLAIN YOUR ISSUE",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),

                // Query Text Area
                TextFormField(
                  controller: controller.messageController,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111111),
                  ),
                  decoration: InputDecoration(
                    hintText:
                        "Describe what went wrong or enter your question here...",
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9CA3AF),
                      fontWeight: FontWeight.normal,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFECECEC)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFECECEC)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Submit Action Button
          CustomButton(
            text: "Submit Support Ticket",
            btncolor: Colors.black,
            isLoading: controller.isSubmitting.value,
            onPressed: () {
              controller.sendTicket();
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // --- TICKET CREATION SUCCESS RECEIPT SCREEN ---
  Widget _buildTicketSuccessScreen(BuildContext context) {
    return _TicketEntranceAnimation(
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ticket Header Checkmark Squircle
              Container(
                height: 74,
                width: 74,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2E7D32).withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                "Ticket Created Successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF111111),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Our team is investigating your query",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),

              // Physical Ticket cutout receipt summary stub
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFECECEC)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildTicketRow(
                            "Ticket ID",
                            controller.ticketId.value,
                            isPrimary: true,
                          ),
                          const SizedBox(height: 10),
                          _buildTicketRow(
                            "Category",
                            controller.selectedCategory.value,
                          ),
                          const SizedBox(height: 10),
                          _buildTicketRow(
                            "Status",
                            "Assigned • Processing",
                            isStatus: true,
                          ),
                        ],
                      ),
                    ),

                    // Dotted Stub Tear Divider Cutout
                    Row(
                      children: [
                        Container(
                          height: 16,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: List.generate(
                                18,
                                (index) => Expanded(
                                  child: Container(
                                    height: 1.2,
                                    color: index % 2 == 0
                                        ? Colors.transparent
                                        : const Color(0xFFECECEC),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 16,
                          width: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Bottom Ticket details - Message Content
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "YOUR MESSAGE SUMMARY",
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFECECEC),
                              ),
                            ),
                            child: Text(
                              controller.messageController.text,
                              style: const TextStyle(
                                color: Color(0xFF4B5563),
                                fontSize: 12,
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Action buttons
              CustomButton(
                text: "Back to Home",
                btncolor: Colors.black,
                onPressed: () {
                  Get.offAllNamed('/dashboard');
                },
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  controller.resetForm();
                },
                child: const Text(
                  "Create New Ticket",
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChannelCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFECECEC)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketRow(
    String title,
    String value, {
    bool isPrimary = false,
    bool isStatus = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isStatus
                ? Colors.green.shade700
                : (isPrimary
                      ? const Color(0xFF111111)
                      : const Color(0xFF4B5563)),
            fontSize: 12,
            fontWeight: (isPrimary || isStatus)
                ? FontWeight.bold
                : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showQuickChannelSnackbar(String channel, String msg) {
    Get.snackbar(
      channel,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF111111),
      colorText: Colors.white,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
    );
  }
}

class _PulsingSupportRing extends StatefulWidget {
  const _PulsingSupportRing();

  @override
  State<_PulsingSupportRing> createState() => _PulsingSupportRingState();
}

class _PulsingSupportRingState extends State<_PulsingSupportRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: 1.0 + (_controller.value * 0.7),
              child: Opacity(
                opacity: (1.0 - _controller.value).clamp(0.0, 1.0),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE53935).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TicketEntranceAnimation extends StatefulWidget {
  final Widget child;
  const _TicketEntranceAnimation({required this.child});

  @override
  State<_TicketEntranceAnimation> createState() =>
      _TicketEntranceAnimationState();
}

class _TicketEntranceAnimationState extends State<_TicketEntranceAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
