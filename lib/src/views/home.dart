import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:revenue_cat_demo/src/models/app_data.dart';
import 'package:revenue_cat_demo/src/constant.dart';
import 'package:revenue_cat_demo/src/models/styles.dart';
import 'package:revenue_cat_demo/src/views/account.dart';
import 'package:revenue_cat_demo/src/views/weather.dart';

final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);


  @override
  AppContainerState createState() => AppContainerState();
}

class AppContainerState extends State<AppContainer> {
  int currentIndex = 0;

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    // Enable debug logs before calling `configure`.
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(apiKey, appUserId: null, observerMode: false);

    appData.appUserID = await Purchases.appUserID;

    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) async {
      appData.appUserID = await Purchases.appUserID;

      PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
      (purchaserInfo.entitlements.all[entitlementID] != null &&
          purchaserInfo.entitlements.all[entitlementID]?.isActive as bool)
          ? appData.entitlementIsActive = true
          : appData.entitlementIsActive = false;

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: kColorBar,
      tabBar: CupertinoTabBar(
        backgroundColor: kColorBar,
        activeColor: kColorAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on,
              size: 24.0,
            ),
            label: 'Purchase',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 24.0,
            ),
            label: 'Account',
          ),
        ],
        onTap: (index) {
          // back home only if not switching tab
          if (currentIndex == index) {
            switch (index) {
              case 0:
                firstTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
              case 1:
                secondTabNavKey.currentState?.popUntil((r) => r.isFirst);
                break;
            }
          }
          currentIndex = index;
        },
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoTabView(
            navigatorKey: firstTabNavKey,
            builder: (BuildContext context) => WeatherScreen(),
          );
        } else {
          return CupertinoTabView(
            navigatorKey: secondTabNavKey,
            builder: (BuildContext context) => UserScreen(),
          );
        }
      },
    );
  }
}