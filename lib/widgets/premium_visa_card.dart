import 'package:flutter/material.dart';

class PremiumVisaCard extends StatelessWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String? cvv; // Optional CVV parameter
  final bool isBlocked;
  final VoidCallback? onTap;
  final Widget?
  topRightAction; // Optional custom action widget for top-right (e.g. eye toggle)
  final String bgImage; // Background image asset path
  final bool useBlackLogos;
  final Color shadowColor; // Optional custom shadow color

  const PremiumVisaCard({
    Key? key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    this.cvv,
    this.isBlocked = false,
    this.onTap,
    this.topRightAction,
    this.bgImage = 'assets/unioncardblack.webp',
    this.useBlackLogos = false,
    this.shadowColor = const Color(0xFFFFCC00),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = useBlackLogos ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 85.60 / 53.98,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFFFD700).withOpacity(0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(isBlocked ? 0.05 : 0.18),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                isBlocked ? Colors.grey : Colors.transparent,
                BlendMode.saturation,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double cardWidth = constraints.maxWidth;
                  // Baseline card width for design is ~340. Scale down dimensions on smaller screens.
                  final double scale = (cardWidth / 340.0).clamp(0.65, 1.0);

                  return Stack(
                    children: [
                      // 1. Dark Gradient Card Background
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF141416), Color(0xFF08080A)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),

                      // 2. Premium Card Background Image
                      Positioned.fill(
                        child: Image.asset(bgImage, fit: BoxFit.cover),
                      ),

                      // 3. Subtle gold curved design element on the right edge
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 8 * scale,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFFD700).withOpacity(0.0),
                                const Color(0xFFFFD700).withOpacity(0.35),
                                const Color(0xFFFFD700).withOpacity(0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * scale,
                          vertical: 16 * scale,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/WU.png',
                                  height: 22 * scale,
                                  fit: BoxFit.contain,
                                  color: useBlackLogos ? Colors.black : null,
                                ),
                                Image.asset(
                                  'assets/WHITE TRANSCORP .png',
                                  height: 14 * scale,
                                  fit: BoxFit.contain,
                                  color: useBlackLogos ? Colors.black : null,
                                ),
                              ],
                            ),

                            // --- BOTTOM SECTION ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Holder Name
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cardHolder.toUpperCase(),
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 14 * scale,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/VisaFree.png',
                                      height: 18 * scale,
                                      fit: BoxFit.contain,
                                      color: useBlackLogos
                                          ? Colors.black
                                          : null,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // 4. Blocked Status Overlay Banner
                      if (isBlocked)
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.35),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16 * scale,
                                  vertical: 8 * scale,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.block,
                                      color: Colors.white,
                                      size: 16 * scale,
                                    ),
                                    SizedBox(width: 6 * scale),
                                    Text(
                                      "CARD BLOCKED",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12 * scale,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
