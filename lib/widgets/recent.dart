import 'package:flutter/material.dart';
import 'package:my_sarafu/cubits/send/view/send_card_view.dart';

const recent = [
  RecentItem('Will'),
  RecentItem('Phil'),
  RecentItem('Louis'),
  RecentItem('Sohail'),
];

class RecentItem {
  const RecentItem(this.name);

  final String name;
}

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
              SizedBox(
                height: 100,
                child: ListView.builder(
                  restorationId: 'recentItemWidget',
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return const SendCardView();
                            },
                          );
                        },
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
