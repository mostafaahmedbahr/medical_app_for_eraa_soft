import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
 import 'package:medical_app_for_eraa_soft/screens/layout_screen.dart';
import '../core/colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_sized_box.dart';
import '../widgets/custom_text.dart';

class UpdatePatientScreen extends StatefulWidget {
  UpdatePatientScreen({
    Key? key,
    required this.time,
    required this.date,
    required this.name,
    required this.address,
    required this.diagnosis,
    required this.id,
  }) : super(key: key);

  String? name;
  String? date;
  String? time;
  String? diagnosis;
  String? address;
  String? id;

  @override
  State<UpdatePatientScreen> createState() => _UpdatePatientScreenState();
}

class _UpdatePatientScreenState extends State<UpdatePatientScreen> {
  var dateOfBirth = TextEditingController();
  var visitTime = TextEditingController();
  TimeOfDay time = const TimeOfDay(hour: 7, minute: 30);
  var formKey = GlobalKey<FormState>();
  var finalTime;

  // _pickTime() async {
  //   TimeOfDay? timeRecord = await showTimePicker(
  //     context: context,
  //     initialTime: time.replacing(hour: time.hourOfPeriod),
  //   );
  //   if (timeRecord != null) {
  //     setState(() {
  //       var df = DateFormat("h:mm a");
  //       var dt = df.parse(timeRecord.format(context));
  //       finalTime = DateFormat('HH:mm').format(dt);
  //       print(finalTime);
  //       // this will return 13:30 only
  //     });
  //   }
  // }

  dynamic currentTime = DateFormat.jm().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
        if(state is UpdatePatientSuccessState){
       await   AppCubit.get(context).getAllPatient();
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const LayoutScreen();
          }));
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
    builder: (context,snapshot) {
      return Form(
        key: formKey,
        child: Scaffold(
          appBar: CustomAppBar(
            appBarToolbarHeight: 70,
            automaticallyLeading: true,
            appBarBackgroundColor: AppColors.mainColorWhite,
            appElevation: 0,
            leadingWidget: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.mainColorBlack,
              ),
            ),
            centerTitle: true,
            titleContent: const CustomText(
              text: "Update Your Patient",
              textColor: AppColors.mainColorBlack,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          body:snapshot.data == ConnectivityResult.none ?
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
          ): SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (val) {
                      widget.name = val;
                      print(widget.name);
                    },
                    initialValue: widget.name,
                    // controller: nameCon,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            )),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        icon: Icon(
                          Icons.person,
                          color: AppColors.mainColorBlack,
                        ),
                        labelText: "Patient Name",
                        labelStyle: TextStyle(
                          color: AppColors.mainColorBlack,
                        )),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: dateOfBirth,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.mainColor,
                          )),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.mainColorBlack,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.mainColorBlack,
                          )),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      icon: Icon(
                        Icons.calendar_today,
                        color: AppColors.mainColorBlack,
                      ),
                      labelText: "Date Of Birth",
                      labelStyle: TextStyle(
                        color: AppColors.mainColorBlack,
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dateOfBirth.text =
                              DateFormat("yyyy-MM-dd").format(pickedDate);
                          print(dateOfBirth.text);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: visitTime,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.mainColor,
                          )),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.mainColorBlack,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.mainColorBlack,
                          )),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      icon: Icon(
                        Icons.calendar_today,
                        color: AppColors.mainColorBlack,
                      ),
                      labelText: "Visit Time",
                      labelStyle: TextStyle(
                        color: AppColors.mainColorBlack,
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          visitTime.text =
                              DateFormat("yyyy-MM-dd").format(pickedDate);
                          print(visitTime.text);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      widget.address = val;
                    },
                    initialValue: widget.address,
                    // controller: addressCon,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            )),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        icon: Icon(
                          Icons.location_city,
                          color: AppColors.mainColorBlack,
                        ),
                        labelText: "Patient Address",
                        labelStyle: TextStyle(
                          color: AppColors.mainColorBlack,
                        )),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      widget.diagnosis = val;
                    },
                    initialValue: widget.diagnosis,
                    // controller: diagnosisCon,
                    maxLines: 6,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColor,
                            )),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mainColorBlack,
                            )),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        icon: Icon(
                          Icons.sick,
                          color: AppColors.mainColorBlack,
                        ),
                        labelText: "Patient Diagnosis",
                        labelStyle: TextStyle(
                          color: AppColors.mainColorBlack,
                        )),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  ConditionalBuilder(
                    condition: state is! UpdatePatientLoadingState,
                    fallback: (context) =>
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    ),
                    builder: (context) {
                      return SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.mainColor,
                          ),
                          onPressed: () {
                            print(widget.name.toString());
                            print(dateOfBirth.text.toString());
                            print(widget.diagnosis.toString());
                            print(widget.address.toString());
                            print(visitTime.text.toString());
                            print(widget.id.toString());
                            if (formKey.currentState!.validate()) {
                              cubit.updatePatient(
                                name: widget.name.toString(),
                                address: widget.address.toString(),
                                dateOfBirth: dateOfBirth.text.toString(),
                                diagnosis: widget.diagnosis.toString(),
                                visitTime: visitTime.text.toString(),
                                patientId: widget.id.toString(),
                              );
                              // Navigator.push(context, MaterialPageRoute(builder: (context){
                              //   return const LayoutScreen();
                              // }));
                            }
                          },
                          child: const CustomText(
                            text: "Save",
                            fontSize: 30,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
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
}
