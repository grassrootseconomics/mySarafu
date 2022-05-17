// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:my_sarafu/cubits/account/views/form.dart';
import 'package:my_sarafu/cubits/accounts/accounts_cubit.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  Widget buildBackButton(BuildContext context) {
    final hasAccounts = context.select<AccountsCubit, bool>(
      (cubit) => cubit.state.accounts.isNotEmpty,
    );
    return hasAccounts
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildConnectAccountButton() {
      return TextButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Form(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Column(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: print,
                          validator: (value) {
                            if (value!.length == 9) {
                              return 'Please enter a valid phone number';
                            } else {
                              return null;
                            }
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          hintText: 'Enter phone number',
                          countries: const ['KE'],
                          autoFocusSearch: true,
                          selectorConfig: const SelectorConfig(
                            useEmoji: true,
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Text('Connect Account'),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  buildBackButton(context),
                ],
              ),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildConnectAccountButton(),
                  TextButton(
                    onPressed: null,
                    child: const Text('Import Account'),
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AccountView();
                        },
                      );
                    },
                    child: const Text('Create Account'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
