import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';
// import 'package:local_auth/local_auth.dart';

class AppColors {
  // Some constants not themed
  static const overlay70 = Color(0xB3000000);
  static const overlay85 = Color(0xD9000000);
}

class BaseTheme {
  BaseTheme({
    required this.primary,
    required this.primary60,
    required this.primary45,
    required this.primary30,
    required this.primary20,
    required this.primary15,
    required this.primary10,
    required this.success,
    required this.success60,
    required this.success30,
    required this.success15,
    required this.successDark,
    required this.successDark30,
    required this.background,
    required this.background40,
    required this.background00,
    required this.backgroundDark,
    required this.backgroundDark00,
    required this.backgroundDarkest,
    required this.text,
    required this.text60,
    required this.text45,
    required this.text30,
    required this.text20,
    required this.text15,
    required this.text10,
    required this.text5,
    required this.text03,
    required this.overlay90,
    required this.overlay85,
    required this.overlay80,
    required this.overlay70,
    required this.overlay50,
    required this.overlay30,
    required this.overlay20,
    required this.barrier,
    required this.barrierWeaker,
    required this.barrierWeakest,
    required this.barrierStronger,
    required this.animationOverlayMedium,
    required this.animationOverlayStrong,
    required this.brightness,
    required this.statusBar,
    required this.boxShadow,
    required this.boxShadowButton,
  });
  Color primary;
  Color primary60;
  Color primary45;
  Color primary30;
  Color primary20;
  Color primary15;
  Color primary10;

  Color success;
  Color success60;
  Color success30;
  Color success15;
  Color successDark;
  Color successDark30;
  Color background;
  Color background40;
  Color background00;
  Color backgroundDark;
  Color backgroundDark00;
  Color backgroundDarkest;
  Color text;
  Color text60;
  Color text45;
  Color text30;
  Color text20;
  Color text15;
  Color text10;
  Color text5;
  Color text03;
  Color overlay90;
  Color overlay85;
  Color overlay80;
  Color overlay70;
  Color overlay50;
  Color overlay30;
  Color overlay20;
  Color barrier;
  Color barrierWeaker;
  Color barrierWeakest;
  Color barrierStronger;
  Color animationOverlayMedium;
  Color animationOverlayStrong;
  Brightness brightness;
  SystemUiOverlayStyle statusBar;
  BoxShadow boxShadow;
  BoxShadow boxShadowButton;

  // QR scanner theme
  // OverlayTheme qrScanTheme;
  // App icon (iOS only)
}

class SarafuTheme extends BaseTheme {
  SarafuTheme()
      : super(
          primary: yellow,
          primary60: yellow.withOpacity(0.6),
          primary45: yellow.withOpacity(0.45),
          primary30: yellow.withOpacity(0.3),
          primary20: yellow.withOpacity(0.2),
          primary15: yellow.withOpacity(0.15),
          primary10: yellow.withOpacity(0.1),
          success: green,
          success60: green.withOpacity(0.6),
          success30: green.withOpacity(0.3),
          success15: green.withOpacity(0.15),
          successDark: greenDark,
          successDark30: greenDark.withOpacity(0.3),
          background: greyLight,
          background40: greyLight.withOpacity(0.4),
          background00: greyLight.withOpacity(0),
          backgroundDark: greyDark,
          backgroundDark00: greyDark.withOpacity(0),
          backgroundDarkest: greyDarkest,
          text: white.withOpacity(0.9),
          text60: white.withOpacity(0.6),
          text45: white.withOpacity(0.45),
          text30: white.withOpacity(0.3),
          text20: white.withOpacity(0.2),
          text15: white.withOpacity(0.15),
          text10: white.withOpacity(0.1),
          text5: white.withOpacity(0.05),
          text03: white.withOpacity(0.03),
          overlay90: black.withOpacity(0.9),
          overlay85: black.withOpacity(0.85),
          overlay80: black.withOpacity(0.8),
          overlay70: black.withOpacity(0.7),
          overlay50: black.withOpacity(0.5),
          overlay30: black.withOpacity(0.3),
          overlay20: black.withOpacity(0.2),
          barrier: black.withOpacity(0.7),
          barrierWeaker: black.withOpacity(0.4),
          barrierWeakest: black.withOpacity(0.3),
          barrierStronger: black.withOpacity(0.85),
          animationOverlayMedium: black.withOpacity(0.7),
          animationOverlayStrong: black.withOpacity(0.85),
          brightness: Brightness.dark,
          statusBar: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Colors.transparent),
          boxShadow: const BoxShadow(color: Colors.transparent),
          boxShadowButton: const BoxShadow(color: Colors.transparent),
        );
  static const yellow = Color(0xFFFBDD11);

  static const green = Color(0xFF4CBF4B);

  static const greenDark = Color(0xFF276126);

  static const greyLight = Color(0xFF2A2A2E);

  static const greyDark = Color(0xFF212124);

  static const greyDarkest = Color(0xFF1A1A1C);

  static const white = Color(0xFFFFFFFF);

  static const black = Color(0xFF000000);
  // OverlayTheme qrScanTheme = OverlayTheme.KALIUM;
}
