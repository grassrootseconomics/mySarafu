part of 'send_form_cubit.dart';

@immutable
class SendFormState extends Equatable {
  const SendFormState({
    this.recipient = const Address.pure(),
    this.amount = const Amount.pure(),
    this.status = FormzStatus.pure,
  });

  final Address recipient;
  final Amount amount;
  final FormzStatus status;

  @override
  List<Object> get props => [recipient, amount, status];

  SendFormState copyWith({
    Address? recipient,
    Amount? amount,
    FormzStatus? status,
  }) {
    return SendFormState(
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }
}
