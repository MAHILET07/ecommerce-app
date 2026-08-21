import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/product_model.dart';
import '../../../providers/storage_provider.dart';
import '../../../core/storage/storage_service.dart';

class FavoriteNotifier extends Notifier<List<ProductModel>> {
  late final StorageService _storage;

  @override
  List<ProductModel> build() {
    _storage = ref.read(storageProvider);

    _loadFavorites();

    return [];
  }

  // Load favorites from local storage.
  Future<void> _loadFavorites() async {
    final savedFavorites =
        await _storage.getFavorites();

    state = savedFavorites
        .map(
          (json) => ProductModel.fromJson(json),
        )
        .toList();
  }

  // Add or remove a product from favorites.
  Future<void> toggleFavorite(
    ProductModel product,
  ) async {
    final exists = state.any(
      (item) => item.id == product.id,
    );

    if (exists) {
      state = state
          .where(
            (item) => item.id != product.id,
          )
          .toList();
    } else {
      state = [
        ...state,
        product,
      ];
    }

    await _saveFavorites();
  }

  // Check whether a product is favorite.
  bool isFavorite(ProductModel product) {
    return state.any(
      (item) => item.id == product.id,
    );
  }

  // Save favorites to local storage.
  Future<void> _saveFavorites() async {
    final favoritesJson = state
        .map(
          (product) => {
            'id': product.id,
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'category': product.category,
            'image': product.image,
            'rating': product.rating,
          },
        )
        .toList();

    await _storage.saveFavorites(
      favoritesJson,
    );
  }

  // Remove all favorites.
  Future<void> clearFavorites() async {
    state = [];

    await _storage.clearFavorites();
  }
}

final favoriteProvider =
    NotifierProvider<
        FavoriteNotifier,
        List<ProductModel>>(
  FavoriteNotifier.new,
);