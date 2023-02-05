import 'package:vakinha_burger/app/models/payment_type_model.dart';

import '../../dto/order_dto.dart';

abstract class OrderRepository {
  Future<List<PaymentTypeModel>> getAllPaymentsTypes();
  Future<void> saveOrder(OrderDto order);
}
