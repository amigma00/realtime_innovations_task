import 'package:flutter/material.dart';

class DialogHelper {
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => WillPopScope(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Center(
                child: Container(
                    height: 80,
                    width: 80,
                    padding: EdgeInsets.all(12),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    )),
              ),
            ],
          ),
        ),
        onWillPop: () => Future.value(false),
      ),
      barrierDismissible: false,
      barrierColor: const Color(0xff141A31).withOpacity(.4),
      useSafeArea: true,
    );
  }

  //hide loading
  static Future<void> hideDialog(BuildContext context) async {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
