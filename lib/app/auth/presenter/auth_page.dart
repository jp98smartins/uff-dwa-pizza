import 'package:flutter/material.dart';
import 'package:pizza/app/auth/domain/models/credentials_model.dart';
import 'package:pizza/core/core.dart';

import '../../../shared/app_routes.dart';
import '../domain/models/account_model.dart';
import '../resources/auth_strings.dart';
import 'cubit/auth_cubit.dart';

final class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailSignInController = TextEditingController();
  final _passwordSignInController = TextEditingController();

  final _enableSignIn = ValueNotifier(true);

  final _addressSignUpController = TextEditingController();
  final _cpfSignUpController = TextEditingController();
  final _emailSignUpController = TextEditingController();
  final _nameSignUpController = TextEditingController();
  final _passwordSignUpController = TextEditingController();
  final _passwordConfirmationSignUpController = TextEditingController();
  final _phoneSignUpController = TextEditingController();

  @override
  void dispose() {
    _emailSignInController.dispose();
    _emailSignUpController.dispose();
    _enableSignIn.dispose();
    _passwordSignInController.dispose();
    _passwordSignUpController.dispose();
    _passwordConfirmationSignUpController.dispose();
    _addressSignUpController.dispose();
    _cpfSignUpController.dispose();
    _nameSignUpController.dispose();
    _phoneSignUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: context.read<AuthCubit>(),
      listener: (context, state) {
        if (state is AuthException) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.tag.toString()),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }

        if (state is AuthSignUpSuccess) {
          _emailSignInController.text = _emailSignUpController.text.trim();
          _formKey.currentState?.reset();
          _enableSignIn.value = true;
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(AuthStrings.signUpSuccess),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is AuthSignInSuccess) {
          context.goNamed(
            state.isClient //
                ? AppRoutes.clientProductsRoute
                : AppRoutes.adminOrdersRoute,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: Center(
                child: SizedBox(
                  width: 448,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          height: 256,
                          width: 256,
                          cacheWidth: 256,
                          cacheHeight: 256,
                        ),
                        const SizedBox(height: 32),
                        ValueListenableBuilder(
                          valueListenable: _enableSignIn,
                          builder: (_, signIn, __) {
                            if (signIn) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    AuthStrings.welcomeSignIn,
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: 16),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _emailSignInController,
                                          decoration: const InputDecoration(
                                            labelText: AuthStrings.emailLabel,
                                            hintText: AuthStrings.emailHint,
                                          ),
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.emailAddress,
                                          validator: AppValidator.email,
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          controller: _passwordSignInController,
                                          decoration: const InputDecoration(
                                            labelText: AuthStrings.passwordLabel,
                                            hintText: AuthStrings.passwordHint,
                                          ),
                                          textInputAction: TextInputAction.done,
                                          validator: AppValidator.required,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ?? false) {
                                        context.read<AuthCubit>().signIn(
                                              CredentialsModel(
                                                email: _emailSignInController.text.trim(),
                                                password: _passwordSignInController.text.trim(),
                                              ),
                                            );
                                      }
                                    },
                                    child: const Text(AuthStrings.signInButton),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _formKey.currentState?.reset();
                                      _enableSignIn.value = false;
                                    },
                                    child: const Text(AuthStrings.signUpButton),
                                  ),
                                ],
                              );
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  AuthStrings.welcomeSignUp,
                                  style: theme.textTheme.headlineMedium,
                                ),
                                const SizedBox(height: 16),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _nameSignUpController,
                                        decoration: const InputDecoration(
                                          labelText: AuthStrings.nameLabel,
                                          hintText: AuthStrings.nameHint,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        validator: AppValidator.required,
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _cpfSignUpController,
                                        decoration: const InputDecoration(
                                          labelText: AuthStrings.cpfLabel,
                                          hintText: AuthStrings.cpfHint,
                                        ),
                                        inputFormatters: [CpfTextFormatter()],
                                        textInputAction: TextInputAction.next,
                                        validator: AppValidator.cpf,
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _phoneSignUpController,
                                        decoration: const InputDecoration(
                                          labelText: AuthStrings.phoneLabel,
                                          hintText: AuthStrings.phoneHint,
                                        ),
                                        inputFormatters: [PhoneTextFormatter()],
                                        textInputAction: TextInputAction.next,
                                        validator: AppValidator.phone,
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _emailSignUpController,
                                        decoration: const InputDecoration(
                                          labelText: AuthStrings.emailLabel,
                                          hintText: AuthStrings.emailHint,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.emailAddress,
                                        validator: AppValidator.email,
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _passwordSignUpController,
                                        decoration: const InputDecoration(
                                          labelText: AuthStrings.passwordLabel,
                                          hintText: AuthStrings.passwordHint,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        validator: AppValidator.required,
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _passwordConfirmationSignUpController,
                                        decoration: const InputDecoration(
                                          labelText: AuthStrings.passwordConfirmationLabel,
                                          hintText: AuthStrings.passwordConfirmationHint,
                                        ),
                                        textInputAction: TextInputAction.next,
                                        validator: (value) => AppValidator.passwordConfirmation(
                                          value,
                                          _passwordSignUpController.text,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      TextFormField(
                                        controller: _addressSignUpController,
                                        decoration: const InputDecoration(
                                          labelText: AuthStrings.addressLabel,
                                          hintText: AuthStrings.addressHint,
                                        ),
                                        textInputAction: TextInputAction.done,
                                        validator: AppValidator.required,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      context.read<AuthCubit>().signUp(
                                            ClientUserModel(
                                              address: _addressSignUpController.text.trim(),
                                              cpf: _cpfSignUpController.text.trim().sanitizeNumbers(),
                                              email: _emailSignUpController.text.trim(),
                                              name: _nameSignUpController.text.trim(),
                                              password: _passwordSignUpController.text.trim(),
                                              phone: _phoneSignUpController.text.trim().sanitizeNumbers(),
                                            ),
                                          );
                                    }
                                  },
                                  child: const Text(AuthStrings.signUpButton),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _formKey.currentState?.reset();
                                    _enableSignIn.value = true;
                                  },
                                  child: const Text(AuthStrings.signInButton),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is AuthLoading) ...{
              DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.5),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            },
          ],
        );
      },
    );
  }
}
