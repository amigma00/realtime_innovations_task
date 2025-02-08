import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => Future.value(false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
    barrierDismissible: false,
    barrierColor: const Color(0xff141A31).withOpacity(.4),
    useSafeArea: true,
  );
}

//hide loading
Future<void> hideDialog(BuildContext context) async {
  context.pop();
}
