import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestService {
  static String serverKey =
      "AAAAA6Ty6N4:APA91bF7gqLNPze3UjMuZ72ijr92efIQT5gMEdFM7cu2ZWs_JOtXwAsM56mQYgkymqBptG3XSpH7bpOW0KRJMJIorVZLBgGqGricYCHwn_o6_DbZ5sg7aqleMKO-AgpmGxSO9hdUJU6y";
  static String requestTarget = "https://fcm.googleapis.com/fcm/send";
  static Future<bool> sendNotification(
      String targetToken, String message, String topic) async {
    final Uri targetUri = Uri.parse(requestTarget);

    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + serverKey,
    };

    final Map data = {
      "to": targetToken,
      "token": targetToken,
      "notification": {
        "body": message,
        "title": topic,
      },
      "android": {"priority": "high"}
    };

    final response = await http.post(targetUri,
        headers: headers, body: JsonEncoder().convert(data));

    return response.statusCode == 200;
  }
}
