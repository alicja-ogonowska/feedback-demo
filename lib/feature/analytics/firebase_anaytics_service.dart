import 'package:feedback_demo/feature/analytics/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService implements AnalyticsService {
  @override
  void logEvent(String name, {Map<String, Object>? parameters}) {
    FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }

  @override
  void logPurchase({double? amount, String? currency}) {
    FirebaseAnalytics.instance.logPurchase(value: amount, currency: currency);
  }
}
