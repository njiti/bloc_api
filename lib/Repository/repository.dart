import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../Model/todos.dart';

class Repository {
  final String baseUri = "https://api.spoonacular.com/recipes/complexSearch?query=pasta&maxFat=25&number=&apiKey=2955470e3ee84af8b8859e0200a0ffdf";
  final String access_token = "";

  Future<List<Result>> get() async{
    List<Result> data = [];

    final uri = Uri.parse(baseUri);
    try{
      final response = await http.get(
          uri,
          headers: <String, String>{
            'Content-type' : 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: access_token,
          }
      );
      print('uri: $uri');
      print(response.statusCode);
      print(response.body);

      if(response.statusCode >= 200 && response.statusCode <= 299){
        final jsonResponse = json.decode(response.body);
        print('jsonResponse: ${jsonResponse.runtimeType}');
        final characterList = jsonResponse['results'] as List;
        print("more");

        print('characterList: ${characterList.length}');
        print('just checking data');

        // Map json list to character list
        data = characterList.map((json) => Result.fromJson(json)).toList();

        print('data: $data');
      }
    }catch(e){
      print('error: $e');
      return data;
    }
    print('Here\'s the data: $data');
    return data;
  }

}