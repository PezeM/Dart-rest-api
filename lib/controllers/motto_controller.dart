import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:aqueduct/aqueduct.dart';
import 'package:rest_api/models/motto_response.dart';
import 'package:rest_api/rest_api.dart';
import 'package:rest_api/services/motto_cache_service.dart';

const API_URL = 'https://quotes.rest/qod?language=en';

const TEST_JSON = '''{
  "success": {
    "total": 1
  },
  "contents": {
    "quotes": [
      {
        "quote": "Keep on going and the chances are you will stumble on something, perhaps when you are least expecting it. I have never heard of anyone stumbling on something sitting down.",
        "length": "171",
        "author": "Charles F. Kettering",
        "tags": [
          "inspire",
          "persistence"
        ],
        "category": "inspire",
        "language": "en",
        "date": "2020-10-21",
        "permalink": "https://theysaidso.com/quote/charles-f-kettering-keep-on-going-and-the-chances-are-you-will-stumble-on-someth",
        "id": "7YD88mupysVHRRHE7NyC_QeF",
        "background": "https://theysaidso.com/img/qod/qod-inspire.jpg",
        "title": "Inspiring Quote of the day"
      }
    ]
  },
  "baseurl": "https://theysaidso.com",
  "copyright": {
    "year": 2022,
    "url": "https://theysaidso.com"
  }
}''';

class MottoController extends ResourceController {
  MottoCacheService mottoCacheService;

  MottoController(this.mottoCacheService);

  @Operation.get()
  Future<Response> getMottoOfTheDay() async {
    final cachedMotto = mottoCacheService.getCachedMottoOfTheDay();
    if (cachedMotto != null) {
      return Response.ok(cachedMotto);
    }

    final requestResponse = await http.get(API_URL);

    if (requestResponse.statusCode == 200) {
      final jsonData = jsonDecode(requestResponse.body) as Map;
      final mottoResponseModel =
          MottoResponseModel.fromJson(jsonData as Map<String, dynamic>);
      final mottoOfTheDay = MottoOfTheDay(mottoResponseModel);
      mottoCacheService.tryAddToCache(mottoOfTheDay);
      return Response.ok(mottoOfTheDay);
    } else {
      return Response.notFound();
    }
  }

  @Operation.get('json')
  Future<Response> getMottoOfTheDayFromJson() async {
    final cachedMotto = mottoCacheService.getCachedMottoOfTheDay();
    if (cachedMotto != null) {
      print('Motto from cache');
      return Response.ok(cachedMotto);
    }

    final jsonData = jsonDecode(TEST_JSON) as Map;
    final mottoResponseModel =
        MottoResponseModel.fromJson(jsonData as Map<String, dynamic>);
    final mottoOfTheDay = MottoOfTheDay(mottoResponseModel);
    mottoCacheService.tryAddToCache(mottoOfTheDay);
    return Response.ok(mottoOfTheDay);
  }
}
