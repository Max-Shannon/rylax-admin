import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app-state/app_state.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/navigation_service.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/screen_size_utils.dart';
import '../../../../core/utils/snack_barz.dart';
import '../../../../core/utils/validation_failure_messages.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../../../core/widgets/app_form_submit_button.dart';
import '../../../../core/widgets/app_linked_text.dart';
import '../../../../core/widgets/app_password_field.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_input_with_title.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  final AuthService authService = AuthService();
  final NavigationService navigationService = NavigationService();

  bool emailValidationFailed = false;
  bool passwordValidatedFailed = false;

  Future<void> login(BuildContext context) async {
    bool emailValidated = ValidationUtils.validateEmail(loginEmailController.text);
    bool passwordValidated = loginPasswordController.text.isNotEmpty;

    if (emailValidated && passwordValidated) {
      var loginSuccess = await authService.signIn(
        email: loginEmailController.text,
        password: loginPasswordController.text,
        context: context,
      );
      if (loginSuccess) {
        _showLoginSuccessSnackBar(context);
        refreshState(emailValidated, passwordValidated);

        context.read<AppState>().setView(AppView.dashboardHome);
        navigationService.navigateToAuthGate(context);
      } else {
        _showLoginFailedSnackBar(context);
        refreshState(emailValidated, passwordValidated);
      }
    } else {
      _showLoginFailedSnackBar(context);
      refreshState(emailValidated, passwordValidated);
    }
  }

  void refreshState(bool emailValidated, bool passwordValidated) {
    setState(() {
      // Reverse the boolean values so the errors don't show when the page opens.
      emailValidationFailed = !emailValidated;
      passwordValidatedFailed = !passwordValidated;
    });
  }

  void _showLoginFailedSnackBar(BuildContext context) {
    SnackBarz.showSnackBar(context, AppColors.mainRed, "Login Failed - Check credentials!");
  }

  void _showLoginSuccessSnackBar(BuildContext context) {
    SnackBarz.showSnackBar(context, AppColors.mainGreen, "Login Success!");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      width: ScreenSizeUtils.calculatePercentageWidth(context, 51),
      height: ScreenSizeUtils.calculatePercentageHeight(context, 100),
      child: Padding(
        padding: EdgeInsets.only(
          top: ScreenSizeUtils.calculatePercentageHeight(context, 30),
          left: ScreenSizeUtils.calculatePercentageWidth(context, 10),
          right: ScreenSizeUtils.calculatePercentageHeight(context, 10),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),

              AppText(textValue: "Login", fontSize: 32),
              SizedBox(height: 25),

              AppTextInputWithTitle(
                title: "Email",
                inputFailedValidation: emailValidationFailed,
                validationFailedMessage: ValidationFailureMessages.email(),
                textEditingController: loginEmailController,
              ),
              SizedBox(height: 20),

              AppPasswordField(
                textEditingController: loginPasswordController,
                inputFailedValidation: passwordValidatedFailed,
                validationFailedMessage: ValidationFailureMessages.passwordEmpty(),
              ),
              AppLinkedText(
                linkTappedFunction: navigationService.navigateToForgotPassword,
                preText: "Having trouble logging in? ",
                linkText: "Click here.",
              ),
              SizedBox(height: 50),

              AppFormSubmitButton(label: "Login", function: () => login(context)),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
