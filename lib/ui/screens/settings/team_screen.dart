import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:open_sky_weather/business_logic/controller/team_screen_controller.dart';
import 'package:open_sky_weather/business_logic/model/team.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamScreen extends StatelessWidget {
  TeamScreen({super.key});
  final TeamScreenController teamScreenController = Get.put(TeamScreenController());
  final RefreshController _refreshController = RefreshController();

  Future<void> _onRefresh() async {
    debugPrint("refreshing");
    await teamScreenController.callAPI();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    teamScreenController.callAPI();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Team"),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GetBuilder<TeamScreenController>(
          init: teamScreenController,
          builder: (controller) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () => _onRefresh(),
              header: const WaterDropMaterialHeader(
                backgroundColor: Colors.white,
              ),
              child: Material(
                child: Container(
                  color: aColor.brandDark.color,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: (teamScreenController.teamList.isEmpty)
                      ? _showLoading()
                      : ListView.builder(
                          primary: false,
                          itemCount: teamScreenController.teamList.length,
                          itemBuilder: (context, index) {
                            final team = teamScreenController.teamList[index];
                            return Container(
                              padding: EdgeInsets.all(Get.width * .04),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: aColor.brandDark2.color,
                                borderRadius: BorderRadius.circular(Get.width * .04),
                              ),
                              child: _buildSocialRow(team),
                            ).marginOnly(bottom: 12);
                          },
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox _showLoading() => SizedBox(
        width: Get.width,
        height: Get.height * .8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ).paddingOnly(right: Get.width * .04),
            Text(
              "Requesting Data!",
              style: TextStyle(
                fontFamily: 'Metropolis',
                color: Colors.white,
                fontSize: Get.width * .05,
              ),
            ),
          ],
        ),
      );

  Row _buildSocialRow(Team team) {
    return Row(
      children: [
        SizedBox(
          // padding: EdgeInsets.all(Get.width * .02),
          width: Get.width * .2,
          height: Get.width * .2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Get.width * .02),
            child: Image(
              image: NetworkImage(
                team.avatar!,
              ),
            ),
          ),
        ),
        SizedBox(width: Get.width * .04),
        SizedBox(
          width: Get.width * .62,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                team.name!,
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: Get.width * .045,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              if (team.bio != null)
                Text(
                  team.bio!,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: Get.width * .04,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(.6),
                  ),
                ).paddingSymmetric(
                  vertical: Get.width * .02,
                ),
              Row(
                children: [
                  social(
                    team.facebook,
                    FontAwesomeIcons.facebook,
                  ),
                  social(
                    team.twitter,
                    FontAwesomeIcons.twitter,
                  ),
                  social(
                    team.web,
                    Icons.language,
                  ),
                  social(
                    team.email,
                    Icons.email,
                  ),
                  social(
                    team.linkedin,
                    FontAwesomeIcons.linkedin,
                  ),
                  social(
                    team.instagram,
                    FontAwesomeIcons.instagram,
                  ),
                ],
              ).paddingSymmetric(
                vertical: Get.width * .02,
              )
            ],
          ),
        )
      ],
    );
  }

  Widget social(String? link, IconData icon) {
    if (link != null) {
      return InkWell(
        onTap: () => openWebLink(link),
        child: Icon(
          icon,
          color: Colors.white.withOpacity(.7),
          size: Get.width * .055,
        ),
      ).paddingOnly(right: Get.width * .03);
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<void> openWebLink(String link) async {
    try {
      await launchUrl(Uri.parse(link));
    } catch (exception) {
      debugPrint('Could not open link ${exception.toString()}');
    }
  }
}
