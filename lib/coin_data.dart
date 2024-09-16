import 'dart:convert';
import 'package:http/http.dart' as http;
import 'price_screen.dart';

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
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'F19B9029-BEF4-4A31-8657-885DE1B16FE3';

class CoinData {
  Future<Map<String, dynamic>> getCoinData(String selectedCurrency) async {
    String reqURL;
    http.Response response;
    var allcoinrates = <String, dynamic>{};
    int fp;
    for (String a in cryptoList) {
      reqURL = '$coinAPIURL/$a/$selectedCurrency?apikey=$apiKey';
      response = await http.get(Uri.parse(reqURL));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        fp = lastPrice.toInt();
        allcoinrates[a] = fp.toString();
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    //TODO 4: Use a for loop here to loop through the cryptoList and request the data for each of them in turn.
    //TODO 5: Return a Map of the results instead of a single value.
    // String requestURL = '$coinAPIURL/BTC$selectedCurrency';

    return allcoinrates;
  }
}
