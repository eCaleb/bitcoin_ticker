import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String baseUrl = 'https://rest.coinapi.io/v1/exchangerate';

  Future<dynamic> getCoinData(String crypto, currency) async {
 String url = '$baseUrl/$crypto/$currency';

    try {
      String apiKey = 'B44B9A69-CA67-4D6A-ADD9-98E0D88BF679';
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {'X-CoinAPI-Key': apiKey}, // Add API Key in the headers
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        return data;
      } else {
        print('Failed to fetch data, Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
