import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:practice_project/utils/app_assets.dart';
import 'package:practice_project/utils/app_gap.dart';
import 'package:practice_project/utils/app_text_style.dart';
import 'package:resize/resize.dart';

class CallTabView extends StatelessWidget {
  const CallTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppGap.height40,
        Text(
          'Recent',
          style: AppTextStyle.carosFont16,
        ),
        AppGap.height16,
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: List.generate(
                20,
                (index) => const CallWidget(
                      name: "Jhon Abraham",
                      profile: "assets/images/pngs/dummy (2).png",
                      time: "Today, 09:30 AM",
                    )),
          ),
        ))
      ],
    );
  }
}

class CallWidget extends StatelessWidget {
  final String profile, name, time;
  const CallWidget({
    super.key,
    required this.profile,
    required this.name,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h),
      child: Row(
        children: [
          Container(
            height: 52.h,
            width: 52.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(
              profile,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyle.carosFont18),
              Text(
                time,
                style: AppTextStyle.circularFont12,
              )
            ],
          ),
          const Spacer(),
          SvgPicture.asset(AppAssets.callLogo),
          SizedBox(width: 10.w),
          SvgPicture.asset(
            AppAssets.videoCall,
            colorFilter:
                const ColorFilter.mode(Color(0xff989E9C), BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
