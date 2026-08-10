import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/providers/product_provider.dart';
import '../../../core/widgets/product_card.dart';

import '../../cart/providers/cart_provider.dart';
import '../../cart/screens/cart_screen.dart';

import '../../favorites/providers/favorite_provider.dart';
import '../../favorites/screens/favorite_screen.dart';

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
    final products = ref.watch(productsProvider);

    // Watch favorites so the product cards
    // update immediately when favorites change.
    final favorites = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ZembilGo",
        ),
        actions: [
          // =========================
          // Favorites
          // =========================
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
            ),
            tooltip: "Favorites",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const FavoriteScreen(),
                ),
              );
            },
          ),

          // =========================
          // Order History
          // =========================
          IconButton(
            icon: const Icon(
              Icons.history,
            ),
            tooltip: "Order History",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const OrdersScreen(),
                ),
              );
            },
          ),

          // =========================
          // Cart
          // =========================
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
            tooltip: "Cart",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // =========================
            // Greeting
            // =========================
            Text(
              "Hello 👋",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 8),

            const Text(
              "What are you looking for today?",
            ),

            const SizedBox(height: 20),

            // =========================
            // Search
            // =========================
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery =
                      value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: "Search products",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // Products title
            // =========================
            Text(
              "Products",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 15),

            // =========================
            // Product list
            // =========================
            Expanded(
              child: products.when(
                // Loading
                loading: () => const Center(
                  child:
                      CircularProgressIndicator(),
                ),

                // Error
                error: (error, stack) => Center(
                  child: Text(
                    "Error: $error",
                  ),
                ),

                // Products loaded
                data: (items) {
                  final filteredProducts =
                      items.where((product) {
                    return product.title
                        .toLowerCase()
                        .contains(searchQuery);
                  }).toList();

                  // No search results
                  if (filteredProducts.isEmpty) {
                    return const Center(
                      child: Text(
                        "No products found",
                        style: TextStyle(
                          fontSize: 18,
                        ),
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
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder:
                        (context, index) {
                      final product =
                          filteredProducts[index];

                      // Check whether this product
                      // is currently a favorite.
                      final isFavorite =
                          favorites.any(
                        (item) =>
                            item.id ==
                            product.id,
                      );

                      return ProductCard(
                        product: product,

                        // =========================
                        // Favorite
                        // =========================
                        onFavorite: () {
                          ref
                              .read(
                                favoriteProvider
                                    .notifier,
                              )
                              .toggleFavorite(
                                product,
                              );
                        },

                        isFavorite:
                            isFavorite,

                        // =========================
                        // Add to Cart
                        // =========================
                        onAddToCart: () {
                          ref
                              .read(
                                cartProvider
                                    .notifier,
                              )
                              .addToCart(
                                product,
                              );

                          ScaffoldMessenger
                                  .of(context)
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