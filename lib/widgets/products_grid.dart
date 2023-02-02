import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopinggapp/widgets/product_item.dart';


import '../providers/product.dart';
import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  //
  // List<Product> productsList ;
  //
  // ProductsGrid(this.productsList);

  final bool showfav;
  ProductsGrid(this.showfav);


  @override
  Widget build(BuildContext context) {

    final productsData =Provider.of<Products>(context);
    final productsList = showfav ? productsData.favouriteItems : productsData.items;
    return Container(
      height: 400,

      child: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 10,childAspectRatio: 3/2,mainAxisSpacing: 10, crossAxisCount: 2),
          itemBuilder:(ctx,i) =>
              ChangeNotifierProvider.value(value: productsList[i],
                  child: ProductItem(),)
          ,itemCount: productsList.length,)
    );
  }
}
