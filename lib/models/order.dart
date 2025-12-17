class CartItem {
  final int productId;
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    "product": productId,
    "quantity": quantity,
    "price": price.toString(),
  };
}

class OrderRequest {
  final double totalPrice;
  final String status;
  final List<CartItem> items;

  OrderRequest({
    required this.totalPrice,
    required this.status,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    "total_price": totalPrice,
    "status": status,
    "items": items.map((item) => item.toJson()).toList(),
  };
}
