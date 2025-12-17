import 'package:foodgo_static/models/product.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var cart = <Product, int>{}.obs;

  @override
  void onInit() {
    loadStaticData();
    super.onInit();
  }

  void loadStaticData() {
    isLoading(true);

    productList.value = [
      Product(
        id: 1,
        name: "Cheeseburger Wendy's Burger",
        description:
            "The Cheeseburger Wendy's Burger is a classic fast food burger that packs a punch of flavor in every bite. Made with a juicy beef patty cooked to perfection, it's topped with melted American cheese, crispy lettuce, ripe tomato, and crunchy pickles.",
        price: 4.12,
        image: "assets/images/cheeseburger.png",
        rating: 4.9,
        timeMinutes: 26,
        isSpicy: false,
      ),
      Product(
        id: 2,
        name: "Hamburger Veggie Burger",
        description:
            "Enjoy our delicious Hamburger Veggie Burger, made with a savory blend of fresh vegetables and herbs, topped with crisp lettuce, juicy tomatoes, and tangy pickles, all served on a soft, toasted bun.",
        price: 9.99,
        image: "assets/images/veggieburger.png",
        rating: 4.8,
        timeMinutes: 14,
        isSpicy: true,
      ),
      Product(
        id: 3,
        name: "Hamburger Chicken Burger",
        description:
            "Our chicken burger is a delicious and healthier alternative to traditional beef burgers, perfect for those looking for a lighter meal option. Try it today and experience the mouth-watering flavors of our Hamburger Chicken Burger!",
        price: 6.24,
        image: "assets/images/chickenburger.png",
        rating: 4.6,
        timeMinutes: 42,
        isSpicy: true,
      ),
      Product(
        id: 4,
        name: "Hamburger Fried Chicken Burger",
        description:
            "Indulge in our crispy and savory Fried Chicken Burger, made with a juicy chicken patty, hand-breaded and deep-fried to perfection, served on a warm bun with lettuce, tomato, and a creamy sauce.",
        price: 6.74,
        image: "assets/images/friedchickenburger.png",
        rating: 4.5,
        timeMinutes: 14,
        isSpicy: false,
      ),
    ];

    isLoading(false);
  }

  double get totalCalculatedPrice =>
      cart.entries.fold(0, (sum, item) => sum + (item.key.price * item.value));
}
