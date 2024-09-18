import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../size_config.dart';

class AddIcon extends StatelessWidget {
  const AddIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FaIcon(FontAwesomeIcons.twitter),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        const FaIcon(FontAwesomeIcons.chrome),
        SizedBox(
          width: getProportionateScreenWidth(10),
        ),
        const FaIcon(FontAwesomeIcons.facebook),
      ],
    );
  }
}
