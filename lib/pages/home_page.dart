import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifi_auto_connect/widgets/glassmorphism.dart';
import '../utilities/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  const BarWidget(
                    icon: Icons.wifi_rounded,
                    title: "Who's on my WIFI?",
                    body:
                        "Let you know about the devices connected to your wifi network",
                    onClick: null,
                  ),
                  //Grid
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Expanded(
                        child: const BoxWidget(
                          icon: Icons.wifi_rounded,
                          title: "Buy Internet",
                          body:
                              "Buy more internet",
                          onClick: null,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                        child: const BoxWidget(
                          icon: Icons.wifi_rounded,
                          title: "Sell Internet",
                          body:
                              "Sell your available internet",
                          onClick: null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      Expanded(
                        child: const BoxWidget(
                          icon: Icons.wifi_rounded,
                          title: "My Account",
                          body:
                          "Manage your account",
                          onClick: null,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Expanded(
                        child: const BoxWidget(
                          icon: Icons.wifi_rounded,
                          title: "Settings",
                          body:
                          "Manage your settings",
                          onClick: null,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  //Bottom Bar
                  const BarWidget(
                    icon: Icons.wifi_rounded,
                    title: "Who's on my WIFI?",
                    body:
                        "Let you know about the devices connected to your wifi network",
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
  final IconData icon;
  final String title;
  final String body;
  final Function()? onClick;
  final bool iconRightSide;

  const BarWidget({
    super.key,
    required this.icon,
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
                      child: Icon(
                        icon,
                        size: 100,
                        color: whiteColor.withOpacity(0.8),
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
                      child: Icon(
                        icon,
                        size: 100,
                        color: whiteColor,
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
  final IconData icon;
  final String title;
  final String body;
  final Function()? onClick;

  const BoxWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 2 - 24,
      width: MediaQuery.of(context).size.width / 2 - 24,
      child: GestureDetector(
        onTap: onClick,
        child: Stack(
          children: [
            Glassmorphism(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(),
                    Icon(
                      icon,
                      size: 100,
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
