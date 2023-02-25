import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture/presentation/resources/constants_manager.dart';
import 'package:furniture/presentation/resources/strings_manager.dart';
import 'package:furniture/presentation/resources/values_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';

class AboutView extends StatefulWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    AppStrings.about.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: AppSize.s40),
                  ),
                  const SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  Text(
                    'Furniture is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: AppSize.s14),
                  ),
                ],
              ),
              const SizedBox(
                height: AppConstants.heightBetweenElements,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.contact.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: AppSize.s20),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.contact,
                        color: ColorManager.darkBlack,
                        width: AppSize.s25,
                      ),
                      const SizedBox(
                        width: AppConstants.widthBetweenElements,
                      ),
                      Text('01208820832',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        ImageAssets.linkedin,
                        color: ColorManager.darkBlack,
                        width: AppSize.s25,
                      ),
                      const SizedBox(
                        width: AppConstants.widthBetweenElements,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('www.linkedin.com/in/',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text('walidbarakat1985',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.location,
                        color: ColorManager.darkBlack,
                        width: AppSize.s25,
                      ),
                      const SizedBox(
                        width: AppConstants.widthBetweenElements,
                      ),
                      Text('Egypt',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImageAssets.email,
                        color: ColorManager.darkBlack,
                        width: AppSize.s25,
                      ),
                      const SizedBox(
                        width: AppConstants.widthBetweenElements,
                      ),
                      Text('leadermatrix2@yahoo.com',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
