import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/common/key_constants.dart';
import 'package:story_app/data/models/add_story_body.dart';
import 'package:story_app/data/models/default_model.dart';
import 'package:story_app/data/models/list_story_body.dart';
import 'package:story_app/data/models/story_model.dart';

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

  Future<DetailStoryModel> getDetailStory(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(KeyConstants.keyUserToken);
      final response = await http.get(
        Uri.parse(
          '${KeyConstants.baseUrl}/stories/$id',
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        return DetailStoryModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        return DetailStoryModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
    } on SocketException {
      return DetailStoryModel(error: true, message: 'No internet connection');
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }

  Future<DefaultModel> addNewStory(AddStoryBody body) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(KeyConstants.keyUserToken);

      final uri = Uri.parse('${KeyConstants.baseUrl}/stories');

      final multiPartFile = http.MultipartFile.fromBytes(
        'photo',
        body.imageByte,
        filename: body.fileName,
      );

      final request = http.MultipartRequest('POST', uri);

      final fields = <String, String>{
        'description': body.description,
      };
      final headers = <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-type': 'multipart/form-data',
      };

      request.files.add(multiPartFile);
      request.fields.addAll(fields);
      request.headers.addAll(headers);

      final streamedResponse = await request.send();

      final responseList = await streamedResponse.stream.toBytes();
      final responseData = String.fromCharCodes(responseList);

      if (streamedResponse.statusCode == 201) {
        return DefaultModel.fromJson(
          json.decode(responseData) as Map<String, dynamic>,
        );
      } else {
        return DefaultModel.fromJson(
          json.decode(responseData) as Map<String, dynamic>,
        );
      }
    } on SocketException {
      return DefaultModel(error: true, message: 'No internet connection');
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }
}
