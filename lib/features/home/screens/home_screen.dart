import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

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
            const EdgeInsets.all(20),


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



            const SizedBox(height: 5),



            const Text(

              "What are you looking for today?",

            ),



            const SizedBox(height: 25),



            TextField(

              decoration:
                  InputDecoration(

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



            const SizedBox(height: 30),



            const Expanded(

              child: Center(

                child: Text(

                  "Products will appear here 🛍️",

                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}