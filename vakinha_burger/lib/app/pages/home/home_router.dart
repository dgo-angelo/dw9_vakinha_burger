import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinha_burger/app/pages/home/home_controller.dart';
import 'package:vakinha_burger/app/pages/home/home_page.dart';
import 'package:vakinha_burger/app/repositories/products/product_repository.dart';
import 'package:vakinha_burger/app/repositories/products/product_repository_impl.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductRepository>(
            create: (context) => ProductRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider<HomeController>(
            create: (context) => HomeController(
              productRepository: context.read(),
            ),
          )
        ],
        child: const HomePage(),
      );
}
