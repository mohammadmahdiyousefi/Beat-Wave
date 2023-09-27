import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPremission {
  static Future<void> getprimission() async {
    await notification();
    await storage();
  }

  static Future<PermissionStatus> notification() async {
    var status = await Permission.notification.request();
    return status;
  }

  static Future<PermissionStatus> storage() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var checkprimission = Hive.box("prmission");
    if (androidInfo.version.sdkInt <= 32) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        await checkprimission.put("check", true);
      } else {
        await checkprimission.put("check", false);
      }
      return status;
    } else {
      var status = await Permission.photos.request();
      var status1 = await Permission.audio.request();
      if (status.isGranted && status1.isGranted) {
        await checkprimission.put("check", true);
      } else {
        await checkprimission.put("check", false);
      }
      return status1;
    }
  }
}
