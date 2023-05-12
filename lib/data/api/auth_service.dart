import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:story_app/common/key_constants.dart';
import 'package:story_app/data/models/default_model.dart';
import 'package:story_app/data/models/login_body.dart';
import 'package:story_app/data/models/login_model.dart';
import 'package:story_app/data/models/register_body.dart';

class AuthService {
  Future<LoginModel> login(LoginBody loginBody) async {
    try {
      final response = await http.post(
        Uri.parse('${KeyConstants.baseUrl}/login'),
        body: loginBody.toJson(),
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return LoginModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        return LoginModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
    } on SocketException {
      return LoginModel(error: true, message: 'No internet connection');
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }

  Future<DefaultModel> register(RegisterBody registerBody) async {
    try {
      final response = await http.post(
        Uri.parse('${KeyConstants.baseUrl}/register'),
        body: registerBody.toJson(),
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return DefaultModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        return DefaultModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
    } on SocketException {
      return DefaultModel(error: true, message: 'No internet connection');
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }
}
