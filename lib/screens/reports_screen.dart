import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_text.dart';

import '../bloc/states.dart';
class ReportsScreen extends StatelessWidget {
  const ReportsScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20),
    child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
    builder: (context,state){
      var cubit = AppCubit.get(context);
          return  StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
    builder: (context,snapshot) {
      return snapshot.data == ConnectivityResult.none ?
      Center(
        child: CustomText(text: "No Internet",
          fontSize: 30,
          fontWeight: FontWeight.bold,
          textColor: Colors.black87,),
      ): Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text:"All Patient",
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              CustomText(text:"${cubit.getAllPatientModel?.data?.data?.length}",
                fontWeight: FontWeight.bold,
                fontSize: 30,
                textColor: Colors.green,
              ),
            ],
          ),
        ],
      );
    }

          );
    }

    ),

    );
  }
}
