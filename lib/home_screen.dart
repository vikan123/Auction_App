import 'package:auction_app/auction_page.dart';
import 'package:auction_app/database_helper.dart';
import 'package:auction_app/modal.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final dbHelper = DatabaseHelper();
  List<Product> products = [];






  



  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  _loadProducts() async {
    List<Product> loadedProducts = await dbHelper.getProducts();
    setState(() {
      products = loadedProducts;
    });
  }

  _addProduct() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController priceController = TextEditingController();


    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String name = nameController.text;
                String category = categoryController.text;
                double price = double.parse(priceController.text);

                Product newProduct = Product(
                    name: name, description: category, price: price);
                await dbHelper.insertProduct(newProduct);
                _loadProducts();
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('Auction App'),
    ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AuctionProductsPage(product: products[index] )),
            );
          },child:ListTile(
            title: Text(products[index].name),
            subtitle: Text('Category: ${products[index].description}, Price: \$${products[index].price}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await dbHelper.deleteProduct(products[index].id!);
                _loadProducts();
              },
            ),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: Icon(Icons.add),
      ),
      );


  }


  }




