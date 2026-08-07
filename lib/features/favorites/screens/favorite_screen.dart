import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorite_provider.dart';
import '../../../core/widgets/product_card.dart';


class FavoritesScreen extends ConsumerWidget {

  const FavoritesScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final favorites = ref.watch(favoriteProvider);



    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Favorites ❤️",
        ),

      ),




      body: favorites.isEmpty


          ? const Center(

              child: Text(

                "No favorite products yet",

                style: TextStyle(

                  fontSize: 18,

                ),

              ),

            )



          : GridView.builder(


              padding:
                  const EdgeInsets.all(12),



              itemCount:
                  favorites.length,



              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(


                crossAxisCount: 2,


                childAspectRatio: 0.65,


                crossAxisSpacing: 10,


                mainAxisSpacing: 10,


              ),




              itemBuilder: (context, index) {


                final product =
                    favorites[index];



                return ProductCard(

                  product: product,


                  onFavorite: () {


                    ref

                        .read(
                          favoriteProvider.notifier,
                        )

                        .toggleFavorite(product);


                  },


                  onAddToCart: () {},


                );


              },


            ),


    );


  }


}