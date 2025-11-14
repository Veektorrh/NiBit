import 'package:get/get.dart';
import 'package:hive/hive.dart';
// import 'package:nibit/utils/reusables/coin_model.dart';

import '../../reusables/coin_model.dart';
import '../services/coin_stream.dart';
// import '../../services/coin_stream.dart';

class StreamController extends GetxController {
  RxList<CoinModel> cachedCoins = <CoinModel>[].obs;
  RxInt refreshTrigger = 0.obs;
  /// All coins fetched from API
  var coinsList = <CoinModel>[].obs;
  /// Filtered coins
  var filteredCoins = <CoinModel>[].obs;
  /// User favorites
  var favList = <CoinModel>[].obs;

  /// Assets
  var assetList = <CoinModel>[].obs;

  /// Loading and error states
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  final Box cacheBox = Hive.box('coinCacheBox');
  // late Stream<List<CoinModel>> coinStream;
  @override
  void onInit() {
    super.onInit();
    _loadCachedCoins();
  }

  Stream<List<CoinModel>> get coinStream async* {
    await for (final coins in CoinStreamService.coinStream(intervalSeconds: 10)) {

      if (coins.isNotEmpty) {
        // save memory cache
        cachedCoins.assignAll(coins);
        filteredCoins.assignAll(coins);
        coinsList.assignAll(coins);

        // save offline cache
        _saveToHive(coins);
      }

      yield coins;
    }
  }
  void refreshCoins() {
    refreshTrigger.value++;
  }

  void _loadCachedCoins() {
    final data = cacheBox.get('coins');

    if (data != null) {
      cachedCoins.assignAll(
        (data as List).map((e) => CoinModel.fromJson(Map<String, dynamic>.from(e))).toList(),
      );
    }
  }

  // Save coins to Hive
  void _saveToHive(List<CoinModel> coins) {
    final jsonData = coins.map((e) => e.toJson()).toList();
    cacheBox.put('coins', jsonData);
  }

  /// Add to Assets
  void addAsset(CoinModel coin) {
    if (assetList.contains(coin)) {
      assetList.remove(coin);

    } else {
      assetList.add(coin);

    }
  }

  /// Filter coins by name or symbol
  void filterCoins(String query) {
    if (query.isEmpty) {
      filteredCoins.assignAll(coinsList);
      return;
    }

    final lowerQuery = query.toLowerCase();
    final results = coinsList.where((coin) {
      return coin.name.toLowerCase().contains(lowerQuery) ||
          coin.symbol.toLowerCase().contains(lowerQuery);
    }).toList();

    filteredCoins.assignAll(results);
  }

  /// Add or remove from favorites
  void toggleFavorite(CoinModel coin) {
    if (favList.contains(coin)) {
      favList.remove(coin);

    } else {
      favList.add(coin);

    }

  }

  /// Check if a coin is favorited
  bool isFav(CoinModel coin) {
    return favList.contains(coin);
  }

  /// check if a coin is an asset
  bool isAsset(CoinModel coin) {
    return assetList.contains(coin);
  }
}
