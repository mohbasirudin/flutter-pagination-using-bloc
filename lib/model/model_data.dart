import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ModelData {
  String userId, id, body, title;

  ModelData({
    this.userId,
    this.id,
    this.body,
    this.title,
  });

  factory ModelData.fromJson(Map<String, dynamic> data) => ModelData(
      userId: data['userId'],
      id: data['id'],
      body: data['body'],
      title: data['title']);

  static Future<List<ModelData>> getData(
      {@required int start, @required int limit}) async {
    var _url =
        'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit';

    var _res = await http.get(_url);
    var _json = json.decode(_res.body) as List;
    return _json.map((data) => ModelData(
        userId: data['userId'].toString(),
        id: data['id'].toString(),
        body: data['body'],
        title: data['title'])).toList();
  }
}
