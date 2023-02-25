import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/domain/model/models.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';
import 'package:furniture/presentation/resources/strings_manager.dart';
import '../../../core/services/service_locator.dart';
import '../../components/error_dialog.dart';
import '../../cubit/interact_cubit.dart';
import '../../cubit/interact_state.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/language_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import 'dart:math' as math;

class CupboardView extends StatefulWidget {
  final Function increaseCart;
  final Function decreaseCart;

  List<Cupboard> cupboard;

  CupboardView(
      {Key? key,
      required this.cupboard,
      required this.increaseCart,
      required this.decreaseCart})
      : super(key: key);

  @override
  State<CupboardView> createState() => _CupboardViewState();
}

class _CupboardViewState extends State<CupboardView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppPadding.p10, AppPadding.p20, 0, 0),
                child: Text(AppStrings.topCupboard.tr(),
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppPadding.p10, AppPadding.p20, 0, 0),
                child: Row(
                  children: [
                    Text(AppStrings.viewAll.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: ColorManager.lightGrey,
                            )),
                    const SizedBox(
                      width: AppConstants.smallDistance,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed(Routes.allCupboardsRoute);
                      },
                      child: Container(
                        width: 15,
                        height: 15,
                        padding: const EdgeInsets.all(AppPadding.p2),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: AppSize.s1, color: ColorManager.lightGrey),
                          borderRadius: BorderRadius.circular(AppSize.s4),
                          color: ColorManager.lightGrey,
                          shape: BoxShape.rectangle,
                        ),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(isRtl() ? math.pi : 0),
                          child: SvgPicture.asset(
                            ImageAssets.next,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
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
            children: List.generate(2, (index) {
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      // navigate to cupboard details screen
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => CupboardDetailsView(
                      //       idCupboard: widget.cupboard[index].id,
                      //     )));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.circular(AppSize.s14),
                          border: Border.all(
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        child: Padding(
                          padding: isRtl()
                              ? const EdgeInsets.fromLTRB(AppPadding.p14,
                                  AppPadding.p12, AppPadding.p14, AppPadding.p2)
                              : const EdgeInsets.fromLTRB(AppPadding.p14,
                                  AppPadding.p12, AppPadding.p2, AppPadding.p2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p2),
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: AppSize.s1,
                                        color: ColorManager.lightPrimary),
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s14),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(widget
                                            .cupboard[index].image
                                            .toString()),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: AppConstants.smallDistance,
                              ),
                              Text(widget.cupboard[index].title.toString(),
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(
                                height: AppConstants.smallDistance,
                              ),
                              Row(
                                children: [
                                  Text(AppStrings.cupboard.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: ColorManager.lightGrey,
                                          )),
                                  const SizedBox(
                                    width: AppConstants.widthBetweenElements,
                                  ),
                                  isRtl()
                                      ? Row(
                                          children: [
                                            Text(
                                                widget.cupboard[index].price
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: ColorManager.price,
                                                    )),
                                            Text('\$',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: ColorManager.price,
                                                    )),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Text('\$',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: ColorManager.price,
                                                    )),
                                            Text(
                                                widget.cupboard[index].price
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: ColorManager.price,
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
                      ..checkCart(widget.cupboard[index].id.toString(),
                          'Cupboard', 'walid barakat'),
                    child: BlocConsumer<InterActCubit, InterActState>(
                      listener: (context, state) {
                        if (state is NoInternetState) {
                          ErrorDialog.show(context, 'noInternet');
                        } else if (state is ToggleCartState) {
                          if (InterActCubit.get(context).ifItemFoundInCart!) {
                            widget.increaseCart(1);
                          } else {
                            widget.decreaseCart(1);
                          }
                        }
                      },
                      builder: (context, state) {
                        return Positioned(
                          top: 170,
                          left: isRtl() ? 2 : 138,
                          child: GestureDetector(
                            onTap: () async {
                              await InterActCubit.get(context).toggleCart(
                                  widget.cupboard[index].id.toString(),
                                  'Cupboard',
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
                      ..checkFavorites(widget.cupboard[index].id.toString(),
                          'Cupboard', 'walid barakat'),
                    child: BlocConsumer<InterActCubit, InterActState>(
                      listener: (context, state) {
                        if (state is NoInternetState) {
                          ErrorDialog.show(context, 'noInternet');
                        }
                      },
                      builder: (context, state) {
                        return Positioned(
                          top: 20,
                          left: 123,
                          child: GestureDetector(
                            onTap: () async {
                              await InterActCubit.get(context).toggleFavorites(
                                  widget.cupboard[index].id.toString(),
                                  'Cupboard',
                                  'walid barakat');
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: AppSize.s1,
                                      color: ColorManager.lightPrimary),
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s25),
                                  color: Theme.of(context).hintColor),
                              child: Icon(
                                Icons.favorite,
                                color: InterActCubit.get(context)
                                        .ifItemFoundInFavorites!
                                    ? ColorManager.error
                                    : ColorManager.secondary,
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
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
