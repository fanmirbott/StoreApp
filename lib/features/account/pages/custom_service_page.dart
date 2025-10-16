import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/account/managers/chatBloc/chat_bloc.dart';
import 'package:storeapp/features/account/managers/chatBloc/chat_state.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import 'package:storeapp/features/common/widgets/text_field_widget_chat.dart';
import 'package:image_picker/image_picker.dart';

class CustomServicePage extends StatefulWidget {
  const CustomServicePage({super.key});

  @override
  State<CustomServicePage> createState() => _CustomServicePageState();
}

class _CustomServicePageState extends State<CustomServicePage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      print('Rasm tanlandi: ${image.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) => Scaffold(
        appBar: AppBarWidgets(
          text: 'Customer Service',
          icon: AppIcons.phone,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 10),
                    itemCount: state.messages.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) => Align(
                      alignment: state.messages[index]["direction"] == "to"
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: 200,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: state.messages[index]["direction"] == "to"
                              ? Colors.grey
                              : AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.messages[index]["message"],
                              textAlign: TextAlign.justify,
                              style: TextStyle(color: AppColors.white),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                DateFormat("HH:mm").format(
                                  DateTime.parse(state.messages[index]["date"]),
                                ),
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Expanded(
                        child: TextFieldWidgetChat(
                          onChanged: (count) {
                            setState(() {});
                          },
                          controller: controller,
                          hintText: 'Write your message...',
                          suffixIcon: controller.text.isEmpty
                              ? IconButton(
                                  onPressed:() =>  _selectedImage,
                                  icon: SvgPicture.asset(
                                    AppIcons.image,
                                    width: 24.w,
                                    height: 24.h,
                                    fit: BoxFit.scaleDown,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    context.read<ChatBloc>().add(
                                      ChatMessageSend(message: controller.text),
                                    );
                                    controller.text = "";
                                  },
                                  icon: Icon(Icons.send),
                                ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          width: 52.w,
                          height: 52.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.primary,
                          ),
                          alignment: AlignmentGeometry.center,
                          child: SvgPicture.asset(AppIcons.mic),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
