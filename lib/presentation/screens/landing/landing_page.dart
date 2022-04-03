import 'package:flutter/material.dart';
import 'package:my_sarafu/presentation/components/bottom_nav/view/bottom_nav.dart';

class LandingView extends StatelessWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Karibu Sarafu',
                  style: Theme.of(context).textTheme.headlineLarge),
              TextButton(
                onPressed: () => print('Pressed'),
                child: const Text('Connect Exisiting Sarafu Wallet'),
              ),
              TextButton(
                onPressed: () => print('Pressed'),
                child: const Text('Create new account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
