// ignore_for_file: always_use_package_imports, camel_case_extensions

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ui_utils.dart';

// ignore: camel_case_types
enum aColor {
  grey,
  greyDark,
  brandDark,
  brandDark2,
  blueBtnOutline,
  blueBtnFill,
  pinkBtnOutline,
  pinkBtnFill,
  orangeBtnOutline,
  orangeBtnFill,
  limeBtnOutline,
  limeBtnFill,
  hospitalListItemOutline,
  textGreen,
  textRed,
}

extension aColorExtension on aColor {
  Color get color {
    switch (this) {
      case aColor.grey:
        return hexToColor("#C4C4C4");
      case aColor.greyDark:
        return hexToColor("#85949F");
      case aColor.brandDark2:
        return hexToColor("#262626");
      case aColor.blueBtnFill:
        return hexToColor("#E3E6FF");
      case aColor.blueBtnOutline:
        return hexToColor("#7480FF");
      case aColor.pinkBtnFill:
        return hexToColor("#F9DEE6");
      case aColor.pinkBtnOutline:
        return hexToColor("#BE71A0");
      case aColor.orangeBtnFill:
        return hexToColor("#FEEFCF");
      case aColor.orangeBtnOutline:
        return hexToColor("#F9A84B");
      case aColor.limeBtnFill:
        return hexToColor("#DCFBEE");
      case aColor.limeBtnOutline:
        return hexToColor("#49C0B8");
      case aColor.hospitalListItemOutline:
        return hexToColor("#EAF2F5");
      case aColor.textGreen:
        return hexToColor("#3AA76D");
      case aColor.textRed:
        return hexToColor("#E25822");
      default:
        return Colors.black;
    }
  }
}

final temperatureBoldLarge = TextStyle(
  fontSize: 40.sp,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

const h1RegularTextStyle = TextStyle(
  fontSize: 30,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

const h2RegularTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

const h3RegularTextStyle = TextStyle(
  fontSize: 22,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

const h4RegularTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

final h5RegularTextStyle = TextStyle(
  fontSize: 18.sp,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

final h6RegularTextStyle = TextStyle(
  fontSize: 16.sp,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

final h7RegularTextStyle = TextStyle(
  fontSize: 15.sp,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

final h8RegularTextStyle = TextStyle(
  fontSize: 12.sp,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

final h9RegularTextStyle = TextStyle(
  fontSize: 10.sp,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

final h7BoldTextStyle = TextStyle(
  fontSize: 15.sp,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontFamily: 'Metropolis',
);

final h8BoldTextStyle = TextStyle(
  fontSize: 12.sp,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontFamily: 'Metropolis',
);

const h5BoldTextStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

const h5RegularextStyle = TextStyle(
  fontSize: 40,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

const h6RegularextStyle = TextStyle(
  fontSize: 28,
  color: Colors.white,
  fontFamily: 'Metropolis',
);

const h6MediumTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: 20,
  fontWeight: FontWeight.w500,
  height: 1.4,
  color: Colors.white,
);

const subheading1LightTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: 14,
  fontWeight: FontWeight.w200,
  height: 1.01,
  letterSpacing: 0.15,
);

final subheading2MediumTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  color: Colors.white,
  fontSize: ScreenUtil().setSp(14),
  fontWeight: FontWeight.w700,
  height: 1.01,
);

final body1RegularTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: ScreenUtil().setSp(15),
  color: Colors.white,
  fontWeight: FontWeight.w300,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.5,
);

final body1MediumTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: ScreenUtil().setSp(16),
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
  height: 1.01,
);

final body1BoldTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: ScreenUtil().setSp(16),
  color: Colors.white,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.normal,
  height: 1.5,
);

final body2RegularTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: ScreenUtil().setSp(14),
  color: hexToColor("#949494"),
  fontWeight: FontWeight.w300,
  fontStyle: FontStyle.normal,
  height: 1.01,
  letterSpacing: 0.3,
);

final buttonMediumTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  color: Colors.white,
  fontSize: ScreenUtil().setSp(14),
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
);

final captionRegularTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: ScreenUtil().setSp(13),
  color: Colors.white,
  fontWeight: FontWeight.w300,
  fontStyle: FontStyle.normal,
  height: 1.2,
);

final caption2RegularTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: ScreenUtil().setSp(10),
  fontWeight: FontWeight.w300,
  color: Colors.white,
  fontStyle: FontStyle.normal,
  height: 1.2,
);

final overLineRegularTextStyle = TextStyle(
  fontFamily: 'Metropolis',
  fontSize: ScreenUtil().setSp(10),
  fontWeight: FontWeight.w700,
  color: Colors.white,
  fontStyle: FontStyle.normal,
  height: 1.01,
  letterSpacing: 1,
);
