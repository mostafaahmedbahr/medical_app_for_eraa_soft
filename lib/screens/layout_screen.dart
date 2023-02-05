import 'package:badges/badges.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
 import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/dio/sh/sh.dart';
import 'package:medical_app_for_eraa_soft/screens/profil_screen.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_sized_box.dart';
import 'package:page_transition/page_transition.dart';
import '../dio/end_points.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text.dart';
import 'add_patient_screen.dart';
import 'more_screen.dart';
import 'notifications_screen.dart';
import 'reports_screen.dart';
import 'home_screen.dart';
class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    context.read<AppCubit>().getAllPatient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context,snapshot) {
            return snapshot.data == ConnectivityResult.none ?
            Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    Image.asset("assets/images/wifi.png",
                    height: 100,),
                    CustomSizedBox(
                      height: 20,
                    ),
                    CustomText(text: "No Internet",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.black87,),
                  ],
                ),
              ),
            ): 
            Scaffold(
              appBar: CustomAppBar(
                appBarToolbarHeight: 70,
                automaticallyLeading: true,
                appBarBackgroundColor: AppColors.mainColorWhite,
                appElevation: 0,
                leadingWidget: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context, PageTransition(
                        duration: const Duration(milliseconds: 400),
                        reverseDuration: const Duration(milliseconds: 400),
                        type: PageTransitionType.leftToRight,
                        child: const NotificationsScreen(),
                        inheritTheme: true,
                        ctx: context));
                  },
                  icon: cubit.value == false ?
                  Badge(
                      badgeContent: const Text("0"
                        , style: TextStyle(color: Colors.white),),
                      child: Image.asset(
                        'assets/images/img_11.png', height: 20,)) :
                  Image.asset("assets/images/img_11.png",
                    height: 20,),
                ),
                centerTitle: true,
                titleContent: CustomText(
                  text: cubit.appBarTitles[cubit.bottomNavBarIndex],
                  textColor: const Color(0xff878787),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                actionsWidgets: [
                  IconButton(
                    onPressed: () {
                      showAlertDialog(context);
                      // Navigator.push(
                      //     context, PageTransition(
                      //     duration: const Duration(milliseconds: 400),
                      //     reverseDuration: const Duration(milliseconds: 400),
                      //     type: PageTransitionType.leftToRight,
                      //     child: const NotificationsScreen(),
                      //     inheritTheme: true,
                      //     ctx: context));
                    },
                    icon: const Icon(
                      IconlyLight.logout, color: AppColors.mainColorBlack,),
                  ),

                ],
              ),
              backgroundColor: AppColors.mainColorWhite,
              body: cubit.getAllPatientModel?.data?.data == null ||
                  cubit.getAllPatientModel?.data?.data == [] ?
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ) : PageStorage(
                bucket: cubit.bucket,
                child: cubit.currentScreen,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  print(TOKEN);
                  Navigator.push(
                      context, PageTransition(
                      duration: const Duration(milliseconds: 400),
                      reverseDuration: const Duration(milliseconds: 400),
                      type: PageTransitionType.bottomToTop,
                      child: const AddPatientScreen(),
                      inheritTheme: true,
                      ctx: context));
                },
                backgroundColor: AppColors.mainColor,
                hoverElevation: 10,
                splashColor: Colors.grey,
                tooltip: 'Add',
                elevation: 4,
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
              bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                shape: const CircularNotchedRectangle(),
                notchMargin: 10,
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: kBottomNavigationBarHeight * 1.1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.mainColorWhite,
                      border: Border(
                        top: BorderSide(
                          color: AppColors.grey,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MaterialButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30),
                              minWidth: 40,
                              onPressed: () {
                                cubit.currentScreen = const HomeScreen();
                                cubit.changeBottomNavBarIndex(
                                    cubit.bottomNavBarIndex = 0);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconlyBold.home,
                                    color: cubit.bottomNavBarIndex == 0
                                        ? AppColors.mainColor
                                        : AppColors.grey,),
                                  CustomText(text: "Home",
                                    textColor: cubit.bottomNavBarIndex == 0
                                        ? AppColors.mainColor
                                        : AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ],
                              ),
                            ),
                            MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                cubit.currentScreen = const ReportsScreen();
                                cubit.changeBottomNavBarIndex(
                                    cubit.bottomNavBarIndex = 1);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconlyBold.calendar,
                                    color: cubit.bottomNavBarIndex == 1
                                        ? AppColors.mainColor
                                        : AppColors.grey,),
                                  CustomText(text: "Reports",
                                    textColor: cubit.bottomNavBarIndex == 1
                                        ? AppColors.mainColor
                                        : AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                cubit.currentScreen = ProfileScreen();
                                cubit.changeBottomNavBarIndex(
                                    cubit.bottomNavBarIndex = 2);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(IconlyBold.profile,
                                    color: cubit.bottomNavBarIndex == 2
                                        ? AppColors.mainColor
                                        : AppColors.grey,),
                                  CustomText(text: "Profile",
                                    textColor: cubit.bottomNavBarIndex == 2
                                        ? AppColors.mainColor
                                        : AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ],
                              ),
                            ),
                            MaterialButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30),
                              minWidth: 40,
                              onPressed: () {
                                cubit.currentScreen = MoreScreen();
                                cubit.changeBottomNavBarIndex(
                                    cubit.bottomNavBarIndex = 3);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.more_horiz,
                                    color: cubit.bottomNavBarIndex == 3
                                        ? AppColors.mainColor
                                        : AppColors.grey,),
                                  CustomText(text: "more",
                                    textColor: cubit.bottomNavBarIndex == 3
                                        ? AppColors.mainColor
                                        : AppColors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),

                  ),
                ),
              ),

            );
          }
        );
      },

    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel",style: TextStyle(
        color: AppColors.mainColor,
      ),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Logout",style: TextStyle(
        color: AppColors.mainColor,
      ),),
      onPressed:  ()async {
        SharedPreferencesHelper.removeData(key: "token");
        AppCubit.get(context).signOut(context);
        print(TOKEN);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Logout"),
      content: const Text("Are You Sure To Logout ?? "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
