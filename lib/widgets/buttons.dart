// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mysarafu/styles.dart';
import 'package:mysarafu/themes.dart';

enum AppButtonType {
  primary,
  primaryOutline,
  success,
  successOutline,
  textOutline
}

class AppButton {
  // Primary button builder
  static Widget buildAppButton(
    BuildContext context,
    AppButtonType type,
    String buttonText,
    List<double> dimens, {
    Function()? onPressed,
    bool disabled = false,
  }) {
    switch (type) {
      case AppButtonType.primary:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [SarafuTheme().boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
              dimens[0],
              dimens[1],
              dimens[2],
              dimens[3],
            ),
            child: TextButton(
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(100.0)),
              // color: disabled ? SarafuTheme().primary60 : SarafuTheme().primary,
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleButtonPrimary(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null && !disabled) {
                  onPressed();
                }
                return;
              },
              // highlightColor: SarafuTheme().background40,
              // splashColor: SarafuTheme().background40,
            ),
          ),
        );
      case AppButtonType.primaryOutline:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: SarafuTheme().backgroundDark,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [SarafuTheme().boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
              dimens[0],
              dimens[1],
              dimens[2],
              dimens[3],
            ),
            child: OutlinedButton(
              // color: SarafuTheme().backgroundDark,
              // textColor: disabled ? SarafuTheme().primary60 : SarafuTheme().primary,
              // borderSide: BorderSide(
              //     color: disabled ? SarafuTheme().primary60 : SarafuTheme().primary,
              //     width: 2.0),
              // highlightedBorderColor:
              //     disabled ? SarafuTheme().primary60 : SarafuTheme().primary,
              // splashColor: SarafuTheme().primary30,
              // highlightColor: SarafuTheme().primary15,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(100.0)),
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: disabled
                    ? AppStyles.textStyleButtonPrimaryOutlineDisabled(context)
                    : AppStyles.textStyleButtonPrimaryOutline(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null && !disabled) {
                  onPressed();
                }
                return;
              },
            ),
          ),
        );
      case AppButtonType.success:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [SarafuTheme().boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
              dimens[0],
              dimens[1],
              dimens[2],
              dimens[3],
            ),
            child: TextButton(
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(100.0)),
              // color: SarafuTheme().success,
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleButtonPrimaryGreen(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null && !disabled) {
                  onPressed();
                }
                return;
              },
              // highlightColor: SarafuTheme().success30,
              // splashColor: SarafuTheme().successDark,
            ),
          ),
        );
      case AppButtonType.successOutline:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: SarafuTheme().backgroundDark,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [SarafuTheme().boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
              dimens[0],
              dimens[1],
              dimens[2],
              dimens[3],
            ),
            child: OutlinedButton(
              // color: SarafuTheme().backgroundDark,
              // textColor: SarafuTheme().success,
              // borderSide: BorderSide(color: SarafuTheme().success, width: 2.0),
              // highlightedBorderColor: SarafuTheme().success,
              // splashColor: SarafuTheme().success30,
              // highlightColor: SarafuTheme().success15,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(100.0)),
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleButtonSuccessOutline(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                }
                return;
              },
            ),
          ),
        );
      case AppButtonType.textOutline:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: SarafuTheme().backgroundDark,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [SarafuTheme().boxShadowButton],
            ),
            height: 55,
            margin: EdgeInsetsDirectional.fromSTEB(
              dimens[0],
              dimens[1],
              dimens[2],
              dimens[3],
            ),
            child: OutlinedButton(
              // color: SarafuTheme().backgroundDark,
              // textColor: SarafuTheme().text,
              // borderSide: BorderSide(color: SarafuTheme().text, width: 2.0),
              // highlightedBorderColor: SarafuTheme().text,
              // splashColor: SarafuTheme().text30,
              // highlightColor: SarafuTheme().text15,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(100.0)),
              child: AutoSizeText(
                buttonText,
                textAlign: TextAlign.center,
                style: AppStyles.textStyleButtonTextOutline(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                }
                return;
              },
            ),
          ),
        );
    }
  } //
}
