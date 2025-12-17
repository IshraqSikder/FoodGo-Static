import 'package:foodgo_static/models/order.dart';
import 'package:foodgo_static/models/product.dart';
import 'package:foodgo_static/screens/payment_success_dialog.dart';
import 'package:foodgo_static/utils/colors.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var isLoading = false.obs;
  var selectedPaymentMethod = 0.obs;
  var saveCardDetails = true.obs;

  var cartItems = <CartItem>[].obs;

  final double taxes = 0.30;
  final double deliveryFees = 1.50;

  double get orderValue =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  double get total => orderValue + taxes + deliveryFees;

  void setSingleOrder(Product product, int quantity) {
    cartItems.clear();
    cartItems.add(
      CartItem(
        productId: product.id,
        name: product.name,
        price: product.price,
        quantity: quantity,
      ),
    );
  }

  void toggleSaveCard(bool? value) {
    saveCardDetails.value = value ?? false;
  }

  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  Future<void> placeOrder() async {
    await Get.dialog(
      const PaymentSuccessDialog(),
      barrierDismissible: false,
      barrierColor: AppColors.background,
    );
  }
}
