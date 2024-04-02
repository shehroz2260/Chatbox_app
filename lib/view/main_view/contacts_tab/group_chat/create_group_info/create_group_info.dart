import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/widgets/app_cached_image.dart';
import 'package:practice_project/widgets/custom_button.dart';
import 'package:practice_project/widgets/custom_textfield.dart';
import 'package:resize/resize.dart';
import '../../../../../models/user_model.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_gap.dart';
import '../../../../../utils/app_text_style.dart';
import '../../../../../widgets/back_button.dart';
import 'create_group_info_controller.dart';

class CreateGroupInfo extends StatelessWidget {
  final List<UserModel> selectedUserList;
  final List<String> idList;
  const CreateGroupInfo(
      {super.key, required this.selectedUserList, required this.idList});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateGroupInfoController(idList));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: AppColors.blackColor,
        child: GetBuilder<CreateGroupInfoController>(builder: (context) {
          return Column(
            children: [
              AppGap.height60,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButtonWidget(
                      isBackWhite: false,
                    ),
                    Text(
                      "Create Group",
                      style: AppTextStyle.carosFont20,
                    ),
                    SizedBox(width: 8.w)
                  ],
                ),
              ),
              AppGap.height30,
              Expanded(
                child: Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32)),
                      color: AppColors.appBgColor),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child:
                      GetBuilder<CreateGroupInfoController>(builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppGap.height40,
                        GestureDetector(
                          onTap: controller.imagePicker,
                          child: Container(
                            height: 200.h,
                            width: 200.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColors.borderColor)),
                            child: controller.pickedFile == null
                                ? const Icon(
                                    Icons.add,
                                    color: AppColors.borderColor,
                                  )
                                : ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(200)),
                                    child: Image.file(
                                      controller.pickedFile!,
                                      fit: BoxFit.cover,
                                      width: Get.width,
                                    ),
                                  ),
                          ),
                        ),
                        AppGap.height30,
                        CustomTextField(
                          hintText: "Create Group Name",
                          controller: controller.nameController,
                        ),
                        AppGap.height30,
                        CustomButton(
                          onTap: controller.createGroupThread,
                          name: "Next",
                          buttonColor: AppColors.greenColor,
                          textColor: AppColors.appBgColor,
                        ),
                        AppGap.height30,
                        const Divider(
                          height: 0,
                          color: AppColors.borderColor,
                        ),
                        SizedBox(height: 6.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                  selectedUserList.length,
                                  (index) => Padding(
                                        padding: EdgeInsets.only(right: 5.w),
                                        child: AppCacheImage(
                                          imageUrl:
                                              selectedUserList[index].profile,
                                          height: 40.h,
                                          width: 40.w,
                                          round: 40,
                                        ),
                                      )),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
