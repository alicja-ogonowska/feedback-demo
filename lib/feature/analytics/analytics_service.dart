abstract class AnalyticsService {
  void logEvent(String name, {Map<String, Object>? parameters});
  void logPurchase({double? amount, String? currency});
}
