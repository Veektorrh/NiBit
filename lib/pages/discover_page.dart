import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nibit/pages/favorites_page.dart';
import 'package:nibit/utils/controllers/coincontroller.dart';
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
  final CoinController controller = Get.put(CoinController());

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
                onChanged: controller.filterCoins
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
                child: Obx((){
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Column(
                      children: [
                        Text(controller.errorMessage.value),
                        IconButton(
                            onPressed: controller.refreshCoins,
                            icon: Icon(Icons.refresh))
                      ],
                    ));
                  }

                  if (controller.filteredCoins.isEmpty) {
                    return const Center(child: Text('No coins found'));
                  }

                  return RefreshIndicator(
                      onRefresh: controller.refreshCoins,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey.shade100),
                        ),
                        child: Obx(()=>
                            ListView.builder(
                          itemCount: controller.filteredCoins.length,
                          itemBuilder: (context, index) {
                            final coin = controller.filteredCoins[index];
                            final isFav = controller.isFav(coin);
                            // return
                            //   ListView.builder(
                            // itemCount: controller.filteredCoins.length,
                            // itemBuilder: (context, index) {
                            //   final coin = controller.filteredCoins[index];
                            return
                              ListTile(
                                  leading: GestureDetector(
                                    onTap: (){
                                      controller.addAsset(coin);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            controller.isAsset(coin)
                                                ? '✅ Added to Assets'
                                                : '❌ Removed from Assets',
                                          ),
                                          backgroundColor: controller.isAsset(coin) ? Colors.green.shade500 : Colors.red.withOpacity(0.5),
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.all(12),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                      },
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(coin.image),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        coin.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '\$${coin.currentPrice.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    coin.symbol.toUpperCase(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  trailing:
                                  Obx(()  {
                                    final isFav = controller.isFav(coin);
                                    return
                                      // Text(coin.price.toStringAsFixed(2)),
                                      IconButton(
                                          onPressed: (){
                                            controller.toggleFavorite(coin);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  controller.isFav(coin)
                                                      ? '✅ Added to favorites'
                                                      : '❌ Removed from favorites',
                                                ),
                                                backgroundColor: controller.isFav(coin) ? Colors.green.shade500 : Colors.red.withOpacity(0.5),
                                                behavior: SnackBarBehavior.floating,
                                                margin: const EdgeInsets.all(12),
                                                duration: const Duration(seconds: 2),
                                              ),
                                            );
                                            },
                                          icon: Icon(isFav ? Icons.star : Icons.star_border_outlined, color: isFav ? Colors.amber: null,));
                                  }
                                  )
                                // trailing: IconButton(
                                //   icon: Icon(
                                //     isFav ? Icons.favorite : Icons.favorite_border,
                                //     color: isFav ? Colors.red : null,
                                //   ),
                                //   onPressed: () => controller.toggleFavorite(coin),
                                // ),
                              );
                            //   ListTile(
                            //     leading: CircleAvatar(child: Text(coin.symbol[0])),
                            //     title: Row(
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Text(coin.name),
                            //         Text(coin.currentPrice.toStringAsFixed(2)),
                            //       ],
                            //     ),
                            //     subtitle: Text(coin.symbol),
                            //     trailing: Obx(()  {
                            //       final isFav = controller.isFav(coin);
                            //       return
                            //           // Text(coin.price.toStringAsFixed(2)),
                            //           IconButton(
                            //               onPressed: (){controller.toggleFavorite(coin);},
                            //               icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red: null,));
                            //     }
                            //     )
                            //
                            //
                            //
                            // );
                          },
                        )
                        )
                        ,
                      ));})



              )


            ],
          ),
        )
      ),
    );
  }
}
