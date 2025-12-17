import 'package:foodgo_static/controllers/order_controller.dart';
import 'package:get/get.dart';
import 'package:foodgo_static/models/product.dart';
import 'package:foodgo_static/controllers/product_controller.dart';

class ProductDetailController extends GetxController {
  final int productId;
  ProductDetailController(this.productId);

  var isLoading = true.obs;
  var product = Rxn<Product>();
  var quantity = 1.obs;
  var spicyValue = 0.3.obs;

  @override
  void onInit() {
    super.onInit();
    loadStaticData();
  }

  void loadStaticData() {
    isLoading(true);

    final ProductController productController = Get.find<ProductController>();

    product.value = productController.productList.firstWhere(
      (p) => p.id == productId,
    );

    isLoading(false);
  }

  void incrementQuantity() => quantity.value++;

  void decrementQuantity() {
    if (quantity.value > 1) quantity.value--;
  }

  double get totalPrice => (product.value?.price ?? 0) * quantity.value;

  void addToCart() {
    if (product.value != null) {
      final OrderController orderController = Get.put(OrderController());

      orderController.setSingleOrder(product.value!, quantity.value);
    }
  }
}
