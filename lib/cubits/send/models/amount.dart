import 'package:formz/formz.dart';

enum AmountValidationError { notValid }

class Amount extends FormzInput<int, AmountValidationError> {
  const Amount.pure() : super.pure(0);
  const Amount.dirty([int value = 0]) : super.dirty(value);

  @override
  AmountValidationError? validator(int? value) {
    if (value != null && value > 0) {
      return null;
    }
    return AmountValidationError.notValid;
  }
}
