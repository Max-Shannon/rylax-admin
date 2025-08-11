import 'package:flutter/cupertino.dart';

import '../utils/font_size_utils.dart';
import 'app_text.dart';

class BuyerPortalLogo extends StatelessWidget {
  const BuyerPortalLogo({super.key});

  @override
  Widget build(BuildContext context) {
    double headingSize = FontSizeUtils.determineHeadingSize(context);
    return Stack(
      children: [
        Center(
          child: ClipRRect(
            child: Image(width: 200, height: 150, image: AssetImage('resources/rylax_logo.png')),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: AppText(textValue: "New Home Buyers Portal", fontSize: 20),
          ),
        ),
      ],
    );
  }
}
