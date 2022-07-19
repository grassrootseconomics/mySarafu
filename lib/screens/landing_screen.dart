// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysarafu/cubits/account/cubit.dart';
import 'package:mysarafu/utils/hdwallet.dart';
import 'package:mysarafu/utils/logger.dart';
import 'package:mysarafu/widgets/pin_screen.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/sarafu_logo.png',
                  height: 100,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Karibu Sarafu',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              BlocConsumer<AccountCubit, AccountState>(
                listener: (context, state) {
                  log.d(state.toString());
                },
                builder: (context, state) {
                  log.d(state.toString());

                  if (state is NoAccountState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const TextButton(
                          onPressed: null,
                          child: Text('Connect Account'),
                        ),
                        const TextButton(
                          onPressed: null,
                          child: Text('Import Account'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final pin = await Navigator.of(context).push(
                              MaterialPageRoute<String>(
                                builder: (BuildContext context) {
                                  return const PinScreen(
                                    PinOverlayType.newPin,
                                  );
                                },
                              ),
                            );
                            final mnumonic = generateMnemonic();
                            await context.read<AccountCubit>().createAccount(
                                  mnumonic: mnumonic,
                                  pin: pin!,
                                );
                            await Navigator.pushReplacementNamed(
                              context,
                              '/create_account',
                            );
                          },
                          child: const Text('Create Account'),
                        )
                      ],
                    );
                  }

                  return const Text('Welcome');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
