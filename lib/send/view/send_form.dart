import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:my_sarafu/send/cubit/send_form_cubit.dart';

class SendForm extends StatelessWidget {
  const SendForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendFormCubit, SendFormState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Send Failure')),
            );
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Send',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _RecipientInput(),
          _AmountInput(),
          _SendButton(),
        ],
      ),
    );
  }
}

class _RecipientInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendFormCubit, SendFormState>(
      buildWhen: (previous, current) => previous.recipient != current.recipient,
      builder: (context, state) {
        return TextField(
          key: const Key('send_form_recipent_textField'),
          onChanged: (recipient) =>
              context.read<SendFormCubit>().recipientChanged(recipient),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Recipent',
            helperText: '',
            errorText: state.recipient.invalid ? 'Invalid Recipent' : null,
          ),
        );
      },
    );
  }
}

class _AmountInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendFormCubit, SendFormState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return TextField(
          key: const Key('sendForm_amountInput_textField'),
          onChanged: (amount) =>
              context.read<SendFormCubit>().amountChanged(amount),
          obscureText: true,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            labelText: 'Amount',
            helperText: '',
            errorText: state.amount.invalid ? 'Invalid amount' : null,
          ),
        );
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendFormCubit, SendFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('sendForm_send_elevatedButton'),
                onPressed: state.status.isValidated
                    ? () => context.read<SendFormCubit>().sendFormSubmitted()
                    : null,
                child: const Text('Send'),
              );
      },
    );
  }
}
