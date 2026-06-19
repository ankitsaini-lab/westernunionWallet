import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';
import 'package:transwallet/widgets/customdropdown/customdropdown_View.dart';

class CreateaccountController extends GetxController {
  var firstName = ''.obs;
  var midName = ''.obs;
  var lastName = ''.obs;
  var gender = ''.obs;
  var dob = ''.obs;

  var hasCode = false.obs;

  var kitNumber = ''.obs;
  var cardNumber = ''.obs;

  var email = ''.obs;
  var address1 = ''.obs;
  var address2 = ''.obs;
  var pincode = ''.obs;
  var city = ''.obs;
  var state = ''.obs;
  var country = 'India'.obs;

  var step = 1.obs;

  final firstNameError = ''.obs;
  final middleNameError = ''.obs;
  final lastNameError = ''.obs;
  final emailError = ''.obs;
  final genderError = ''.obs;
  final dobError = ''.obs;
  final kitError = ''.obs;
  final cardError = ''.obs;

  final address1Error = ''.obs;
  final address2Error = ''.obs;
  final pincodeError = ''.obs;
  final countryError = ''.obs;
  final stateError = ''.obs;
  final cityError = ''.obs;

  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  void toggleCode(bool value) {
    hasCode.value = value;
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    required RxString errorText,
    List<TextInputFormatter>? inpputofrmater,
    TextInputType? keyboardtype,
    bool enabled = true,
  }) {
    const primaryRed = Color(0xFFD64550);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.2,
              color: Color(0xFF4B5563),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Obx(
          () => TextField(
            keyboardType: keyboardtype,
            enabled: enabled,
            onChanged: onChanged,
            inputFormatters: inpputofrmater,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
              errorText: errorText.value.isEmpty ? null : errorText.value,
              filled: true,
              fillColor: const Color(0xFFF5F6F8),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Color(0xFFE5E7EB),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Color(0xFFE5E7EB),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: primaryRed, width: 2.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: const Color(0xFFF5F6F8),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
    );
  }

  void nextStep() {
    firstNameError.value = firstName.value.isEmpty
        ? "First Name is required"
        : "";

    middleNameError.value = midName.value.isEmpty
        ? "Middle Name is required"
        : "";

    lastNameError.value = lastName.value.isEmpty ? "Last Name is required" : "";

    emailError.value = email.value.isEmpty
        ? "Email is required"
        : !_isValidEmail(email.value)
        ? "Enter a valid email address"
        : "";

    genderError.value = gender.value.isEmpty ? "Gender is required" : "";

    if (dob.value.isEmpty) {
      dobError.value = "Date of birth is required";
    } else {
      try {
        final parts = dob.value.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          final birthDate = DateTime(year, month, day);
          final adultDate = DateTime(
            birthDate.year + 18,
            birthDate.month,
            birthDate.day,
          );
          if (adultDate.isAfter(DateTime.now())) {
            dobError.value = "You must be at least 18 years old";
          } else {
            dobError.value = "";
          }
        } else {
          dobError.value = "Invalid date format";
        }
      } catch (e) {
        dobError.value = "Invalid date format";
      }
    }

    if (hasCode.value) {
      kitError.value = kitNumber.value.isEmpty ? "Kit Number is required" : "";

      cardError.value = cardNumber.value.isEmpty
          ? "Card Number is required"
          : "";
    }

    bool hasError =
        firstNameError.value.isNotEmpty ||
        middleNameError.value.isNotEmpty ||
        lastNameError.value.isNotEmpty ||
        emailError.value.isNotEmpty ||
        genderError.value.isNotEmpty ||
        dobError.value.isNotEmpty ||
        kitError.value.isNotEmpty ||
        cardError.value.isNotEmpty;

    if (hasError) return;

    step.value = 2;
  }

  void previousStep() {
    if (step.value > 1) {
      step.value--;
    }
  }

  Widget buildStep(String title, int index) {
    const primaryRed = Color(0xFFD64550);

    return Obx(() {
      bool isActive = step.value == index;

      return Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              letterSpacing: 0.5,
              color: isActive ? Colors.black : Colors.black26,
            ),
          ),

          const SizedBox(height: 8),

          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12),

            decoration: BoxDecoration(
              color: isActive ? primaryRed : Colors.grey.withOpacity(0.15),

              borderRadius: BorderRadius.circular(10),

              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: primaryRed.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : [],
            ),
          ),
        ],
      );
    });
  }

  Widget buildStepOene(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        buildTextField(
          label: "First Name",
          hint: "Enter First Name",
          errorText: firstNameError,
          onChanged: (v) {
            firstName.value = v;
            if (v.isNotEmpty) firstNameError.value = '';
          },
        ),
        const SizedBox(height: 10),
        buildTextField(
          label: "Middle Name",
          hint: "Enter Middle Name",
          errorText: middleNameError,
          onChanged: (v) {
            midName.value = v;
            if (v.isNotEmpty) middleNameError.value = '';
          },
        ),
        const SizedBox(height: 10),
        buildTextField(
          label: "Last Name",
          hint: "Enter Last Name",
          errorText: lastNameError,
          onChanged: (v) {
            lastName.value = v;
            if (v.isNotEmpty) lastNameError.value = '';
          },
        ),
        height10,

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                "Gender",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.2,
                  color: Color(0xFF4B5563),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: ["Male", "Female", "Other"].map((g) {
                      final bool isSelected = gender.value == g;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            gender.value = g;
                            genderError.value = "";
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF111111)
                                  : const Color(0xFFF5F6F8),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF111111)
                                    : const Color(0xFFE5E7EB),
                                width: 1.5,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.12),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                g,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF4B5563),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (genderError.value.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 6),
                      child: Text(
                        genderError.value,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),

        height10,

        buildTextField(
          label: "Email",
          hint: "Enter your email",
          errorText: emailError,
          onChanged: (v) {
            email.value = v;
            if (v.isNotEmpty && !_isValidEmail(v)) {
              emailError.value = "Enter a valid email address";
            } else {
              emailError.value = "";
            }
          },
          inpputofrmater: [
            FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9@._\-+]")),
          ],
        ),
        height10,
        const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "Date of Birth",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 0.2,
              color: Color(0xFF4B5563),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  final today = DateTime.now();
                  final maxAdultDate = DateTime(
                    today.year - 18,
                    today.month,
                    today.day,
                  );
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: maxAdultDate,
                    firstDate: DateTime(1700),
                    lastDate: maxAdultDate,
                  );

                  if (picked != null) {
                    dob.value = "${picked.day}/${picked.month}/${picked.year}";
                    dobError.value = "";
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: boxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dob.value.isEmpty ? "Select Date of Birth" : dob.value,
                        style: TextStyle(
                          color: dob.value.isEmpty
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF111111),
                          fontWeight: dob.value.isEmpty
                              ? FontWeight.w400
                              : FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_rounded,
                        size: 20,
                        color: Color(0xFF6B7280),
                      ),
                    ],
                  ),
                ),
              ),
              if (dobError.value.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 6),
                  child: Text(
                    dobError.value,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Obx(
          () => Row(
            children: [
              Checkbox(
                activeColor: const Color(0xFFD64550),
                value: hasCode.value,
                onChanged: (v) => toggleCode(v ?? false),
              ),

              const Text("I have an activation code"),
            ],
          ),
        ),

        height8,

        Obx(
          () => hasCode.value
              ? buildTextField(
                  label: "Kit Number",
                  hint: "KIT-000123",
                  enabled: hasCode.value,
                  errorText: kitError,
                  onChanged: (v) {
                    kitNumber.value = v;
                    if (v.isNotEmpty) kitError.value = '';
                  },
                )
              : Container(),
        ),

        height8,

        Obx(
          () => hasCode.value
              ? buildTextField(
                  label: "Card Number",
                  hint: "Last 4 digits of card",
                  enabled: hasCode.value,
                  errorText: cardError,
                  keyboardtype: TextInputType.number,
                  inpputofrmater: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: (v) {
                    cardNumber.value = v;
                    if (v.isNotEmpty) cardError.value = '';
                  },
                )
              : Container(),
        ),

        const SizedBox(height: 20),

        CustomButton(
          text: "Next Step",
          btncolor: const Color(0xFF111111),
          borderRadius: 20,
          suffixIcon: const Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 18,
          ),
          onPressed: nextStep,
        ),
      ],
    );
  }

  Widget buildStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text(
          "Permanent Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 14),

        buildTextField(
          label: "Address Line 1",
          hint: "Enter address",
          errorText: address1Error,
          onChanged: (v) {
            address1.value = v;
            if (v.isNotEmpty) address1Error.value = '';
          },
        ),

        const SizedBox(height: 10),

        buildTextField(
          label: "Address Line 2 (Optional)",
          hint: "Enter address",
          errorText: address2Error,
          onChanged: (v) {
            address2.value = v;
            if (v.isNotEmpty) address2Error.value = '';
          },
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: buildTextField(
                label: "Pincode",
                hint: "000000",
                errorText: pincodeError,
                keyboardtype: TextInputType.number,

                inpputofrmater: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],

                onChanged: (v) {
                  pincode.value = v;
                  if (v.isNotEmpty) pincodeError.value = '';
                },
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      "Country",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        letterSpacing: 0.2,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdown(
                          options: const ["India"],
                          selectedValue: country.value,
                          onChanged: (val) {
                            country.value = val;
                            countryError.value = "";
                          },
                        ),
                        if (countryError.value.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 8),
                            child: Text(
                              countryError.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      "State",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        letterSpacing: 0.2,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdown(
                          options: const ["Rajasthan"],
                          onChanged: (val) {
                            state.value = val;
                            stateError.value = "";
                          },
                        ),
                        if (stateError.value.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 8),
                            child: Text(
                              stateError.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(
                      "City",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        letterSpacing: 0.2,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdown(
                          options: const ["Jaipur"],
                          onChanged: (val) {
                            city.value = val;
                            cityError.value = "";
                          },
                        ),
                        if (cityError.value.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 6, left: 8),
                            child: Text(
                              cityError.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        CustomButton(
          text: "Proceed to Min KYC",
          btncolor: const Color(0xFF111111),
          borderRadius: 20,
          suffixIcon: const Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            address1Error.value = address1.value.isEmpty
                ? "Address Line 1 is required"
                : "";

            address2Error.value = "";

            pincodeError.value = pincode.value.isEmpty
                ? "Pincode is required"
                : "";

            countryError.value = country.value.isEmpty
                ? "Country is required"
                : "";

            stateError.value = state.value.isEmpty ? "State is required" : "";

            cityError.value = city.value.isEmpty ? "City is required" : "";

            bool hasError =
                address1Error.value.isNotEmpty ||
                address2Error.value.isNotEmpty ||
                pincodeError.value.isNotEmpty ||
                countryError.value.isNotEmpty ||
                stateError.value.isNotEmpty ||
                cityError.value.isNotEmpty;

            if (hasError) return;

            Get.toNamed("/minkyc_view");
          },
        ),

        const SizedBox(height: 16),

        GestureDetector(
          onTap: previousStep,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_back_rounded,
                size: 16,
                color: Color(0xFF4B5563),
              ),
              const SizedBox(width: 6),
              Text(
                "Go to previous Step",
                style: TextStyle(
                  color: const Color(0xFF4B5563),
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
