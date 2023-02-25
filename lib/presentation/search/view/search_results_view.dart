import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../components/error_dialog.dart';
import '../../components/error_widget.dart';
import '../../cubit/interact_cubit.dart';
import '../../cubit/interact_state.dart';
import '../../home_page/chair_bloc/chair_bloc.dart';
import '../../product_details/view/chair_details_view.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/language_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

import 'dart:math' as math;

class SearchResultsView extends StatefulWidget {
  String searchChair;

  SearchResultsView({Key? key, required this.searchChair}) : super(key: key);

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).hintColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).hintColor,
        elevation: 0,
        leading: Padding(
            padding:
                const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p8, 0, 0),
            child: Bounceable(
              onTap: (){},
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(AppPadding.p12),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: AppSize.s1, color: ColorManager.primary),
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      color: ColorManager.primary),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
                    child: SvgPicture.asset(
                      ImageAssets.back,
                      color: ColorManager.grey,
                    ),
                  ),
                ),
              ),
            )),
        title: Text(
          AppStrings.searchResults.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: bodyContent(context),
    ));
  }

  BlocProvider<ChairBloc> bodyContent(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<ChairBloc>()..add(SearchForChairsEvent(widget.searchChair)),
      child: SingleChildScrollView(
        child: BlocBuilder<ChairBloc, ChairState>(
          buildWhen: (previous, current) =>
              previous.chairState != current.chairState,
          builder: (context, state) {
            switch (state.chairState) {
              case RequestState.loading:
                return const SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              case RequestState.loaded:
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: AppConstants.heightBetweenElements,
                      ),
                      GridView.count(
                        crossAxisCount: AppSize.s2,
                        crossAxisSpacing: AppSize.s12,
                        mainAxisSpacing: AppSize.s12,
                        childAspectRatio: 10 / 12,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children:
                            List.generate(state.chairList.length, (index) {
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  // navigate to store details screen
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChairDetailsView(
                                            idChair: state.chairList[index].id,
                                          )));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s14),
                                      border: Border.all(
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: isRtl() ?
                                      const EdgeInsets.fromLTRB(
                                          AppPadding.p14,
                                          AppPadding.p12,
                                          AppPadding.p14,
                                          AppPadding.p2):
                                      const EdgeInsets.fromLTRB(
                                          AppPadding.p14,
                                          AppPadding.p12,
                                          AppPadding.p2,
                                          AppPadding.p2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(
                                                AppPadding.p2),
                                            child: Container(
                                                height: 130,
                                                width: 130,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: AppSize.s1,
                                                      color: ColorManager
                                                          .lightPrimary),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppSize.s14),
                                                  shape: BoxShape.rectangle,
                                                  image: DecorationImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              state
                                                                  .chairList[
                                                                      index]
                                                                  .image
                                                                  .toString()),
                                                      fit: BoxFit.fill),
                                                )),
                                          ),
                                          const SizedBox(
                                            height: AppConstants.smallDistance,
                                          ),
                                          Text(
                                              state.chairList[index].title
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          const SizedBox(
                                            height: AppConstants.smallDistance,
                                          ),
                                          Row(
                                            children: [
                                              Text(AppStrings.chair.tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: ColorManager
                                                            .lightGrey,
                                                      )),
                                              const SizedBox(
                                                width: AppConstants
                                                    .widthBetweenElements,
                                              ),
                                              isRtl() ?
                                              Row(
                                                children: [
                                                  Text(
                                                      state.chairList[index].price
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                        color:
                                                        ColorManager.price,
                                                      )),
                                                  Text('\$',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                        color:
                                                        ColorManager.price,
                                                      )),
                                                ],
                                              ):Row(
                                                children: [
                                                  Text('\$',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                        color:
                                                        ColorManager.price,
                                                      )),
                                                  Text(
                                                      state.chairList[index].price
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                        color:
                                                        ColorManager.price,
                                                      )),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                              BlocProvider(
                                create: (context) => sl<InterActCubit>()
                                  ..checkCart(state.chairList[index].id.toString(), 'Chair',
                                      'walid barakat'),
                                child: BlocConsumer<InterActCubit, InterActState>(
                                  listener: (context, state2) {
                                    if (state2 is NoInternetState){
                                      ErrorDialog.show(context,'noInternet');
                                    }
                                  },
                                  builder: (context, state2) {
                                    return Positioned(
                                      top: 170,
                                      left: isRtl() ? 0 : 140,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await InterActCubit.get(context).toggleCart(
                                              state.chairList[index].id.toString(),
                                              'Chair',
                                              'walid barakat',
                                              '1');
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: AppSize.s1,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(AppSize.s25),
                                              color: Theme.of(context).backgroundColor),
                                          child: Icon(
                                            InterActCubit.get(context).ifItemFoundInCart!
                                                ? Icons.remove
                                                : Icons.add,
                                            color: Theme.of(context).hintColor,
                                            size: AppSize.s16,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              BlocProvider(
                                create: (context) => sl<InterActCubit>()
                                  ..checkFavorites(
                                      state.chairList[index].id.toString(),
                                      'Chair',
                                      'walid barakat'),
                                child: BlocConsumer<InterActCubit,
                                    InterActState>(
                                  listener: (context, state2) {
                                    if (state2 is NoInternetState){
                                      ErrorDialog.show(context,'noInternet');
                                    }
                                  },
                                  builder: (context, state2) {
                                    return Positioned(
                                      top: 20,
                                      left: 123,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await InterActCubit.get(context).toggleFavorites(
                                              state.chairList[index].id.toString(),
                                              'Chair',
                                              'walid barakat');
                                        },
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: AppSize.s1,
                                                  color: ColorManager
                                                      .lightPrimary),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppSize.s25),
                                              color: Theme.of(context).hintColor),
                                          child: Icon(
                                            Icons.favorite,
                                            color: InterActCubit.get(context).ifItemFoundInFavorites! ? ColorManager.error : ColorManager.secondary,
                                            size: AppSize.s16,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                );
              case RequestState.error:
                return errorMessage();
            }
          },
        ),
      ),
    );
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
