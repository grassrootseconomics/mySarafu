// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_sarafu/cubits/accounts/accounts_cubit.dart';
import 'package:my_sarafu/cubits/account/create_account_cubit.dart';
import 'package:my_sarafu/widgets/loading.dart';

class CreateAccountFormView extends StatefulWidget {
  const CreateAccountFormView({Key? key}) : super(key: key);

  @override
  CreateAccountFormViewState createState() {
    return CreateAccountFormViewState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CreateAccountFormViewState extends State<CreateAccountFormView> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final _namePassController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return BlocProvider(
      create: (context) => CreateAccountFormCubit(),
      child: BlocListener<CreateAccountFormCubit, CreateAccountFormState>(
        listener: (context, state) {
          if (state is CreatedAccountState) {
            context.read<AccountsCubit>().addAccount(state.account);
            Navigator.pushNamed(context, '/home');
          }
        },
        child: BlocBuilder<CreateAccountFormCubit, CreateAccountFormState>(
          builder: (context, state) {
            if (state is EmptyAccountFormState) {
              return _buildForm(context, state);
            }
            if (state is CreatingAccountFormState) {
              return _buildCreatingAccount(context, state);
            }
            if (state is CreatedAccountState) {
              return _buildAccountCreated(context, state);
            }
            if (state is DirtyAccountFormState) {
              return _buildForm(context, state);
            }
            if (state is ErrorAccountFormState) {
              return _buildForm(context, state);
            }
            return _buildForm(context, state);
          },
          bloc: CreateAccountFormCubit(),
        ),
      ),
    );
  }

  Widget _buildCreatingAccount(
    BuildContext context,
    CreateAccountFormState state,
  ) {
    return const Loading();
  }

  Widget _buildAccountCreated(BuildContext context, CreatedAccountState state) {
    return Text(
      '''${state.account.name} created successfully address: ${state.account.address}''',
    );
  }

  Widget _buildForm(BuildContext context, CreateAccountFormState state) {
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
                final existingAccountName = context
                    .read<AccountsCubit>()
                    .state
                    .accounts
                    .any((element) => element.name == value);

                if (existingAccountName) {
                  return 'This Account name already exists';
                }
                return null;
              },
              controller: _namePassController,
            ),
            TextFormField(
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              controller: _passController,
            ),
            TextFormField(
              // The validator receives the text that the user has entered.
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                final _password = _passController.text;
                if (_password != value) {
                  return 'Passwords do not match';
                }
                return null;
              },
              controller: _confirmPassController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<CreateAccountFormCubit>().createAccount(
                          name: _namePassController.text,
                          password: _passController.text,
                          passwordConfirmation: _confirmPassController.text,
                        );
                  }
                },
                child: const Text('Create Account'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
