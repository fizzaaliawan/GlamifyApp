import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../view_models/booking/add_card_viewmodel.dart';

class AddCardScreen extends GetView<AddCardViewModel> {
  final String title;
  final double price;
  final DateTime date;
  final String time;
  final String selectedSpecialist;

  const AddCardScreen({
    super.key,
    required this.title,
    required this.price,
    required this.date,
    required this.time,
    required this.selectedSpecialist,
  });

  static const teal = Color(0xFF008080);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controller = Get.put(AddCardViewModel());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Payment Card", style: TextStyle(color: teal)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: teal),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _cardPreview(controller),
              const SizedBox(height: 30),

              // Card Number
              _buildField(
                label: "Card Number",
                hint: "1234 5678 9012 3456",
                controller: controller.cardNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  _CardNumberFormatter(),
                ],
                onChange: (val) => controller.cardNumber.value = val,
                validator: (val) => val!.replaceAll(' ', '').length == 16
                    ? null
                    : "Enter 16 digit card number",
              ),
              const SizedBox(height: 20),

              // Card Holder Name
              _buildField(
                label: "Card Holder Name",
                hint: "FIZZA ALI",
                controller: controller.nameController,
                inputFormatters: [UpperCaseTextFormatter()],
                onChange: (val) => controller.cardName.value = val,
                validator: (val) => val!.isEmpty ? "Name required" : null,
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  // Expiry
                  Expanded(
                    child: _buildField(
                      label: "Expiry Date",
                      hint: "MM/YYYY",
                      controller: controller.expiryController,
                      inputFormatters: [_ExpiryFormatter()],
                      onChange: (val) => controller.expiry.value = val,
                      validator: (val) =>
                          RegExp(r'^(0[1-9]|1[0-2])\/\d{4}$').hasMatch(val!)
                          ? null
                          : "Enter valid MM/YYYY",
                    ),
                  ),
                  const SizedBox(width: 15),
                  // CVV
                  Expanded(
                    child: _buildField(
                      label: "CVV",
                      hint: "***",
                      controller: controller.cvvController,
                      obscure: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                      onChange: (val) =>
                          controller.cardNumber.value = val, // <-- safe
                      validator: (val) =>
                          val!.length == 3 ? null : "Enter 3 digits",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Add Card Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.addCard();
                      _showSuccessDialog();
                    }
                  },
                  child: const Text(
                    "Add Card",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= CARD PREVIEW =================
  Widget _cardPreview(AddCardViewModel controller) {
    return Obx(() {
      // Mask all but last 4 digits
      String displayCardNumber = controller.cardNumber.value;
      if (displayCardNumber.replaceAll(' ', '').length > 4) {
        String digits = displayCardNumber.replaceAll(' ', '');
        String last4 = digits.substring(digits.length - 4);
        displayCardNumber = '**** **** **** $last4';
      } else if (displayCardNumber.isEmpty) {
        displayCardNumber = '**** **** **** 3456';
      }

      String displayName = controller.cardName.value.isEmpty
          ? "CARD HOLDER"
          : controller.cardName.value;
      String displayExpiry = controller.expiry.value.isEmpty
          ? "MM/YYYY"
          : controller.expiry.value;

      return Container(
        height: 180,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AddCardScreen.teal, Color(0xFF004D4D)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayCardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(displayName, style: const TextStyle(color: Colors.white)),
                Text(
                  displayExpiry,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // ================= INPUT FIELD =================
  Widget _buildField({
    required String label,
    required String hint,
    TextEditingController? controller,
    bool obscure = false,
    List<TextInputFormatter>? inputFormatters,
    required Function(String) onChange,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          inputFormatters: inputFormatters,
          onChanged: onChange,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  // ================= SUCCESS DIALOG =================
  void _showSuccessDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, color: Colors.teal, size: 80),
              SizedBox(height: 20),
              Text(
                "Booking Confirmed",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Your appointment has been successfully booked.",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}

// ================= CARD NUMBER FORMATTER =================
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 16) digits = digits.substring(0, 16);

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i != 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// ================= EXPIRY DATE FORMATTER =================
class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 6) digits = digits.substring(0, 6);

    String text;
    if (digits.length >= 3) {
      text = '${digits.substring(0, 2)}/${digits.substring(2)}';
    } else {
      text = digits;
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

// ================= CARD HOLDER NAME UPPERCASE =================
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
