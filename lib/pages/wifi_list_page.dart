import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wifi_auto_connect/controller/wifi_controller.dart';
import 'package:wifi_iot/wifi_iot.dart';
import '../utilities/constants.dart';
import '../widgets/glassmorphism.dart';

class WifiListPage extends StatelessWidget {
  final wifiController = Get.put(WifiController());

  WifiListPage({super.key});

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
              child: GetX<WifiController>(
                dispose: (controller) {
                  controller.controller!.isScanning = false;
                },
                builder: (controller) {
                  return Column(
                    children: [
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
                              "Wifi List",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
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
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              const Glassmorphism(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: ImageIcon(
                                    AssetImage("assets/wifi-router.png"),
                                    size: 100,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Glassmorphism(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        width: 300,
                                      ),
                                      Text(
                                        controller.wifiNetworksList.length
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        "Available Wifi Networks",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ...List.generate(
                                controller.wifiNetworksList.length,
                                (index) => wifiInfo(
                                  context,
                                  controller.wifiNetworksList[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: deprecated_member_use
  Widget wifiInfo(BuildContext context, WifiNetwork network) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Glassmorphism(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.wifi_rounded,
                  size: 60,
                  color: whiteColor,
                ),
              ),
              //Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // const SizedBox(height: 8,),
                    Text(
                      network.ssid.toString(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Freq: ${network.frequency.toString()}MHz",
                            style: const TextStyle(
                                color: whiteColor, fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Channel: ${_convertFrequencyToChannel(network.frequency!.toInt())}",
                            style: const TextStyle(
                                color: whiteColor, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Security: ${_getSecurity(network.capabilities.toString())}",
                            style: const TextStyle(
                                color: whiteColor, fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            network.level.toString(),
                            style: const TextStyle(
                                color: whiteColor, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  wifiDetails(context, network);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: primaryColor,
                    highlightColor: Colors.white,
                    child: const Text(
                      "Connect",
                      style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _convertFrequencyToChannel(int frequency) {
    // 2.4 GHz Band
    if (frequency >= 2412 && frequency <= 2484) {
      return ((frequency - 2412) ~/ 5 + 1).toString();
    }
    // 5 GHz Band
    if (frequency >= 5170 && frequency <= 5825) {
      return ((frequency - 5170) ~/ 5 + 34).toString();
    }
    return "Unknown";
  }

  String _getSecurity(String info) {
    final Map<String, String> securityTypes = {
      "ESS": "Open",
      "WPA2-PSK": "WPA2",
      "WPA2-EAP": "WPA2",
      "WPA-PSK": "WPA",
      "WPA-EAP": "WPA",
      "WEP": "WEP",
    };

    for (String key in securityTypes.keys) {
      if (info.contains(key)) {
        return securityTypes[key]!;
      }
    }

    return "Unknown";
  }

  // ignore: deprecated_member_use
  void wifiDetails(BuildContext context, WifiNetwork network) {
    showModalBottomSheet(
      useSafeArea: true,
      backgroundColor: whiteColor.withOpacity(0.4),
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 400,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 32,
              ),
              child: Column(
                children: [
                  Text(
                    network.ssid.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
