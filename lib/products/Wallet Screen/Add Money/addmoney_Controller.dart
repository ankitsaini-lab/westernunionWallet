import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:transwallet/widgets/custombutton.dart';

class AddmoneyController extends GetxController {
  var balance = 1600.0.obs;
  var enteredAmount = '50'.obs;
  var sliderValue = 50.0.obs;
  var isCustom = false.obs;
  var isProcessing = false.obs;
  var showSuccess = false.obs;

  final LocalAuthentication auth = LocalAuthentication();

  TextEditingController customController = TextEditingController();
  FocusNode customFocus = FocusNode();

  double get amount =>
      double.tryParse(enteredAmount.value.isEmpty ? "0" : enteredAmount.value) ?? 0;

  String formatAmount(String value) {
    if (value.isEmpty) return "0";
    final number = int.tryParse(value) ?? 0;
    return number.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ",");
  }

  double getFontSize(String value) {
    if (value.length > 9) return 24;
    if (value.length > 7) return 24;
    return 27;
  }

Future<bool> authenticate() async {
  try {
    final canCheck = await auth.canCheckBiometrics;

    if (!canCheck) return false;

    return await auth.authenticate(
      localizedReason: 'Confirm payment',
      biometricOnly: true,
      // stickyAuth: true,
    );
  } catch (_) {
    return false;
  }
}
bool isTesting = true;
Future<void> payNow() async {
  if (amount <= 0) return;

  isProcessing.value = true;
  HapticFeedback.mediumImpact();

  bool ok = isTesting ? true : await authenticate();

  if (ok) {
    HapticFeedback.heavyImpact();
    balance.value += amount;
    // showSuccess.value = true;

    await Future.delayed(const Duration(milliseconds: 1200));
   Get.to(() => PaymentReceiptView(
      amount: amount,
      balance: balance.value,
));
  } else {
    Get.snackbar("Failed", "Authentication required");
  }

  isProcessing.value = false;
}

  Widget circleBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(icon),
      ),
    );
  }
}
class PaymentReceiptView extends StatelessWidget {
  final double amount;
  final double balance;

  const PaymentReceiptView({
    super.key,
    required this.amount,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final txnId = DateTime.now().millisecondsSinceEpoch.toString();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),

            const SizedBox(height: 20),

            const Text(
              "Payment Successful",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "₹${amount.toStringAsFixed(0)}",
              style: const TextStyle(
                  fontSize: 36, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  row("Status", "Success"),
                  row("Txn ID", txnId),
                  row("Date", DateTime.now().toString().substring(0, 16)),
                  row("Payment Mode", "Wallet"),
                  row("Updated Balance", "₹${balance.toStringAsFixed(0)}"),
                ],
              ),
            ),

            const SizedBox(height: 40),
CustomButton(text: "Done", btncolor: Colors.black, onPressed: () {
   Get.offAllNamed('/dashboard');
},)

             
          ],
        ),
      ),
    );
  }

  Widget row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(title, style: const TextStyle(color: Colors.black54)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}