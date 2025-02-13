import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livine/src/common_widgets/no_connection.dart';

import '../../../common_widgets/recipe/food_category_widget.dart';
import '../../../constants/constants.dart';
import '../../../shared/connectivity/check_network.dart';
import '../../../translations/locale_keys.g.dart';

class Patient extends ConsumerStatefulWidget {
  const Patient({Key? key}) : super(key: key);

  @override
  ConsumerState<Patient> createState() => _PatientState();
}

class _PatientState extends ConsumerState<Patient> {
  @override
  void initState() {
    super.initState();

    runOnlyOnAndroid();
  }

  void runOnlyOnAndroid() {
    if (Platform.isAndroid) {
      adHelper.nativeBannerFunction(setState);
    }
  }

  void disposeOnAndroid() {
    adHelper.nativeAdBanner.dispose();
  }

  @override
  void dispose() {
    disposeOnAndroid();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConnectivityStatus network = ref.watch(checkNetworkProvider);

    return network == ConnectivityStatus.On
        ? Scaffold(
            body: SafeArea(
              child: RawScrollbar(
                thumbColor: getColorScheme(context).tertiary,
                thickness: 5,
                radius: const Radius.circular(10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GridView.count(
                    crossAxisCount: rh.responsiveCatogeries(context),
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      FoodCategory(
                        navigate: '/breakfast',
                        name: LocaleKeys.Breakfast.tr(),
                        image:
                            "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=710&q=80",
                      ),
                      FoodCategory(
                        navigate: '/lunch',
                        name: LocaleKeys.Lunch.tr(),
                        image:
                            "https://images.unsplash.com/photo-1576866209830-589e1bfbaa4d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                      ),
                      if (adHelper.isnativeBannerAdLoaded & kReleaseMode) ...[
                        SizedBox(
                          height:
                              adHelper.nativeAdBanner.size.height.toDouble(),
                          width: adHelper.nativeAdBanner.size.width.toDouble(),
                          child: AdWidget(ad: adHelper.nativeAdBanner),
                        ),
                      ],
                      FoodCategory(
                        navigate: '/dinner',
                        name: LocaleKeys.Dinner.tr(),
                        image:
                            "https://images.unsplash.com/photo-1473973916745-60839aebf06b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                      ),
                      FoodCategory(
                        navigate: '/snacks',
                        name: LocaleKeys.Snacks.tr(),
                        image:
                            "https://images.unsplash.com/photo-1496412705862-e0088f16f791?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : NoConnection();
  }
}
