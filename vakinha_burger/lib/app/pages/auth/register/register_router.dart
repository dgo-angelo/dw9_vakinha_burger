import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burger/app/pages/auth/register/register_controller.dart';
import 'package:vakinha_burger/app/pages/auth/register/register_page.dart';

class RegisterRouter {
  RegisterRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<RegisterContoller>(
            create: (context) => RegisterContoller(
              authRepository: context.read(),
            ),
          ),
        ],
        child: const RegisterPage(),
      );
}
