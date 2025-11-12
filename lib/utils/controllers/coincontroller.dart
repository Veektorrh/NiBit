import 'package:get/get.dart';
// import 'package:nibit/services/coin_stream.dart';
// import 'package:nibit/utils/reusables/coin_model.dart';
import '../../reusables/coin_model.dart';
import '../services/api_service.dart';
// import '../../services/api_service.dart';

class CoinController extends GetxController {
  /// All coins fetched from API
  var coins = <CoinModel>[].obs;

  /// Filtered coins
  var filteredCoins = <CoinModel>[].obs;

  /// User favorites
  var favList = <CoinModel>[].obs;

  /// Assets
  var assetList = <CoinModel>[].obs;

  /// Loading and error states
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoins();
  }

  /// Fetch coins from API
  Future<void> fetchCoins() async {
    try {
      isLoading(true);
      errorMessage('');

      final fetchedCoins = await ApiService.fetchCoins();

      coins.assignAll(fetchedCoins);
      filteredCoins.assignAll(fetchedCoins);
    } catch (e) {
      errorMessage('Failed to load coins: $e');
    } finally {
      isLoading(false);
    }
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
      filteredCoins.assignAll(coins);
      return;
    }

    final lowerQuery = query.toLowerCase();
    final results = coins.where((coin) {
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

  /// Refresh coins manually (like pull-to-refresh)
  Future<void> refreshCoins() async {
    await fetchCoins();
  }
}


// import 'package:get/get.dart';
// import 'package:nibit/utils/reusables/coin_model.dart';
//
// class CoinController extends GetxController {
//   List<Coin> coins = [
//     Coin(name: "Bitcoin", symbol: "BTC", price: 68000),
//     Coin(name: "Ethereum", symbol: "ETH", price: 3600),
//     Coin(name: "Cardano", symbol: "ADA", price: 0.5),
//     Coin(name: "Solana", symbol: "SOL", price: 180),
//   ];
//   List<Coin> favList = <Coin>[].obs;
//   List<Coin> filteredCoins = <Coin>[].obs;
//
//   @override
//   void onInit() {
//     filteredCoins.assignAll(coins);
//     super.onInit();
//   }
//
//   void filterCoins(String query) {
//     if (query.isEmpty) {
//       filteredCoins.assignAll(coins);
//     }
//     final results = coins.where((coin) {
//       final nameLower = coin.name.toLowerCase();
//       final symbolLower = coin.symbol.toLowerCase();
//       final searchLower = query.toLowerCase();
//       return nameLower.contains(searchLower) || symbolLower.contains(searchLower);
//     }).toList();
//     filteredCoins.assignAll(results);
//   }
//
//   void toggleFavorite(Coin coin){
//     if (favList.contains(coin)){
//       favList.remove(coin);
//       print('Coin removed from favorites');
//     } else
//     {
//       favList.add(coin);
//       print('Coin added to favorites');
//     }
//   }
//
//   bool isFav (Coin coin){
//     return favList.contains(coin);
//   }
// }