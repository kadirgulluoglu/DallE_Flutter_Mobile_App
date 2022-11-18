import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dalle_flutter_mobile_app/core/extension/context_extensions.dart';
import 'package:dalle_flutter_mobile_app/features/home/viewmodel/home_viewmodel.dart';
import 'package:dalle_flutter_mobile_app/product/components/background_image.dart';
import 'package:dalle_flutter_mobile_app/product/components/custom_logo.dart';
import 'package:dalle_flutter_mobile_app/product/components/glass_box.dart';
import 'package:dalle_flutter_mobile_app/product/components/large_text.dart';
import 'package:dalle_flutter_mobile_app/product/components/text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../product/enum/cache_status_enum.dart';
import '../../../product/enum/view_state.dart';
import '../../history_search/view/history_search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(context: context),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
            child: Container(),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: context.height,
              width: context.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: context.paddingLow,
                    child: Column(
                      children: [
                        CustomLogo(),
                        _buildSearchBar(viewModel),
                        _buildSpacer(.02),
                        _buildImageStyle(viewModel),
                        _buildElevatedButon(context, viewModel),
                        _buildSpacer(.02),
                      ],
                    ),
                  ),

                  //Sorgulanan resmi göstermesi için
                  viewModel.state == ViewState.busy
                      ? Expanded(child: _buildLoadingWidget(context))
                      : viewModel.state == ViewState.idle
                          ? Expanded(
                              child: _buildResultImageList(context, viewModel))
                          : Expanded(child: _buildFirstTimeText()),
                  _buildSpacer(.02),
                  viewModel.cacheStatus == CacheStatus.available
                      ? _buildHistorySearchButton(context, viewModel)
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center _buildFirstTimeText() {
    return Center(
      child: CustomText(
        text: "Hadi şimdi DALL-E ile yazıyı resme çevirin",
        isCenter: true,
      ),
    );
  }

  Padding _buildHistorySearchButton(
      BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: context.paddingLow,
      child: GlassContainer(
        child: SizedBox(
          width: context.width * .95,
          height: context.height * .05,
          child: TextButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.history, color: Colors.white),
                CustomText(
                  text: " Geçmiş aramalarınızı görmek için tıklayınız",
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: viewModel,
                    child: const HistorySearchView(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Padding _buildResultImageList(BuildContext context, HomeViewModel viewModel) {
    return Padding(
      padding: context.paddingLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLargeText(text: "🔥 Sonuçlar"),
          _buildSpacer(.03),
          SizedBox(
            height: context.height * 0.4,
            child: ListView.builder(
              itemCount: viewModel.dallEModel?.data?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: context.paddingLow,
                  child: ClipRRect(
                    borderRadius: context.containerRadius,
                    child: SizedBox(
                      height: context.height * .3,
                      child: CachedNetworkImage(
                        imageUrl: viewModel.dallEModel?.data?[index].url ?? "",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => GlassContainer(
                          width: context.width * .5,
                          child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                        ),
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildLoadingWidget(BuildContext context) {
    return SizedBox(
      height: context.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              size: 70,
              color: Colors.white,
            ),
          ),
          _buildSpacer(.03),
          CustomText(text: "Lütfen Yüklenirken Bekleyiniz...")
        ],
      ),
    );
  }

  GlassContainer _buildElevatedButon(
      BuildContext context, HomeViewModel viewModel) {
    return GlassContainer(
      child: SizedBox(
        width: context.width * .95,
        height: context.height * .04,
        child: TextButton(
          child: CustomText(
            text: "OLUŞTUR",
          ),
          onPressed: () {
            if (_searchController.text.isNotEmpty) {
              FocusManager.instance.primaryFocus?.unfocus();
              viewModel.getImage(prompt: _searchController.text);
            }
          },
        ),
      ),
    );
  }

  SizedBox _buildImageStyle(HomeViewModel viewModel) {
    return SizedBox(
      height: context.height * .08,
      child: ListView.builder(
        itemCount: viewModel.typeList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var type = viewModel.typeList[index];
          return InkWell(
            onTap: () {
              viewModel.changeSelected(index);
            },
            child: Padding(
              padding: context.paddingLow,
              child: GlassContainer(
                color: type.isSelected ? Colors.black : Colors.white,
                child: Container(
                  margin: context.paddingLow,
                  child: Row(
                    children: [
                      Icon(
                        type.icon,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      CustomText(
                        text: type.title ?? "",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  GlassContainer _buildSearchBar(HomeViewModel viewModel) {
    return GlassContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(
            flex: 1,
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 9,
            child: TextFormField(
              readOnly: viewModel.state == ViewState.busy ? true : false,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Lütfen detaylı bir açıklama giriniz"),
              controller: _searchController,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildSpacer(double size) => SizedBox(height: context.height * size);
}
