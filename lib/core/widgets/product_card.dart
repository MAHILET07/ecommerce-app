import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../../features/product/screens/product_details_screen.dart';


class ProductCard extends StatelessWidget {

  final ProductModel product;
  final VoidCallback? onFavorite;
  final VoidCallback? onAddToCart;


  const ProductCard({
    super.key,
    required this.product,
    this.onFavorite,
    this.onAddToCart,
  });



  @override
  Widget build(BuildContext context) {


    return InkWell(

      borderRadius: BorderRadius.circular(18),


      onTap: () {


        Navigator.push(

          context,

          MaterialPageRoute(

            builder: (_) => ProductDetailsScreen(

              product: product,

            ),

          ),

        );


      },


      child: Card(

        elevation: 2,

        margin: const EdgeInsets.all(6),

        shape: RoundedRectangleBorder(

          borderRadius:
              BorderRadius.circular(18),

        ),


        clipBehavior:
            Clip.antiAlias,



        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,



          children: [



            Expanded(

              flex: 5,


              child: Stack(

                children: [



                  Positioned.fill(

                    child: Padding(

                      padding:
                          const EdgeInsets.all(12),


                      child: Image.network(

                        product.image,

                        fit:
                            BoxFit.contain,


                        errorBuilder:
                            (context, error, stackTrace) {

                          return const Center(

                            child: Icon(

                              Icons.image_not_supported_outlined,

                              size: 45,

                            ),

                          );

                        },


                      ),

                    ),

                  ),




                  Positioned(

                    top: 8,

                    right: 8,


                    child: Material(

                      color:
                          Theme.of(context)
                              .colorScheme
                              .surface,


                      shape:
                          const CircleBorder(),


                      child: IconButton(

                        onPressed:
                            onFavorite,


                        icon:
                            const Icon(

                          Icons.favorite_border,

                        ),

                      ),

                    ),

                  ),



                ],

              ),

            ),




            Expanded(

              flex: 4,


              child: Padding(

                padding:
                    const EdgeInsets.fromLTRB(
                      12,
                      4,
                      12,
                      10,
                    ),



                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,



                  children: [



                    Text(

                      product.category,

                      maxLines: 1,

                      overflow:
                          TextOverflow.ellipsis,

                    ),




                    const SizedBox(height: 5),




                    Text(

                      product.title,

                      maxLines: 2,

                      overflow:
                          TextOverflow.ellipsis,


                      style: const TextStyle(

                        fontWeight:
                            FontWeight.bold,

                      ),

                    ),





                    const Spacer(),




                    Row(

                      children: [


                        const Icon(

                          Icons.star,

                          size: 17,

                        ),



                        const SizedBox(width: 4),




                        Text(

                          product.rating
                              .toStringAsFixed(1),

                        ),




                        const Spacer(),




                        Text(

                          "\$${product.price.toStringAsFixed(2)}",


                          style:
                              const TextStyle(

                            fontWeight:
                                FontWeight.bold,

                          ),

                        ),



                      ],

                    ),





                    const SizedBox(height: 8),





                    SizedBox(

                      width:
                          double.infinity,


                      height:
                          38,



                      child:
                          ElevatedButton.icon(


                        onPressed:
                            onAddToCart,


                        icon:
                            const Icon(

                          Icons.shopping_cart_outlined,

                          size: 18,

                        ),



                        label:
                            const Text(
                              "Add to cart",
                            ),


                      ),

                    ),


                  ],

                ),

              ),

            ),



          ],

        ),

      ),

    );


  }


}