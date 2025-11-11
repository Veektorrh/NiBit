
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import 'stylings.dart';

class Balancecards extends StatefulWidget {
  final Color thecolor;
  final String type;
  final String currency;
  final dynamic balance;
  const Balancecards({super.key,
    required this.thecolor,
    required this.type, required this.balance, required this.currency});

  @override
  State<Balancecards> createState() => _BalancecardsState();
}

class _BalancecardsState extends State<Balancecards> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return
        Container(
        padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 20),
        width: Get.width*0.85,
        height: Get.height*0.25,
        decoration: BoxDecoration(
          color:widget.thecolor,
          borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: AssetImage('assets/images/carddflower.png'),fit: BoxFit.cover, opacity: 0.5)
            // image: DecorationImage(image: AssetImage("assets/images/notify.png"),fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //line 1
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("${widget.type} balance",style: Stylings.titles.copyWith(fontSize: 18)),
                        SizedBox(width: Get.width *0.02,),
                        GestureDetector(
                            onTap: (){
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: isVisible ? Icon(Icons.visibility): Icon(Icons.visibility_off_outlined)),
                      ],
                    ),
                    SizedBox(width: Get.height *0.05,),
                    Text(isVisible ? '${widget.currency}${widget.balance}' : '**********', style: Stylings.titles.copyWith(fontSize: 23),)
                  ],
                ),

                const Expanded(child: SizedBox()),
                Text("Card Details",style: Stylings.titles.copyWith(fontSize: 15),),
              ],
            ),
            //balance

            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.playlist_play_outlined,color: Colors.black,size: 20,),
                const SizedBox(width: 5),
                Text("Manage",style: Stylings.titles.copyWith(fontSize: 15),),
                const Expanded(child: SizedBox()),
                Text("NiBit",style: Stylings.titles.copyWith(fontSize: 20),),
              ],
            ),
          ],
        ),
      );

  }
}
