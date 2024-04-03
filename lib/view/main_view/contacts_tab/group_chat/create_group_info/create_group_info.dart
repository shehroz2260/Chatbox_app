import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_project/controllers/admin_base_controller.dart';
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
              // AppGap.height60,
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 24),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const BackButtonWidget(
              //         isBackWhite: false,
              //       ),
              //       Text(
              //         "Create Group",
              //         style: AppTextStyle.carosFont20,
              //       ),
              //       SizedBox(width: 8.w)
              //     ],
              //   ),
              // ),
              // AppGap.height30,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGap.height60,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButtonWidget(),
                            Text(
                              "Create Group",
                              style: AppTextStyle.carosFont16,
                            ),
                            SizedBox(width: 8.w)
                          ],
                        ),
                        AppGap.height30,
                        Text(
                          "Group Description",
                          style: AppTextStyle.carosFont16.copyWith(
                              color: AppColors.greyTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                        AppGap.height16,
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: controller.imagePicker,
                            child: Container(
                              height: 100.h,
                              width: 100.w,
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
                        ),
                        AppGap.height16,
                        CustomTextField(
                          titleText: "Make Group for",
                          controller: controller.nameController,
                        ),
                        AppGap.height16,
                        Text(
                          "Group Admin",
                          style: AppTextStyle.carosFont16.copyWith(
                              color: AppColors.greyTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                        AppGap.height16,
                        Row(
                          children: [
                            AppCacheImage(
                              imageUrl: AdminBaseController.userData.profile,
                              height: 44.h,
                              width: 44.w,
                              round: 44,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AdminBaseController.userData.name,
                                  style: AppTextStyle.carosFont16
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Group Admin",
                                  style: AppTextStyle.circularFont12
                                      .copyWith(fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                        AppGap.height30,
                        Text(
                          "Invited members",
                          style: AppTextStyle.carosFont16.copyWith(
                              color: AppColors.greyTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                        AppGap.height16,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.zero,
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
                        ),
                        const Spacer(),
                        CustomButton(
                          onTap: controller.createGroupThread,
                          name: "Create",
                          buttonColor: AppColors.greenColor,
                          textColor: AppColors.appBgColor,
                        ),
                        AppGap.height30
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
