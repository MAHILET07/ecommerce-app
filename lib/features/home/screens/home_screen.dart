import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/providers/product_provider.dart';
import '../../../core/widgets/product_card.dart';

import '../../cart/providers/cart_provider.dart';
import '../../cart/screens/cart_screen.dart';
import '../../orders/screens/orders_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {

  const HomeScreen({super.key});


  @override
  ConsumerState<HomeScreen> createState() =>
      _HomeScreenState();

}



class _HomeScreenState extends ConsumerState<HomeScreen> {


  String searchQuery = "";



  @override
  Widget build(BuildContext context) {


    final products =
        ref.watch(productsProvider);



    return Scaffold(

appBar: AppBar(
  title: const Text(
    "ZembilGo",
  ),
  actions: [
    // My Orders
    IconButton(
      icon: const Icon(
        Icons.receipt_long_outlined,
      ),
      tooltip: 'My Orders',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const OrdersScreen(),
          ),
        );
      },
    ),

    // Cart
    IconButton(
      icon: const Icon(
        Icons.shopping_cart_outlined,
      ),
      tooltip: 'Cart',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CartScreen(),
          ),
        );
      },
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


              onChanged: (value) {


                setState(() {

                  searchQuery =
                      value.toLowerCase();

                });


              },



              decoration: InputDecoration(


                hintText:
                    "Search products",



                prefixIcon:
                    const Icon(
                      Icons.search,
                    ),



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

                      child:
                          Text(

                            "Error: $error",

                          ),

                    ),






                data: (items) {



                  final filteredProducts =

                      items.where((product) {



                    return product.title

                        .toLowerCase()

                        .contains(searchQuery);



                  }).toList();






                  if(filteredProducts.isEmpty) {


                    return const Center(

                      child: Text(

                        "No products found",

                      ),

                    );


                  }





                  return GridView.builder(



                    itemCount:
                        filteredProducts.length,



                    gridDelegate:

                        const SliverGridDelegateWithFixedCrossAxisCount(


                      crossAxisCount: 2,


                      childAspectRatio: 0.65,


                    ),






                    itemBuilder:
                        (context,index) {



                      final product =
                          filteredProducts[index];






                      return ProductCard(


                        product: product,




                        onFavorite: () {



                          // Favorites later



                        },






                        onAddToCart: () {



                          ref

                              .read(
                                cartProvider.notifier,
                              )

                              .addToCart(product);






                          ScaffoldMessenger.of(context)

                              .showSnackBar(


                            SnackBar(


                              content: Text(

                                "${product.title} added to cart 🛒",

                              ),


                            ),


                          );



                        },



                      );



                    },


                  );



                },



              ),


            ),


          ],


        ),


      ),


    );


  }


}