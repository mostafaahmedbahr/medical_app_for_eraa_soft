import 'package:badges/badges.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../../core/colors.dart';
 import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';
import '../notifications_screen.dart';
class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

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
                  child: CustomText(text: "No Internet",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.black87,),
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
                    text: "Terms",
                    textColor: const Color(0xff878787),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  actionsWidgets: [


                  ],
                ),
                backgroundColor: AppColors.mainColorWhite,
                body: Padding(
                  padding: EdgeInsets.all(20),
                  child: CustomText(text: """These terms and conditions is applied to your usage of the application and the website (www.ma3aak.app) - Ma3ak site and application By using Ma3ak site and application, you are accepting to commit to the following terms and conditions. In case of not accepting the terms and obligations, you shall be obligated not to use the site and application. We reserve our right to change the term and conditions from time to time without any notification what so ever. Accordingly, it is your responsibility to check the term and conditions periodically. Continuing of the use of Ma3ak site and application shall be considered an acceptance of the terms and conditions applied at the time of your usage to the site and applications As part of our obligation to make Ma3ak a site and application you want to visit continually, we are more than happily to receive your all comments upon any of the policies or rules that we are listing below.""",
                      fontSize: 30,
                  fontWeight: FontWeight.bold,
                  ),
                ),

              );
            }
        );
      },

    );
  }
}
