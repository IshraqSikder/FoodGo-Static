import 'package:foodgo_static/controllers/product_detail_controller.dart';
import 'package:get/get.dart';

final ProductDetailController productDetailController = Get.find<ProductDetailController>();

class Ingredient {
  final String name;
  final String image;
  final double price;

  Ingredient(this.name, this.image, this.price);
}

class AddOnController extends GetxController {
  // Observables
  var spicyValue = 0.5.obs;
  var portionCount = productDetailController.quantity.value.obs;
  var basePrice = productDetailController.totalPrice.obs;

  // Dummy Data for Toppings
  final List<Ingredient> toppings = [
    Ingredient("Tomato", "assets/images/tomato.png", 1.0),
    Ingredient("Onions", "assets/images/onion.png", 0.5),
    Ingredient("Pickles", "assets/images/pickles.png", 0.5),
    Ingredient("Bacons", "assets/images/bacons.png", 2.0),
  ];

  // Dummy Data for Side Options
  final List<Ingredient> sideOptions = [
    Ingredient("Fries", "assets/images/fries.png", 3.5),
    Ingredient("Coleslaw", "assets/images/coleslaw.png", 2.0),
    Ingredient("Salad", "assets/images/salad.png", 2.5),
    Ingredient("Onion", "assets/images/onionfry.png", 3.0),
  ];

  // Methods
  void incrementPortion() => portionCount.value++;

  void decrementPortion() {
    if (portionCount.value > 1) portionCount.value--;
  }

  // Calculate total (Base * Portion)
  double get totalPrice => basePrice.value * portionCount.value;
}