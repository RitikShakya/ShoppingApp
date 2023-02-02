import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopinggapp/providers/product.dart';

import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routename = 'editproductscreen';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final titleFocus = FocusNode();
  final priceFocus =FocusNode();
  final imageController = TextEditingController();
  final imageUrlfocus = FocusNode();

  final _form = GlobalKey<FormState>();

  var editedProduct =Product(id: null.toString(), title: '', imageUrl: '', description: '', price: 0);

  var isInit = true;
  var isLoading =false;

  var initValues= {
    'title': '',
    'description':'',
    'price':'',
    'imageUrl': ''

  };
  @override
  void initState() {
    // TODO: implement initState
    imageUrlfocus.addListener(() {_imageUrl();});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(isInit){
      if(ModalRoute.of(context)!.settings.arguments!=null) {
        final productId = ModalRoute
            .of(context)!
            .settings
            .arguments as String;

        if (productId != '') {
          editedProduct =
              Provider.of<Products>(context, listen: false).findById(productId);
           initValues={
             'title' :editedProduct.title,
             'price': editedProduct.price.toString(),
             'description': editedProduct.description,
             'imageUrl':''
           };
          imageController.text = editedProduct.imageUrl;
        }
      }

    }
    isInit=false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    imageUrlfocus.removeListener(() {_imageUrl();});
    titleFocus.dispose();
    priceFocus.dispose();
    imageController.dispose();
    imageUrlfocus.dispose();
    super.dispose();
  }

  void _imageUrl(){
    if(!imageUrlfocus.hasFocus){
      setState((){});
    }
  }

  Future<void> saveForm() async{
    _form.currentState?.save();
    setState((){
      isLoading= true;
    });
    // print(editedProduct.title);
    // print(editedProduct.imageUrl);

    // if(editedProduct.id!=null){
    //   Provider.of<Products>(context,listen: false).updateProduct(editedProduct.id, editedProduct);

      // print(editedProduct.id);
    // }else{
    //

    if(editedProduct.id!= null.toString()){
     await Provider.of<Products>(context,listen: false).updateProduct(editedProduct.id, editedProduct);


    }else {

      try {
         await Provider.of<Products>(context, listen: false).addData(editedProduct);
      }catch(error){
        await showDialog(context: context, builder:(ctx) =>
            AlertDialog(title: Text('An Error Occured'),
            content: Text('Something went wrong'),
            actions: [
              FlatButton(onPressed: (){Navigator.of(ctx).pop();}, child: Text('OK'))
            ],)
        );
      // }finally {
      //   Navigator.of(context).pop();
      //   setState(() {
      //     isLoading = false;
      //   });
      }
    }

    setState((){isLoading=false;});
    Navigator.of(context).pop();
    // }
    //


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Products'),actions: [IconButton(onPressed: (){saveForm();}, icon: Icon(Icons.save))]),
      body: isLoading? Center(child: CircularProgressIndicator(),):Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
            child: ListView(children: [
          TextFormField(
            initialValue: initValues['title'],
            decoration: InputDecoration(label: Text('Title')),
            textInputAction:TextInputAction.next,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(titleFocus);
            },
            onSaved: (val){
              editedProduct = Product(isFavorite: editedProduct.isFavorite,id:editedProduct.id, title: val as String, imageUrl: editedProduct.imageUrl, description: editedProduct.description, price: editedProduct.price);
            },



          ),
          TextFormField(
            initialValue: initValues['price'],
            decoration: InputDecoration(label: Text('Price')),
            focusNode: titleFocus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_){
              FocusScope.of(context).requestFocus(priceFocus);
            },
            onSaved: (val){
              editedProduct = Product(isFavorite: editedProduct.isFavorite,id:editedProduct.id,title: editedProduct.title, imageUrl: editedProduct.imageUrl, description: editedProduct.description, price: double.parse(val as String));
            },
          ),
          TextFormField(
            initialValue: initValues['description'],
            decoration: InputDecoration(label: Text('Desctiprion')),
            focusNode: priceFocus,
            maxLines: 3,
            textInputAction: TextInputAction.next,

            keyboardType: TextInputType.multiline,
            onSaved: (val){
              editedProduct = Product(isFavorite: editedProduct.isFavorite,id:editedProduct.id, title: editedProduct.title, imageUrl: editedProduct.imageUrl, description: val as String, price: editedProduct.price);
            },
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Container(height: 100,width: 100,margin: EdgeInsets.all(10),decoration: BoxDecoration(border: Border.all(width: 5,color: Colors.grey)),child: imageController.text.isEmpty?Text('Enter a Url'):FittedBox(child :Image.network(imageController.text,fit: BoxFit.cover,)),),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'imageUrl'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: imageController,

                focusNode: imageUrlfocus,
                onEditingComplete: (){
                  setState((){});
                },

                onSaved: (val){
                  editedProduct = Product(isFavorite: editedProduct.isFavorite,id:editedProduct.id, title: editedProduct.title, imageUrl: val as String, description: editedProduct.description, price: editedProduct.price);
                },


              ),
            ),

          ],)
        ],)),
      ),
    );
  }
}
