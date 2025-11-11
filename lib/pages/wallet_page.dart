import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../reusables/balancecards.dart';
import '../reusables/stylings.dart';
import '../utils/controllers/coincontroller.dart';
// import '../utils/reusables/balancecards.dart';
// import '../utils/reusables/stylings.dart';

class WalletPage extends StatelessWidget {
   WalletPage({super.key});
   final CoinController controller = Get.put(CoinController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets'),
        centerTitle: true,
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
          SizedBox(height: Get.height * 0.02),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Container(
                 width: Get.width * 0.3,
                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: Colors.amber.withOpacity(0.5),
                 ),
                 child: Center(child: Text('Add Funds', style: Stylings.titles.copyWith(fontSize: 15),)),
               ),
                Container(
                  width: Get.width * 0.3,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: Center(child: Text('Send', style: Stylings.titles.copyWith(fontSize: 15),)),
                ),
                Container(
                  width: Get.width * 0.3,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: Center(child: Text('Transfer', style: Stylings.titles.copyWith(fontSize: 15),)),
                )

              ],
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Align(
            alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('Balances', style: Stylings.titles.copyWith(fontSize: 18)),
              )),
          SizedBox(height: Get.height * 0.02),
          Expanded(
              child:
              Obx((){
                // if(controller.assetList.isEmpty){
                //   final coin = controller.assetList;
                //   return Padding(
                //     padding: const EdgeInsets.all(10.0),
                //     child:
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             CircleAvatar(
                //               backgroundImage: NetworkImage(coin.image),
                //               backgroundColor: Colors.transparent,
                //             ),
                //             SizedBox(width: Get.width * 0.02,),
                //             Column(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   coin.symbol.toUpperCase(),
                //                   style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.w600 ),
                //                 ),
                //                 Text(
                //                   coin.name,
                //                   style: const TextStyle(
                //                       color: Colors.grey, fontSize: 15),
                //                 ),
                //                 Text(
                //                   'Average Price',
                //                   style: const TextStyle(color: Colors.grey, fontSize: 15),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             Text(
                //               '0.15678',
                //               style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.w600),
                //             ),
                //             Text(
                //               '\$1,680',
                //               style:  TextStyle(
                //                   color: Colors.grey.shade900, fontSize: 15),
                //             ),
                //             Text(
                //               '\$${coin.currentPrice.toStringAsFixed(2)}',
                //               style: const TextStyle(color: Colors.black, fontSize: 15),
                //             ),
                //           ],
                //         ),
                //
                //
                //       ],
                //     ),
                //   );
                // }
                  return ListView.builder(
                  itemCount: (controller.assetList).length,
                  itemBuilder: (context, index) {
                    final coin = controller.assetList[index];
                    return  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                  backgroundImage: NetworkImage(coin.image),
                                  backgroundColor: Colors.transparent,
                                ),
                              SizedBox(width: Get.width * 0.02,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(
                                      coin.symbol.toUpperCase(),
                                      style: const TextStyle(fontFamily: 'Inter',fontSize: 20,color: Colors.black, fontWeight: FontWeight.w600 ),
                                    ),
                                Text(
                                    coin.name,
                                    style: const TextStyle(fontFamily: 'Inter',
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                  Text(
                                    'Average Price',
                                    style: const TextStyle(fontFamily: 'Inter',color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                          ],
                        ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '0.15678',
                                style: const TextStyle(fontFamily: 'Inter',fontSize: 20,color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '\$1,680',
                                style:  TextStyle(fontFamily: 'Inter',
                                    color: Colors.grey.shade900, fontSize: 15),
                              ),
                              Text(
                                '\$${coin.currentPrice.toStringAsFixed(2)}',
                                style: const TextStyle(fontFamily: 'Inter',color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),


                        ],
                      ),
                    );

                    //   ListTile(
                    //     leading: CircleAvatar(
                    //       backgroundImage: NetworkImage(coin.image),
                    //       backgroundColor: Colors.transparent,
                    //     ),
                    //     title: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Text(
                    //           coin.name,
                    //           style: const TextStyle(
                    //               fontWeight: FontWeight.w600),
                    //         ),
                    //         Text(
                    //           '\$${coin.currentPrice.toStringAsFixed(2)}',
                    //           style: const TextStyle(
                    //               color: Colors.green,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //       ],
                    //     ),
                    //     subtitle: Text(
                    //       coin.symbol.toUpperCase(),
                    //       style: const TextStyle(color: Colors.grey),
                    //     ),
                    //     trailing:
                    //     Text('welcome')
                    // );
                    // trailing: IconButton(
                    //   icon: Icon(
                    //     isFav ? Icons.favorite : Icons.favorite_border,
                    //     color: isFav ? Colors.red : null,
                    //   ),
                    //   onPressed: () => controller.toggleFavorite(coin),
                    // ),

                  });})

          )
        ],
      ),
    );
  }
}
