import 'package:flutter_test/flutter_test.dart';
import 'package:my_sarafu/logic/cubit/tokens/tokens_cubit.dart';

import '../../helpers/hydrated_bloc.dart';
import '../../mocks.dart';

void main() {
  group('TokensCubit', () {
    test('equality', () {
      mockHydratedStorage(() {
        expect(
          TokensCubit(MockTokenRepository()).state,
          TokensCubit(MockTokenRepository()).state,
        );
      });
    });
    group('toJson/fromJson', () {
      test('work properly', () {
        mockHydratedStorage(() {
          final tokensCubit = TokensCubit(MockTokenRepository());
          expect(
            tokensCubit.fromJson(tokensCubit.toJson(tokensCubit.state)),
            tokensCubit.state,
          );
        });
      });
    });
    group('operations', () {
      late TokensCubit tokensCubit;

      setUp(() async {
        tokensCubit =
            await mockHydratedStorage(() => TokensCubit(MockTokenRepository()));
      });

      test('fetchAllTokens', () async {
        expect(tokensCubit.state, isA<TokensInitial>());
        await tokensCubit.fetchAllTokens(MockEthereumAddress());
        expect(
          tokensCubit.state,
          TokensLoaded(tokens: [mockToken], activeTokenIdx: 0),
        );
      });

      // blocTest<TokensCubit, Color>(
      //   'emits correct color for WeatherCondition.snowy',
      //   build: () => themeCubit,
      //   act: (cubit) => cubit.updateTheme(snowyWeather),
      //   expect: () => <Color>[Colors.lightBlueAccent],
      // );

      // blocTest<TokensCubit, Color>(
      //   'emits correct color for WeatherCondition.cloudy',
      //   build: () => themeCubit,
      //   act: (cubit) => cubit.updateTheme(cloudyWeather),
      //   expect: () => <Color>[Colors.blueGrey],
      // );

      // blocTest<TokensCubit, Color>(
      //   'emits correct color for WeatherCondition.rainy',
      //   build: () => themeCubit,
      //   act: (cubit) => cubit.updateTheme(rainyWeather),
      //   expect: () => <Color>[Colors.indigoAccent],
      // );

      // blocTest<TokensCubit, Color>(
      //   'emits correct color for WeatherCondition.unknown',
      //   build: () => themeCubit,
      //   act: (cubit) => cubit.updateTheme(unknownWeather),
      //   expect: () => <Color>[ThemeCubit.defaultColor],
      // );
    });
  });
}
