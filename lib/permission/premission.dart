import 'package:beat_wave/di/di.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AppPremission {
  static Future<bool> storage() async {
    final OnAudioQuery permission = locator.get<OnAudioQuery>();
    var status = await permission.permissionsStatus();
    if (status == false) {
      status = await permission.permissionsRequest();
    }
    return status;
  }
}
