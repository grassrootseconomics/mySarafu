import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_sarafu/styles.dart';
import 'package:my_sarafu/themes.dart';
import 'package:my_sarafu/utils/user_data_util.dart';
import 'package:my_sarafu/l10n/l10n.dart';

/// A widget for displaying a mnemonic phrase
class MnemonicDisplay extends StatefulWidget {
  const MnemonicDisplay({
    Key? key,
    required this.wordList,
    this.obscureSeed = false,
    this.showButton = true,
  }) : super(key: key);
  final List<String> wordList;
  final bool obscureSeed;
  final bool showButton;

  @override
  MnemonicDisplayState createState() => MnemonicDisplayState();
}

class MnemonicDisplayState extends State<MnemonicDisplay> {
  static final List<String> _obscuredSeed = List.filled(24, '•' * 6);
  bool _seedCopied = false;
  bool _seedObscured = false;
  Timer? _seedCopiedTimer;

  @override
  void initState() {
    super.initState();
    _seedCopied = false;
    _seedObscured = true;
  }

  List<Widget> _buildMnemonicRows() {
    const nRows = 8;
    const itemsPerRow = 24 ~/ nRows;
    var curWord = 0;
    final ret = <Widget>[];
    for (var i = 0; i < nRows; i++) {
      ret.add(
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: SarafuTheme().text5,
        ),
      );
      // Build individual items
      final items = <Widget>[];
      for (var j = 0; j < itemsPerRow; j++) {
        items.add(
          Container(
            width: (MediaQuery.of(context).size.width -
                    (smallScreen(context) ? 15 : 30)) /
                itemsPerRow,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: curWord < 9 ? " " : "",
                    style: AppStyles.textStyleNumbersOfMnemonic(context),
                  ),
                  TextSpan(
                    text: " ${curWord + 1}) ",
                    style: AppStyles.textStyleNumbersOfMnemonic(context),
                  ),
                  TextSpan(
                    text: _seedObscured && widget.obscureSeed
                        ? _obscuredSeed[curWord]
                        : widget.wordList[curWord],
                    style: _seedCopied
                        ? AppStyles.textStyleMnemonicSuccess(context)
                        : AppStyles.textStyleMnemonic(context),
                  )
                ],
              ),
            ),
          ),
        );
        curWord++;
      }
      ret.add(
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: smallScreen(context) ? 6.0 : 9.0,
          ),
          child: Container(
            margin: const EdgeInsetsDirectional.only(start: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items,
            ),
          ),
        ),
      );
      if (curWord == itemsPerRow * nRows) {
        ret.add(
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: SarafuTheme().text5,
          ),
        );
      }
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (widget.obscureSeed) {
              setState(() {
                _seedObscured = !_seedObscured;
              });
            }
          },
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Column(
                  children: _buildMnemonicRows(),
                ),
              ),
              // Tap to reveal or hide
              if (widget.obscureSeed)
                Container(
                  margin: const EdgeInsetsDirectional.only(top: 8),
                  child: _seedObscured
                      ? AutoSizeText(
                          context.l10n.tapToReveal,
                          style:
                              AppStyles.textStyleParagraphThinPrimary(context),
                        )
                      : Text(
                          context.l10n.tapToHide,
                          style:
                              AppStyles.textStyleParagraphThinPrimary(context),
                        ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
        if (widget.showButton)
          Container(
            margin: const EdgeInsetsDirectional.only(top: 5),
            padding: const EdgeInsets.all(0.0),
            child: OutlinedButton(
              onPressed: () {
                UserDataUtil.setSecureClipboardItem(widget.wordList.join(' '));
                setState(() {
                  _seedCopied = true;
                });
                if (_seedCopiedTimer != null) {
                  _seedCopiedTimer!.cancel();
                }
                _seedCopiedTimer =
                    Timer(const Duration(milliseconds: 1500), () {
                  setState(() {
                    _seedCopied = false;
                  });
                });
              },
              // splashColor: _seedCopied
              //     ? Colors.transparent
              //     : SarafuTheme().primary30,
              // highlightColor: _seedCopied
              //     ? Colors.transparent
              //     : SarafuTheme().primary15,
              // highlightedBorderColor: _seedCopied
              //     ? SarafuTheme().success
              //     : SarafuTheme().primary,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(100.0)),
              // borderSide: BorderSide(
              //     color: _seedCopied
              //         ? SarafuTheme().success
              //         : SarafuTheme().primary,
              //     width: 1.0),
              child: AutoSizeText(
                _seedCopied ? context.l10n.copied : context.l10n.copy,
                textAlign: TextAlign.center,
                style: _seedCopied
                    ? AppStyles.textStyleButtonSuccessSmallOutline(context)
                    : AppStyles.textStyleButtonPrimarySmallOutline(context),
                maxLines: 1,
                stepGranularity: 0.5,
              ),
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
