import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:carousel_slider/carousel_slider.dart';
import 'package:medical_app_for_eraa_soft/bloc/cubit.dart';
import 'package:medical_app_for_eraa_soft/bloc/states.dart';
 import 'package:medical_app_for_eraa_soft/screens/update_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../widgets/custom_app_bar.dart';
import '../core/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_sized_box.dart';
import '../widgets/custom_text.dart';

class DetailsScreen extends StatefulWidget {
    const DetailsScreen({Key? key, required this.name, required this.dataOfBirth, required this.diagnosis, required this.address, required this.visitTime, required this.id , }) : super(key: key);
    final String name;
    final String dataOfBirth;
    final String diagnosis;
    final String address;
    final String visitTime;
    final String id;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List imagesSlider = [
    "assets/images/fun-3d-cartoon-illustration-indian-doctor.jpg",
    "assets/images/fun-3d-cartoon-illustration-indian-doctor (1).jpg",
  ];
  var current = 0;
  var carouselController = CarouselController();

  @override
  void initState() {
    AppCubit.get(context).getAllPatient();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xffFFFFFF),
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
                    Icons.arrow_back,
                    color: AppColors.mainColor,
                  )),
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
              child: Column(children: [
                ListView(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 332,
                      width: double.infinity,
                      child: CarouselSlider(
                        items: imagesSlider.map((item) {
                          return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      // Get.to(()=>TestFullScreen());
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
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
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.mainColor),
                                  child: CustomText(
                                    text:
                                        '${current + 1}/${imagesSlider.length}',
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
                    const CustomSizedBox(
                      height: 17,
                    ),
                    const CustomText(
                      text: "Some Information : ",
                      fontWeight: FontWeight.w800,
                      textColor: AppColors.mainColorBlack,
                      fontSize: 17,
                    ),
                    const CustomSizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 17),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.info_outlined,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                      text: "other",
                                      textColor: AppColors.mainColorBlack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  child: Row(
                                    children:  [
                                      const Icon(Icons.check_circle_outline,
                                          color: AppColors.mainColorGreen),
                                      const  SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                        text: widget.name,
                                        textColor: AppColors.darkGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  child: Row(
                                    children:  [
                                      const Icon(Icons.check_circle_outline,
                                          color: AppColors.mainColorGreen),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                        text: widget.diagnosis,
                                        textColor: AppColors.darkGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  child: Row(
                                    children:  [
                                      const Icon(Icons.check_circle_outline,
                                          color: AppColors.mainColorGreen),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                        text: widget.address,
                                        textColor: AppColors.darkGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  child: Row(
                                    children:  [
                                      const Icon(Icons.check_circle_outline,
                                          color: AppColors.mainColorGreen),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CustomText(
                                        text: widget.visitTime,
                                        textColor: AppColors.darkGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const CustomSizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      height: 60,
                      onPressed: (){
                        Navigator.push(
                            context, PageTransition(
                            duration: const Duration(milliseconds: 400),
                            reverseDuration: const Duration(milliseconds: 400),
                            type: PageTransitionType.leftToRight,
                            child: UpdatePatientScreen(
                              name: widget.name,
                              address: widget.address,
                              date: widget.dataOfBirth,
                              diagnosis: widget.diagnosis,
                              time: widget.visitTime,
                              id: widget.id,
                            ),
                            inheritTheme: true,
                            ctx: context));
                      },
                      btnText: const CustomText(
                        text: "Update",
                        fontSize: 20,
                      ),
                      btnColor: AppColors.mainColor,
                      width: double.infinity,
                    ),
                  ],
                ),
              ]),
            )),
          ),
        );
      },
    );
  }

  void changeIndicator(int value) {
    setState(() {
      current = value;
    });
  }
}
