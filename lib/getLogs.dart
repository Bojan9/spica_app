import 'dart:convert';
import 'package:http/http.dart' as http;
import 'logWidget.dart';

// get the token
Future<String> getToken() async {
  final url = Uri.parse(
      'https://myhoursdevelopment-api.azurewebsites.net/api/Tokens/login');
  final response = await http.post(
    url,
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json-patch+json'
    },
    body: json.encode({
      "grantType": "password",
      "email": "luke.skywalker@myhours.com",
      "password": "Myhours123",
      "clientId": "3d6bdd0e-5ee2-4654-ac53-00e440eed057"
    }),
  );
  final responseData = json.decode(response.body);
  return responseData['accessToken'];
}

// get the logs (2023)
Future<List<LogWidget>> getLogs(String token) async {
  final url = Uri.parse(
      'https://myhoursdevelopment-api.azurewebsites.net/api/logs?startIndex=0&step=29&maxDate=2023-03-30');

  final response = await http.get(
    url,
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json-patch+json',
      'Authorization': 'Bearer $token'
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);

    List<LogWidget> logs = [];
    // get the project name, if null - add default value log
    // get date
    // get time, if null - add default time 00:00
    for (int i = 0; i < responseData.length; i++) {
      String name = responseData[i]['projectName'] ?? 'log';
      String dateStr = responseData[i]['date'].substring(0, 10);
      String time =
          responseData[i]['startTime']?.substring(11, 16) ?? '00:00';

      LogWidget logWidget =
          LogWidget(title: name, dateStr: dateStr, time: time);
      logs.add(logWidget);
    }
    return logs;
  } else {
    throw Exception('Failed to load logs');
  }
}
