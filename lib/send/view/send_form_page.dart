import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/logic/cubit/settings/settings_cubit.dart';
import 'package:my_sarafu/logic/data/meta_repository.dart';
import 'package:my_sarafu/send/cubit/send_form_cubit.dart';
import 'package:my_sarafu/send/view/send_form.dart';

class SendPage extends StatelessWidget {
  const SendPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SendPage());
  }

  @override
  Widget build(BuildContext context) {
    final meta =
        MetaRepository(metaUrl: context.read<SettingsCubit>().state.metaUrl);
    return Scaffold(
      appBar: AppBar(title: const Text('Send')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SendFormCubit>(
          create: (_) => SendFormCubit(meta: meta),
          child: const SendForm(),
        ),
      ),
    );
  }
}
