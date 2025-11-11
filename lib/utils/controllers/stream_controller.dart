import 'package:get/get.dart';
// import 'package:nibit/utils/reusables/coin_model.dart';

import '../../reusables/coin_model.dart';
import '../services/coin_stream.dart';
// import '../../services/coin_stream.dart';

class StreamController extends GetxController {
  RxList<CoinModel> cachedCoins = <CoinModel>[].obs;
  RxInt refreshTrigger = 0.obs;
  // late Stream<List<CoinModel>> coinStream;

  Stream<List<CoinModel>> get coinStream =>
      CoinStreamService.coinStream(intervalSeconds: 30).asBroadcastStream();

  void refreshCoins() {
    refreshTrigger.value++;
  }
}
