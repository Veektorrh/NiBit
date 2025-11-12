import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../reusables/coin_model.dart';
import '../reusables/stylings.dart';
import '../utils/controllers/coincontroller.dart';

class CoinDetailsPage extends StatelessWidget {
  final CoinModel coin;
   CoinDetailsPage({super.key, required this.coin});

  final CoinController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChangePercentage24h >= 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(coin.name, style: TextStyle(fontFamily: 'Inter',)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical:20, horizontal:16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(coin.image), radius: 28),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(coin.name,
                            style: const TextStyle(fontFamily: 'Inter',
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(coin.symbol.toUpperCase(),
                            style: const TextStyle(fontFamily: 'Inter',color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$${coin.currentPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontFamily: 'Inter',
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                      style: TextStyle(fontFamily: 'Inter',
                        fontSize: 15,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Spacer(flex: 1,),

              SizedBox(height: Get.height * 0.06),

            // Price
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('\$${coin.currentPrice.toStringAsFixed(2)}',
            //         style: const TextStyle(
            //             fontSize: 28, fontWeight: FontWeight.bold)),
            //     Text(
            //       '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: isPositive ? Colors.green : Colors.red,
            //       ),
            //     ),
            //   ],
            // ),


            // 7-day Chart
            if (coin.sparklineIn7d != null && coin.sparklineIn7d!.isNotEmpty)
              SizedBox(
                height: Get.height * 0.3,
                width: Get.width * 0.9,
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: coin.sparklineIn7d!
                            .asMap()
                            .entries
                            .map((e) => FlSpot(e.key.toDouble(), e.value))
                            .toList(),
                        isCurved: true,
                        color: isPositive ? Colors.green : Colors.red,
                        barWidth: 2.5,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              )
            else
              const Center(
                  child: Text("No trend data available",
                      style: TextStyle(color: Colors.grey))),
            // Spacer(flex:1),
             SizedBox(height: Get.height * 0.05),

            // Other details
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Market Cap: \$${coin.marketCap.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Inter',)),
                SizedBox(height: Get.height * 0.02),

                Text('Rank: #${coin.marketCapRank}',
                    style: const TextStyle(fontSize: 20, fontFamily: 'Inter',)),
                SizedBox(height: Get.height * 0.02),

                Text('24h Volume: \$${coin.totalVolume.toStringAsFixed(0)}',
                    style: const TextStyle(fontFamily: 'Inter',fontSize: 20)),
                 SizedBox(height: Get.height * 0.02),
              ],
            ),
            // Spacer(flex:1),
            SizedBox(height: Get.height * 0.06),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
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
                  child: Container(
                    width: Get.width * 0.6,
                    // height: Get.height * 0.1,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber.shade600,
                    ),
                    child: Center(child: Text('+ Add to assets', style: Stylings.titles.copyWith(fontSize: 18, color:  Colors.white),)),
                  ),
                ),


                GestureDetector(
                  onTap: (){
                    controller.toggleFavorite(coin);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          controller.isFav(coin)
                              ? '✅ Added to Favorites'
                              : '❌ Removed from Favorites',
                        ),
                        backgroundColor: controller.isFav(coin) ? Colors.green.shade500 : Colors.red.withOpacity(0.5),
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(12),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Container(
                    width: Get.width * 0.3,
                    // height: Get.height * 0.1,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200,
                    ),
                    child: Center(child:
                   Obx(()=> Icon(controller.isFav(coin) ? Icons.star : Icons.star_border_outlined,size: 30, color: controller.isFav(coin) ? Colors.amber : Colors.black ,))
                    // Text('+ Add to Favorites', style: Stylings.titles.copyWith(fontSize: 15, color:  Colors.white),)
                    ),
                  ),
                ),
              ],
            ),

            // TextButton(
            //     onPressed: (){
            //       controller.addAsset(coin);
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //           content: Text(
            //             controller.isAsset(coin)
            //                 ? '✅ Added to Assets'
            //                 : '❌ Removed from Assets',
            //           ),
            //           backgroundColor: controller.isAsset(coin) ? Colors.green.shade500 : Colors.red.withOpacity(0.5),
            //           behavior: SnackBarBehavior.floating,
            //           margin: const EdgeInsets.all(12),
            //           duration: const Duration(seconds: 2),
            //         ),
            //       );
            //       },
            //   style: TextButton.styleFrom(
            //     backgroundColor: Colors.green.shade700
            //   ),
            //     child: Center(child: Text('Add to Assets(Buy)', style: TextStyle(color: Colors.white,fontFamily: 'Inter'))),)
          ],
        ),
      ),
    );
  }
}
