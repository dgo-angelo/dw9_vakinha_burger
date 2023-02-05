import 'package:flutter/cupertino.dart';
import 'package:vakinha_burger/app/core/config/env/env.dart';
import 'package:vakinha_burger/app/vakinha_burger_app.dart';

void main() async {
  await Env.instance.load();
  runApp(VakinhaBurgerApp());
}
