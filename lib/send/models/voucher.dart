import 'package:formz/formz.dart';
import 'package:web3dart/credentials.dart';

enum AddressValidationError { notValid }

class Address extends FormzInput<String, AddressValidationError> {
  const Address.pure() : super.pure('');
  const Address.dirty([String value = '']) : super.dirty(value);

  @override
  AddressValidationError? validator(String value) {
    try {
      // ignore: unused_local_variable
      final address = EthereumAddress.fromHex(value);
      return null;
    } catch (e) {
      return AddressValidationError.notValid;
    }
  }
}
