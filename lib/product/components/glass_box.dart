import 'package:dalle_flutter_mobile_app/core/extension/context_extensions.dart';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final Color color;
  final bool isCircular;

  const GlassContainer({
    super.key,
    this.height,
    this.width,
    this.color = Colors.white,
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
                border: Border.all(color: color.withOpacity(0.2)),
                borderRadius: isCircular
                    ? context.circularRadius
                    : context.containerRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.4),
                    color.withOpacity(0.1),
                  ],
                ),
              ),
              child: child, //child
            ),
          ],
        ),
      ),
    );
  }
}
