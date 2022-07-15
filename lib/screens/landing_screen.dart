// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_sarafu/cubits/account/views/create_account_view.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);
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
                      children: [],
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
                          return CreateAccountView();
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
