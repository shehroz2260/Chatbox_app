import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_colors.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/view/main_view/contacts_tab/contact_tab_view.dart';
import 'package:practice_project/widgets/back_button.dart';
import 'package:practice_project/widgets/custom_textfield.dart';
import 'package:practice_project/widgets/thread_widget.dart';
import 'package:resize/resize.dart';
import '../../models/thread_model.dart';
import '../../models/user_model.dart';
import 'search_controller.dart';

class SearchView extends StatelessWidget {
  final List<UserModel> users;
  final List<ThreadModel> threads;
  const SearchView({super.key, required this.users, required this.threads});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchViewController());
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: GetBuilder<SearchViewController>(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppGap.height60,
              const BackButtonWidget(),
              AppGap.height16,
              CustomTextField(
                  onChanged: controller.handleSearch,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      AppAssets.searchIcon,
                      colorFilter: const ColorFilter.mode(
                          AppColors.blackColor, BlendMode.srcIn),
                    ),
                  ),
                  isSearchField: true,
                  filled: true,
                  hintText: "Searching......",
                  fillColor: AppColors.lightGreyColor,
                  titleText: ""),
              AppGap.height16,
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      users.isEmpty ? threads.length : users.length,
                      (index) => users.isEmpty
                          ? (threads[index]
                                  .userDetail!
                                  .name
                                  .toLowerCase()
                                  .contains(controller.searchText)
                              ? ThreadWidget(
                                  isSearchView: true,
                                  model: threads[index],
                                )
                              : const SizedBox())
                          : (users[index]
                                  .name
                                  .toLowerCase()
                                  .contains(controller.searchText)
                              ? ContactWidget(
                                  model: users[index],
                                  index: index,
                                )
                              : const SizedBox())),
                ),
              ))
            ],
          );
        }),
      ),
    );
  }
}
