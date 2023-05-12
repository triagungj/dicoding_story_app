import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/common/assets_path.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/common/key_constants.dart';
import 'package:story_app/data/cubit/auth/login_cubit.dart';
import 'package:story_app/data/models/login_body.dart';
import 'package:story_app/ui/widgets/custom_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.onLoginSuccess,
    required this.onRegister,
    required this.loginCubit,
    super.key,
  });

  final void Function(String key) onLoginSuccess;
  final void Function() onRegister;
  final LoginCubit loginCubit;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void onLogin() {
    widget.loginCubit.login(
      LoginBody(
        email: emailTextController.text,
        password: passwordTextController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showSnackBar(
            context,
            CustomSnackBar(context: context, content: Text(state.message)),
          );
        }
        if (state is LoginSuccess) {
          widget.onLoginSuccess(state.result.loginResult!.token);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.secondaryContainer,
                    Theme.of(context).colorScheme.primaryContainer
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 13,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 36,
                        horizontal: 24,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Hero(
                              tag: KeyConstants.iconAppHeroTag,
                              child: Image.asset(
                                AssetsPath.logoDicodingDark,
                                width: 180,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              AppLocalizations.of(context)!.appTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    fontSize: 50,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                            Text(
                              'Submission',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 21,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Form(
                      key: formKey,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.login,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontSize: 32,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                cursorColor: Theme.of(context).primaryColor,
                                controller: emailTextController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  hintText: AppLocalizations.of(context)!.email,
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF7d7d7d)),
                                  prefixIcon: const Icon(
                                    Icons.account_box,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '* Required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                obscureText: true,
                                controller: passwordTextController,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                cursorColor: Theme.of(context).primaryColor,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  hintText:
                                      AppLocalizations.of(context)!.password,
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF7d7d7d),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.password,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '* Required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 48,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: state is LoginLoading
                                      ? null
                                      : () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            onLogin();
                                          }
                                        },
                                  child: state is LoginLoading
                                      ? const Padding(
                                          padding: EdgeInsets.all(8),
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          AppLocalizations.of(context)!.login,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .dontHaveAccount,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 5),
                                  InkWell(
                                    onTap: widget.onRegister,
                                    child: Text(
                                      AppLocalizations.of(context)!.registerNow,
                                      style: const TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
