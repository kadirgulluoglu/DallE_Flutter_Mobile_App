import 'dart:ui';

import 'package:dalle_flutter_mobile_app/core/extension/context_extensions.dart';
import 'package:dalle_flutter_mobile_app/features/home/model/dalle_model.dart';
import 'package:dalle_flutter_mobile_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:dalle_flutter_mobile_app/product/components/background_image.dart';
import 'package:dalle_flutter_mobile_app/product/components/image_container.dart';
import 'package:dalle_flutter_mobile_app/product/components/large_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/components/text.dart';

class HistorySearchView extends StatelessWidget {
  const HistorySearchView({Key? key}) : super(key: key);
  final String _historyText = "🕰 Geçmiş Aramalar";
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: CustomLargeText(text: _historyText),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          BackgroundImage(context: context),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
            child: Container(),
          ),
          Column(
            children: [
              _buildSpacer(context),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.modelList?.length ?? 0,
                  itemBuilder: (context, index) {
                    var historyModel = viewModel.modelList?[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(context, historyModel),
                        _buildImageList(context, historyModel),
                        _buildDivider(context),
                        _buildSpacer(context),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _buildSpacer(BuildContext context) {
    return SizedBox(
      height: context.height * .03,
    );
  }

  Center _buildDivider(BuildContext context) {
    return Center(
      child: Container(
        width: context.width * .95,
        height: 3,
        color: Colors.grey.withOpacity(.2),
      ),
    );
  }

  SizedBox _buildImageList(BuildContext context, DallEModel? historyModel) {
    return SizedBox(
      height: context.height * 0.4,
      child: ListView.builder(
        itemCount: historyModel?.data?.length ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ImageContainer(
            context: context,
            model: historyModel,
            index: index,
          );
        },
      ),
    );
  }

  Padding _buildTitle(BuildContext context, DallEModel? historyModel) {
    return Padding(
      padding: context.paddingLeft,
      child: CustomText(
        text: historyModel?.title.toString().firstUpperCase() ?? "",
        size: 20,
      ),
    );
  }
}
