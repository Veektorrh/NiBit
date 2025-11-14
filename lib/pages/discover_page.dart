import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nibit/pages/favorites_page.dart';
import 'package:nibit/utils/controllers/stream_controller.dart';

import '../reusables/coin_model.dart';
import 'coindetails_page.dart';
// import 'package:nibit/utils/reusables/coin_model.dart';

// import '../utils/reusables/stylings.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {

  // List<Coin> coins = [
  //   Coin(name: "Bitcoin", symbol: "BTC", price: 68000),
  //   Coin(name: "Ethereum", symbol: "ETH", price: 3600),
  //   Coin(name: "Cardano", symbol: "ADA", price: 0.5),
  //   Coin(name: "Solana", symbol: "SOL", price: 180),
  // ];
  //
  // List<Coin> filteredCoins = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   filteredCoins = coins; // default: show all
  // }

  // void _filterCoins(String query) {
  //   final results = coins.where((coin) {
  //     final nameLower = coin.name.toLowerCase();
  //     final symbolLower = coin.symbol.toLowerCase();
  //     final searchLower = query.toLowerCase();
  //     return nameLower.contains(searchLower) || symbolLower.contains(searchLower);
  //   }).toList();
  //
  //   setState(() => filteredCoins = results);
  // }
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

  bool get _hasData => streamController.filteredCoins != null && streamController.filteredCoins!.isNotEmpty;
  final StreamController streamController = Get.find();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Stylings.bgColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  filled:true,
                  fillColor: Colors.white,
                  hintText: 'Search coin...',
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                     borderSide: BorderSide.none
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onChanged: streamController.filterCoins
              ),
              // SizedBox(height: Get.height * 0.02),
              // GestureDetector(
              //   onTap: () => Get.to(() => FavoritesPage()),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: const [
              //       Icon(Icons.star, color: Colors.amber),
              //       SizedBox(width: 8),
              //       Text(
              //         'View Favorites',
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //       Icon(Icons.arrow_forward_ios, size: 16),
              //     ],
              //   ),
              // ),
              // SizedBox(height: Get.height* 0.02,),
              // GestureDetector(
              //     onTap: (){
              //       Get.to(()=>FavoritesPage());
              //     },
              //     child: Icon(Icons.arrow_forward_ios, size: 20,)),
              SizedBox(height: Get.height* 0.02,),
              Expanded(
                child:
                StreamBuilder<List<CoinModel>>(
                  key: ValueKey(streamController.refreshTrigger.value),
                  stream: streamController.coinStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // Save latest data to cache
                      _showNetworkError = false;
                      streamController.cachedCoins.assignAll(snapshot.data!);
                      streamController.filteredCoins.assignAll(snapshot.data!);
                      return Obx(() =>
                          ListView.builder(
                            itemCount: streamController.filteredCoins.length,
                            itemBuilder: (context, index) {
                              final coin = streamController.filteredCoins[index];
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
                      streamController.filteredCoins = streamController.cachedCoins;
                      // If we have cached data, show it while waiting
                      return Obx(() =>
                          ListView.builder(
                            itemCount: streamController.filteredCoins.length,
                            itemBuilder: (context, index) {
                              final coin = streamController.filteredCoins[index];
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
                        streamController.filteredCoins = streamController.cachedCoins;
                        return Column(
                          children: [
                            _buildBanner(
                                "Offline mode — Reload to update"),
                            Expanded(
                              child: ListView.builder(
                                itemCount: streamController.filteredCoins.length,
                                itemBuilder: (context, index) {
                                  final coin = streamController
                                      .filteredCoins[index];
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
                    if (streamController.filteredCoins.isEmpty) {
    return const Center(child: Text('No coins found'));
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






              )


            ],
          ),
        )
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





// Obx((){
//   if (controller.isLoading.value) {
//     return Center(child:  Column(
//       children: [
//         const CircularProgressIndicator(),
//         const SizedBox(height: 16),
//         if (_showNetworkError)
//     Container(
//         // color: Colors.amber.withOpacity(0.2),
//         child: Center(
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.crisis_alert, color:Colors.amber),
//                 Text('Network error. Reconnecting now ...', style: TextStyle(fontFamily: 'Inter', color: Colors.amber, fontWeight: FontWeight.w900),),
//       ],
//     )
//         ))
//     ]));
//   }
//
//   if (controller.errorMessage.isNotEmpty) {
//     return Center(child: Column(
//       children: [
//         Text(controller.errorMessage.value),
//         IconButton(
//             onPressed: controller.refreshCoins,
//             icon: Icon(Icons.refresh))
//       ],
//     ));
//   }
//
//   if (controller.filteredCoins.isEmpty) {
//     return const Center(child: Text('No coins found'));
//   }
//   _showNetworkError = true;
//   return RefreshIndicator(
//       onRefresh: controller.refreshCoins,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
//         clipBehavior: Clip.hardEdge,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(25),
//           border: Border.all(color: Colors.grey.shade100),
//         ),
//         child: Obx(()=>
//             ListView.builder(
//           itemCount: controller.filteredCoins.length,
//           itemBuilder: (context, index) {
//             final coin = controller.filteredCoins[index];
//             final isFav = controller.isFav(coin);
//             final priceChangeColor =
//             coin.priceChangePercentage24h >= 0
//                 ? Colors.green
//                 : Colors.red;
//
//             // return
//             //   ListView.builder(
//             // itemCount: controller.filteredCoins.length,
//             // itemBuilder: (context, index) {
//             //   final coin = controller.filteredCoins[index];
//             return
//               ListTile(
//                   onTap: (){
//                     Get.to(() => CoinDetailsPage(coin: coin));
//                   },
//                   leading: GestureDetector(
//                     // onTap: (){
//                     //   controller.addAsset(coin);
//                     //   ScaffoldMessenger.of(context).showSnackBar(
//                     //     SnackBar(
//                     //       content: Text(
//                     //         controller.isAsset(coin)
//                     //             ? '✅ Added to Assets'
//                     //             : '❌ Removed from Assets',
//                     //       ),
//                     //       backgroundColor: controller.isAsset(coin) ? Colors.green.shade500 : Colors.red.withOpacity(0.5),
//                     //       behavior: SnackBarBehavior.floating,
//                     //       margin: const EdgeInsets.all(12),
//                     //       duration: const Duration(seconds: 2),
//                     //     ),
//                     //   );
//                     //   },
//                     child: CircleAvatar(
//                       backgroundImage: NetworkImage(coin.image),
//                       backgroundColor: Colors.transparent,
//                     ),
//                   ),
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         coin.name,
//                         style: const TextStyle(fontFamily: 'Inter',
//                             fontWeight: FontWeight.w600),
//                       ),
//                       Text(
//                         '\$${coin.currentPrice.toStringAsFixed(2)}',
//                         style: const TextStyle(fontFamily: 'Inter',
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   subtitle: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         coin.symbol.toUpperCase(),
//                         style: const TextStyle(fontFamily: 'Inter',color: Colors.grey),
//                       ),
//                       Text(
//                         '${coin.priceChangePercentage24h
//                             .toStringAsFixed(2)}%',
//                         style: TextStyle(fontFamily: 'Inter',
//                             color: priceChangeColor),
//                       ),
//                     ],
//                   ),
//                   trailing:
//                   Obx(()  {
//                     final isFav = controller.isFav(coin);
//                     return
//                       // Text(coin.price.toStringAsFixed(2)),
//                       IconButton(
//                           onPressed: (){
//                             controller.toggleFavorite(coin);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   controller.isFav(coin)
//                                       ? '✅ Added to favorites'
//                                       : '❌ Removed from favorites',
//                                 ),
//                                 backgroundColor: controller.isFav(coin) ? Colors.green.shade500 : Colors.red.withOpacity(0.5),
//                                 behavior: SnackBarBehavior.floating,
//                                 margin: const EdgeInsets.all(12),
//                                 duration: const Duration(seconds: 2),
//                               ),
//                             );
//                             },
//                           icon: Icon(isFav ? Icons.star : Icons.star_border_outlined, color: isFav ? Colors.amber: null,));
//                   }
//                   )
//                 // trailing: IconButton(
//                 //   icon: Icon(
//                 //     isFav ? Icons.favorite : Icons.favorite_border,
//                 //     color: isFav ? Colors.red : null,
//                 //   ),
//                 //   onPressed: () => controller.toggleFavorite(coin),
//                 // ),
//               );
//             //   ListTile(
//             //     leading: CircleAvatar(child: Text(coin.symbol[0])),
//             //     title: Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //       children: [
//             //         Text(coin.name),
//             //         Text(coin.currentPrice.toStringAsFixed(2)),
//             //       ],
//             //     ),
//             //     subtitle: Text(coin.symbol),
//             //     trailing: Obx(()  {
//             //       final isFav = controller.isFav(coin);
//             //       return
//             //           // Text(coin.price.toStringAsFixed(2)),
//             //           IconButton(
//             //               onPressed: (){controller.toggleFavorite(coin);},
//             //               icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red: null,));
//             //     }
//             //     )
//             //
//             //
//             //
//             // );
//           },
//         )
//         )
//         ,
//       ));})
