import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/patient_widget.dart';
import 'details_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index){
              return   InkWell(
                onTap: (){
                  cubit.getAllPatient();
                  print("fdgdfg");
                  Navigator.push(
                      context, PageTransition(
                      duration: const Duration(milliseconds: 400),
                      reverseDuration: const Duration(milliseconds: 400),
                      type: PageTransitionType.rightToLeft,
                      child:   DetailsScreen(),
                      inheritTheme: true,
                      ctx: context));
                },
                child:const CustomPatientWidget(),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 15,);
            },),
        );
      },

    );
  }
}
