import 'package:feedback_demo/feature/analytics/analytics_service.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

class PosthogAnalyticsService implements AnalyticsService {
  final _posthog = Posthog();

  @override
  void logEvent(String name, {Map<String, Object>? parameters}) {
    _posthog.capture(eventName: name, properties: parameters);
  }

  @override
  void logPurchase({double? amount, String? currency}) {
    _posthog.capture(
      eventName: 'purchase',
      properties: {
        'currency': currency ?? 'N/A',
      },
    );
  }
}
