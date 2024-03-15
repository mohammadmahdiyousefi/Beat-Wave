import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(
  BuildContext context,
  String titel,
) {
  final FToast fToast = FToast();
  fToast.removeCustomToast();
  fToast.init(context);
  Widget toast = ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Theme.of(context).cardColor,
        ),
        child: Text(titel,
            style: const TextStyle(
                color: Colors.white, overflow: TextOverflow.ellipsis)),
      ),
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
    fadeDuration: const Duration(milliseconds: 350),
  );
}
