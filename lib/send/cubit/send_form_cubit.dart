import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/send/models/address.dart';
import 'package:my_sarafu/send/models/amount.dart';

part 'send_form_state.dart';

class SendFormCubit extends Cubit<SendFormState> {
  SendFormCubit() : super(const SendFormState());

  void amountChanged(String value) {
    final amount = Amount.dirty(int.parse(value));
    emit(
      state.copyWith(
        amount: amount,
        status: Formz.validate([amount, state.recipient]),
      ),
    );
  }

  void recipientChanged(String value) {
    final recipient = Address.dirty(value);
    emit(
      state.copyWith(
        recipient: recipient,
        status: Formz.validate([state.amount, recipient]),
      ),
    );
  }

  Future<void> sendFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      });
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
