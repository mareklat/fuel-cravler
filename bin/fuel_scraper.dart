import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:core';

void main() async {
  final String endpointUrl =
      "https://api.auchan.com/corp/cms/v4/pl/template/gas-stations?lang=pl";
  final uri = Uri.parse(endpointUrl);
  final response = await http.get(uri, headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    "X-Gravitee-Api-Key": "f3fef77a-534a-4223-8907-47382f646efa"
  });

  final data = jsonDecode(response.body) as List<dynamic>;

  final station = data.firstWhere(
      (element) => element["slug"] == "stacja-paliw-poznan-komorniki");

  final fuels = station["soldFuels"] as List<dynamic>;
  final pb95 = fuels.firstWhere((element) => element["slug"] == "pb95-e5");
  final price = pb95["price"];

  print(price);
}
