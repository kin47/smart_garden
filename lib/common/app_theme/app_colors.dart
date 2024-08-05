// coverage:ignore-file

import 'package:flutter/material.dart';

class AppColors {
  ///primary
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFE60313);
  static const Color yellow = Color(0xFFFF9900);
  static const Color yellow2 = Color(0xFFD07D01);
  static const Color green = Color(0xFF049844);
  static const Color green2 = Color(0xFF119B4C);
  static const Color gray050 = Color(0xFFF7F7F7);
  static const Color gray100 = Color(0xFFEDEDED);
  static const Color gray150 = Color(0xFFD9D9D9);
  static const Color gray200 = Color(0xFFCCCCCC);
  static const Color gray300 = Color(0xFFB2B2B2);
  static const Color gray400 = Color(0xFF999999);
  static const Color gray500 = Color(0xFF7F7F7F);
  static const Color gray600 = Color(0xFF656565);
  static const Color gray700 = Color(0xFF4c4c4c);
  static const Color gray800 = Color(0xFF323232);
  static const Color gray900 = Color(0xFF191919);
  static const Color grayE6 = Color(0xFFE6E7EA);
  static const Color black = Color(0xFF000000);
  static const Color black22 = Color(0xFF222222);

  ///primary
  static const Color primary050 = Color(0xFFf2f7f8);
  static const Color primary100 = Color(0xFFD4EFF7);
  static const Color primary200 = Color(0xFFd4eff7);
  static const Color primary300 = Color(0xFF68b4cb);
  static const Color primary400 = Color(0xFF178caf);
  static const Color primary500 = Color(0xFF0E6C8B);
  static const Color primary700 = Color(0xFF083c4d);
  static const Color primary900 = Color(0xFF062631);

  ///secondary

  static const Color secondary200 = Color(0xFFefbe7c);
  static const Color secondary300 = Color(0xFFf47f35);
  static const Color secondary500 = Color(0xFFed640e);
  static const Color secondary700 = Color(0xFFb7500f);

  static const Color transparent = Colors.transparent;

  ///base

  static const Color base100 = Color(0xFFF7F2EC);
  static const Color base200 = Color(0xFFF5EBDF);
  static const Color base300 = Color(0xFFEDDFD0);
  static const Color base350 = Color(0xFFE0CDB9);
  static const Color base500 = Color(0xFFD3bca1);

  ///special
  static const Color danger = Color(0xFFe0032d);
  static const Color textLink = Color(0xFF0a64cc);

  ///Icon color
  static const Color iconDisabled = Color(0xFF999999);
  static const Color iconEnabled = Color(0xFFED640E);

  //shadow
  static const Color shadow = Color(0xFF000029);
  static const Color shadow2 = Color(0x52000000);

  ///---------------- color from common--------------------///
  static const Color deepDark = Color(0xFF001626);
  static const Color primary = Color(0xFF102436);

  ///secondary
  static const Color background = Color(0xFFF6F5F3);
  static const Color bottomBarColor = Color(0xFFF1E4D5);
  static const Color stroke = Color(0xFFEBEBEB);

  ///products
  static const Color lightRed = Color(0xFFCB7373);

  ///branding
  static const Color brandingOwen = Color(0xFFCEE1FF);
  static const Color brandingWinny = Color(0xFFF38EAD);
  static const Color brandingDunlop = Color(0xFFD7FC51);
  static const Color brandingBHPolo = Color(0xFFB7B0A3);

  ///alert
  static const Color alertError = Color(0xFFFE5050);
  static const Color alertSuccess = Color(0xFF6DC68E);
  static const Color alertLink = Color(0xFF007AFF);
  static const Color alertWarning = Color(0xFFFFCC00);

  ///icon
  static const Color ellipse7 = Color(0xFFE82828);
  static const Color yellowGreen = Color(0xFFA1D239);
  static const Color lightRedWinny = Color(0xFFFBC8CD);
  static const Color silverFoil = Color(0xFFB7B0A3);
  static const Color richElectricBlue = Color(0xFF0291D7);

  /// more color
  static const Color ghostWhite = Color(0xffF6F5F3);
  static const Color superSliver = Color(0xffEFEFEF);
  static const Color blackBanner = Color(0xff001626);
  static const Color datePickerTheme = Color(0xff0D607D);

  static const Color lineSeparated = Color(0xff777068);
  static const Color deleteAccountWarning = Color(0xffFDCD84);

  /// close button
  static const Color closeButton = Color(0xff323232);
  static const Color closeButtonHover = Color(0xffB3B9BE);

  /// color evaluate
  static const Color textEvaluate = Color(0xff77757F);
  static const Color starRatedColor = Color(0xffFDAA63);
  static const Color dividerDialog = Color(0xffE8E8EA);

  static const Color notificationBg = Color(0xff2F304D);

  static const Color grey200 = Color(0xffC5C5C5);
  static const Color grey600 = Color(0xff737373);
  static const Color grey800 = Color(0xff454545);

  ///background
  static const Color backgroundGrey1 = Color(0xffFFFFFF);
  static const Color backgroundGrey3 = Color(0xffF2F3F5);

  /// color from hex String
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
