import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/select_seat_controller.dart';

class SelectSeatView extends GetView<SelectSeatController> {
  const SelectSeatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 197, 202, 233),
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,            
          ),
          Column(
            children: [
              SizedBox(height: context.mediaQueryPadding.top),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pilih Kursi',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333e63)
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'New Shantika',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333e63)
                          ),
                        ),
                        Text(
                          'JetBus',
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Status(
                      stat: 'Available',
                      color: Colors.white,
                    ),
                    Status(
                      stat: 'Filled',
                      color: Color.fromARGB(255, 162, 162, 158),
                    ),
                    Status(
                      stat: 'Selected',
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('A', style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            Text('B',style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold
                            ),
                            ),  
                            Text('C',style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            Text('D',style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(                                
                                    child: Obx(
                                      () => GridView.builder(
                                      padding: EdgeInsets.all(10),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 14,
                                        crossAxisSpacing: 16,
                                        crossAxisCount: 4,
                                      ),
                                      itemCount: controller
                                          .bus[
                                              controller.indexBus.value]
                                          .length,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () =>
                                            controller.selectKursi(index),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black38,
                                            ),
                                            color: controller.bus[controller
                                                            .indexBus.value]
                                                        [index]["stat"] ==
                                                    "Available"
                                                ? Colors.white
                                                : controller.bus[controller
                                                                .indexBus
                                                                .value][index]
                                                            ["stat"] ==
                                                        "Filled"
                                                    ? Color.fromARGB(255, 162, 162, 158)
                                                    : Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                     /*() => GridView.count(
                                        mainAxisSpacing: 14,
                                        crossAxisSpacing: 16,
                                        crossAxisCount: 4,), 
                                      itemCount: ((context, index) 
                                      => GestureDetector(
                                        onTap: () =>
                                          controller.selectKursi(index),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: controller.bus[controller.indexBus.value][index]["Status"] == "Avaiable"
                                          ? Colors.white
                                          : controller.bus[controller.indexBus.value][index]["Status"] == "Filled"
                                          ? Color.fromARGB(255, 162, 162, 158)
                                          : Colors.green,
                                        ),
                                      )
                                      )
                                      )
                                    ),*/
                                    ),                                
                              ),
                              ),
                              ),
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                color: Colors.white.withOpacity(0.5),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("PESAN"),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF656CEE),
                      fixedSize: Size(Get.width * 0.8, 50),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}

class Status extends StatelessWidget {
  const Status({
    Key? key,
    required this.stat,
    required this.color,
  }) : super(key: key);

  final String stat;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5)
          ),
        ),
        SizedBox(width : 7),
        Text(
          stat, 
          style: TextStyle(
            fontSize: 18,
          ),
          )
      ],
    );
  }
}