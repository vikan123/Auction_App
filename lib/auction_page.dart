import 'package:auction_app/modal.dart';
import 'package:flutter/material.dart';

class AuctionProductsPage extends StatelessWidget {
final Product product;
  const AuctionProductsPage({super.key, required this.product, });


  @override
  Widget build(BuildContext context) {
    // Implement UI for displaying marked products from Firestore database
    return Scaffold(
      appBar: AppBar(
        title: Text('Auction Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              Text("This Products are dispatched !"),
              SizedBox(height: 10,),
            ListTile(
            title: Text(product.name),
            subtitle: Text('Category: ${product.description}, Price: \$${product.price}'),

            ),


            ],
        ),
      ));

  }

}
