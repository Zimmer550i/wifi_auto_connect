import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifi_auto_connect/widgets/glassmorphism.dart';
import '../utilities/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _playClickSound() async{
    await AudioPlayer().play(AssetSource("click.wav"));
  }

  void _playTapSound() async{
    await AudioPlayer().play(AssetSource("tap.wav"));
  }

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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //App Bar
                  Glassmorphism(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: whiteColor,
                          ),
                        ),
                        Text(
                          "Wifi Auto Connect",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor,
                                  ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu_rounded,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  //Top Bar
                  BarWidget(
                    iconLocation: "assets/wifi-router.png",
                    title: "Who's on my WIFI?",
                    body:
                        "Let you know about the devices connected to your wifi network",
                    onClick: (){
                      _playClickSound();
                    },
                  ),
                  //Grid
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        child: BoxWidget(
                          iconLocation: "assets/buy.png",
                          title: "Buy Internet",
                          body: "Buy more internet",
                          onClick: (){
                            _playClickSound();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: BoxWidget(
                          iconLocation: "assets/sell.png",
                          title: "Sell Internet",
                          body: "Sell your available internet",
                          onClick: (){
                            _playTapSound();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: BoxWidget(
                          iconLocation: "assets/user.png",
                          title: "My Account",
                          body: "Manage your account",
                          onClick: (){
                            _playTapSound();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: BoxWidget(
                          iconLocation: "assets/settings.png",
                          title: "Settings",
                          body: "Manage your settings",
                          onClick: (){
                            _playTapSound();
                          },
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  //Bottom Bar
                  const BarWidget(
                    iconLocation: "assets/padlock.png",
                    title: "Password Generator",
                    body:
                        "Easily create and generate random password for high security",
                    onClick: null,
                    iconRightSide: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BarWidget extends StatelessWidget {
  final String iconLocation;
  final String title;
  final String body;
  final Function()? onClick;
  final bool iconRightSide;

  const BarWidget({
    super.key,
    required this.iconLocation,
    required this.title,
    required this.body,
    required this.onClick,
    this.iconRightSide = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Glassmorphism(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              iconRightSide
                  ? Container()
                  : Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImageIcon(
                          AssetImage(iconLocation),
                          size: 80,
                          color: whiteColor.withOpacity(0.8),
                        ),
                      ),
                    ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: whiteColor.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Text(
                            body,
                            maxLines: 3,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: whiteColor.withOpacity(0.8),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: -5,
                      child: Icon(
                        Icons.double_arrow_rounded,
                        color: whiteColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              iconRightSide
                  ? Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ImageIcon(
                          AssetImage(iconLocation),
                          size: 80,
                          color: whiteColor.withOpacity(0.8),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final String iconLocation;
  final String title;
  final String body;
  final Function()? onClick;

  const BoxWidget({
    super.key,
    required this.iconLocation,
    required this.title,
    required this.body,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 2 - 32,
      width: MediaQuery.of(context).size.width / 2 - 32,
      child: GestureDetector(
        onTap: onClick,
        child: Stack(
          children: [
            Glassmorphism(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(),
                    ImageIcon(
                      AssetImage(iconLocation),
                      size: 80,
                      color: whiteColor.withOpacity(0.8),
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: whiteColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      body,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: whiteColor.withOpacity(0.8),
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Icon(
                Icons.double_arrow_rounded,
                color: whiteColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
