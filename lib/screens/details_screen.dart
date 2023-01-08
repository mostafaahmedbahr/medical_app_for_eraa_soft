 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../widgets/custom_app_bar.dart';
import '../core/colors.dart';
import '../widgets/custom_text.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List imagesSlider = [
    "assets/images/fun-3d-cartoon-illustration-indian-doctor.jpg",
    "assets/images/fun-3d-cartoon-illustration-indian-doctor (1).jpg",
  ];
  var current = 0;
  var carouselController = CarouselController() ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:  Scaffold(
        backgroundColor:const Color(0xffFFFFFF) ,
        appBar: CustomAppBar(
          appBarToolbarHeight: 70,
          automaticallyLeading: true,
          appBarBackgroundColor: AppColors.mainColorWhite,
          appElevation: 0,
          leadingWidget:   IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(Icons.arrow_back,color: AppColors.mainColor,)) ,
          titleContent: const CustomText(
            text: "Details",
            textColor: AppColors.mainColorBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  children: [
                    ListView(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 332,
                          width: double.infinity,
                          child:   CarouselSlider(
                            items: imagesSlider
                                .map((item) {
                              return Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          // Get.to(()=>TestFullScreen());
                                        },
                                        child:ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child:  Image.asset(
                                            "$item",
                                            height: 332,
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                          ),
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 14),
                                      alignment: Alignment.bottomCenter,
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: AppColors.mainColor),
                                      child: CustomText(
                                        text: '${current + 1}/${imagesSlider.length}',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        textColor: Colors.white,
                                      ),
                                    ),

                                  ]);
                            }).toList(),
                            carouselController: carouselController,
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                // height: MediaQuery.of(context).size.height * 0.4,
                                aspectRatio: 1,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlayInterval: const Duration(seconds: 4),
                                autoPlayAnimationDuration:
                                const Duration(seconds: 4),
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) {
                                  changeIndicator(index);
                                }),
                          ),
                        ),
                        const SizedBox(height: 17,),
                        const CustomText(
                          text: "Description",
                          fontWeight: FontWeight.w800,
                          textColor: AppColors.mainColorBlack,
                          fontSize: 17,
                        ),
                        const CustomText(text: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.",
                          textColor: AppColors.mainColorBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          maxLines: 6,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 14,),
                        const CustomText(
                          text: "Contents",
                          textColor:AppColors.mainColorBlack,
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          height: 480,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 17),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.info_outlined,size: 30,),
                                        SizedBox(width: 10,),
                                        CustomText(text: "other",
                                          textColor: AppColors.mainColorBlack,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ],
                                    ),
                                    const  SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:35 ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.check_circle_outline,color: AppColors.mainColorGreen),
                                          SizedBox(width: 10,),
                                          CustomText(text: "Treatment 1",
                                            textColor: AppColors.darkGrey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:35 ),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.check_circle_outline,color: AppColors.mainColorGreen),
                                          SizedBox(width: 10,),
                                          CustomText(text: "Treatment 2",
                                            textColor:AppColors.darkGrey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),


                  ]  ),
            )
        ),
      ),
    );

  }


  void changeIndicator(int value) {
    setState(() {
      current = value;
    });
  }
}