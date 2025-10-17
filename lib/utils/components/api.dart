// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:admin_dormsync/utils/components/prefences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseurl = "https://api.dormsync.com/api";

  static Future fetchData(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseurl/$endpoint'),
      headers: {
        'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  static Future postData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseurl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          throw Exception('Response body is empty');
        }
      } else {
        print(response.body);
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      log("$e");
      throw Exception('Failed to post data: $e');
    }
  }

  static Future putData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseurl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          throw Exception('Response body is empty');
        }
      } else {
        print(response.body);
        throw Exception('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      log("$e");
      throw Exception('Failed to post data: $e');
    }
  }

  static Future deleteData(String endpoint, {String? licenceNo}) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseurl/$endpoint'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Preference.getString(PrefKeys.token)}',
        },
        body: licenceNo == null ? {} : {"licence_no": licenceNo},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return json.decode(response.body.isNotEmpty ? response.body : '{}');
      } else {
        throw Exception('Failed to delete data: ${response.statusCode}');
      }
    } catch (e) {
      log("Delete error: $e");
      throw Exception('Failed to delete data: $e');
    }
  }
}
