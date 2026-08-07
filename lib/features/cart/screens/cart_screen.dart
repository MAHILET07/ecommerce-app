import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';



class CartScreen extends ConsumerWidget {

  const CartScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final cart =
        ref.watch(cartProvider);



    final cartNotifier =
        ref.read(cartProvider.notifier);



    return Scaffold(


      appBar: AppBar(

        title:
            const Text(
              "My Cart",
            ),

      ),



      body:

      cart.isEmpty


          ? const Center(

              child: Text(

                "Your cart is empty 🛒",

                style:
                    TextStyle(
                      fontSize: 18,
                    ),

              ),

            )



          :

          Column(

            children: [


              Expanded(

                child: ListView.builder(

                  itemCount:
                      cart.length,


                  itemBuilder:
                      (context,index){


                    final item =
                        cart[index];



                    return Card(

                      margin:
                          const EdgeInsets.all(10),


                      child:
                          ListTile(


                        leading:
                            Image.network(

                              item.product.image,

                              width: 50,

                            ),



                        title:
                            Text(

                              item.product.title,

                              maxLines: 1,

                              overflow:
                                  TextOverflow.ellipsis,

                            ),



                        subtitle:
                            Text(

                              "\$${item.totalPrice.toStringAsFixed(2)}",

                            ),



                        trailing:
                            Row(

                              mainAxisSize:
                                  MainAxisSize.min,


                              children: [


                                IconButton(

                                  icon:
                                      const Icon(
                                        Icons.remove,
                                      ),

                                  onPressed: (){

                                    cartNotifier
                                        .decreaseQuantity(
                                          item.product.id,
                                        );

                                  },

                                ),



                                Text(
                                  "${item.quantity}",
                                ),



                                IconButton(

                                  icon:
                                      const Icon(
                                        Icons.add,
                                      ),

                                  onPressed: (){

                                    cartNotifier
                                        .increaseQuantity(
                                          item.product.id,
                                        );

                                  },

                                ),



                              ],

                            ),


                      ),

                    );


                  },

                ),

              ),




              Padding(

                padding:
                    const EdgeInsets.all(20),


                child:
                    Text(

                  "Total: \$${cartNotifier.totalAmount.toStringAsFixed(2)}",

                  style:
                      const TextStyle(

                    fontSize: 22,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

              ),


            ],

          ),


    );


  }

}