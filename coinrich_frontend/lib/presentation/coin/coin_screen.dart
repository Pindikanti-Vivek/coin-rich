import 'package:coinrich_frontend/core/config/colors.dart';
import 'package:coinrich_frontend/core/config/styles.dart';
import 'package:coinrich_frontend/presentation/coin/coin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinScreen extends StatelessWidget {
  const CoinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: kNeutral8,
          appBar: AppBar(
            backgroundColor: kBlackColor,
            title: Text("CoinRich", style: kText30Bold.copyWith(color: kWhiteColor)),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.pie_chart, color: kSecondaryColor, size: 25),
                  const SizedBox(width: 8),
                  Text("Show Chart", style: kText16Medium.copyWith(color: kSecondaryColor)),
                  const Expanded(child: SizedBox()),
                  Text("Count: ${controller.quotes.length}", style: kText16Normal.copyWith(color: kNeutral4)),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.quotes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: kBlackColor,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.quotes[index]["name"],
                                  style: kText20Medium.copyWith(color: kSecondaryColor),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    controller.quotes[index]["change"].startsWith("-")
                                        ? const Icon(Icons.arrow_downward, color: kFailColor, size: 20)
                                        : const Icon(Icons.arrow_upward, color: kSuccessColor, size: 20),
                                    Text(
                                      "${controller.quotes[index]["change"]}%",
                                      style: kText16Normal.copyWith(color: kNeutral2),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: kNeutral8,
                                  ),
                                  child: Center(child: Text(controller.quotes[index]["symbol"], style: kText16Normal.copyWith(color: kNeutral4),)),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "Price     \$ ${controller.quotes[index]["price"]}",
                                  style: kText16Normal.copyWith(color: kNeutral2),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  " Rank     ${controller.quotes[index]["rank"]}",
                                  style: kText16Normal.copyWith(color: kNeutral2),
                                ),
                              ),
                              const Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_circle_right, color: kSecondaryColor, size: 30),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingAll(12),
                    ).paddingOnly(bottom: 12);
                  },
                ),
              ),
            ],
          ).paddingAll(8),
        );
      },
    );
  }
}
