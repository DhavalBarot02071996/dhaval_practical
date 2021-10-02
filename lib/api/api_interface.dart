import 'dart:convert';

import 'package:dhaval_practical_demo/models/contact_list_model.dart';

import 'api_client.dart';
import 'package:http/http.dart' as http;

class ApiInterface{
  Future<ContactListModel> loadContacts(String page) async {
    String subcategoryUrl = ApiClient.baseUrl + 'users';
    Map<String, String> queryParams = {
      'page': page,
    };
    String queryString = Uri(queryParameters: queryParams).query;
    var requestUrl = subcategoryUrl + '?' + queryString;
    final response = await http.get(Uri.parse(requestUrl));
    print('responseBody_17=${response.body}');
    print('responseStatus_18=${response.statusCode}');
    if (response.statusCode == 200) {
      return ContactListModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get contacts...");
    }
  }
}