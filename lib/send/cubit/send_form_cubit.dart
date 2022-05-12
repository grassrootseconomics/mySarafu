import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_sarafu/logic/data/meta_repository.dart';
import 'package:my_sarafu/logic/utils/logger.dart';
import 'package:my_sarafu/send/models/address.dart';
import 'package:my_sarafu/send/models/amount.dart';

part 'send_form_state.dart';

class SendFormCubit extends Cubit<SendFormState> {
  SendFormCubit({required this.meta}) : super(const SendFormState());
  final MetaRepository meta;
  void amountChanged(String value) {
    final amount = Amount.dirty(int.parse(value));
    emit(
      state.copyWith(
        amount: amount,
        status: Formz.validate([amount, state.recipient]),
      ),
    );
  }

  Future<void> setAddressFromPhoneNumber(String phoneNumber) async {
    final address = await meta.getAddressFromPhoneNumber(phoneNumber);
    final recipient = Address.dirty(address.hexEip55);
    log.d(address.hexEip55);
    emit(
      state.copyWith(
        recipient: recipient,
        status: Formz.validate([state.amount, recipient]),
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
