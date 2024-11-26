import 'package:flutter/material.dart';

import 'cubit/auth_cubit.dart';

final class AuthPage extends StatefulWidget {
  final AuthCubit authCubit;

  const AuthPage({
    required this.authCubit,
    super.key,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Login'),
      ),
    );
  }
}
