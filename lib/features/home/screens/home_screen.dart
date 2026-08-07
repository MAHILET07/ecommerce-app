import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/providers/product_provider.dart';
import '../../product/screens/product_details_screen.dart';
import '../../../core/widgets/product_card.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() =>
      _HomeScreenState();
}


class _HomeScreenState
    extends ConsumerState<HomeScreen> {

  final searchController =
      TextEditingController();

  String searchText = "";


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }



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

          IconButton(

            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),

            onPressed: () {

              ScaffoldMessenger.of(context)
                  .showSnackBar(

                const SnackBar(
                  content: Text(
                    "Cart coming soon 🛒",
                  ),
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



            // SEARCH BAR

            TextField(

              controller:
                  searchController,


              onChanged: (value){

                setState(() {

                  searchText =
                      value.toLowerCase();

                });

              },


              decoration:
                  InputDecoration(

                hintText:
                    "Search products...",


                prefixIcon:
                    const Icon(
                      Icons.search,
                    ),



                suffixIcon:
                    searchText.isNotEmpty

                    ?

                    IconButton(

                      icon:
                          const Icon(
                            Icons.clear,
                          ),


                      onPressed: (){

                        searchController.clear();

                        setState(() {

                          searchText =
                              "";

                        });

                      },

                    )

                    : null,



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




                data: (items){



                  final filteredProducts =
                      items.where((product){


                    return product.title
                            .toLowerCase()
                            .contains(searchText)

                        ||

                        product.category
                            .toLowerCase()
                            .contains(searchText)

                        ||

                        product.description
                            .toLowerCase()
                            .contains(searchText);



                  }).toList();





                  if(filteredProducts.isEmpty){

                    return const Center(

                      child: Column(

                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons.search_off,
                            size: 60,
                          ),


                          SizedBox(height: 15),


                          Text(
                            "No products found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                        ],

                      ),

                    );

                  }





                  return GridView.builder(


                    itemCount:
                        filteredProducts.length,



                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount:
                          2,

                      childAspectRatio:
                          0.62,

                      crossAxisSpacing:
                          10,

                      mainAxisSpacing:
                          10,

                    ),




                    itemBuilder:
                        (context,index){


                      final product =
                          filteredProducts[index];



                      return GestureDetector(

                        onTap: (){


                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>

                                  ProductDetailsScreen(

                                    product:
                                        product,

                                  ),

                            ),

                          );


                        },



                        child: ProductCard(

                          product:
                              product,


                          onFavorite: (){},


                          onAddToCart: (){


                            ScaffoldMessenger.of(context)
                                .showSnackBar(

                              SnackBar(

                                content: Text(

                                  "${product.title} added to cart 🛒",

                                ),

                              ),

                            );


                          },

                        ),

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