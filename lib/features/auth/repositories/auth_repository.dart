import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../models/auth_response.dart';


class AuthRepository {


  final ApiClient apiClient;


  AuthRepository(this.apiClient);



  Future<AuthResponse> login(
      String username,
      String password) async {


    try {


      final response =
          await apiClient.dio.post(

        '/auth/login',


        data: {

          'username': username,

          'password': password,

        },

      );



      return AuthResponse.fromJson(
          response.data);



    } on DioException catch (e) {


      throw Exception(
        e.response?.data ??
            "Login failed",
      );


    }

  }

}