import 'package:flutter/cupertino.dart';

import '../enum/image_enum.dart';

class CustomLogo extends SizedBox {
  CustomLogo({super.key})
      : super(
          height: 100,
          width: 100,
          child: Image.asset(
            AssetsEnum.logo.toPng(),
          ),
        );
}
