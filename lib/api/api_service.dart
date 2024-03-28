import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shoof24/models/iptv.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiService {
  static const String baseUrl = 'http://shoof.watch:8000'; // Update with your API base URL

static Future<List<CategoryModel>> getCategories(String type) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    final url = Uri.parse('$baseUrl/player_api.php?password=$password&username=$username&action=$type');

    final response = await http.get(url).timeout(const Duration(seconds: 60)); // Set a timeout duration of 30 seconds

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body.replaceAll(r"\'", "'"));
      if (data is List) {
        return data.map((item) => CategoryModel.fromJson(item)).toList();
      } else if (data is Map && data.containsKey('categories')) {
        final List<dynamic> categories = data['categories'];
        return categories.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load live categories: ${response.statusCode}');
    }
  } on TimeoutException catch (e) {
    print('Request timed out: $e');
    // Handle timeout error
    return []; // Return an empty list if a timeout occurs
  } catch (e) {
    print('Error fetching live categories: $e');
    return []; // Return an empty list if an error occurs
  }
}



  static Future<List<ChannelLive>> fetchLiveChannels() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      String? password = prefs.getString('password');

      final url = Uri.parse('$baseUrl/player_api.php?password=$password&username=$username&action=get_live_streams');
      
      final response = await http.get(url).timeout(const Duration(seconds: 60)); // Set a timeout duration of 30 seconds

      // print(response.body);
      if (response.statusCode == 200) { 
        final List<dynamic> data = jsonDecode(response.body ?? "[]");
        return data.map((item) => ChannelLive.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load live channels: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Request timed out: $e');
      // Handle timeout error
      return []; // Return an empty list if a timeout occurs
    } catch (e) {
      print('Error fetching live channels: $e');
      return []; // Return an empty list if an error occurs
    }
  }

  static Future<List<ChannelLive>> fetchMovieChannels() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      String? password = prefs.getString('password');

      final url = Uri.parse('$baseUrl/player_api.php?password=$password&username=$username&action=get_vod_streams');
      
      final response = await http.get(url).timeout(const Duration(seconds: 60)); // Set a timeout duration of 30 seconds

      // print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body ?? "[]");
        return data.map((item) => ChannelLive.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load live channels: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Request timed out: $e');
      // Handle timeout error
      return []; // Return an empty list if a timeout occurs
    } catch (e) {
      print('Error fetching live channels: $e');
      return []; // Return an empty list if an error occurs
    }
  }

  static Future<List<ChannelLive>> fetchSeriesChannels() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      String? password = prefs.getString('password');

      final url = Uri.parse('$baseUrl/player_api.php?password=$password&username=$username&action=get_series');
      
      final response = await http.get(url).timeout(const Duration(seconds: 60)); // Set a timeout duration of 30 seconds

      // print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body ?? "[]");
        return data.map((item) => ChannelLive.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load live channels: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('Request timed out: $e');
      // Handle timeout error
      return []; // Return an empty list if a timeout occurs
    } catch (e) {
      print('Error fetching live channels: $e');
      return []; // Return an empty list if an error occurs
    }
  }

}
