import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_sarafu/cubits/account/cubit.dart';

void main() {
  group('AccountCubit', () {
    test('equality', () {
      expect(
        AccountCubit().state,
        AccountCubit().state,
      );
    });
    group('operations', () {
      blocTest<AccountCubit, AccountState>(
        'createAccount emits CreatingAccountState then CreatedAccountState',
        build: AccountCubit.new,
        act: (cubit) => cubit.createAccount(
          name: 'test',
          password: 'test',
          passwordConfirmation: 'test',
        ),
        expect: () => [isA<CreatingAccountState>(), isA<CreatedAccountState>()],
      );

      blocTest<AccountCubit, AccountState>(
        'createAccount(mismatch passwords) emits ErrorAccountState',
        build: AccountCubit.new,
        act: (cubit) => cubit.createAccount(
          name: 'test',
          password: 'test',
          passwordConfirmation: 'tes',
        ),
        expect: () => [
          const ErrorAccountState(
            name: 'test',
            password: 'test',
            passwordConfirmation: 'tes',
            message: 'Passwords do not match',
          )
        ],
      );
      blocTest<AccountCubit, AccountState>(
        'createAccount(invalid) emits InvalidAccountState',
        build: AccountCubit.new,
        act: (cubit) => cubit.createAccount(
          name: '',
          password: '',
          passwordConfirmation: '',
        ),
        expect: () => [
          const InvalidAccountState(
            name: '',
            password: '',
            passwordConfirmation: '',
          )
        ],
      );
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
