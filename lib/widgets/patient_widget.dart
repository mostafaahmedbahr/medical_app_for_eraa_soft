import 'package:flutter/material.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_text.dart';
class CustomPatientWidget extends StatelessWidget {
  const CustomPatientWidget({Key? key, required this.name, required this.dataOfBirth, required this.diagnosis, required this.address, required this.visitTime}) : super(key: key);
final String name;
final String dataOfBirth;
final String diagnosis;
final String address;
final String visitTime;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainColor,
      ),
      child: Row(
        children: [
          Image.asset("assets/images/fun-3d-cartoon-illustration-indian-doctor.jpg",width: 150,
          height: 140,
          fit: BoxFit.cover,
          ),
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              CustomText(text: name,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              textColor: AppColors.mainColorWhite,),
               const SizedBox(height: 10,),
              CustomText(text: dataOfBirth,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                textColor: AppColors.mainColorWhite,),
            ],
          ),
          const Spacer(),
          IconButton(onPressed: (){},
            icon:const Icon(Icons.arrow_forward_ios,
            color: AppColors.mainColorWhite,),
          ),
        ],
      ),
    );
  }
}
