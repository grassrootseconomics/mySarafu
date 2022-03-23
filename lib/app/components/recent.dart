import 'package:flutter/material.dart';

const recent = [
  RecentItem('Will'),
  RecentItem('Sam'),
];

class RecentItem {
  const RecentItem(this.name);

  final String name;
}

const address = 'e451221d403ad317f2fa77d01ac1ec1ba82ce22f';

/// Displays a list of SampleItems.
class RecentWidget extends StatelessWidget {
  const RecentWidget({
    Key? key,
    this.items = recent,
  }) : super(key: key);

  final List<RecentItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Recent',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  // Providing a restorationId allows the ListView to restore 
                  // the scroll position when a user leaves and returns to the
                  // app after it has been killed while running in the background.
                  restorationId: 'recentItemWidget',
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/images/sarafu_logo.png',
                                height: 35,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(item.name),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
