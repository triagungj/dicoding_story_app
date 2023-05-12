import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/data/cubit/auth/register_cubit.dart';
import 'package:story_app/data/models/register_body.dart';
import 'package:story_app/ui/widgets/custom_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    required this.registerCubit,
    required this.onRegisterSuccess,
    super.key,
  });

  final RegisterCubit registerCubit;
  final void Function() onRegisterSuccess;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void onRegister() {
    widget.registerCubit.registerUser(
      RegisterBody(
        email: emailTextController.text,
        name: nameTextController.text,
        password: passwordTextController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          showSnackBar(
            context,
            CustomSnackBar(context: context, content: Text(state.message)),
          );
        }
        if (state is RegisterSuccess) {
          showSnackBar(
            context,
            CustomSnackBar(context: context, content: Text(state.message)),
          );
          Future<void>.delayed(
            const Duration(milliseconds: 500),
            () {
              widget.onRegisterSuccess();
            },
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Form(
              key: formKey,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    AppLocalizations.of(context)!.registrationAccount,
                  ),
                ),
                body: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.fillRegistrationDesc,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: nameTextController,
                      decoration: InputDecoration(
                        label: Text(AppLocalizations.of(context)!.name),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: const OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: emailTextController,
                      decoration: InputDecoration(
                        label: Text(AppLocalizations.of(context)!.email),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: passwordTextController,
                      decoration: InputDecoration(
                        label: Text(
                          AppLocalizations.of(context)!.password,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: const OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        errorStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: confirmPasswordTextController,
                      decoration: InputDecoration(
                        label: Text(
                          AppLocalizations.of(context)!.confirmPassword,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: const OutlineInputBorder(),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        errorStyle: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '* Required';
                        } else if (value != passwordTextController.text) {
                          return '* Konfirmasi Password harus sama';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                bottomNavigationBar: ElevatedButton(
                  onPressed: state is RegisterLoading
                      ? null
                      : () {
                          if (formKey.currentState!.validate()) {
                            onRegister();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      AppLocalizations.of(context)!.register,
                    ),
                  ),
                ),
              ),
            ),
            if (state is RegisterLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
