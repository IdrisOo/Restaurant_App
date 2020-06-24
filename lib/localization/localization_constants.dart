import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:restauranttest/localization/demo_localization.dart';
String getTranslated(BuildContext context, String key){
  return DemoLocalizations.of(context).getTranslatedValue(key);
}