import 'package:flutter/material.dart';
import 'package:my_sarafu/app/components/bottom_nav/view/bottom_nav.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () => print('Pressed'),
              child: const Text('Migrate from USSD'),
            ),
            TextButton(
              onPressed: () => print('Pressed'),
              child: const Text('Create new account'),
            ),
            TextButton(
              onPressed: () => print('Pressed'),
              child: const Text('Connect Existing Account'),
            ),
          ],
        ),
      ),
    );
  }
}
