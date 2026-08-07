import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/product_model.dart';
import '../../cart/providers/cart_provider.dart';



class ProductDetailsScreen extends ConsumerWidget {

  final ProductModel product;


  const ProductDetailsScreen({

    super.key,

    required this.product,

  });



  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Product Details",
        ),

      ),




      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),



        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,



          children: [



            Center(

              child: Image.network(

                product.image,

                height: 250,

                fit:
                    BoxFit.contain,

              ),

            ),




            const SizedBox(height: 25),





            Text(

              product.title,

              style:
                  Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(

                        fontWeight:
                            FontWeight.bold,

                      ),

            ),





            const SizedBox(height: 15),





            Row(

              children: [



                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 12,

                    vertical: 6,

                  ),



                  decoration: BoxDecoration(

                    color:
                        Theme.of(context)
                            .colorScheme
                            .primaryContainer,


                    borderRadius:
                        BorderRadius.circular(20),

                  ),


                  child: Text(

                    product.category,

                  ),

                ),




                const Spacer(),




                const Icon(

                  Icons.star,

                  color:
                      Colors.amber,

                ),




                const SizedBox(width: 5),





                Text(

                  product.rating.toString(),

                  style:
                      const TextStyle(

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),


              ],


            ),





            const SizedBox(height: 20),





            Text(

              "\$${product.price}",

              style:
                  Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(

                        fontWeight:
                            FontWeight.bold,

                      ),

            ),





            const SizedBox(height: 20),





            Text(

              "Description",

              style:
                  Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(

                        fontWeight:
                            FontWeight.bold,

                      ),

            ),




            const SizedBox(height: 10),





            Text(

              product.description,

              style:
                  Theme.of(context)
                      .textTheme
                      .bodyLarge,

            ),





            const SizedBox(height: 30),






            SizedBox(

              width:
                  double.infinity,


              height:
                  55,



              child: ElevatedButton(

                onPressed: () {



                  ref

                      .read(
                        cartProvider.notifier,
                      )

                      .addToCart(product);





                  ScaffoldMessenger.of(context)
                      .showSnackBar(


                    const SnackBar(

                      content:
                          Text(
                            "Added to cart 🛒",
                          ),

                    ),


                  );



                },



                child:
                    const Text(

                      "Add To Cart",

                    ),


              ),


            ),



          ],


        ),


      ),


    );


  }


}