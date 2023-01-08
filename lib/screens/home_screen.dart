import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/patient_widget.dart';
import 'details_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
        itemCount: 10,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index){
            return   InkWell(
              onTap: (){
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
  }
}
