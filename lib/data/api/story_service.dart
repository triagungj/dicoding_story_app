import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/common/key_constants.dart';
import 'package:story_app/data/models/list_story_body.dart';
import 'package:story_app/data/models/list_story_model.dart';

class StoryService {
  Future<ListStoryModel> getListStories(ListStoryBody body) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(KeyConstants.keyUserToken);
      final response = await http.get(
        Uri.parse(
          '${KeyConstants.baseUrl}/stories?page=${body.page}&size=${body.size}',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return ListStoryModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        return ListStoryModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
    } on SocketException {
      return ListStoryModel(error: true, message: 'No internet connection');
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }
}
