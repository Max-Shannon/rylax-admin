import 'package:flutter/material.dart';
import 'package:rylax_admin/features/login/presentation/widgets/login_form.dart';
import 'package:rylax_admin/features/login/presentation/widgets/login_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: renderLoginWidgetBasedOnScreenSize(context));
  }

  renderLoginWidgetBasedOnScreenSize(BuildContext context) {
    return Column(
      children: [
        Row(children: [LoginLogo(), LoginForm()]),
      ],
    );
  }
}
