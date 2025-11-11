import 'dart:async';
import '../../reusables/coin_model.dart';
// import '../reusables/coin_model.dart';
// import '../utils/reusables/coin_model.dart';
import 'api_service.dart';

class CoinStreamService {
  static Stream<List<CoinModel>> coinStream({int intervalSeconds = 10}) async* {
    // Emits a new list of coins every [intervalSeconds]
    yield* Stream.periodic(Duration(seconds: intervalSeconds), (_) async {
      final coins = await ApiService.fetchCoins();
      return coins;
    }).asyncMap((event) async => await event);
  }
}
