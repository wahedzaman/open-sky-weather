import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future showInformativeDialog(
  String title,
  String description, {
  String? icon,
  TextButton? button,
}) {
  return Get.defaultDialog(
    barrierDismissible: false,
    titlePadding: const EdgeInsets.all(15),
    titleStyle: const TextStyle(
      fontFamily: 'Metropolis',
      fontSize: 22,
    ),
    middleTextStyle: const TextStyle(
      fontFamily: 'Metropolis',
      fontSize: 18,
    ),
    contentPadding: const EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 20,
    ),
    title: title,
    buttonColor: Colors.black,
    confirmTextColor: Colors.white,
    cancelTextColor: Colors.black,
    actions: [
      if (button != null) button else Container(),
    ],
    content: Column(
      children: [
        if (icon != null)
          Image.asset(
            icon,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          )
        else
          Container(),
        const SizedBox(
          height: 20,
        ),
        Text(description),
      ],
    ),
  );
}
