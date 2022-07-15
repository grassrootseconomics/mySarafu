// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/cubits/account/cubit.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return const Scaffold(
      body: SafeArea(child: CreateAccountView()),
    );
  }
}

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  CreateAccountViewState createState() {
    return CreateAccountViewState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CreateAccountViewState extends State<CreateAccountView> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final _namePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) => {
        if (state is VerifiedAccountState)
          {Navigator.pushNamed(context, '/home')}
      },
      builder: (context, state) {
        if (state is NoAccountState) {
          return _buildForm(context, state);
        }
        if (state is UnverifiedAccountState) {
          return _buildVerifyAccount(context, state);
        }
        if (state is VerifiedAccountState) {
          return _buildAccountCreated(context, state);
        }
        if (state is InvalidAccountState) {
          return _buildForm(context, state);
        }
        if (state is ErrorAccountState) {
          return _buildForm(context, state);
        }
        return _buildForm(context, state);
      },
    );
  }

  Widget _buildVerifyAccount(
    BuildContext context,
    UnverifiedAccountState state,
  ) {
    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('This currently is noop')),
          );
        context.read<AccountCubit>().verifyAccount(otp: '123456');
      },
      child: const Text('Verify Account'),
    );
  }

  Widget _buildAccountCreated(
    BuildContext context,
    VerifiedAccountState state,
  ) {
    return Text(
      '''Account created successfully: ${state.account.activeWalletAddress}''',
    );
  }

  Widget _buildForm(BuildContext context, AccountState state) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(
                labelText: 'Account Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an Account Name';
                }
                return null;
              },
              controller: _namePassController,
            ),
          ],
        ),
      ),
    );
  }
}
