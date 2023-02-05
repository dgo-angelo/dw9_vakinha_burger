import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vakinha_burger/app/core/exceptions/repository_exception.dart';
import 'package:vakinha_burger/app/dto/order_dto.dart';
import 'package:vakinha_burger/app/models/payment_type_model.dart';

import '../../core/rest_client/custom_dio.dart';
import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;
  OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await dio.auth().get('/payment-types');

      return result.data
          .map<PaymentTypeModel>((payment) => PaymentTypeModel.fromMap(payment))
          .toList();
    } on DioError catch (e, s) {
      log('Falha ao buscar formas de pagamento', error: e, stackTrace: s);
      throw RepositoryException(message: 'Falha ao buscar formas de pagamento');
    }
  }

  @override
  Future<void> saveOrder(OrderDto order) async {
    try {
      await dio.auth().post('/orders', data: {
        'products': order.products
            .map(
              (product) => {
                'id': product.product.id,
                'amount': product.amount,
                'total_price': product.totalPrice,
              },
            )
            .toList(),
        'user_id': '#userAuthRef',
        'address': order.address,
        'CPF': order.document,
        'payment_method_id': order.paymentMethodId,
      });
    } on DioError catch (e, s) {
      log('Falha ao incluir pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Falha ao incluir pedido');
    }
  }
}
