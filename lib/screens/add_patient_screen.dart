import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
import 'package:intl/intl.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_app_bar.dart';
 import '../core/colors.dart';
import '../widgets/custom_sized_box.dart';
import '../widgets/custom_text.dart';
 class AddPatientScreen extends StatefulWidget {
    const AddPatientScreen({Key? key}) : super(key: key);

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
  TimeOfDay time = const TimeOfDay(hour: 7, minute: 30);
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
          AppCubit.get(context).getAllPatient();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
     builder: (context,snapshot) {
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
         body: snapshot.data == ConnectivityResult.none ?
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
         ): Form(
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
                   const CustomSizedBox(
                     height: 15,
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
                         firstDate: DateTime(2020),
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
                   const CustomSizedBox(
                     height: 15,
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
                       DateTime? pickedDate = await showDatePicker(
                         context: context,
                         initialDate: DateTime.now(),
                         firstDate: DateTime(2020),
                         lastDate: DateTime(2030),
                       );
                       if (pickedDate != null) {
                         setState(() {
                           visitTime.text = DateFormat(
                               "yyyy-MM-dd")
                               .format(
                               pickedDate);
                           print(visitTime.text);
                         });
                       }
                       print(visitTime.text);
                     },
                   ),
                   const CustomSizedBox(
                     height: 15,
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
                   const CustomSizedBox(
                     height: 15,
                   ),
                   TextFormField(
                     controller: diagnosisCon,
                     maxLines: 6,
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
                   const CustomSizedBox(
                     height: 15,
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
                                 visitTime: visitTime.text.toString(),
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
                   const CustomSizedBox(
                     height: 15,
                   ),
                 ],
               ),
             ),
           ),
         ),

         );
     }   );
      },

    );
  }


}
