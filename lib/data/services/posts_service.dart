import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

class PostsService {
  static var totalPage;
  static var perPage;
  final baseUrl = "https://reqres.in/api/users";

  Future<List<dynamic>> fetchPosts(int page) async {
    try {
      final response = await get(Uri.parse(baseUrl + "?page=$page"));
      var res = jsonDecode(response.body);
      // print("Data ${res['data']}");
      totalPage = res['total_pages'];
      perPage = res['per_page'];
      return res['data'] as List<dynamic>;
    } catch (err) {
      return [];
    }
  }
}
