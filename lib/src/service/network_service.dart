import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_stock/src/constants/api.dart';
import 'package:my_stock/src/models/post.dart';
import 'package:my_stock/src/models/product.dart';

class NetworkService {
  NetworkService._internal();

  // Create a single instance of the class
  static final NetworkService _instance = NetworkService._internal();

  // Get the instance of the class
  factory NetworkService() => _instance;

  // Create a Dio instance
  static final _dio = Dio();

  // Create a method to get the products
  Future<List<Product>> getAllProduct(int startIndex, {int? limit = 10}) async {
    // get URL from API
    const url = '${API.baseURL}${API.productURL}';
    final response = await _dio.get(url); // Get the response
    // Check if the response is successful
    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data)); // Return the products
    }
    throw Exception(
        'Network failed'); // Throw an error if the response is not successful
  }

  // Create a method to get the posts
  Future<List<Post>> fetchPosts(int startIndex, {int limit = 10}) async {
    // Create a URL
    const url = 'https://jsonplaceholder.typicode.com/posts?_start=1&_limit=10';
    final response = await _dio.get(url); // Get the response
    // Check if the response is successful
    if (response.statusCode == 200) {
      return postFromJson(jsonEncode(response.data)); // Return the List posts
    }
    throw Exception(
        'Network failed'); // Throw an error if the response is not successful
  }
}
