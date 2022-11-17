import 'package:dalle_flutter_mobile_app/core/extension/context_extensions.dart';
import 'package:dalle_flutter_mobile_app/features/home/view/home_view.dart';
import 'package:dalle_flutter_mobile_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:dalle_flutter_mobile_app/product/components/custom_logo.dart';
import 'package:dalle_flutter_mobile_app/product/components/glass_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/components/large_text.dart';
import '../../../product/components/text.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  List<String> imagePath = [
    "onboarding1.png",
    "onboarding2.png",
    "onboarding3.png",
  ];
  List<String> text = [
    "SINIRLARI ZORLAYIN",
    "HAYAL GÜCÜNÜZÜN SINIRI YOK",
    "KENDİ DUVAR KAĞIDINIZI OLUŞTURUN"
  ];
  List<String> subtitle = [
    "Çölde Astronot Kıyafeti İle Yürüyen İnsan",
    "Avakado Şeklinde Koltuk",
    "Siyah Arka Planda Renkli Tozun Patlaması"
  ];

  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: imagePath.length,
        itemBuilder: (_, index) {
          return Stack(
            children: [
              _buildBackGroundImage(context, index),
              Positioned(
                top: 20,
                width: context.width,
                child: CustomLogo(),
              ),
              Positioned(
                bottom: context.height * .15,
                width: context.width,
                child: Center(
                  child: GlassContainer(
                    width: context.width * .8,
                    height: context.height * .2,
                    child: SizedBox(
                      width: context.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomLargeText(
                            text: text[index],
                            size: context.width * .06,
                            isCenter: true,
                          ),
                          CustomText(
                            text: subtitle[index],
                            size: context.width * .03,
                            isCenter: true,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                child: SizedBox(
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildRightAndLeftArrow(
                        isLeft: true,
                        onPress: () => _buildOnPressLeft(index),
                      ),
                      _buildDots(index),
                      _buildRightAndLeftArrow(
                        onPress: () => _buildOnPressRight(index),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Row _buildDots(int index) {
    return Row(
      children: List.generate(
        imagePath.length,
        (indexDots) {
          return Container(
            margin: const EdgeInsets.only(left: 4),
            width: index == indexDots ? 50 : 16,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: index == indexDots
                    ? Colors.white.withOpacity(0.8)
                    : Colors.white.withOpacity(0.3)),
          );
        },
      ),
    );
  }

  Container _buildBackGroundImage(BuildContext context, int index) {
    return Container(
      height: context.height,
      width: context.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/${imagePath[index]}"),
        ),
      ),
    );
  }

  void _buildOnPressRight(int index) {
    if (index == imagePath.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => HomeViewModel(),
            child: const HomeView(),
          ),
        ),
      );
    } else {
      _controller.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.linearToEaseOut);
    }
  }

  void _buildOnPressLeft(int index) {
    if (index != 0) {
      _controller.previousPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.linearToEaseOut);
    }
  }

  GlassContainer _buildRightAndLeftArrow(
      {void Function()? onPress, bool isLeft = false}) {
    return GlassContainer(
      isCircular: true,
      height: 50,
      width: 50,
      child: Center(
        child: IconButton(
          icon: Icon(
            isLeft
                ? Icons.keyboard_double_arrow_left
                : Icons.keyboard_double_arrow_right_outlined,
            color: Colors.white,
          ),
          onPressed: onPress,
        ),
      ),
    );
  }
}
