import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_shop/presentation/home/components/cartitem.dart';
import 'package:web_shop/presentation/home/mobile/components/cart_item.dart';
import 'package:web_shop/presentation/home/mobile/components/custom_scaffold_widget.dart';

class MMyCartPage extends StatefulWidget {
  const MMyCartPage({super.key});

  @override
  State<MMyCartPage> createState() => _MMyCartPageState();
}

class _MMyCartPageState extends State<MMyCartPage> {
  List<String> productNames = [
    "Shirt 1",
    "Shirt 2",
    "Shirt 3",
    "Shirt 4",
    "Shirt 5",
    "Shirt 6",
  ];

  List<int> quantities = [1, 1, 1, 1, 1, 1];

  List<double> prices = [2.0, 5.99, 18.50, 3.0, 5.0, 4.55];

  List<String> images = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
    "assets/images/5.jpg",
    "assets/images/6.jpg",
  ];

  void incrementQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  double getCartTotal() {
    double total = 0.0;
    for (var i = 0; i < productNames.length; i++) {
      total += quantities[i] * prices[i];
    }
    return total;
  }

  void showCheckDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Checkout"),
          content: Text("Hurray! You have purchased the products"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItem = Provider.of<CartProvider>(context).cartItem;
    return CustomScaffoldWidget(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "CART",
                style: GoogleFonts.manrope(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItem.length,
                  itemBuilder: (BuildContext context, int index) {
                    CartItem item = cartItem[index];
                    return Dismissible(
                      key: Key(productNames[index]),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          productNames.removeAt(index);
                          quantities.removeAt(index);
                          prices.removeAt(index);
                          images.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        child: Icon(Icons.cancel, color: Colors.white),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 16.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              images[index],
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // productNames[index],
                                    item.title.toString(),
                                    style: GoogleFonts.manrope(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    // "\$${prices[index].toStringAsFixed(2)}",
                                    '\$${item.pricing}',
                                    style: GoogleFonts.manrope(
                                      fontSize: 16.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    decrementQuantity(index);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                Text(
                                  quantities[index].toString(),
                                  style: GoogleFonts.manrope(
                                    fontSize: 18.0,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    incrementQuantity(index);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      'Cart Total:',
                      style: GoogleFonts.manrope(
                        fontSize: 18.0,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\$${getCartTotal().toStringAsFixed(2)}',
                      style: GoogleFonts.manrope(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          showCheckDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          'Add To Cart',
                          style: GoogleFonts.manrope(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
