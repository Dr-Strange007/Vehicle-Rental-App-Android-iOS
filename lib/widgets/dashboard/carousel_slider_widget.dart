import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controller/bottom_nav_bar/dashboard/dashboard_controller.dart';

import '../../utils/custom_color.dart';
import '../../utils/dimensions.dart';
import '../../utils/size.dart';

class MyCarouselSlider extends StatelessWidget {
  final DashboardController controller;

  const MyCarouselSlider({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final RxInt current = 0.obs;

    return controller.widgets.isEmpty
        ? const SizedBox.shrink()
        : Column(
            children: [
              CarouselSlider(
                items: controller.widgets.map((widget) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(),
                        child: widget,
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  aspectRatio: 16 / 8.5,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    current.value = index;
                  },
                ),
              ),
              verticalSpace(Dimensions.heightSize * .5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.widgets.asMap().entries.map((entry) {
                  final index = entry.key;
                  return Obx(() => Container(
                        width: current.value == index ? 6.0 : 4.0,
                        height: current.value == index ? 6.0 : 4.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: current.value == index
                              ? CustomColor.primaryLightColor
                              : CustomColor.primaryLightColor.withOpacity(0.2),
                        ),
                      ));
                }).toList(),
              ),
            ],
          );
  }
}
