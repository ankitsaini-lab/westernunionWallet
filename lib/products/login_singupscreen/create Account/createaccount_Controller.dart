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
  var country = ''.obs;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        Obx(
          () => TextField(
            keyboardType: keyboardtype,
            enabled: enabled,

            onChanged: (value) {

              onChanged(value);

              if (value.isNotEmpty) {
                errorText.value = "";
              }
            },

            inputFormatters: inpputofrmater,

            decoration: InputDecoration(

              hintText: hint,

              hintStyle: const TextStyle(
                fontSize: 14,
              ),

              errorText:
                  errorText.value.isEmpty
                      ? null
                      : errorText.value,

              filled: true,

              fillColor: const Color(0xFFF5F5F5),

              contentPadding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),

              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFE53935),
                  width: 1.2,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),

              focusedErrorBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration boxDecoration() {

    return BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
    );
  }

  void nextStep() {

    firstNameError.value =
        firstName.value.isEmpty
            ? "First Name is required"
            : "";

    middleNameError.value =
        midName.value.isEmpty
            ? "Middle Name is required"
            : "";

    lastNameError.value =
        lastName.value.isEmpty
            ? "Last Name is required"
            : "";

    emailError.value =
        email.value.isEmpty
            ? "Email is required"
            : "";

    genderError.value =
        gender.value.isEmpty
            ? "Gender is required"
            : "";

    dobError.value =
        dob.value.isEmpty
            ? "Date of birth is required"
            : "";

    if (hasCode.value) {

      kitError.value =
          kitNumber.value.isEmpty
              ? "Kit Number is required"
              : "";

      cardError.value =
          cardNumber.value.isEmpty
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
              fontWeight: isActive
                  ? FontWeight.w700
                  : FontWeight.w500,
              letterSpacing: 0.5,
              color: isActive
                  ? Colors.black
                  : Colors.black26,
            ),
          ),

          const SizedBox(height: 8),

          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            height: 4,
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),

            decoration: BoxDecoration(
              color: isActive
                  ? primaryRed
                  : Colors.grey.withOpacity(0.15),

              borderRadius:
                  BorderRadius.circular(10),

              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color:
                            primaryRed.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
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
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Row(
          children: [

            Expanded(
              child: buildTextField(
                label: "First Name",
                hint: "Enter First Name",
                errorText: firstNameError,
                onChanged: (v) =>
                    firstName.value = v,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: buildTextField(
                label: "Middle Name",
                hint: "Enter Middle Name",
                errorText: middleNameError,
                onChanged: (v) =>
                    midName.value = v,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [

            Expanded(
              child: buildTextField(
                label: "Last Name",
                hint: "Enter Last Name",
                errorText: lastNameError,
                onChanged: (v) =>
                    lastName.value = v,
              ),
            ),

            width10,

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text("Gender"),

                  const SizedBox(height: 8),

                  Obx(
                    () => Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),

                          decoration: boxDecoration(),

                          child: DropdownButton<String>(
                            value: gender.value.isEmpty
                                ? null
                                : gender.value,

                            hint: const Text(
                              "Select..",
                              style:
                                  TextStyle(fontSize: 14),
                            ),

                            isExpanded: true,
                            underline: const SizedBox(),

                            items: [
                              "Male",
                              "Female",
                              "Other"
                            ]
                                .map(
                                  (e) =>
                                      DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),

                            onChanged: (value) {

                              gender.value =
                                  value ?? '';

                              if (value != null) {
                                genderError.value = "";
                              }
                            },
                          ),
                        ),

                        if (genderError.value.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.only(
                              left: 12,
                              top: 6,
                            ),
                            child: Text(
                              genderError.value,
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

        buildTextField(
          label: "Email",
          hint: "Enter your email",
          errorText: emailError,
          onChanged: (v) =>
              email.value = v,

          inpputofrmater: [
            FilteringTextInputFormatter.allow(
              RegExp(r"[a-zA-Z0-9@._\-+]"),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text("Date of Birth"),

        const SizedBox(height: 8),

        Obx(
          () => Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: () async {

                  DateTime? picked =
                      await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1700),
                    lastDate: DateTime.now(),
                  );

                  if (picked != null) {

                    dob.value =
                        "${picked.day}/${picked.month}/${picked.year}";

                    dobError.value = "";
                  }
                },

                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecoration(),

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,

                    children: [

                      Text(
                        dob.value.isEmpty
                            ? "dd/mm/yyyy"
                            : dob.value,

                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      const Icon(
                        Icons.calendar_today,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              if (dobError.value.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.only(
                    left: 12,
                    top: 6,
                  ),
                  child: Text(
                    dobError.value,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
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
                activeColor:
                    const Color(0xFFD64550),
                value: hasCode.value,
                onChanged: (v) =>
                    toggleCode(v ?? false),
              ),

              const Text(
                "I have an activation code",
              ),
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
                  onChanged: (v) =>
                      kitNumber.value = v,
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
                  keyboardtype:
                      TextInputType.number,
                  inpputofrmater: [
                    FilteringTextInputFormatter
                        .digitsOnly,
                    LengthLimitingTextInputFormatter(
                        4),
                  ],
                  onChanged: (v) =>
                      cardNumber.value = v,
                )
              : Container(),
        ),

        const SizedBox(height: 12),

        CustomButton(
          text: "Next",
          btncolor: const Color(0xFF111111),
          onPressed: nextStep,
        ),
      ],
    );
  }

  Widget buildStepTwo() {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        const Text(
          "Permanent Address",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 14),

        buildTextField(
          label: "Address Line 1",
          hint: "Enter address",
          errorText: address1Error,
          onChanged: (v) =>
              address1.value = v,
        ),

        const SizedBox(height: 10),

        buildTextField(
          label: "Address Line 2",
          hint: "Enter address",
          errorText: address2Error,
          onChanged: (v) =>
              address2.value = v,
        ),

        const SizedBox(height: 10),

        Row(
          children: [

            Expanded(
              child: buildTextField(
                label: "Pincode",
                hint: "000000",
                errorText: pincodeError,
                keyboardtype:
                    TextInputType.number,

                inpputofrmater: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter
                      .digitsOnly,
                ],

                onChanged: (v) =>
                    pincode.value = v,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text("Country"),

                  const SizedBox(height: 6),

                  Obx(
                    () => Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        CustomDropdown(
                          options: const [
                            "India",
                            "USA",
                            "Canada",
                            "Australia",
                            "Germany"
                          ],

                          onChanged: (val) {

                            country.value = val;

                            countryError.value = "";
                          },
                        ),

                        if (countryError.value.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.only(
                              top: 6,
                              left: 8,
                            ),
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text("State"),

                  const SizedBox(height: 6),

                  Obx(
                    () => Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        CustomDropdown(
                          options: const [
                            "Rajasthan",
                          ],

                          onChanged: (val) {

                            state.value = val;

                            stateError.value = "";
                          },
                        ),

                        if (stateError.value.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.only(
                              top: 6,
                              left: 8,
                            ),
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  const Text("City"),

                  const SizedBox(height: 6),

                  Obx(
                    () => Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        CustomDropdown(
                          options: const [
                            "Jaipur",
                          ],

                          onChanged: (val) {

                            city.value = val;

                            cityError.value = "";
                          },
                        ),

                        if (cityError.value.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.only(
                              top: 6,
                              left: 8,
                            ),
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

        const SizedBox(height: 24),

        CustomButton(
          text: "Proceed to Min KYC",
          btncolor: Colors.black,

          onPressed: () {

            address1Error.value =
                address1.value.isEmpty
                    ? "Address Line 1 is required"
                    : "";

            address2Error.value =
                address2.value.isEmpty
                    ? "Address Line 2 is required"
                    : "";

            pincodeError.value =
                pincode.value.isEmpty
                    ? "Pincode is required"
                    : "";

            countryError.value =
                country.value.isEmpty
                    ? "Country is required"
                    : "";

            stateError.value =
                state.value.isEmpty
                    ? "State is required"
                    : "";

            cityError.value =
                city.value.isEmpty
                    ? "City is required"
                    : "";

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

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          crossAxisAlignment:
              CrossAxisAlignment.center,

          children: [

            const Icon(
              Icons.arrow_back,
              size: 16,
              color: Colors.black,
            ),

            const SizedBox(width: 4),

            GestureDetector(
              onTap: previousStep,

              child: const Text(
                "Go to previous Step",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}