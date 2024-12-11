// ignore: unused_import
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {required String nama,
      required String email,
      required String password}) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {
      'nama': nama,
      'email': email,
      'password': password,
    };

    try {
      final response = await Api().post(apiUrl, body);

      // Log response body for debugging purposes
      if (kDebugMode) {
        print('Response body: $response');
      } // Add logging here

      // Periksa status code dari respons
      if (response != null && response is Map<String, dynamic>) {
        if (response['code'] == 200 && response['status'] == true) {
          return Registrasi.fromJson(response);
        } else {
          // Tangani jika status code bukan 200
          throw Exception(response['data'] ?? 'Registrasi Gagal');
        }
      } else {
        throw Exception('Format respons tidak valid');
      }
    } catch (error) {
      // Menangani error lainnya seperti kesalahan jaringan
      throw Exception('Terjadi kesalahan: $error');
    }
  }
}
