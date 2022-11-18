import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalle_flutter_mobile_app/core/extension/context_extensions.dart';
import 'package:dalle_flutter_mobile_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:dalle_flutter_mobile_app/product/components/background_image.dart';
import 'package:dalle_flutter_mobile_app/product/components/large_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/components/glass_box.dart';
import '../../../product/components/text.dart';
import '../../../product/enum/cache_status_enum.dart';
import '../../../product/enum/view_state.dart';

class HistorySearchView extends StatelessWidget {
  const HistorySearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: CustomLargeText(text: "🕰 Geçmiş Aramalar"),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          BackgroundImage(context: context),
          viewModel.cacheStatus == CacheStatus.available
              ? Column(
                  children: [
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.modelList?.length ?? 0,
                        itemBuilder: (context, index) {
                          var historyModel = viewModel.modelList?[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: context.paddingLeft,
                                child: CustomText(
                                  text: historyModel?.title
                                          .toString()
                                          .firstUpperCase() ??
                                      "",
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                height: context.height * 0.4,
                                child: ListView.builder(
                                  itemCount: historyModel?.data?.length ?? 0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: context.paddingLow,
                                      margin: context.paddingLow,
                                      child: ClipRRect(
                                        borderRadius: context.containerRadius,
                                        child: SizedBox(
                                          height: context.height * .4,
                                          child: CachedNetworkImage(
                                            imageUrl: historyModel
                                                    ?.data?[index].url ??
                                                "",
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                GlassContainer(
                                              width: context.height * .3,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                            ),
                                            fit: BoxFit.fill,
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Expanded(child: _buildFirstTimeText(viewModel)),
        ],
      ),
    );
  }

  Center _buildFirstTimeText(HomeViewModel viewModel) {
    return Center(
      child: CustomText(
        text: viewModel.state == ViewState.error
            ? "Hadi şimdi DALL-E ile yazıyı resme çevirin"
            : "",
        isCenter: true,
      ),
    );
  }
}
