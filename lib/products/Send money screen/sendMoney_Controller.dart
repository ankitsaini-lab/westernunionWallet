import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:transwallet/widgets/constsize.dart';
import 'package:transwallet/widgets/custombutton.dart';

class SendmoneyController extends GetxController {

var step = 0.obs;

  var accountNumber = ''.obs;
  var confirmAccount = ''.obs;
  var name = ''.obs;
  var ifsc = ''.obs;
  var otp = ''.obs;

  var beneficiaries = <Map<String, String>>[].obs;

  void nextStep() => step.value++;

  void addBeneficiary() {
    beneficiaries.add({
      "name": name.value,
      "account": accountNumber.value,
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
      switch (step.value) {

        
        case 0:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               height40,
              SvgPicture.asset("assets/User_empty.svg"),
              Text("You don’t have any beneficiary",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              height10,
              Text("Create a beneficiary now to do bank transfer.",style: TextStyle(fontSize: 12,color: Colors.grey),),
              height24,
              CustomButton(text: "Add Beneficiary", btncolor: Colors.black, onPressed: () => nextStep())
            ],
          );

        
       case 1:
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      height40,
       Text("Beneficiary Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
       height16,
      TextField(
        decoration: InputDecoration(
          labelText: "Account Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
        ),
        onChanged: (v) => accountNumber.value = v,
      ),

      SizedBox(height: 12),

      TextField(
        decoration: InputDecoration(
          labelText: "Re-enter Account",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (v) => confirmAccount.value = v,
      ),

      SizedBox(height: 12),

      TextField(
        decoration: InputDecoration(
          labelText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (v) => name.value = v,
      ),

      SizedBox(height: 12),

      TextField(
        decoration: InputDecoration(
          labelText: "IFSC",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (v) => ifsc.value = v,
      ),

      SizedBox(height: 20),
CustomButton(text: "Proceed", btncolor: Colors.black, onPressed: () => nextStep())
      
    ],
  );

       case 2:
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      height16,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text("Enter OTP sent to your registered mobile number", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
      ),
      
    const  SizedBox(height: 20),

      
      

      Padding(
        padding: const EdgeInsets.
        symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return SizedBox(
              width: 60,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (v) {
                  if (v.isNotEmpty) {
                    otp.value = otp.value.padRight(4);
                    otp.value =
                        otp.value.substring(0, index) + v + otp.value.substring(index + 1);
        
                    /// auto move focus
                    if (index < 3) {
                      FocusScope.of(Get.context!).nextFocus();
                    }
                  }
                },
              ),
            );
          }),
        ),
      ),

    const  SizedBox(height: 20),
    
      Text("Resend OTP in 00:30s", style: TextStyle(fontSize: 14, color: Colors.grey)),
      
     const SizedBox(height: 30),

    CustomButton(text: "Add", btncolor: Colors.black, onPressed: () async {
            if (otp.value.length == 4 && !otp.value.contains(" ")) {
              step.value = 3;
              await Future.delayed(Duration(seconds: 1));
              addBeneficiary();
              step.value = 4;
            }
          }),
       
    ],
  );
        case 3:
          return Center(child: CircularProgressIndicator());

        
       case 4:
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// 🔹 Success Icon
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 70,
            ),
          ),

          SizedBox(height: 25),

          /// 🔹 Title
          Text(
            "Beneficiary Added!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 10),

          /// 🔹 Subtitle
          Text(
            "You can now send money instantly to this beneficiary.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),

          SizedBox(height: 40),

         CustomButton(text: "Continue", btncolor: Colors.black, onPressed: () {
                resetForm();
                step.value = 5;
              })
           
        ],
      ),
    ),
  );

         
        case 5:
          return Column(
            children: [
              ...beneficiaries.map((b) => ListTile(
                    title: Text(b["name"]!),
                    subtitle: Text(b["account"]!),
                  )),
              ElevatedButton(
                onPressed: () {
                  step.value = 1;
                },
                child: Text("Add Beneficiary"),
              )
            ],
          );

        default:
          return SizedBox();
      }
    });
  }













  /////////////////////////////////////
  TextEditingController phoneController = TextEditingController();
var istransferTypeP2P = true.obs;
  var selectedCountryCode = "+91".obs;
  var isValid = false.obs;

  void updateNumber(String value) {
    isValid.value = value.length >= 10;
  }

  void setNumberFromContact(String number) {
    phoneController.text = number;
    isValid.value = true;
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
   Widget tab(String text, bool selected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
        ),
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
         leading:   GestureDetector(
          onTap: () => Get.back(),
          child: BackButton()),
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text("Choose a contact", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500,fontSize: 18)),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (_, index) {
          final c = contacts[index];

          return ListTile(
            leading: CircleAvatar(
              child: Text(c["name"]![0]),
            ),
            title: Text(c["name"]!),
            onTap: () {
              controller.setNumberFromContact(c["number"]!);
              Get.back();
            },
          );
        },
      ),
    );
  }
}