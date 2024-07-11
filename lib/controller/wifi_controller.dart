// ignore_for_file: deprecated_member_use
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiController extends GetxController{
  RxList<WifiNetwork> wifiNetworksList = <WifiNetwork>[].obs;
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

    var newNetworks = WifiNetwork.parse("""[{"SSID":"Florian","BSSID":"30:7e:cb:8c:48:e4","capabilities":"[WPA-PSK-CCMP+TKIP][ESS]","frequency":2462,"level":-64,"timestamp":201307720907},{"SSID":"Pi3-AP","BSSID":"b8:27:eb:b1:fa:e1","capabilities":"[WPA2-PSK-CCMP][ESS]","frequency":2437,"level":-66,"timestamp":201307720892},{"SSID":"AlternaDom-SonOff","BSSID":"b8:27:eb:98:b4:81","capabilities":"[WPA2-PSK-CCMP][ESS]","frequency":2437,"level":-86,"timestamp":201307720897},{"SSID":"SFR_1CF0_2GEXT","BSSID":"9c:3d:cf:58:98:07","capabilities":"[WPA-PSK-CCMP+TKIP][WPA2-PSK-CCMP+TKIP][WPS][ESS]","frequency":2412,"level":-87,"timestamp":201307720887},{"SSID":"Freebox-5CC952","BSSID":"f4:ca:e5:96:71:c4","capabilities":"[WPA-PSK-CCMP][ESS]","frequency":2442,"level":-90,"timestamp":201307720902}]""");
    networks.addAll(newNetworks);

    wifiNetworksList.value = networks;
  }
}