import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopinggapp/screens/edit_product_screen.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  static String routename ='userproductsscreen';

  Future<void> oNRefresh(BuildContext context) async{
    await Provider.of<Products>(context,listen: false).fetchAndSetProducts(true);

}
  @override
  Widget build(BuildContext context) {
    final productData =Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Products'),
      actions: [
        IconButton(onPressed: (){Navigator.of(context).pushNamed(EditProductScreen.routename);}, icon: Icon(Icons.add))
      ],),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: ()=> oNRefresh(context),
          child: Padding(padding: EdgeInsets.all(10),
          child: ListView.builder(itemBuilder: (context,i){return Column(children:[ UserProductsItem(title: productData.items[i].title,price:productData.items[i].price ,imageUrl: productData.items[i].imageUrl,id: productData.items[i].id,),Divider()],);}, itemCount: productData.items.length,)),
        ),
    );
  }
}
