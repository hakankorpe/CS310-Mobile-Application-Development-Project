import 'package:firebase_analytics/firebase_analytics.dart';

setLogEvent(FirebaseAnalytics analytics) {
  analytics.logEvent(
      name: 'CS310_Test',
      parameters: <String, dynamic> {
        'string': 'string',
        'int': 310,
        'long': 1234567890123,
        'double': 310.202002,
        'bool': true,
      }
  );
}

setCurrentScreen(FirebaseAnalytics analytics, String screenName, String screenClass) {
  analytics.setCurrentScreen(
    screenName: screenName,
    screenClassOverride: screenClass,
  );
}

setuserId(FirebaseAnalytics analytics, String userID) {
  analytics.setUserId(userID);
}