import 'package:flutter_test/flutter_test.dart';
import 'package:my_sarafu/app/app.dart';
import 'package:my_sarafu/app/view/landing/landing.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(LandingPage), findsOneWidget);
    });
  });
}
