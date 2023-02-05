import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/custom_sized_box.dart';
import '../widgets/custom_text.dart';
import '../widgets/patient_widget.dart';
import 'details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return   StreamBuilder<ConnectivityResult>(
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
            ): Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.mainColor,
              ),
              body:state is SearchLoadingState ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.mainColor,
                ),
              ) :
              cubit.searchModel!.data!.data!.isEmpty ? Center(
                child: Text("No Result",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
              ) :
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.separated(
                  itemCount: cubit.searchModel!.data!.data!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.push(
                            context, PageTransition(
                            duration: const Duration(milliseconds: 400),
                            reverseDuration: const Duration(milliseconds: 400),
                            type: PageTransitionType.rightToLeft,
                            child: DetailsScreen(
                              name: "${cubit.searchModel!.data!.data![index].name}",
                              dataOfBirth: "${cubit.searchModel!.data!
                                  .data![index].dateOfBirth}",
                              diagnosis: "${cubit.searchModel!.data!.data![index]
                                  .diagnosis}",
                              address: "${cubit.searchModel!.data!.data![index]
                                  .address}",
                              visitTime: "${cubit.searchModel!.data!.data![index]
                                  .visitTime}",
                              id: "${cubit.searchModel!.data!.data![index].id}",
                            ),
                            inheritTheme: true,
                            ctx: context));
                      },
                      child: CustomPatientWidget(
                        name: "${cubit.searchModel!.data!.data![index].name}",
                        dataOfBirth: "${cubit.searchModel!.data!.data![index]
                            .dateOfBirth}",
                        diagnosis: "${cubit.searchModel!.data!.data![index]
                            .diagnosis}",
                        address: "${cubit.searchModel!.data!.data![index]
                            .address}",
                        visitTime: "${cubit.searchModel!.data!.data![index]
                            .visitTime}",
                        id: "${cubit.searchModel!.data!.data![index].id}",
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const CustomSizedBox(
                      height: 15,
                    );
                  },),
              ),
            );
    }

        );
      },

    );
  }
}
