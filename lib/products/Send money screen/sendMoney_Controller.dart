import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/custombutton.dart';

class SendmoneyController extends GetxController {
  var step = 0.obs;
  var isOneTimeTransfer = false.obs; 

  var accountNumber = ''.obs;
  var confirmAccount = ''.obs;
  var name = ''.obs;
  var ifsc = ''.obs;
  var otp = ''.obs;

  var beneficiaries = <Map<String, String>>[].obs;

  var phoneError = ''.obs;
  var selectedContactName = ''.obs;

  bool get isBeneficiaryValid {
    return accountNumber.value.isNotEmpty &&
        accountNumber.value == confirmAccount.value &&
        name.value.trim().isNotEmpty &&
        ifsc.value.trim().length == 11;
  }

  String? get accountError {
    if (accountNumber.value.isEmpty) return null;
    if (!RegExp(r'^[0-9]+$').hasMatch(accountNumber.value)) {
      return "Account number must contain digits only";
    }
    return null;
  }

  String? get confirmAccountError {
    if (confirmAccount.value.isEmpty) return null;
    if (confirmAccount.value != accountNumber.value) {
      return "Account numbers do not match";
    }
    return null;
  }

  String? get nameError {
    if (name.value.isEmpty) return null;
    if (name.value.trim().isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  String? get ifscError {
    if (ifsc.value.isEmpty) return null;
    if (ifsc.value.trim().length != 11) {
      return "IFSC must be exactly 11 characters";
    }
    return null;
  }

  void nextStep() => step.value++;

  void addBeneficiary() {
    beneficiaries.add({
      "name": name.value,
      "account": accountNumber.value,
      "ifsc": ifsc.value,
    });
  }

  void resetForm() {
    accountNumber.value = '';
    confirmAccount.value = '';
    name.value = '';
    ifsc.value = '';
    otp.value = '';
  }

  Widget buildStep() {
    return Obx(() {
      if (isOneTimeTransfer.value) {
        return _buildDirectTransferForm();
      }
      switch (step.value) {
        case 0:
          return _buildEmptyState();
        case 1:
          return _buildBeneficiaryForm();
        case 2:
          return _buildOtpVerification();
        case 3:
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: Color(0xFFE53935)),
            ),
          );
        case 4:
          return _buildSuccessState();
        case 5:
          return _buildBeneficiaryList();
        default:
          return const SizedBox();
      }
    });
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE53935).withOpacity(0.08),
            ),
            child: SvgPicture.asset(
              "assets/User_empty.svg",
              colorFilter: const ColorFilter.mode(Color(0xFFE53935), BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "No Beneficiaries Yet",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF111111),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Create a beneficiary to instantly transfer money to any bank account.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF6B7280),
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: "Add Saved Beneficiary",
            btncolor: Colors.black,
            onPressed: () => nextStep(),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              side: const BorderSide(color: Colors.black, width: 1.5),
            ),
            onPressed: () {
              isOneTimeTransfer.value = true;
              resetForm();
            },
            child: const Text(
              "Instant One-Time Transfer",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectTransferForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "DIRECT BANK TRANSFER",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                  letterSpacing: 1.0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  isOneTimeTransfer.value = false;
                  step.value = beneficiaries.isEmpty ? 0 : 5;
                },
                child: const Text(
                  "Use Saved",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE53935),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            decoration: InputDecoration(
              labelText: "Account Number",
              labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 13),
              errorText: accountError,
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onChanged: (v) => accountNumber.value = v,
          ),
          const SizedBox(height: 12),
          
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            decoration: InputDecoration(
              labelText: "Confirm Account Number",
              labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 13),
              errorText: confirmAccountError,
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onChanged: (v) => confirmAccount.value = v,
          ),
          const SizedBox(height: 12),
          
          TextField(
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            decoration: InputDecoration(
              labelText: "Account Holder Name",
              labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 13),
              errorText: nameError,
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onChanged: (v) => name.value = v,
          ),
          const SizedBox(height: 12),
          
          TextField(
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [LengthLimitingTextInputFormatter(11)],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.0),
            decoration: InputDecoration(
              labelText: "IFSC Code",
              labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 13),
              errorText: ifscError,
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onChanged: (v) => ifsc.value = v,
          ),
          const SizedBox(height: 20),
          
          CustomButton(
            text: "Proceed to Pay",
            btncolor: isBeneficiaryValid ? Colors.black : Colors.grey,
            onPressed: () {
              if (isBeneficiaryValid) {
                selectedContactName.value = name.value;
                istransferTypeP2P.value = false;
                Get.toNamed("/sendmoneyprocess");
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiaryForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "BENEFICIARY DETAILS",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B7280),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 16),
          
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            decoration: InputDecoration(
              labelText: "Account Number",
              labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 13),
              errorText: accountError,
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onChanged: (v) => accountNumber.value = v,
          ),
          const SizedBox(height: 12),
          
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            decoration: InputDecoration(
              labelText: "Confirm Account Number",
              labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 13),
              errorText: confirmAccountError,
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onChanged: (v) => confirmAccount.value = v,
          ),
          const SizedBox(height: 12),
          
          TextField(
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            decoration: InputDecoration(
              labelText: "Account Holder Name",
              labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 13),
              errorText: nameError,
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onChanged: (v) => name.value = v,
          ),
          const SizedBox(height: 12),
          
          TextField(
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [LengthLimitingTextInputFormatter(11)],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.0),
            decoration: InputDecoration(
              labelText: "IFSC Code",
              labelStyle: const TextStyle(color: Color(0xFF6B7280), fontWeight: FontWeight.w500, fontSize: 13),
              errorText: ifscError,
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black, width: 1.5),
              ),
            ),
            onChanged: (v) => ifsc.value = v,
          ),
          const SizedBox(height: 20),
          
          CustomButton(
            text: "Proceed & Verify",
            btncolor: isBeneficiaryValid ? Colors.black : Colors.grey,
            onPressed: () {
              if (isBeneficiaryValid) {
                nextStep();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOtpVerification() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE53935).withOpacity(0.08),
            ),
            child: const Icon(Icons.phonelink_ring_rounded, color: Color(0xFFE53935), size: 28),
          ),
          const SizedBox(height: 16),
          const Text(
            "Verify OTP",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF111111)),
          ),
          const SizedBox(height: 6),
          const Text(
            "Enter the 4-digit code sent to your registered mobile number",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 58,
                height: 58,
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    counterText: "",
                    filled: true,
                    fillColor: const Color(0xFFF9FAFB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFECECEC), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.5),
                    ),
                  ),
                  onChanged: (v) {
                    if (v.isNotEmpty) {
                      otp.value = otp.value.padRight(4);
                      otp.value = otp.value.substring(0, index) + v + otp.value.substring(index + 1);
                      if (index < 3) {
                        FocusScope.of(Get.context!).nextFocus();
                      }
                    }
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          const Text(
            "Resend OTP in 00:30s",
            style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: "Add Beneficiary",
            btncolor: Colors.black,
            onPressed: () async {
              if (otp.value.length == 4 && !otp.value.contains(" ")) {
                step.value = 3;
                await Future.delayed(const Duration(seconds: 1));
                addBeneficiary();
                step.value = 4;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 74,
            width: 74,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF4CAF50),
              size: 52,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Beneficiary Added!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF111111)),
          ),
          const SizedBox(height: 6),
          const Text(
            "You can now send money instantly to this beneficiary from your Transcorp wallet.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: "Continue to Transact",
            btncolor: Colors.black,
            onPressed: () {
              resetForm();
              step.value = 5;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiaryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "MY BENEFICIARIES",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B7280),
                letterSpacing: 1.0,
              ),
            ),
            GestureDetector(
              onTap: () => step.value = 1,
              child: const Row(
                children: [
                  Icon(Icons.add_circle_outline_rounded, color: Color(0xFFE53935), size: 14),
                  SizedBox(width: 4),
                  Text(
                    "Add New",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE53935),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFECECEC), width: 1.5),
          ),
          child: Column(
            children: [
              ...beneficiaries.map((b) {
                final isLast = beneficiaries.indexOf(b) == beneficiaries.length - 1;
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      leading: Container(
                        height: 38,
                        width: 38,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE53935),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          b["name"]![0].toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      title: Text(
                        b["name"]!,
                        style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF111111), fontSize: 14),
                      ),
                      subtitle: Text(
                        "A/C : ${b["account"]}",
                        style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Color(0xFF9CA3AF)),
                      onTap: () {
                        selectedContactName.value = b["name"]!;
                        name.value = b["name"]!;
                        accountNumber.value = b["account"]!;
                        ifsc.value = b["ifsc"] ?? '';
                        istransferTypeP2P.value = false;
                        Get.toNamed("/sendmoneyprocess");
                      },
                    ),
                    if (!isLast) const Divider(color: Color(0xFFECECEC), height: 1, indent: 64),
                  ],
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 24),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            side: const BorderSide(color: Colors.black, width: 1.5),
          ),
          onPressed: () {
            isOneTimeTransfer.value = true;
            resetForm();
          },
          child: const Text(
            "Instant One-Time Transfer",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ],
    );
  }

  
  TextEditingController phoneController = TextEditingController();
  var istransferTypeP2P = true.obs;
  var selectedCountryCode = "+91".obs;
  var isValid = false.obs;

  void updateNumber(String value) {
    isValid.value = RegExp(r'^[0-9]{10}$').hasMatch(value);
    if (value.isEmpty) {
      phoneError.value = '';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      phoneError.value = 'Only numbers are allowed';
    } else if (value.length < 10) {
      phoneError.value = 'Mobile number must be 10 digits';
    } else {
      phoneError.value = '';
    }
  }

  void setNumberFromContact(String number) {
    String digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 10) {
      digits = digits.substring(digits.length - 10);
    }
    phoneController.text = digits;
    updateNumber(digits);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  Widget tab(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(color: selected ? Colors.white : Colors.black),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final controller = Get.find<SendmoneyController>();

  final contacts = [
    {"name": "Adison Workman", "number": "9876543210"},
    {"name": "Brandon Mango", "number": "9123456780"},
    {"name": "Carla Franci", "number": "9988776655"},
    {"name": "Gustavo Dokidis", "number": "9876501234"},
    {"name": "James Herwitz", "number": "9123987456"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(onTap: () => Get.back(), child: const BackButton()),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          "Choose a contact",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (_, index) {
          final c = contacts[index];

          return ListTile(
            leading: CircleAvatar(child: Text(c["name"]![0])),
            title: Text(c["name"]!),
            onTap: () {
              controller.selectedContactName.value = c["name"]!;
              controller.setNumberFromContact(c["number"]!);
              Get.back();
            },
          );
        },
      ),
    );
  }
}
