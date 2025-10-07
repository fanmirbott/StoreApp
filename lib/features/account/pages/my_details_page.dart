import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storeapp/core/utils/colors.dart';
import 'package:storeapp/core/utils/icons.dart';
import 'package:storeapp/features/account/widgets/button_widget.dart';
import 'package:storeapp/features/account/widgets/gender_dropdown_widget.dart';
import 'package:storeapp/features/account/widgets/phone_input_field.dart';
import 'package:storeapp/features/auth/widgets/text_field_and_text.dart';
import 'package:storeapp/features/common/widgets/app_bar_widgets.dart';
import '../../../core/utils/status.dart';
import '../../../data/models/me_model.dart';
import '../managers/userBloc/user_bloc.dart';
import '../managers/userBloc/user_state.dart';
import '../managers/updateUserBloc/update_user_bloc.dart';
import '../managers/updateUserBloc/update_user_state.dart';

class MyDetailsPage extends StatefulWidget {
  const MyDetailsPage({super.key});

  @override
  State<MyDetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController dataController;
  late TextEditingController phoneNumberController;

  String? selectedGender;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    dataController = TextEditingController();
    phoneNumberController = TextEditingController();
    context.read<UserBloc>().add(FetchUser());
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    dataController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(text: 'My Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: BlocListener<UpdateUserBloc, UpdateUserState>(
          listener: (context, updateState) {
            if (updateState.status == Status.loading) {
            } else if (updateState.status == Status.success) {
              showDialog(
                context: context,
                builder: (context) => Align(
                  alignment: AlignmentGeometry.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    width: 300.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h,),
                        SvgPicture.asset(
                          AppIcons.checkDoutone,
                          width: 89.w,
                          height: 89.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          "Successfully!",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          "Profile updated",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.sp,
                            color: AppColors.primary500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (updateState.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    updateState.errorMessage ?? "Error updating profile",
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == Status.error) {
                return Center(child: Text(state.errorMessage ?? "Error"));
              }
              if (state.user == null) {
                return const Center(child: Text("No user data"));
              }

              fullNameController.text = state.user!.fullName;
              emailController.text = state.user!.email;
              dataController.text = state.user!.birthDate;
              phoneNumberController.text = state.user!.phoneNumber;
              selectedGender = selectedGender ?? state.user!.gender;

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  spacing: 16,
                  children: [
                    const Divider(),
                    SizedBox(height: 5.h),
                    TextFieldAndText(
                      controller: fullNameController,
                      text: "Full Name",
                      hintText: "Full Name",
                    ),
                    TextFieldAndText(
                      controller: emailController,
                      text: 'Email Address',
                      hintText: 'Email Address',
                    ),
                    TextFieldAndText(
                      controller: dataController,
                      text: 'Date of Birth',
                      hintText: '12/07/1990',
                      suffixIcon: InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                DateTime.tryParse(state.user!.birthDate) ??
                                DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                "${pickedDate.day.toString().padLeft(2, '0')}/"
                                "${pickedDate.month.toString().padLeft(2, '0')}/"
                                "${pickedDate.year}";
                            dataController.text = formattedDate;
                          }
                        },
                        child: SvgPicture.asset(
                          AppIcons.calendar,
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    GenderDropdown(
                      initialValue: state.user!.gender,
                      onChanged: (newGender) {
                        setState(() {
                          selectedGender = newGender;
                        });
                      },
                    ),
                    PhoneFieldWidget(
                      controller: phoneNumberController,
                      text: 'Phone Number',
                      initialValue: state.user!.phoneNumber,
                      onPhoneNumberChanged: (newPhoneNumber) {
                        setState(() {
                          phoneNumberController.text = newPhoneNumber!;
                        });
                      },
                      initialCountryCode: 'UZ',
                    ),
                    SizedBox(height: 104.h),
                    ButtonWidget(
                      width: 341.w,
                      onTap: () {
                        final current = state.user!;
                        final updatedUser = UserModel(
                          id: current.id,
                          fullName: fullNameController.text.trim(),
                          email: emailController.text.trim(),
                          phoneNumber: phoneNumberController.text.trim(),
                          gender: selectedGender ?? current.gender,
                          birthDate: dataController.text.trim(),
                        );
                        context.read<UpdateUserBloc>().add(
                          UpdateUserStarted(user: updatedUser),
                        );
                      },
                      text: 'Submit',
                      buttonColor: AppColors.primary,
                      textColor: AppColors.white,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
