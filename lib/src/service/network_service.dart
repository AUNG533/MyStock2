// network_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_stock/src/constants/api.dart';
import 'package:my_stock/src/models/post.dart';
import 'package:my_stock/src/models/product.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class NetworkService {
  NetworkService._internal();

  // Create a single instance of the class
  static final NetworkService _instance = NetworkService._internal();

  // Get the instance of the class
  factory NetworkService() => _instance;

  // Create a Dio instance
  static final _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          options.baseUrl = API.baseURL; // Set the base URL
          print(options.baseUrl + options.path);
          // Set the timeout
          options.connectTimeout = 5000;
          options.receiveTimeout = 3000;

          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          // Do something with response data
          return handler.next(response); // continue
        },
        onError: (DioError e, handler) async {
          // Do something with response error
          return handler.next(e); //continue
          // If you want to resolve the request with some custom data，
          // you can resolve a `Response` object eg: `handler.resolve(response)`.
        },
      ),
    );

  // Create a method to get the products
  Future<List<Product>> getAllProduct(int startIndex, {int? limit = 10}) async {
    // get URL from API
    const url = API.productURL; // path: /products
    final response = await _dio.get(url); // Get the response from the server
    // Check if the response is successful
    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data)); // Return the products
    }
    throw Exception(
        'Network failed'); // Throw an error if the response is not successful
  }

  // Create a method add product
  Future<String> addProduct(Product product, {File? imageFile}) async {
    // get URL from API
    const url = API.productURL; // path: /products

    // Create a FormData object to send the data
    FormData data = FormData.fromMap(
      {
        "name": product.name,
        "price": product.price,
        'stock': product.stock,
        if (imageFile != null)
          "photo": await MultipartFile.fromFile(imageFile.path,
              contentType: MediaType("image", "jpg")),
      },
    );

    final response =
        await _dio.post(url, data: data); // post the data to the server
    // Check if the response is successful
    if (response.statusCode == 201) {
      return 'Add Successfully'; // show the message
    }
    throw Exception(
        'Network failed'); // Throw an error if the response is not successful
  }

  // Create a method Edit product
  Future<String> editProduct(Product product, {File? imageFile}) async {
    // get URL from API
    final url = '${API.productURL}/${product.id}'; // path: /products

    // Create a FormData object to send the data
    FormData data = FormData.fromMap(
      {
        "name": product.name,
        "price": product.price,
        'stock': product.stock,
        if (imageFile != null)
          "photo": await MultipartFile.fromFile(imageFile.path,
              contentType: MediaType("image", "jpg")),
      },
    );

    final response =
    await _dio.put(url, data: data); // post the data to the server
    // Check if the response is successful
    if (response.statusCode == 200) {
      return 'Edit Successfully'; // show the message
    }
    throw Exception(
        'Network failed'); // Throw an error if the response is not successful
  }

  // Create a method Delete product
  Future<String> deleteProduct(int productId) async {
    // get URL from API
    final url = '${API.productURL}/$productId'; // path: /products

    final response =
    await _dio.delete(url); // post the data to the server
    // Check if the response is successful
    if (response.statusCode == 204) {
      return 'Delete Successfully'; // show the message
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
