// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiController extends GetxController{
  RxList<WifiNetwork> wifiNetworksList = <WifiNetwork>[].obs;
  bool isScanning = false;
  bool _locationPermitted = false;

  Future<void> requestPermissions() async {
    PermissionStatus status = await Permission.locationWhenInUse.status;
    _locationPermitted = status.isGranted;
    await Permission.locationWhenInUse.request();
  }

  void getWifiNetworks() async{
    if(!_locationPermitted) {
      await requestPermissions();
    }
    List<WifiNetwork> networks = await WiFiForIoTPlugin.loadWifiList();

    wifiNetworksList.value = networks;

    await Future.delayed(const Duration(seconds: 2));
    if(isScanning){
      getWifiNetworks();
    }
  }
}