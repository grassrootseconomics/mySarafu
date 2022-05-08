import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/send/cubit/send_form_cubit.dart';
import 'package:my_sarafu/send/view/send_form.dart';

class SendCardView extends StatelessWidget {
  const SendCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SendFormCubit>(
          create: (_) => SendFormCubit(),
          child: const SendForm(),
        ),
      ),
    );
  }
}
