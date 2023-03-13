import 'package:flutter/material.dart';
import 'package:flutter_application_1/datamanager.dart';

import '../datamodel.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({super.key, required this.dataManager});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (((context, snapshot) {
      if (snapshot.hasData) {
        var categories = snapshot.data! as List<Category>;
        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(categories[index].name),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: categories[index].products.length,
                  itemBuilder: (context, prodIndex) {
                    var product = categories[index].products[prodIndex];
                    return ProductItem(
                        product: product,
                        onAdd: (addedProduct) {
                          dataManager.cartAdd(addedProduct);
                        });
                  },
                )
              ],
            );
          }),
        );
      } else {
        if (snapshot.hasError) {
          return const Text("Error");
        } else {
          return const CircularProgressIndicator();
        }
      }
    })));
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function onAdd;

  const ProductItem({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Image.network(product.imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("\$${product.price.toStringAsFixed(2)} ea"),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        onAdd(product);
                      },
                      child: const Text("Add"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
