import 'package:flutter/material.dart';
import 'package:medical_app_for_eraa_soft/core/colors.dart';
import 'package:medical_app_for_eraa_soft/widgets/custom_text.dart';
class CustomPatientWidget extends StatelessWidget {
  const CustomPatientWidget({Key? key, required this.name, required this.dataOfBirth, required this.diagnosis, required this.address, required this.visitTime, required this.id}) : super(key: key);
final String name;
final String dataOfBirth;
final String diagnosis;
final String address;
final String visitTime;
final String id;
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
          Image.asset("assets/images/doctor-with-his-arms-crossed-white-background.jpg",width: 150,
          height: 140,
          fit: BoxFit.cover,
          ),
          const SizedBox(width: 10,),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Flexible(child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),),
               
                 const SizedBox(height: 10,),
                CustomText(text: dataOfBirth,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  textColor: AppColors.mainColorWhite,),
              ],
            ),
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
