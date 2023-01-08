import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';

import '../core/colors.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_text.dart';
class MoreScreen extends StatelessWidget {
  const MoreScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height:30,),
                InkWell(
                  onTap: (){
                    // navigatePushed(context,  const LanguagesScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  const [
                      Icon(Icons.language,color: AppColors.mainColorBlack,),
                      SizedBox(width: 10,),
                      CustomText(
                        text: "Change language",
                        fontSize: 20,
                      ),
                      Spacer(),
                      // CacheHelper.getDataFromSharedPreferenceLang(key: 'lang')=='ar'?
                      // const CustomText(
                      //   text: 'العربية',
                      //   fontSize: 16,
                      //   color: AppColors.primaryColorGold3,
                      // ):
                      CustomText(
                        text: 'English',
                        fontSize: 16,
                        textColor: AppColors.mainColor,
                      ),
                      SizedBox(width: 10,),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    const CustomText(
                      text: "allow Notifications",
                      fontSize: 20,
                    ),
                    const Spacer(),
                    Transform.scale(
                      scale: 0.75,
                      child: CupertinoSwitch(
                          trackColor: AppColors.mainColor,
                          activeColor: AppColors.grey,
                          value:cubit.value ,
                          onChanged:(bool val){
                            // setState(() {
                            //   cubit.value = val;
                            //   print(cubit.value);
                            // });
                            cubit.changeValue(val);
                          }
                      ),
                    )
                  ],
                ),
                const SizedBox(height:20,),
                InkWell(
                  onTap: (){
                    // navigatePushed(context,const TermsScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:   [
                      const CustomImage(
                        'assets/images/terms.png',
                        isShadow: false,
                        isNetwork: false,
                        height: 25,
                        width: 25,
                      ),
                      const SizedBox(width: 10,),
                      CustomText(
                        text: "terms".replaceAll('The ', ''),
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:20,),
                InkWell(
                  onTap: (){
                    // navigatePushed(context,  ContactUsScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const  [

                        CustomImage(
                        'assets/images/contact us.png',
                        isShadow: false,
                        isNetwork: false,
                        height: 25,
                        width: 25,
                      ),
                        SizedBox(width: 10,),
                        CustomText(
                        text:"connect Us",
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:20,),
                // token.isNotEmpty? InkWell(
                //   onTap: ()async{
                //     showAlertDialog(context);
                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children:   [
                //       const Icon(Icons.delete,color: Colors.red,),
                //       const SizedBox(width: 10,),
                //       CustomText(
                //         text:LocaleKeys.deleteAccount.tr(),
                //         fontSize: 16,
                //         color: Colors.red,
                //       ),
                //     ],
                //   ),
                // ) : Container(),



              ],
            ),
          ),
        );
      },

    );
  }
}
