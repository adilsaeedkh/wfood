import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wfoodalbayt/src/model/Post.dart';

class Rating_api_response {
  static const _serviceUrl = 'http://23.111.185.155:3000/api/rating';
  static final _headers = {'Content-Type': 'application/json'};

  Future<Post> createPost(Post post) async {
    try {
      String json = _toJson(post);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);
      var c = _fromJson(response.body);

      return c;
    } catch (e) {
      print('Oooops! Server Exception!!!');
      print(e);
      return null;
    }
  }

  Post _fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    var post = new Post();
    post.centerId = map['centerId'];
    post.patientId = map['patientId'];
    post.comment = map['comment'];
    post.rate = map['rate'];

    return post;
  }

  String _toJson(Post post) {
    var mapData = new Map();
    mapData["centerId"] = post.centerId;
    mapData["patientId"] = post.patientId;
    mapData["comment"] = post.comment;
    mapData["rate"] = post.rate;
    String json = jsonEncode(mapData);
    return json;
  }
}
