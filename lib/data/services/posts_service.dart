import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class PostsService {
  final baseUrl = "https://reqres.in/api/users";

  Future<List<dynamic>> fetchPosts(int page) async {
    try {
      final response = await get(Uri.parse(baseUrl + "?page=$page"));
      var res = jsonDecode(response.body);
      // print("Data ${res['data']}");
      return res['data'] as List<dynamic>;
    } catch (err) {
      return [];
    }
  }
}
