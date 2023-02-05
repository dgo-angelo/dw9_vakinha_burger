import 'package:vakinha_burger/app/dto/order_product_dto.dart';

class OrderDto {
  final List<OrderProductDto> products;
  final String address;
  final String document;
  final int paymentMethodId;
  OrderDto({
    required this.products,
    required this.address,
    required this.document,
    required this.paymentMethodId,
  });
}
