import 'package:flutter/widgets.dart';

extension ResponsiveSize on num {
  Widget get kheightBox => SizedBox(height: toDouble());
  Widget get kwidthBox => SizedBox(width: toDouble());
}
