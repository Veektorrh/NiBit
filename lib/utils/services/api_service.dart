import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../reusables/coin_model.dart';
// import '../reusables/coin_model.dart';
// import '../utils/reusables/coin_model.dart';


class ApiService {
  static const String _baseUrl =
      'https://api.coingecko.com/api/v3/coins/markets';

  /// Fetches the top coins from CoinGecko
  static Future<List<CoinModel>> fetchCoins() async {
    final url = Uri.parse(
      '$_baseUrl?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=true',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => CoinModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load coins : ${response.statusCode}');
    }
  }
}
