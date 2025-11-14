import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:nibit/utils/controllers/stream_controller.dart';
import '../reusables/balancecards.dart';
import '../reusables/coin_model.dart';
import '../reusables/stylings.dart';
import 'coindetails_page.dart';
// import '../services/api_service.dart';
// import '../services/coin_stream.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final StreamController streamController = Get.put(
      StreamController(), permanent: true);

  bool _showNetworkError = false;
  @override
  void initState() {
    super.initState();

    // Start a 5-second timer when page loads
    Future.delayed(const Duration(seconds: 15), () {
      // Only show error if still loading
      if (mounted && !_hasData) {
        setState(() {
          _showNetworkError = true;
        });
      }
    });
  }

  bool get _hasData => streamController.cachedCoins != null && streamController.cachedCoins!.isNotEmpty;

  // late Future<List<CoinModel>> _coinsFuture;
  // List<CoinModel>? _cachedCoins;
  // late Stream<List<CoinModel>> _coinStream;


  // @override
  // void initState() {
  //   super.initState();
  //   _coinStream = CoinStreamService.coinStream(intervalSeconds: 30);
  // }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: Get.height * 0.1,
          shape: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          centerTitle: true,
          title: Text(
            'Hello User', style: Stylings.titles.copyWith(fontSize: 15),),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                // padding: EdgeInsets.all(5),
                  height: Get.height * 0.01,
                  width: Get.width * 0.1,
                  // padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade200,
                    shape: BoxShape.circle,
                    // border: Border.all(color: Colors.red),
                  ),
                  child: Center(child: Icon(
                    Icons.person_outline_rounded, size: 25,
                    color: Colors.white,))),
            ),

          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.notifications_none_rounded, size: 30,),
            )
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Balancecards(
                    thecolor: Stylings.yellow,
                    type: 'USD',
                    currency: '\$', balance: '3,535',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Balancecards(
                    thecolor: Colors.green,
                    type: 'NGN',
                    balance: '1,200,000',
                    currency: '₦',
                  )
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.025),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //add money
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.wallet,
                            size: 23,
                            color: Colors.black,
                          )),
                      Text(
                        "Add money",
                        style: Stylings.subTitles.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  //withdraw
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.snackbar("Coming soon",
                                "Feature not currently available");
                          },
                          icon: const Icon(
                            Icons.money_outlined,
                            size: 23,
                            color: Colors.black,
                          )),
                      Text(
                        "Withdraw",
                        style: Stylings.subTitles.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  //discover
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {

                          },
                          icon: const Icon(
                            Icons.compass_calibration_outlined,
                            size: 23,
                            color: Colors.black,
                          )),
                      Text(
                        "Discover",
                        style: Stylings.subTitles.copyWith(fontSize: 12),
                      )
                    ],
                  ),

                ],
              ),
            ),
            SizedBox(height: Get.height * 0.025),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Top Coins",
                    style: Stylings.titles.copyWith(fontSize: 15),
                  ),
                  const Expanded(child: SizedBox()),
                  const Icon(
                    Icons.add_circle_outline,
                    size: 14,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Portfolio builder",
                    style: Stylings.titles.copyWith(fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Stylings.bgColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child:
                    StreamBuilder<List<CoinModel>>(
                      key: ValueKey(streamController.refreshTrigger.value),
                      stream: streamController.coinStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // Save latest data to cache
                          _showNetworkError = false;
                          streamController.cachedCoins.assignAll(snapshot.data!);
                          return Obx(() =>
                              ListView.builder(
                                itemCount: streamController.cachedCoins.length,
                                itemBuilder: (context, index) {
                                  final coin = streamController.cachedCoins[index];
                                  final priceChangeColor =
                                  coin.priceChangePercentage24h >= 0 ? Colors
                                      .green : Colors.red;

                                  return ListTile(
                                    onTap: () {
                                      Get.to(() => CoinDetailsPage(coin: coin));
                                    },

                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(coin.image),
                                      radius: 22,
                                    ),
                                    title: Text(
                                      coin.name,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      coin.symbol.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.grey),
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          '\$${coin.currentPrice
                                              .toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '${coin.priceChangePercentage24h
                                              .toStringAsFixed(2)}%',
                                          style: TextStyle(
                                              color: priceChangeColor),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting &&
                            streamController.cachedCoins.isNotEmpty) {
                          // If we have cached data, show it while waiting
                          return Obx(() =>
                              ListView.builder(
                                itemCount: streamController.cachedCoins.length,
                                itemBuilder: (context, index) {
                                  final coin = streamController.cachedCoins[index];
                                  final priceChangeColor =
                                  coin.priceChangePercentage24h >= 0 ? Colors
                                      .green : Colors.red;

                                  return ListTile(
                                    onTap: () {
                                      Get.to(() => CoinDetailsPage(coin: coin));
                                    },
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(coin.image),
                                      radius: 22,
                                    ),
                                    title: Text(
                                      coin.name,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      coin.symbol.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.grey),
                                    ),
                                    trailing: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .end,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          '\$${coin.currentPrice
                                              .toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(
                                          '${coin.priceChangePercentage24h
                                              .toStringAsFixed(2)}%',
                                          style: TextStyle(
                                              color: priceChangeColor),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ));
                        }
                        if (snapshot.hasError) {
                          // debugPrint('Stream error: ${snapshot.error}');

                          if (streamController.cachedCoins.isNotEmpty) {
                            // show cached coins with banner
                            return Column(
                              children: [
                                _buildBanner(
                                    "Offline mode — Reload to update"),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: streamController.cachedCoins.length,
                                    itemBuilder: (context, index) {
                                      final coin = streamController
                                          .cachedCoins[index];
                                      final priceChangeColor =
                                      coin.priceChangePercentage24h >= 0
                                          ? Colors.green
                                          : Colors.red;

                                      return ListTile(
                                        onTap: () {
                                          Get.to(() => CoinDetailsPage(coin: coin));
                                        },
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              coin.image),
                                          radius: 22,
                                        ),
                                        title: Text(
                                          coin.name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          coin.symbol.toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        trailing: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .end,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              '\$${coin.currentPrice
                                                  .toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              '${coin.priceChangePercentage24h
                                                  .toStringAsFixed(2)}%',
                                              style: TextStyle(
                                                  color: priceChangeColor),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // no cached data available
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Network Error, Failed to load data",
                                      style: TextStyle(color: Colors.grey)),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: streamController.refreshCoins,
                                    child: const Text("Retry"),
                                  )
                                ],
                              ),
                            );
                          }

                          // else
                          //   if (snapshot.hasError &&
                          //     controller.cachedCoins.isNotEmpty)
                          //   {
                          //   return Column(
                          //     children: [
                          //       _buildBanner("Showing offline data"),
                          //       Expanded(child: Obx(()=>RefreshIndicator(
                          //         onRefresh: () async {
                          //           controller.refreshCoins();
                          //           await Future.delayed(const Duration(seconds: 1));
                          //         },
                          //         child: ListView.builder(
                          //           itemCount: controller.cachedCoins.length,
                          //           itemBuilder: (context, index) {
                          //             final coin = controller.cachedCoins[index];
                          //             final priceChangeColor =
                          //             coin.priceChangePercentage24h >= 0 ? Colors.green : Colors.red;
                          //
                          //             return ListTile(
                          //               leading: CircleAvatar(
                          //                 backgroundImage: NetworkImage(coin.image),
                          //                 radius: 22,
                          //               ),
                          //               title: Text(
                          //                 coin.name,
                          //                 style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          //               ),
                          //               subtitle: Text(
                          //                 coin.symbol.toUpperCase(),
                          //                 style: const TextStyle(color: Colors.grey),
                          //               ),
                          //               trailing: Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.end,
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 children: [
                          //                   Text(
                          //                     '\$${coin.currentPrice.toStringAsFixed(2)}',
                          //                     style: const TextStyle(color: Colors.black),
                          //                   ),
                          //                   Text(
                          //                     '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                          //                     style: TextStyle(color: priceChangeColor),
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           },
                          //         ),
                          //       ))),
                          //     ],
                          //   );
                          // }
                          return const Center(
                              child: CircularProgressIndicator());
                          // else if (snapshot.hasError) {
                          //   // Show cached data instead of empty/error state
                          //   if (controller.cachedCoins != null && controller.cachedCoins.isNotEmpty) {
                          //     return Column(
                          //       children: [
                          //         _buildBanner("Showing offline data"),
                          //         Expanded(child:
                          //         ListView.builder(
                          //           itemCount: _cachedCoins!.length,
                          //           itemBuilder: (context, index) {
                          //             final coin = _cachedCoins![index];
                          //             final priceChangeColor =
                          //             coin.priceChangePercentage24h >= 0 ? Colors.green : Colors.red;
                          //
                          //             return ListTile(
                          //               leading: CircleAvatar(
                          //                 backgroundImage: NetworkImage(coin.image),
                          //                 radius: 22,
                          //               ),
                          //               title: Text(
                          //                 coin.name,
                          //                 style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          //               ),
                          //               subtitle: Text(
                          //                 coin.symbol.toUpperCase(),
                          //                 style: const TextStyle(color: Colors.grey),
                          //               ),
                          //               trailing: Column(
                          //                 crossAxisAlignment: CrossAxisAlignment.end,
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 children: [
                          //                   Text(
                          //                     '\$${coin.currentPrice.toStringAsFixed(2)}',
                          //                     style: const TextStyle(color: Colors.black),
                          //                   ),
                          //                   Text(
                          //                     '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                          //                     style: TextStyle(color: priceChangeColor),
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           },
                          //         )),
                          //       ],
                          //     );
                          //   }
                          return const Center(child: Text(
                              'Failed to load data'));
                        }
                        return Center(child:
                        Column(
                          children: [
                            const CircularProgressIndicator(color: Colors.amber,),
                            const SizedBox(height: 16),
                            if (_showNetworkError)
                            Container(
                              // color: Colors.amber.withOpacity(0.2),
                              child: Center(
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.crisis_alert, color:Colors.amber),
                                    Text('Network error. Reconnecting now ...', style: TextStyle(fontFamily: 'Inter', color: Colors.amber, fontWeight: FontWeight.w900),),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ));
                      },

                    )
                  // StreamBuilder<List<CoinModel>>(
                  //   stream: CoinStreamService.coinStream(intervalSeconds: 30),
                  //   // future: _coinsFuture,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     }
                  //
                  //     if (snapshot.hasError) {
                  //       return Center(
                  //         child: Column(
                  //           children: [
                  //             Text('Error: ${snapshot.error}',
                  //                 style: const TextStyle(color: Colors.red)),
                  //             TextButton(
                  //                 onPressed: (){
                  //                  setState(() {
                  //                    CoinStreamService.coinStream(intervalSeconds: 30);
                  //                  });
                  //                 },
                  //                 child: Text('Reload'))
                  //           ],
                  //         ),
                  //       );
                  //     }
                  //
                  //     if (!snapshot.hasData) {
                  //       return const Center(
                  //         child: Text('Loading...', style: TextStyle(color: Colors.grey)),
                  //       );
                  //     }
                  //
                  //     final coins = snapshot.data!;
                  //
                  //     return
                  //       ListView.builder(
                  //       itemCount: coins.length,
                  //       itemBuilder: (context, index) {
                  //         final coin = coins[index];
                  //         final priceChangeColor =
                  //         coin.priceChangePercentage24h >= 0 ? Colors.green : Colors.red;
                  //
                  //         return ListTile(
                  //           leading: CircleAvatar(
                  //             backgroundImage: NetworkImage(coin.image),
                  //             radius: 22,
                  //           ),
                  //           title: Text(
                  //             coin.name,
                  //             style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  //           ),
                  //           subtitle: Text(
                  //             coin.symbol.toUpperCase(),
                  //             style: const TextStyle(color: Colors.grey),
                  //           ),
                  //           trailing: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.end,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 '\$${coin.currentPrice.toStringAsFixed(2)}',
                  //                 style: const TextStyle(color: Colors.black),
                  //               ),
                  //               Text(
                  //                 '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                  //                 style: TextStyle(color: priceChangeColor),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(String text) {
    return Container(
      color: Colors.amber.shade200,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(width: 6),
          IconButton(
              onPressed: streamController.refreshCoins,
              icon: Icon(Icons.refresh)),
        ],
      ),
    );
  }

}
