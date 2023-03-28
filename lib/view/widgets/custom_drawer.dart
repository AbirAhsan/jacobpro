import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:service/controller/auth_controller.dart';
import 'package:service/view/variables/colors_variable.dart';
import 'package:service/view/variables/icon_variables.dart';
import 'package:service/view/variables/text_style.dart';
import 'package:service/view/widgets/custom_image_icon.dart';
import 'package:service/view/widgets/profile_image_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import '../../controller/screen_controller.dart';
import '../../services/page_navigation_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: white,
      child: Stack(
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage(
                          CustomIcons.banner,
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            CustomColors.black.withOpacity(0.5),
                            BlendMode.darken)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ProfileImageWidget(
                        imageUrl: "",
                        radius: 26,
                        margin: EdgeInsets.only(bottom: 0),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  "Abir Ahsan".toUpperCase(),
                                  style: CustomTextStyle.mediumBoldStyleWhite,
                                ),
                              ),
                              Text(
                                "01716422666",
                                style: CustomTextStyle.mediumBoldStyleWhite,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    physics: const ScrollPhysics(),
                    //  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      //<====================================== Dashboard
                      ListTile(
                        tileColor: Get.currentRoute == "/DashBoardScreen"
                            ? CustomColors.primary
                            : CustomColors.white,
                        leading: CustomImageIcon(
                          imagepath: CustomIcons.dashboard,
                          color: Get.currentRoute == "/DashBoardScreen"
                              ? CustomColors.white
                              : CustomColors.primary,
                        ),
                        title: Text(
                          "Dashboard",
                          style: Get.currentRoute == "/DashBoardScreen"
                              ? CustomTextStyle.normalBoldStyleWhite
                              : CustomTextStyle.normalBoldStylePrimary,
                        ),
                        onTap: () {
                          if (Get.currentRoute == "/DashBoardScreen") {
                            PageNavigationService.backScreen();
                          } else {
                            PageNavigationService.generalNavigation(
                                "/DashBoardScreen");
                          }

                          // if (scafoldKey?.currentState?.isDrawerOpen == true) {
                          //   print("Drawer is Open");
                          // }
                        },
                      ),
                      //<====================================== My Profile
                      ListTile(
                        tileColor: Get.currentRoute == "/ProfileDetailsScreen"
                            ? CustomColors.primary
                            : CustomColors.white,
                        leading: CustomImageIcon(
                          imagepath: CustomIcons.person,
                          color: Get.currentRoute == "/ProfileDetailsScreen"
                              ? CustomColors.white
                              : CustomColors.primary,
                        ),
                        title: Text(
                          "My Profile",
                          style: Get.currentRoute == "/ProfileDetailsScreen"
                              ? CustomTextStyle.normalBoldStyleWhite
                              : CustomTextStyle.normalBoldStylePrimary,
                        ),
                        onTap: () {
                          if (Get.currentRoute == "/ProfileDetailsScreen") {
                            PageNavigationService.backScreen();
                          } else {
                            PageNavigationService.generalNavigation(
                                "/ProfileDetailsScreen");
                          }

                          // if (scafoldKey?.currentState?.isDrawerOpen == true) {
                          //   print("Drawer is Open");
                          // }
                        },
                      ),
                      //<====================================== My Customers
                      ListTile(
                        tileColor: Get.currentRoute == "/MyCustomersScreen"
                            ? CustomColors.primary
                            : CustomColors.white,
                        leading: CustomImageIcon(
                          imagepath: CustomIcons.myCustomers,
                          color: Get.currentRoute == "/MyCustomersScreen"
                              ? CustomColors.white
                              : CustomColors.primary,
                        ),
                        title: Text(
                          "My Customers",
                          style: Get.currentRoute == "/MyCustomersScreen"
                              ? CustomTextStyle.normalBoldStyleWhite
                              : CustomTextStyle.normalBoldStylePrimary,
                        ),
                        onTap: () {
                          if (Get.currentRoute == "/MyCustomersScreen") {
                            PageNavigationService.backScreen();
                          } else {
                            PageNavigationService.generalNavigation(
                                "/MyCustomersScreen");
                          }

                          // if (scafoldKey?.currentState?.isDrawerOpen == true) {
                          //   print("Drawer is Open");
                          // }
                        },
                      ),
//<========== Logout
                      //<====================================== My Customers
                      GetBuilder<AuthController>(
                          init: AuthController(),
                          builder: (authCtrl) {
                            return ListTile(
                              tileColor: CustomColors.white,
                              leading: const CustomImageIcon(
                                imagepath: CustomIcons.myCustomers,
                                color: CustomColors.primary,
                              ),
                              title: Text(
                                "LogOut",
                                style: CustomTextStyle.normalBoldStylePrimary,
                              ),
                              onTap: () {
                                authCtrl.tryToLogOut();
                                // if (scafoldKey?.currentState?.isDrawerOpen == true) {
                                //   print("Drawer is Open");
                                // }
                              },
                            );
                          }),
                      // //<======================================= Operation
                      // ExpansionTile(
                      //   expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      //   leading: const CustomIcon(
                      //     imagepath: operation2,
                      //   ),
                      //   title: Text(
                      //     LocaleKeys.home_title.tr(),
                      //     style: normalBoldStyle,
                      //   ),

                      //   collapsedIconColor: mainColor,
                      //   collapsedTextColor: mainColor,
                      //   textColor: Colors.black,
                      //   iconColor: Colors.black,

                      //   //  trailing: const Icon(Icons.arrow_forward_ios),
                      //   children: [
                      //     ListTile(
                      //       leading: const SizedBox(),
                      //       title: Text(
                      //         LocaleKeys.home_tab1.tr(),
                      //         style: normalBoldStyle,
                      //       ),
                      //       trailing: const Icon(Icons.add_box),
                      //       onTap: () {
                      //         scrCtrl.changeTabbar(0);
                      //         PageNavigationService().generalNavigation(
                      //           const HomeScreen(),
                      //         );
                      //         //Close Drawer
                      //         scafoldKey!.currentState!.openEndDrawer();
                      //       },
                      //     ),
                      //     ListTile(
                      //       leading: const SizedBox(),
                      //       title: Text(
                      //         LocaleKeys.home_tab2.tr(),
                      //         style: normalBoldStyle,
                      //       ),
                      //       trailing: const CustomIcon(
                      //         imagepath: inHand2,
                      //       ),
                      //       onTap: () {
                      //         scrCtrl.changeTabbar(1);
                      //         PageNavigationService().generalNavigation(
                      //           const HomeScreen(),
                      //         );
                      //         //Close Drawer
                      //         scafoldKey!.currentState!.openEndDrawer();
                      //       },
                      //     ),
                      //     ListTile(
                      //       leading: const SizedBox(),
                      //       title: Text(
                      //         LocaleKeys.home_tab3.tr(),
                      //         style: normalBoldStyle,
                      //       ),
                      //       trailing: const CustomIcon(
                      //         imagepath: onWay,
                      //       ),
                      //       onTap: () {
                      //         scrCtrl.changeTabbar(2);
                      //         PageNavigationService().generalNavigation(
                      //           const HomeScreen(),
                      //         );
                      //         //Close Drawer
                      //         scafoldKey!.currentState!.openEndDrawer();
                      //       },
                      //     ),
                      //     ListTile(
                      //       leading: const SizedBox(),
                      //       title: Text(
                      //         LocaleKeys.home_tab4.tr(),
                      //         style: normalBoldStyle,
                      //       ),
                      //       trailing: const CustomIcon(
                      //         imagepath: inAssign2,
                      //       ),
                      //       onTap: () {
                      //         scrCtrl.changeTabbar(3);
                      //         PageNavigationService().generalNavigation(
                      //           const HomeScreen(),
                      //         );
                      //         //Close Drawer
                      //         scafoldKey!.currentState!.openEndDrawer();
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // //<====================================== Accounts
                      // ExpansionTile(
                      //   expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      //   leading: const CustomIcon(
                      //     imagepath: dashboard,
                      //   ),
                      //   title: Text(
                      //     LocaleKeys.account_title.tr(),
                      //     style: normalBoldStyle,
                      //   ),

                      //   collapsedIconColor: mainColor,
                      //   collapsedTextColor: mainColor,
                      //   textColor: Colors.black,
                      //   iconColor: Colors.black,

                      //   //  trailing: const Icon(Icons.arrow_forward_ios),
                      //   children: [
                      //     ListTile(
                      //       leading: const SizedBox(),
                      //       title: Text(
                      //         LocaleKeys.account_depositMoney.tr(),
                      //         style: normalBoldStyle,
                      //       ),
                      //       trailing: const CustomIcon(
                      //         imagepath: depositeMoney2,
                      //       ),
                      //       onTap: () {
                      //         PageNavigationService().generalNavigation(
                      //           const DepositScreen(),
                      //         );
                      //         //Close Drawer
                      //         scafoldKey!.currentState!.openEndDrawer();
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // //<========================================= Report
                      // ExpansionTile(
                      //   expandedCrossAxisAlignment: CrossAxisAlignment.end,
                      //   leading: const CustomIcon(
                      //     imagepath: report2,
                      //   ),
                      //   title: Text(
                      //     LocaleKeys.report_title.tr(),
                      //     style: normalBoldStyle,
                      //   ),
                      //   collapsedIconColor: mainColor,
                      //   collapsedTextColor: mainColor,
                      //   textColor: Colors.black,
                      //   iconColor: Colors.black,
                      //   children: [
                      //     ListTile(
                      //       leading: const SizedBox(),
                      //       title: Text(
                      //         LocaleKeys.report_parcelHistory_title.tr(),
                      //         style: normalBoldStyle,
                      //       ),
                      //       trailing: const CustomIcon(
                      //         imagepath: parcelHistory3,
                      //       ),
                      //       onTap: () {
                      //         PageNavigationService().generalNavigation(
                      //             const ParcelHistoryScreen());
                      //         //Close Drawer
                      //         scafoldKey!.currentState!.openEndDrawer();
                      //       },
                      //     ),
                      //     ListTile(
                      //       leading: const SizedBox(),
                      //       title: Text(
                      //         LocaleKeys.report_transHistory_title.tr(),
                      //         style: normalBoldStyle,
                      //       ),
                      //       trailing: const CustomIcon(
                      //         imagepath: tRasactionHistory2,
                      //       ),
                      //       onTap: () {
                      //         PageNavigationService().generalNavigation(
                      //             const TransactionHistoryScreen());

                      //         //Close Drawer
                      //         scafoldKey!.currentState!.openEndDrawer();
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // ListTile(
                      //   leading: const Icon(
                      //     Icons.exit_to_app_sharp,
                      //     color: mainColor,
                      //   ),
                      //   title: Text(
                      //     LocaleKeys.profile_logout.tr(),
                      //     style: normalBoldStyleWithColor,
                      //   ),
                      //   onTap: () => authCtrl.logout(),
                      // ),

                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "developed by Jacob Electric",
              style: CustomTextStyle.titleItalicStyleDarkGrey,
            ),
          )
        ],
      ),
    );
  }
}
