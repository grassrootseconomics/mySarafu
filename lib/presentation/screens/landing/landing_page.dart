// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:my_sarafu/presentation/forms/create_account/create_account.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Karibu Sarafu',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Form(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              children: [
                                InternationalPhoneNumberInput(
                                  onInputChanged: (value) => print(value),
                                  validator: (value) {
                                    if (value!.length == 9) {
                                      return 'Please enter correct phone number';
                                    } else {
                                      return null;
                                    }
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  hintText: 'Enter phone number',
                                  autoFocusSearch: true,
                                  selectorConfig: const SelectorConfig(
                                    useEmoji: true,
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
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
                child: const Text('Connect Sarafu Account'),
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return CreateAccountFormView();
                    },
                  );
                },
                child: const Text('Create Account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
