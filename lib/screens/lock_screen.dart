// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysarafu/app_icons.dart';
import 'package:mysarafu/cubits/account/cubit.dart';
import 'package:mysarafu/dimens.dart';
import 'package:mysarafu/l10n/l10n.dart';
import 'package:mysarafu/model/authentication_method.dart';
import 'package:mysarafu/repository/vault_repository.dart';
import 'package:mysarafu/styles.dart';
import 'package:mysarafu/themes.dart';
import 'package:mysarafu/utils/biometrics.dart';
import 'package:mysarafu/utils/format.dart';
import 'package:mysarafu/utils/logger.dart';
import 'package:mysarafu/utils/service_locator.dart';
import 'package:mysarafu/utils/sharedprefsutil.dart';
import 'package:mysarafu/widgets/buttons.dart';
import 'package:mysarafu/widgets/pin_screen.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({Key? key}) : super(key: key);

  @override
  AppLockScreenState createState() => AppLockScreenState();
}

class AppLockScreenState extends State<AppLockScreen> {
  bool _showUnlockButton = false;
  bool _showLock = false;
  bool _lockedOut = true;
  String _countDownTxt = '';

  Future<void> _goHome() async {
    // if (StateContainer.of(context).wallet != null) {
    //   StateContainer.of(context).reconnect();
    // } else {
    //   await NanoUtil().loginAccount(context);
    // }

    final hasAccount = context.read<AccountCubit>().hasAccount;
    final isVerified = context.read<AccountCubit>().isVerified;
    log
      ..d('goHome')
      ..d('hasAccount $hasAccount, isVerified=$isVerified');
    if (!hasAccount) {
      await Navigator.pushReplacementNamed(context, '/landing');
    } else if (hasAccount && !isVerified) {
      await Navigator.pushReplacementNamed(context, '/verify_account');
    } else {
      await Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Widget _buildPinScreen(BuildContext context, String expectedPin) {
    return PinScreen(
      PinOverlayType.enterPin,
      expectedPin: expectedPin,
      description: context.l10n.unlockPin,
    );
  }

  Future<void> _runCountdown(int count) async {
    if (count >= 1) {
      if (mounted) {
        setState(() {
          _showUnlockButton = true;
          _showLock = true;
          _lockedOut = true;
          _countDownTxt = formatCountDown(count);
        });
      }
      Future.delayed(const Duration(seconds: 1), () {
        _runCountdown(count - 1);
      });
    } else {
      if (mounted) {
        setState(() {
          _lockedOut = false;
        });
      }
    }
  }

  Future<void> authenticateWithBiometrics() async {
    final authenticated = await sl
        .get<BiometricUtil>()
        .authenticateWithBiometrics(context, context.l10n.unlockBiometrics);
    if (authenticated) {
      await _goHome();
    } else {
      setState(() {
        _showUnlockButton = true;
      });
    }
  }

  Future<void> authenticateWithPin({bool transitions = false}) async {
    final expectedPin = await sl.get<VaultRepository>().getPin();
    if (expectedPin == null) {
      await Navigator.pushReplacementNamed(context, '/landing');
      return;
    }
    bool? auth = false;
    if (transitions) {
      if (!mounted) return;
      auth = await Navigator.of(context).push(
        MaterialPageRoute<bool>(
          builder: (BuildContext context) {
            return _buildPinScreen(context, expectedPin);
          },
        ),
      );
    } else {
      if (!mounted) return;
      auth = await Navigator.of(context).push(
        MaterialPageRoute<bool>(
          builder: (BuildContext context) {
            return _buildPinScreen(context, expectedPin);
          },
        ),
      );
    }
    if (auth != null && auth) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await _goHome();
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _showUnlockButton = true;
          _showLock = true;
        });
      }
    });
  }

  Future<void> _authenticate({bool transitions = false}) async {
    // Test if user is locked out
    // Get duration of lockout
    final lockUntil = await sl.get<SharedPrefsUtil>().getLockDate();
    if (lockUntil == null) {
      await sl.get<SharedPrefsUtil>().resetLockAttempts();
    } else {
      final countDown = lockUntil.difference(DateTime.now().toUtc()).inSeconds;
      // They're not allowed to attempt
      if (countDown > 0) {
        await _runCountdown(countDown);
        return;
      }
    }
    setState(() {
      _lockedOut = false;
    });
    final authMethod = await sl.get<SharedPrefsUtil>().getAuthMethod();
    final hasBiometrics = await sl.get<BiometricUtil>().hasBiometrics();
    if (authMethod.method == AuthMethod.biometrics && hasBiometrics) {
      setState(() {
        _showLock = true;
        _showUnlockButton = true;
      });
      try {
        await authenticateWithBiometrics();
      } catch (e) {
        await authenticateWithPin(transitions: transitions);
      }
    } else {
      await authenticateWithPin(transitions: transitions);
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: SarafuTheme().background,
        width: double.infinity,
        child: SafeArea(
          minimum: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.035,
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: _showLock
                    ? Column(
                        children: <Widget>[
                          Icon(
                            AppIcons.lock,
                            size: 80,
                            color: SarafuTheme().primary,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              context.l10n.locked.toUpperCase(),
                              style: AppStyles.textStyleHeaderColored(context),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
              if (_lockedOut)
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    context.l10n.tooManyFailedAttempts,
                    style: AppStyles.textStyleErrorMedium(context),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                const SizedBox(),
              if (_showUnlockButton)
                Row(
                  children: <Widget>[
                    AppButton.buildAppButton(
                      context,
                      AppButtonType.primary,
                      _lockedOut ? _countDownTxt : context.l10n.unlock,
                      Dimens.buttonBottomDimens,
                      onPressed: () {
                        if (!_lockedOut) {
                          _authenticate(transitions: true);
                        }
                      },
                      disabled: _lockedOut,
                    ),
                  ],
                )
              else
                const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
