import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed("/home"),
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(10),
        child: SvgPicture.asset(
          "assets/logo.svg",
        ),
      ),
    );
  }
}
