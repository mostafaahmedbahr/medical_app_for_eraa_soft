import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/dio/end_points.dart';
import 'package:medical_app_for_eraa_soft/screens/search_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../widgets/custom_sized_box.dart';
import '../widgets/custom_text.dart';
import '../widgets/patient_widget.dart';
import 'details_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen ({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AppCubit.get(context).getAllPatient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        var searchCon = TextEditingController();
        return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
    builder: (context,snapshot) {
      return snapshot.data == ConnectivityResult.none ?
      Center(
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
      ): Padding(
        padding: const EdgeInsets.all(20.0),
        child:
        cubit.getAllPatientModel!.data!.data == null
            || cubit.getAllPatientModel!.data!.data == [] ?
        const Center(
          child: CircularProgressIndicator(
            color: AppColors.mainColor,
          ),
        ) :
        cubit.getAllPatientModel!.data!.data!.isEmpty ? const Center(
            child: Text("No Patients yet", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),)
        ) : Column(
          children: [
            TextFormField(
              controller: searchCon,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainColorBlack,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.mainColorBlack,
                      )
                  ),
                hintText: "Search",
                suffixIcon: IconButton(
                  onPressed: (){
                    cubit.search(searchName: searchCon.text.toString(), token: TOKEN);
                    if(state is SearchSuccessState){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SearchScreen();
                      }));
                    }
                  },
                  icon: Icon(Icons.search),
                )
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.separated(
                itemCount: cubit.getAllPatientModel!.data!.data!.length,
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
                            name: "${cubit.getAllPatientModel!.data!.data![index]
                                .name}",
                            dataOfBirth: "${cubit.getAllPatientModel!.data!
                                .data![index].dateOfBirth}",
                            diagnosis: "${cubit.getAllPatientModel!.data!.data![index]
                                .diagnosis}",
                            address: "${cubit.getAllPatientModel!.data!.data![index]
                                .address}",
                            visitTime: "${cubit.getAllPatientModel!.data!.data![index]
                                .visitTime}",
                            id: "${cubit.getAllPatientModel!.data!.data![index].id}",
                          ),
                          inheritTheme: true,
                          ctx: context));
                    },
                    child: CustomPatientWidget(
                      name: "${cubit.getAllPatientModel!.data!.data![index].name}",
                      dataOfBirth: "${cubit.getAllPatientModel!.data!.data![index]
                          .dateOfBirth}",
                      diagnosis: "${cubit.getAllPatientModel!.data!.data![index]
                          .diagnosis}",
                      address: "${cubit.getAllPatientModel!.data!.data![index]
                          .address}",
                      visitTime: "${cubit.getAllPatientModel!.data!.data![index]
                          .visitTime}",
                      id: "${cubit.getAllPatientModel!.data!.data![index].id}",
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const CustomSizedBox(
                    height: 15,
                  );
                },),
            ),
          ],
        ),
      );
    }
        );
      },

    );
  }
}
