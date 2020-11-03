import 'package:rest_api/models/motto_response.dart';

class MottoCacheService {
  MottoOfTheDay _cachedMottoOfTheDay;

  MottoOfTheDay getCachedMottoOfTheDay() {
    return _cachedMottoOfTheDay;
  }

  void tryAddToCache(MottoOfTheDay mottoOfTheDay) {
    if (mottoOfTheDay != null) {
      if (_cachedMottoOfTheDay == null ||
          _cachedMottoOfTheDay.date != mottoOfTheDay.date) {
        _cachedMottoOfTheDay = mottoOfTheDay;
      }
    }
  }
}
