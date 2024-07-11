import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wifi_auto_connect/pages/home_page.dart';
import 'package:wifi_auto_connect/utilities/constants.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/bg.jpg",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    "Wifi Auto Connect",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                  ),
                  Image.asset("assets/logo.png"),
                  const SlideButton(),
                  const SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: whiteColor,
                                      ),
                              text:
                                  "By Clicking on Let's Start You Agree To Our "),
                          TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: primaryColor),
                            text: "Privacy Policy.",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {

                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideButton extends StatefulWidget {
  const SlideButton({
    super.key,
  });

  @override
  State<SlideButton> createState() => _SlideButtonState();
}

class _SlideButtonState extends State<SlideButton> {
  double val = -10;

  void _playSound() async {
    await AudioPlayer().play(AssetSource("click.wav"));
  }

  void _playCancelSound() async{
    await AudioPlayer().play(AssetSource("tap.wav"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Shimmer.fromColors(
            baseColor: primaryColor.withOpacity(0.8),
            highlightColor: primaryColor.withOpacity(0.2),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 50,
                right: 30,
              ),
              child: const Text("Let's Start"),
            ),
          ),
          Positioned(
            left: val,
            top: -5,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  if (val < 120) {
                    val += details.delta.dx;
                  }
                });
              },
              onPanEnd: (details) {
                setState(() {
                  if (val < 120) {
                    _playCancelSound();
                    val = -10;
                  } else {
                    _playSound();
                    Get.to(
                      () => const HomePage(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 300),
                    );
                    val = -10;
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: primaryColor.withOpacity(0.8)),
                  borderRadius: const BorderRadius.all(Radius.circular(900)),
                  color: Colors.black.withOpacity(0.8),
                ),
                child: Icon(
                  Icons.power_settings_new_rounded,
                  size: 50,
                  color: primaryColor.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
