import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:intl/intl.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_app_bar.dart';
import 'package:page_transition/page_transition.dart';
import '../core/colors.dart';
import '../widgets/custom_text.dart';
import 'notifications_screen.dart';
class AddPatientScreen extends StatefulWidget {
    AddPatientScreen({Key? key}) : super(key: key);

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  DateTime? parsedTime;
  var nameCon = TextEditingController();
  var dateOfBirth = TextEditingController();
  var visitTime = TextEditingController();
  var diagnosisCon = TextEditingController();
  var addressCon = TextEditingController();
  TimeOfDay time = TimeOfDay(hour: 7, minute: 30);
  var formKey = GlobalKey<FormState>();
  var finalTime;
  _pickTime() async {
    TimeOfDay? timeRecord = await showTimePicker(
      context: context,
      initialTime: time.replacing(hour: time.hourOfPeriod),

    );
    if (timeRecord != null) {
      setState(() {
        var df = DateFormat("h:mm a");
        var dt = df.parse(timeRecord.format(context));
          finalTime = DateFormat('HH:mm').format(dt);
        print(finalTime);
        // this will return 13:30 only
      });
    }
  }
   dynamic currentTime = DateFormat.jm().format(DateTime.now());
   @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AddPatientSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
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
                Icons.arrow_back_ios_new, color: AppColors.mainColorBlack,),
            ),
            centerTitle: true,
            titleContent: const CustomText(text: "Add Your Patient",
              textColor: AppColors.mainColorBlack,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameCon,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainColor,
                              )
                          ),
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
                          contentPadding:
                          EdgeInsets
                              .symmetric(
                              horizontal: 10,
                              vertical: 10),
                          icon: Icon(
                            Icons.person,
                            color: AppColors.mainColorBlack,),
                          labelText: "Patient Name",
                          labelStyle: TextStyle(
                            color: AppColors.mainColorBlack,
                          )
                      ),

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
                            )
                        ),
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
                        contentPadding:
                        EdgeInsets
                            .symmetric(
                            horizontal: 10,
                            vertical: 10),
                        icon: Icon(
                          Icons.calendar_today,
                          color: AppColors.mainColorBlack,),
                        labelText: "Date Of Birth",
                        labelStyle: TextStyle(
                          color: AppColors.mainColorBlack,
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            dateOfBirth.text = DateFormat(
                                "yyyy-MM-dd")
                                .format(
                                pickedDate);
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
                            )
                        ),
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
                        contentPadding:
                        EdgeInsets
                            .symmetric(
                            horizontal: 10,
                            vertical: 10),
                        icon: Icon(
                          Icons.calendar_today,
                          color: AppColors.mainColorBlack,),
                        labelText: "Visit Time",
                        labelStyle: TextStyle(
                          color: AppColors.mainColorBlack,
                        ),
                      ),
                      onTap: () async {
                        TimeOfDay? pickedTime =  await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context, //context of current state
                        );
                        if(pickedTime != null ){
                          print(pickedTime.format(context));   //output 10:51 PM
                            parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime = DateFormat('HH:mm:ss').format(parsedTime!);
                          print(formattedTime); //output 14:59:00
                          setState((){
                            visitTime.text = "$parsedTime";
                          });
                          //DateFormat() is from intl package, you can format the time on any pattern you need.
                        }else{
                          print("Time is not selected");
                        }
                        setState((){
                          visitTime.text ="$parsedTime";
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: addressCon,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainColor,
                              )
                          ),
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
                          contentPadding:
                          EdgeInsets
                              .symmetric(
                              horizontal: 10,
                              vertical: 10),
                          icon: Icon(
                            Icons.location_city,
                            color: AppColors.mainColorBlack,),
                          labelText: "Patient Address",
                          labelStyle: TextStyle(
                            color: AppColors.mainColorBlack,
                          )
                      ),

                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                      controller: diagnosisCon,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.mainColor,
                              )
                          ),
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
                          contentPadding:
                          EdgeInsets
                              .symmetric(
                              horizontal: 10,
                              vertical: 10),
                          icon: Icon(
                            Icons.sick,
                            color: AppColors.mainColorBlack,),
                          labelText: "Patient Diagnosis",
                          labelStyle: TextStyle(
                            color: AppColors.mainColorBlack,
                          )
                      ),

                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! AddPatientLoadingState,
                      fallback: (context) =>
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,),
                      ),
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.mainColor,
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.addPatient(
                                  name: nameCon.text.toString(),
                                  dateOfBirth: dateOfBirth.text.toString(),
                                  diagnosis: diagnosisCon.text.toString(),
                                  address: addressCon.text.toString(),
                                  visitTime: "$parsedTime",
                                );
                              }
                            },
                            child: const CustomText(text: "Add",
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
      },

    );
  }


}
