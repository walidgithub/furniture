import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/home_page/tabs/chair.dart';
import 'package:furniture/presentation/home_page/tabs/table.dart';
import 'package:furniture/presentation/notification/cubit/notification_cubit.dart';
import 'package:furniture/presentation/notification/cubit/notification_state.dart';
import 'package:furniture/presentation/resources/assets_manager.dart';
import 'package:furniture/presentation/resources/colors_manager.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator.dart';

import '../../../core/utils/enums.dart';
import '../../components/error_widget.dart';
import '../../cubit/interact_cubit.dart';
import '../../cubit/interact_state.dart';
import '../../resources/language_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../search/view/search_results_view.dart';
import '../chair_bloc/chair_bloc.dart';
import '../cupboard_bloc/cupboard_bloc.dart';
import '../sofa_bloc/sofa_bloc.dart';
import '../table_bloc/table_bloc.dart';
import '../tabs/cupboard.dart';
import '../tabs/sofa.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _counter = 0;

  bool emptyCart = false;

  void _increaseCart(int increase) {
    setState(() {
      _counter = _counter + increase;
      emptyCart = false;
    });
  }

  void _decreaseCart(int decrease) {
    setState(() {
      _counter = _counter - decrease;
      if (_counter == 0) {
        emptyCart = true;
      }
    });
  }

  final TextEditingController _searchEditingController =
      TextEditingController();

  int tabIndex = 0;

  List isSelected = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).hintColor,
        body: SingleChildScrollView(child: bodyContent()),
      ),
    );
  }

  Widget bodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: isRtl()
                  ? const EdgeInsets.fromLTRB(
                      0, AppPadding.p28, AppPadding.p10, 0)
                  : const EdgeInsets.fromLTRB(
                      AppPadding.p10, AppPadding.p28, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.homeTitle1.tr(),
                      style: Theme.of(context).textTheme.displayLarge),
                  Text(AppStrings.homeTitle2.tr(),
                      style: Theme.of(context).textTheme.displayLarge),
                ],
              ),
            ),
            Padding(
              padding: isRtl()
                  ? const EdgeInsets.fromLTRB(
                      AppPadding.p20, AppPadding.p20, 0, 0)
                  : const EdgeInsets.fromLTRB(
                      0, AppPadding.p20, AppPadding.p28, 0),
              child: BlocProvider(
                create: (context) =>
                    sl<InterActCubit>()..getCountOfCart('walid barakat'),
                child: BlocConsumer<InterActCubit, InterActState>(
                  listener: (context, state) {
                    if (state is EmptyUserCartCountState) {
                      emptyCart = true;
                    } else if (state is UserCartCountState) {
                      emptyCart = false;
                      _counter = state.countOfUserCart;
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        !emptyCart
                            ? Badge(
                                badgeContent: Text(
                                  _counter.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontSize: 10),
                                ),
                                badgeColor: Theme.of(context).backgroundColor,
                                position: BadgePosition.topEnd(),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed(Routes.allCartsRoute);
                                  },
                                  child: SvgPicture.asset(
                                    ImageAssets.cart,
                                    color: ColorManager.darkBlack,
                                    width: AppSize.s25,
                                  ),
                                ),
                              )
                            : SvgPicture.asset(
                                ImageAssets.cart,
                                color: Theme.of(context).backgroundColor,
                                width: AppSize.s25,
                              ),
                        const SizedBox(
                          width: AppConstants.widthBetweenElements,
                        ),
                        BlocProvider(
                          create: (context) =>
                              sl<NotificationCubit>()..showAllNotifications(),
                          child:
                              BlocBuilder<NotificationCubit, NotificationState>(
                            builder: (context, state) {
                              if (NotificationCubit.get(context)
                                  .notificationsList
                                  .isNotEmpty) {
                                return Badge(
                                  badgeContent: Text(
                                    NotificationCubit.get(context)
                                        .notificationsList
                                        .length
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(fontSize: 10),
                                  ),
                                  badgeColor: Theme.of(context).backgroundColor,
                                  position: BadgePosition.topEnd(),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(Routes.notificationRoute);
                                    },
                                    child: SvgPicture.asset(
                                      ImageAssets.notification,
                                      color: Theme.of(context).backgroundColor,
                                      width: AppSize.s25,
                                    ),
                                  ),
                                );
                              } else {
                                return SvgPicture.asset(
                                    ImageAssets.notification,
                                    color: Theme.of(context).backgroundColor,
                                    width: AppSize.s25,
                                  );
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppConstants.heightBetweenElements,
        ),
        Padding(
          padding:
              const EdgeInsets.fromLTRB(AppPadding.p10, 0, AppPadding.p10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                    onSubmitted: (_) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => SearchResultsView(
                            searchChair: _searchEditingController.text,
                          )));
                    },
                    keyboardType: TextInputType.text,
                    controller: _searchEditingController,
                    decoration: InputDecoration(
                        hintText: AppStrings.searchHint.tr(),
                        prefixIcon:
                            Icon(Icons.search, color: ColorManager.lightGrey),
                        border: InputBorder.none)),
              ),
              const SizedBox(
                width: AppConstants.widthBetweenElements,
              ),
              Expanded(
                flex: 1,
                child: Bounceable(
                  onTap:(){},
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(Routes.settingsRoute);
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
                      child: SvgPicture.asset(
                        ImageAssets.settings,
                        color: ColorManager.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: isRtl()
              ? const EdgeInsets.fromLTRB(0, AppPadding.p28, AppPadding.p10, 0)
              : const EdgeInsets.fromLTRB(AppPadding.p10, AppPadding.p28, 0, 0),
          child: Text(AppStrings.categories.tr(),
              style: Theme.of(context).textTheme.headlineLarge),
        ),
        const SizedBox(
          height: AppConstants.heightBetweenElements,
        ),
        Padding(
          padding:
              const EdgeInsets.fromLTRB(AppPadding.p10, 0, AppPadding.p10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tabButtons(
                AppStrings.chair.tr(),
                0,
                ImageAssets.chair,
              ),
              tabButtons(AppStrings.table.tr(), 1, ImageAssets.table),
              tabButtons(AppStrings.cupboard.tr(), 2, ImageAssets.cupboard),
              tabButtons(AppStrings.sofa.tr(), 3, ImageAssets.sofa),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 1,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            switch (tabIndex) {
              case 0:
                return BlocProvider(
                  create: (context) => sl<ChairBloc>()..add(GetTopChairEvent()),
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
                            padding: const EdgeInsets.all(AppPadding.p10),
                            child: Center(
                              child: ChairView(
                                chair: state.chairList,
                                increaseCart: (int increase) {
                                  _increaseCart(increase);
                                },
                                decreaseCart: (int decrease) {
                                  _decreaseCart(decrease);
                                },
                              ),
                            ),
                          );
                        case RequestState.error:
                          return errorMessage();
                      }
                    },
                  ),
                );
              case 1:
                return BlocProvider(
                  create: (context) => sl<TableBloc>()..add(GetTopTableEvent()),
                  child: BlocBuilder<TableBloc, TableState>(
                    buildWhen: (previous, current) =>
                    previous.tableState != current.tableState,
                    builder: (context, state) {
                      switch (state.tableState) {
                        case RequestState.loading:
                          return const SizedBox(
                              height: 400,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        case RequestState.loaded:
                          return Padding(
                            padding: const EdgeInsets.all(AppPadding.p10),
                            child: Center(
                              child: TableView(
                                table: state.tableList,
                                increaseCart: (int increase) {
                                  _increaseCart(increase);
                                },
                                decreaseCart: (int decrease) {
                                  _decreaseCart(decrease);
                                },
                              ),
                            ),
                          );
                        case RequestState.error:
                          return errorMessage();
                      }
                    },
                  ),
                );
              case 2:
                return BlocProvider(
                  create: (context) =>
                      sl<CupboardBloc>()..add(GetTopCupboardEvent()),
                  child: BlocBuilder<CupboardBloc, CupboardState>(
                    buildWhen: (previous, current) =>
                        previous.cupboardState != current.cupboardState,
                    builder: (context, state) {
                      switch (state.cupboardState) {
                        case RequestState.loading:
                          return const SizedBox(
                              height: 400,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        case RequestState.loaded:
                          return Padding(
                            padding: const EdgeInsets.all(AppPadding.p10),
                            child: Center(
                              child: CupboardView(
                                cupboard: state.cupboardList,
                                increaseCart: (int increase) {
                                  _increaseCart(increase);
                                },
                                decreaseCart: (int decrease) {
                                  _decreaseCart(decrease);
                                },
                              ),
                            ),
                          );
                        case RequestState.error:
                          return errorMessage();
                      }
                    },
                  ),
                );
              case 3:
                return BlocProvider(
                  create: (context) => sl<SofaBloc>()..add(GetTopSofaEvent()),
                  child: BlocBuilder<SofaBloc, SofaState>(
                    buildWhen: (previous, current) =>
                        previous.sofaState != current.sofaState,
                    builder: (context, state) {
                      switch (state.sofaState) {
                        case RequestState.loading:
                          return const SizedBox(
                              height: 400,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        case RequestState.loaded:
                          return Padding(
                            padding: const EdgeInsets.all(AppPadding.p10),
                            child: Center(
                              child: SofaView(
                                sofa: state.sofaList,
                                increaseCart: (int increase) {
                                  _increaseCart(increase);
                                },
                                decreaseCart: (int decrease) {
                                  _decreaseCart(decrease);
                                },
                              ),
                            ),
                          );
                        case RequestState.error:
                          return errorMessage();
                      }
                    },
                  ),
                );
            }
            return const Text('');
          },
        ),
      ],
    );
  }

  Widget tabButtons(String title, int index, String image) {
    return Bounceable(
      onTap:(){},
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (tabIndex == index) {
              return;
            }
            tabIndex = index;
            isOptionSelected(index);
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.075,
          decoration: BoxDecoration(
            color: isSelected[index]
                ? Theme.of(context).backgroundColor
                : Theme.of(context).hintColor,
            borderRadius: BorderRadius.circular(AppSize.s14),
            border: Border.all(
              color: isSelected[index]
                  ? Theme.of(context).backgroundColor
                  : ColorManager.lightGrey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Row(
              children: [
                isSelected[index]
                    ? SvgPicture.asset(
                        image,
                        width: AppSize.s20,
                        color: Theme.of(context).hintColor,
                      )
                    : Container(),
                isSelected[index]
                    ? const SizedBox(width: AppSize.s4)
                    : Container(),
                Text(title,
                    style: isSelected[index]
                        ? Theme.of(context).textTheme.titleSmall
                        : Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  isOptionSelected(index) {
    var previousIndex = isSelected.indexOf(true);
    isSelected[index] = true;
    isSelected[previousIndex] = false;
  }

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
}
