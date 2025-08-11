import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/rylax_api_service.dart';
import 'logged_in_container.dart';
import 'logged_out_container.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final RylaxAPIService rylaxAPIService = RylaxAPIService();

  @override
  void initState() {
    super.initState();
  }

  Widget determineWidget() {
    var loggedInUser = AuthService().getLoggedInUser();
    if (loggedInUser != null) {
      var userId = loggedInUser.uid;
      var displayName = loggedInUser.displayName;
      var email = loggedInUser.email;

      return Text("HI");

      // return FutureBuilder(
      //   future: rylaxAPIService.getOrInitBuyersProfile(userId, displayName!, email!),
      //   builder: (context, profileSnapshot) {
      //     if (profileSnapshot.connectionState == ConnectionState.waiting) {
      //       return Scaffold(body: Center(child: CircularProgressIndicator()));
      //     }
      //
      //     if (profileSnapshot.hasError) {
      //       print(profileSnapshot.error);
      //       return Scaffold(body: Center(child: Text('Error loading profile')));
      //     }
      //
      //     final profile = profileSnapshot.data!;
      //     setStepContext(context, profile);
      //
      //     print("LoggedInContainer used");
      //     return LoggedInContainer();
      //   },
      // );
    }

    print("LoggedOutContainer used");
    return LoggedOutContainer();
  }

  @override
  Widget build(BuildContext context) {
    return determineWidget();
  }

  // void setStepContext(BuildContext context) {
  //   var metadata = buyerProfile.buyerProfileMetadata;
  //   if (metadata.buyerProfileComplete) {
  //     context.read<AppState>().setView(AppView.end);
  //     return;
  //   }
  //   switch (metadata.buyerProfileStep) {
  //     case 0:
  //       context.read<AppState>().setView(AppView.mobileCollection);
  //   }
  // }
}
