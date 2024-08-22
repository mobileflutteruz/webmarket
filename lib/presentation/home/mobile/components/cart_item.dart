import 'package:flutter/foundation.dart';
import 'package:web_shop/presentation/home/components/cartitem.dart';



class CartProvider with ChangeNotifier {
  List<CartItem> cartItem = [];

  void addToCart(CartItem item) {
    cartItem.add(item);
    notifyListeners();
  }
}
