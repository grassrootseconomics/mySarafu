import 'package:flutter_test/flutter_test.dart';
import 'package:my_sarafu/cubits/vouchers/vouchers_cubit.dart';

import '../../helpers/hydrated_bloc.dart';
import '../../helpers/mocks.dart';

void main() {
  group('VouchersCubit', () {
    test('equality', () {
      mockHydratedStorage(() {
        expect(
          VouchersCubit(MockVoucherRepository()).state,
          VouchersCubit(MockVoucherRepository()).state,
        );
      });
    });
    group('toJson/fromJson', () {
      test('work properly', () {
        mockHydratedStorage(() {
          final vouchersCubit = VouchersCubit(MockVoucherRepository());
          expect(
            vouchersCubit.fromJson(vouchersCubit.toJson(vouchersCubit.state)),
            vouchersCubit.state,
          );
        });
      });
    });
    group('operations', () {
      late VouchersCubit vouchersCubit;

      setUp(() async {
        vouchersCubit = await mockHydratedStorage(
          () => VouchersCubit(MockVoucherRepository()),
        );
      });

      test('fetchAllVouchers', () async {
        expect(vouchersCubit.state, isA<VouchersInitial>());
        await vouchersCubit.fetchAllVouchers(MockEthereumAddress());
        expect(
          vouchersCubit.state,
          VouchersLoaded(vouchers: [mockVoucher], activeVoucherIdx: 0),
        );
      });

      // blocTest<VouchersCubit, Color>(
      //   'emits correct color for WeatherCondition.snowy',
      //   build: () => themeCubit,
      //   act: (cubit) => cubit.updateTheme(snowyWeather),
      //   expect: () => <Color>[Colors.lightBlueAccent],
      // );

      // blocTest<VouchersCubit, Color>(
      //   'emits correct color for WeatherCondition.cloudy',
      //   build: () => themeCubit,
      //   act: (cubit) => cubit.updateTheme(cloudyWeather),
      //   expect: () => <Color>[Colors.blueGrey],
      // );

      // blocTest<VouchersCubit, Color>(
      //   'emits correct color for WeatherCondition.rainy',
      //   build: () => themeCubit,
      //   act: (cubit) => cubit.updateTheme(rainyWeather),
      //   expect: () => <Color>[Colors.indigoAccent],
      // );

      // blocTest<VouchersCubit, Color>(
      //   'emits correct color for WeatherCondition.unknown',
      //   build: () => themeCubit,
      //   act: (cubit) => cubit.updateTheme(unknownWeather),
      //   expect: () => <Color>[ThemeCubit.defaultColor],
      // );
    });
  });
}
