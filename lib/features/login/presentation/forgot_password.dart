import 'package:flutter/material.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/utils/font_size_utils.dart';
import '../../../core/utils/screen_size_utils.dart';
import '../../../core/utils/snack_barz.dart';
import '../../../core/utils/validation_failure_messages.dart';
import '../../../core/utils/validation_utils.dart';
import '../../../core/widgets/app_form_submit_button.dart';
import '../../../core/widgets/app_text.dart';
import '../../../core/widgets/app_text_input_with_title.dart';
import '../../../core/widgets/default_app_bar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();

  final AuthService authService = AuthService();

  bool emailValidationFailed = false;

  void navToLogin(BuildContext context) {
    NavigationService().navigateToLoginView(context);
  }

  Future<void> sendPasswordForgotEmail(BuildContext context) async {
    bool emailedValidated = ValidationUtils.validateEmail(emailController.text);

    if (emailedValidated) {
      await authService.sendPasswordResetEmail(emailController.text);
      SnackBarz.showSnackBar(context, AppColors.mainGreen, "Password Reset Sent!");
      refreshState(true);
    } else {
      refreshState(emailValidationFailed);
    }
  }

  void refreshState(bool emailValidationFailed) {
    setState(() {
      this.emailValidationFailed = !emailValidationFailed;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void doNothing() {}

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    double subtitleSize = FontSizeUtils.determineSubtitleSize(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: DefaultAppBar(toggleSettingsPanel: doNothing),
      ),
      body: Center(
        child: Card(
          color: AppColors.mainWhite,
          elevation: 2.0,
          child: SizedBox(
            width: ScreenSizeUtils.calculatePercentageWidth(context, getPercentageWidthBasedOnScreenSize(context)),
            height: ScreenSizeUtils.calculatePercentageHeight(context, getPercentageHeightBasedOnScreenSize(context)),
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Center(
                child: Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.mainGreen, size: 24),
                      onPressed: () {
                        navToLogin(context); // Go back a step
                      },
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          AppText(textValue: "Forgot password?", fontSize: headingSize),
                          SizedBox(height: 30),
                          AppText(
                            textValue: "Rylax, we will send you reset instructions!",
                            fontSize: subtitleSize,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 30),
                          SizedBox(
                            width: 400,
                            child: AppTextInputWithTitle(
                              textEditingController: emailController,
                              title: "Email",
                              validationFailedMessage: ValidationFailureMessages.email(),
                              inputFailedValidation: emailValidationFailed,
                            ),
                          ),
                          SizedBox(height: 20),
                          AppText(textValue: "Still having trouble? support@rylax.ie", fontSize: subtitleSize, fontWeight: FontWeight.w400),
                          SizedBox(height: 40),
                          SizedBox(
                            width: 400,
                            child: AppFormSubmitButton(label: "Send", function: () => sendPasswordForgotEmail(context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double getPercentageWidthBasedOnScreenSize(BuildContext context) {
    if (ScreenSizeUtils.isMobileWidth(context)) {
      return 90;
    }

    if (ScreenSizeUtils.isTabletWidth(context)) {
      return 75;
    }

    if (ScreenSizeUtils.isSmallScreen(context)) {
      return 45;
    }

    return 35;
  }

  double getPercentageHeightBasedOnScreenSize(BuildContext context) {
    if (ScreenSizeUtils.isMobileWidth(context)) {
      return 50;
    }
    if (ScreenSizeUtils.isTabletWidth(context)) {
      return 50;
    }

    if (ScreenSizeUtils.isSmallScreen(context)) {
      return 50;
    }

    return 40;
  }
}
