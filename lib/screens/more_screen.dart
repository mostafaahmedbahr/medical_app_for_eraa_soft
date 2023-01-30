import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';

import '../core/colors.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_sized_box.dart';
import '../widgets/custom_text.dart';
import 'more_screen/terms_screen.dart';
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
                const CustomSizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: (){
                    // navigatePushed(context,  const LanguagesScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  const [
                      Icon(Icons.language,color: AppColors.mainColorBlack,),
                        CustomSizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "Change language",
                        fontSize: 20,
                      ),
                      Spacer(),
                      CustomText(
                        text: 'English',
                        fontSize: 16,
                        textColor: AppColors.mainColor,
                      ),
                        CustomSizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
                const CustomSizedBox(
                  height: 20,
                ),
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
                const CustomSizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                     Navigator.push(context,MaterialPageRoute(builder: (context){
                       return TermsScreen();
                     }));
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
                      const CustomSizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: "terms".replaceAll('The ', ''),
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(
                  height: 20,
                ),
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
                        CustomSizedBox(
                        width: 10,
                      ),
                        CustomText(
                        text:"connect Us",
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                const CustomSizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        );
      },

    );
  }
}
