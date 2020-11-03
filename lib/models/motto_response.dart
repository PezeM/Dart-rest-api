import 'package:rest_api/rest_api.dart';

class MottoResponseModel {
  Contents contents;
  String baseUrl;

  MottoResponseModel({this.contents, this.baseUrl});

  MottoResponseModel.fromJson(Map<String, dynamic> json) {
    contents = json['contents'] != null
        ? Contents.fromJson(json['contents'] as Map<String, dynamic>)
        : null;
    baseUrl = json['baseurl'] as String;
  }
}

class Contents {
  List<Quotes> quotes;

  Contents({this.quotes});

  Contents.fromJson(Map<String, dynamic> json) {
    if (json['quotes'] != null) {
      quotes = <Quotes>[];
      json['quotes'].forEach((q) {
        quotes.add(Quotes.fromJson(q as Map<String, dynamic>));
      });
    }
  }
}

class Quotes {
  String quote;
  String length;
  String author;
  List<String> tags;
  String category;
  String language;
  String date;
  String permalink;
  String id;
  String background;
  String title;

  Quotes(
      {this.quote,
      this.length,
      this.author,
      this.tags,
      this.category,
      this.language,
      this.date,
      this.permalink,
      this.id,
      this.background,
      this.title});

  Quotes.fromJson(Map<String, dynamic> json) {
    quote = json['quote'] as String;
    length = json['length'] as String;
    author = json['author'] as String;
    language = json['language'] as String;
    date = json['date'] as String;
    permalink = json['permalink'] as String;
    title = json['title'] as String;
  }
}

class MottoOfTheDay extends Serializable {
  String quote;
  String author;
  String date;

  MottoOfTheDay(MottoResponseModel motto) {
    final quote = motto.contents.quotes.first;
    this.quote = quote.quote;
    author = quote.author;
    date = quote.date;
  }

  @override
  Map<String, dynamic> asMap() {
    return {"quote": quote, "author": author, "date": date};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    // TODO: implement readFromMap
  }
}
