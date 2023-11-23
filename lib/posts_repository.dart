import 'dart:convert';

import 'package:flutterhive/post_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostsRepository {
  final _client = http.Client();

  late Box<PostsModel> _postsBox;

  Future<int> initialize(String strBoxName) async {
    try {
      _postsBox = await Hive.openBox<PostsModel>(strBoxName);
      return _postsBox.length != 0 ? 1 : 2;
    } catch (e) {
      print('init error: $e');
      return 0;
    }
  }

  Future<List<PostsModel>> getPosts() async {
    final response = await _client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode != 200) {
      throw Exception('Something went wrong. Try again later');
    }

    final json = jsonDecode(response.body) as List<dynamic>;
    final posts = json.map(
      (e) => PostsModel.fromMap(
        Map<String, dynamic>.from(e as Map<String, dynamic>),
      ),
    );

    return posts.toList();
  }

  Future<void> savePostsLocally({
    required List<PostsModel> posts,
    required Duration expirationDuration,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime expirationTime = DateTime.now().add(expirationDuration);
    await prefs.setString('expire_time', expirationTime.toIso8601String());
    for (final post in posts) {
      await _postsBox.put(post.ofListingId, post);
    }
  }

  Future<List<PostsModel>> fetchAllLocalPosts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? expirationTimeStr = prefs.getString('expire_time');
      if (expirationTimeStr == null) {
        final postsBox = await Hive.openBox<PostsModel>('posts');
        postsBox.clear();
        return [];
      } else {
        DateTime expirationTime = DateTime.parse(expirationTimeStr);
        if (expirationTime.isAfter(DateTime.now())) {
          print('Data has not expired.');
          final localPosts = _postsBox.values.toList();
          return localPosts;
        } else {
          print('Data has expired. Removed from SharedPreferences.');
          final postsBox = await Hive.openBox<PostsModel>('posts');
          postsBox.clear();
          await prefs.remove('expire_time');
          return [];
        }
      }
    } catch (e) {
      print('error: $e');
      return [];
    }
  }
}
