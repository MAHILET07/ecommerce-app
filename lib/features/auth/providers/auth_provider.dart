import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../repositories/auth_repository.dart';


final apiClientProvider =
    Provider<ApiClient>((ref){

  return ApiClient();

});



final authRepositoryProvider =
    Provider<AuthRepository>((ref){

  return AuthRepository(
    ref.watch(apiClientProvider),
  );

});