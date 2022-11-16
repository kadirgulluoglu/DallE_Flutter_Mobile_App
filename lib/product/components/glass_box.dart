import 'package:dalle_flutter_mobile_app/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final bool isCircular;

  const GlassContainer({
    super.key,
    this.height = 200,
    this.width = 200,
    required this.child,
    this.isCircular = false,
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          isCircular ? context.circularRadius : context.containerRadius,
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            //blur
            BackdropFilter(
              filter: context.imageFilter,
              child: Container(),
            ),

            //gradient
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: isCircular
                    ? context.circularRadius
                    : context.containerRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
            ),

            //child
            child,
          ],
        ),
      ),
    );
  }
}
