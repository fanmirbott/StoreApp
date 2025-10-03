
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String initialCountryCode;
  final String? initialValue;
  final Function(String? newPhoneNumber) onPhoneNumberChanged;

  const PhoneFieldWidget({
    super.key,
    required this.controller,
    required this.text,
    required this.initialCountryCode,
    this.initialValue,
    required this.onPhoneNumberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Yuqoridagi Matn
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),

        // IntlPhoneField ni to'g'ridan-to'g'ri ishlatish
        IntlPhoneField(
          controller: controller,
          initialCountryCode: initialCountryCode,
          initialValue: initialValue,

          // Raqam o'zgarganda orqa fonda (backend) yuborish uchun ma'lumotni tayyorlaymiz
          onChanged: (phone) {
            // Faqat raqamning o'zi o'zgarishi bilan funksiya chaqiriladi
            onPhoneNumberChanged(phone.completeNumber);
          },

          // Dizaynni sizning boshqa TextField'laringizga moslash
          decoration: InputDecoration(
            hintText: '90 123 45 67',
            // labelText o'rniga, matn yuqorida ko'rsatilgani uchun to'g'ridan-to'g'ri InputDecoration beramiz

            // Chegaralarni TextFieldAndText dagi kabi sozlash
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            // ... boshqa chegaralar (errorBorder) ham shunga o'xshash bo'lishi kerak

            // Kiritish maydoniga moslash uchun ichki paddingni o'rnatish
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),

          // Bayroq va kodni ko'rsatish stilini sozlash
          dropdownTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
          style: const TextStyle(fontSize: 16),

          // Dropdown o'qini ko'rsatish
          showDropdownIcon: true,

          // Kod raqam bilan birga bo'lishi uchun, alohida chiziqchani olib tashlash:
          disableLengthCheck: true, // Uzunlikni tekshirmaslik
        ),
      ],
    );
  }
}