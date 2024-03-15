import 'dart:io';
import 'package:beat_wave/widget/toastflutter.dart';
import 'package:flutter/material.dart';
import 'package:ringtone_set/ringtone_set.dart';

class SetRingTone {
  static Future<void> setRingTone(BuildContext context, String path) async {
    await RingtoneSet.setRingtoneFromFile(File(path)).then((value) {
      if (value) {
        toast(context, "Ringtone Set");
      } else {
        toast(context, "Error");
      }
    });
  }

  static Future<void> setAlarm(BuildContext context, String path) async {
    await RingtoneSet.setAlarmFromFile(File(path)).then((value) {
      if (value) {
        toast(context, "Alarm Ringtone Set");
      } else {
        toast(context, "Error");
      }
    });
  }

  static Future<void> setNotification(BuildContext context, String path) async {
    await RingtoneSet.setNotificationFromFile(File(path)).then((value) {
      if (value) {
        toast(context, "Notification Ringtone Set");
      } else {
        toast(context, "Error");
      }
    });
  }
}
