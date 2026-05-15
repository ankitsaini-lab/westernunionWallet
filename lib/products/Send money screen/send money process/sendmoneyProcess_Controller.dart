import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/custombutton.dart';

class SendmoneyprocessController extends GetxController {
  var balance = 1600.0.obs;
var enteredAmount = ''.obs;
var isLoading = false.obs;

 
double get amount {
  String cleaned = enteredAmount.value.replaceAll(',', '');
  return double.tryParse(cleaned.isEmpty ? "0" : cleaned) ?? 0;
}

void setAmount(String value) {
  log("check value >> $value"); 
  String current = enteredAmount.value;

 
  if (value == "back") {
    if (current.isNotEmpty) {
      enteredAmount.value = current.substring(0, current.length - 1);
    }
    return;
  }

   
  if (value == "," && current.contains(",")) return;

  
  if (current == "0" && value == "0") return;

 
  if (current == "0" && value != ",") {
    enteredAmount.value = value;
    return;
  }

 
  enteredAmount.value += value;
}
 void setPreset(int value) {
  enteredAmount.value = value.toString();
}

   
 Future<void> addMoney() async {
  if (amount <= 0) return;

  double addedAmount = amount;

  
  Get.to(() => PaymentProcessingScreen());

  isLoading.value = true;

  await Future.delayed(const Duration(seconds: 2));

  balance.value += addedAmount;
  enteredAmount.value = '';

  isLoading.value = false;

 
  Get.off(() => PaymentSuccessScreen(
        amount: addedAmount,
      ));
}

  
Widget keyButton(String value) {
  return GestureDetector(
    onTap: () => setAmount(value),
    child: Container(
      alignment: Alignment.center,
      child: value == "back"
          ? const Icon(Icons.backspace_outlined)
          : Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
    ),
  );
}
  Widget presetButton(String label, int value) {
    return GestureDetector(
      onTap: () =>  setPreset(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label),
      ),
    );
  }

}
class PaymentProcessingScreen extends StatelessWidget {
  const PaymentProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              "Payment processing...",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 40),
            Text(
              "Please don’t press back or close the app",
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
class PaymentSuccessScreen extends StatefulWidget {
  final double amount;

  const PaymentSuccessScreen({super.key, required this.amount});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Get.off(  () => PaymentafterSuccessScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check,
                      color: Colors.white, size: 60),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Payment Successful!",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Text(
                  "₹${widget.amount.toStringAsFixed(2)} added to wallet",
                  style:
                      const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//////////////
 

class PaymentafterSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),

              // Success Icon
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.green,
                child: Icon(Icons.check, color: Colors.white, size: 40),
              ),

              SizedBox(height: 20),

              Text(
                "Send Money Successful!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),

              SizedBox(height: 10),

              Text(
                "₹500",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 30),

              
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    rowItem("Current Balance", "₹2100"),
                    SizedBox(height: 10),
                    rowItem("Date & Time", "30th Nov 2024\n03:53 PM"),
                    SizedBox(height: 10),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentDetailsScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payment Details"),
                          Icon(Icons.arrow_forward_ios, size: 16)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),

              CustomButton(text: "Back to Home", btncolor: Colors.black, onPressed: () {
                Get.offAllNamed("/dashboard");
              },),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget rowItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.grey[600])),
        Text(value, textAlign: TextAlign.right),
      ],
    );
  }
}
///////////////////////////////////
class PaymentDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Get.back(),
  ),
        title: Text("Payment Details"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),

            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.green,
              child: Icon(Icons.check, color: Colors.white, size: 30),
            ),

            SizedBox(height: 20),

            Text(
              "Payment Successful!",
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 10),

            Text(
              "₹500",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  detailRow("Reference ID",
                      "aec68852-f711-4b7d-9e8ergdye4vg44bu"),
                  divider(),
                  detailRow("Credited To", "General Wallet"),
                  divider(),
                  detailRow("Payment Using", "UPI\njanedoe@upi"),
                  divider(),
                  detailRow("Date & Time", "30th Nov 2024\n03:53 PM"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title, style: TextStyle(color: Colors.grey)),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget divider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Divider(height: 1),
      );
}