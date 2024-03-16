import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class ApiService {
  static Future<String> sendMessage() async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/chat"),
        headers: {
          "Authorization": "Bearer $API_KEY",
          "Content-Type": "application/json"
        },
        body: jsonEncode({"text": "go"}),
      );

      if (response.statusCode == 200) {
        // 检查响应状态码
        Map jsonResponse = jsonDecode(response.body);
        // log(jsonResponse["text"]);
        return jsonResponse["text"];
      } else {
        // 可以在这里处理不同的响应状态码
        log("Server error: ${response.statusCode}");
        return "网络异常，请重新请求"; // 或者返回错误信息
      }
    } catch (error) {
      log("error: $error");
      return "网络异常，请重新请求";
    }
  }
}
