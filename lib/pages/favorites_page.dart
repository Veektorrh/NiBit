import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nibit/pages/discover_page.dart';
import 'package:nibit/utils/controllers/coincontroller.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final CoinController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Coins'),
        centerTitle: true,
        //   leading: GestureDetector(
        //       onTap:()=> Get.to(()=>DiscoverPage()),
        //       child: Icon(Icons.arrow_back_rounded)),
         ),

        body: Obx(() {
          final favs = controller.favList;
          if (favs.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: favs.length,
              itemBuilder: (context, index) {
                final coin = favs[index];
                final priceChangeColor =
                coin.priceChangePercentage24h >= 0 ? Colors.green : Colors.red;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(coin.image),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Row(
                    children: [
                      Text(coin.name,  style: const TextStyle(
                          fontWeight: FontWeight.w600),),
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
                  })
                    ],
                  ),
                  subtitle: Text(coin.symbol.toUpperCase(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Column(
                    children: [
                      Text('\$${coin.currentPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),),
                      Text(
                        '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                        style: TextStyle(color: priceChangeColor),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      );
  }
}
