// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:open_sky_weather/business_logic/core/constants.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';
import 'package:open_sky_weather/business_logic/utilities/ui_utils.dart';
import 'package:open_sky_weather/ui/screens/settings/privacy_policy_screen.dart';
import 'package:open_sky_weather/ui/screens/settings/team_screen.dart';
import 'package:open_sky_weather/ui/screens/settings/temrs_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final InAppReview inAppReview = InAppReview.instance;

  InkWell _buildRow(String divisionName, Function function, {IconData? icon}) => InkWell(
        onTap: () {
          function();
        },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: hexToColor("#444444"),
              ),
            ),
          ),
          child: Row(
            children: [
              if (icon != null)
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 18),
                  ],
                )
              else
                const SizedBox(),
              Text(
                divisionName,
                style: buttonMediumTextStyle,
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.black,
      ),
      backgroundColor: aColor.brandDark2.color,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(24),
              height: 70,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/logo.svg",
                    width: 64,
                    height: 64,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    appName,
                    style: h6MediumTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildRow(
                    "About Us",
                    () {
                      Get.to(() => TeamScreen());
                    },
                    icon: CupertinoIcons.person_3,
                  ),
                  _buildRow(
                    "Rate This App",
                    () async {
                      inAppReview.openStoreListing();
                      // if (await inAppReview.isAvailable()) {
                      //   await inAppReview.requestReview();
                      // } else {
                      //   inAppReview.openStoreListing();
                      // }
                    },
                    icon: Icons.star_border,
                  ),
                  _buildRow("Terms & Condition", () {
                    Get.to(() => TermsScreen());
                  }),
                  _buildRow("Privacy Policy", () {
                    Get.to(() => PrivacyPolicyScreen());
                  }),
                  // _buildRow("Credit", () {
                  //   openWebLink("");
                  // }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //todo:: move it to controller
  Future<void> openWebLink(String link) async {
    try {
      await launchUrl(Uri.parse(link));
    } catch (exception) {
      debugPrint(exception.toString());
    }
    // await canLaunch(link) ? await launch(link) : throw 'Could not open link';
  }
}
