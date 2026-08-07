import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/providers/product_provider.dart';


class HomeScreen extends ConsumerWidget {

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final products =
        ref.watch(productsProvider);



    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "ZembilGo",
        ),


        actions: [

          IconButton(

            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),

            onPressed: () {},

          ),

        ],

      ),



      body: Padding(

        padding:
            const EdgeInsets.all(16),


        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,


          children: [


            Text(

              "Hello 👋",

              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(

                    fontWeight:
                        FontWeight.bold,

                  ),

            ),



            const SizedBox(height: 8),



            const Text(
              "What are you looking for today?",
            ),



            const SizedBox(height: 20),



            TextField(

              decoration:
                  InputDecoration(

                hintText:
                    "Search products",

                prefixIcon:
                    const Icon(Icons.search),


                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(15),

                ),

              ),

            ),



            const SizedBox(height: 25),



            Text(

              "Products",

              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(

                    fontWeight:
                        FontWeight.bold,

                  ),

            ),



            const SizedBox(height: 15),



            Expanded(

              child: products.when(

                loading: () =>

                    const Center(

                      child:
                          CircularProgressIndicator(),

                    ),



                error: (error, stack) =>

                    Center(

                      child: Text(

                        "Error: $error",

                      ),

                    ),



                data: (items) {


                  return GridView.builder(

                    itemCount:
                        items.length,


                    gridDelegate:

                        const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2,

                      childAspectRatio: 0.65,

                    ),



                    itemBuilder:
                        (context, index) {


                      final product =
                          items[index];


                      return Card(

                        elevation: 3,


                        child: Column(

                          children: [


                            Expanded(

                              child: Image.network(

                                product.image,

                                fit:
                                    BoxFit.contain,

                              ),

                            ),



                            Padding(

                              padding:
                                  const EdgeInsets.all(8),


                              child: Text(

                                product.title,

                                maxLines: 2,

                                overflow:
                                    TextOverflow.ellipsis,

                                style:
                                    const TextStyle(

                                      fontWeight:
                                          FontWeight.bold,

                                    ),

                              ),

                            ),



                            Text(

                              "\$${product.price}",

                              style:
                                  const TextStyle(

                                    color:
                                        Colors.green,

                                    fontWeight:
                                        FontWeight.bold,

                                  ),

                            ),



                            const SizedBox(height: 8),

                          ],

                        ),

                      );

                    },

                  );

                },

              ),

            )

          ],

        ),

      ),

    );

  }

}