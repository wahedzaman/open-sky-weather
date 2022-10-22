// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TermsScreen extends StatelessWidget {
  TermsScreen({super.key});
  RxString htmlString = "".obs;

  @override
  Widget build(BuildContext context) {
    _loadSeedData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Condition"),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.black,
      ),
      // backgroundColor: aColor.brandDark2.color,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Html(
              data: htmlString.value,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadSeedData() async {
    htmlString.value = await rootBundle.loadString('assets/terms.html');
  }
}
