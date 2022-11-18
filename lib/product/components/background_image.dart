import 'package:dalle_flutter_mobile_app/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';

import '../enum/image_enum.dart';

class BackgroundImage extends SizedBox {
  final BuildContext context;
  BackgroundImage({required this.context, super.key})
      : super(
          width: context.width,
          height: context.height,
          child: Image.asset(
            AssetsEnum.background.toJpg(),
            fit: BoxFit.fill,
          ),
        );
}
