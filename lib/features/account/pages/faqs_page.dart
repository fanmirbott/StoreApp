import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import 'package:storeapp/features/home/widgets/bottom_navigation_bar_app.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/icons.dart';

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}

final Map<String, List<FaqItem>> allFaqs = {
  'General': [
    FaqItem(
      question: "How do I make a purchase?",
      answer:
          "When you find a product you want to purchase, tap on it to view the product details. Check the price, description, and available options (if applicable), and then tap the \"Add to Cart\" button. Follow the on-screen instructions to complete the purchase, including providing shipping details and payment information.",
    ),
    FaqItem(
      question: "What payment methods are accepted?",
      answer:
          "We accept Visa, MasterCard, PayPal, and local bank transfers. All transactions are secure and encrypted.",
    ),
    FaqItem(
      question: "How do I track my orders?",
      answer:
          "You can track your order status by visiting the 'Orders' section in your Account profile. A tracking number will be provided once your item ships.",
    ),
    FaqItem(
      question: "Can I cancel or return an order?",
      answer:
          "Yes, you can cancel or return an order within 30 days of delivery. Please refer to our detailed Returns Policy for specific conditions.",
    ),
    FaqItem(
      question: "How can I contact customer support for assistance?",
      answer:
          "You can reach our customer support team via the in-app chat function, email, or by calling our toll-free number during business hours.",
    ),
  ],

  'Account': [
    FaqItem(
      question: "How do I reset my password?",
      answer:
          "Go to the 'Login' screen and click 'Forgot Password'. Follow the instructions sent to your registered email address.",
    ),
    FaqItem(
      question: "How do I update my personal information?",
      answer:
          "You can update your name, email, and shipping addresses in the 'Profile Settings' section of your Account.",
    ),
    FaqItem(
      question: "Is my personal data safe?",
      answer:
          "We use industry-standard encryption and security protocols to ensure your personal data is protected.",
    ),
  ],

  'Service': [
    FaqItem(
      question: "What are your shipping options and costs?",
      answer:
          "We offer standard and express shipping. Shipping costs vary based on the destination and the chosen speed. Details are provided at checkout.",
    ),
    FaqItem(
      question: "Do you offer international shipping?",
      answer:
          "Yes, we ship to over 50 countries worldwide. Please check our shipping policy for the full list of supported regions.",
    ),
    FaqItem(
      question: "How do I use a promotion code?",
      answer:
          "Enter your promotion code in the dedicated field during the checkout process before finalizing your payment.",
    ),
  ],

  'Pay': [
    FaqItem(
      question: "When will I be charged for my order?",
      answer:
          "Your card is typically charged immediately upon confirmation of your order.",
    ),
    FaqItem(
      question: "What should I do if my payment fails?",
      answer:
          "If your payment fails, please double-check your card details, ensure sufficient funds, or try an alternative payment method.",
    ),
    FaqItem(
      question: "Do you save my credit card information?",
      answer:
          "For your security, we do not store full credit card details on our servers. They are securely processed by our payment partners.",
    ),
  ],
};

class FaqsPage extends StatefulWidget {
  const FaqsPage({super.key});

  @override
  State<FaqsPage> createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  final List<String> tabs = ['General', 'Account', 'Service', 'Pay'];
  String _selectedTab = 'General';

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildTabButton(String tabText) {
    final Color primaryColor = AppColors.primary;

    final bool isSelected = _selectedTab == tabText;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = tabText;
          _searchController.clear();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Text(
          tabText,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            color: isSelected ? Colors.white : AppColors.primary500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<FaqItem> currentFaqs = allFaqs[_selectedTab] ?? [];
    return Scaffold(
      appBar: AppBarWidgets(text: 'FAQs'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              child: Row(
                children: tabs
                    .map(
                      (tab) => Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: _buildTabButton(tab),
                      ),
                    )
                    .toList(),
              ),
            ),

            SizedBox(height: 20.h),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  borderRadius: BorderRadius.circular(40.r),
                  onTap: () {},
                  child: SvgPicture.asset(
                    AppIcons.mic,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                prefixIcon: SvgPicture.asset(
                  AppIcons.search,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.scaleDown,
                ),
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: AppColors.primary200,
                ),
                hintText: 'Search for questions...',

                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.primary100,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.primary100,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: currentFaqs.length,
                itemBuilder: (context, index) {
                  final faq = currentFaqs[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 4.h,
                          ),
                          collapsedIconColor: AppColors.primary500,
                          iconColor: AppColors.primary,
                          title: Text(
                            faq.question,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary500,
                            ),
                          ),
                          trailing: Icon(Icons.keyboard_arrow_down, size: 28.w),

                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                bottom: 16.h,
                                top: 0,
                              ),
                              child: Text(
                                faq.answer,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primary200,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarApp(),
    );
  }
}
