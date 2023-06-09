import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/kursi_page.dart';
import '../modules/select_seat/views/select_seat_view.dart';

class BookTiket extends StatefulWidget {
  final String nobus;
  final String harga;
  final String dari;
  final String ke;
  final String jamberangkat;
  final String jamsampai;
  final String tipebus;
  final String tanggal;

  const BookTiket({
    Key? key,
    required this.nobus,
    required this.harga,
    required this.dari,
    required this.ke,
    required this.jamberangkat,
    required this.jamsampai,
    required this.tipebus,
    required this.tanggal,
  }) : super(key: key);

  @override
  State<BookTiket> createState() => _BookTiketState();
}

class _BookTiketState extends State<BookTiket> {
  String selectedValue = "lakilaki";
  final namaController = TextEditingController();
  final notelpController = TextEditingController();

  var formatter = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pesan Tiket'),
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 60, 88, 248),
                      ),
                      width: 350,
                      height: 150,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 14,
                      ),
                      Text(widget.tanggal),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.dari,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.trending_flat_sharp,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 24,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.ke,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.jamberangkat + " - " + widget.jamsampai,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.tipebus,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text('Nomor Bus: '),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Nama Penumpang: '),
                        SizedBox(
                          height: 30,
                        ),
                        Text('No Telp: '),
                        SizedBox(
                          height: 50,
                        ),
                        Text('Jenis Kelamin: '),
                        SizedBox(
                          height: 50,
                        ),
                        Text("Harga: "),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        Text(widget.nobus),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: namaController,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 21, 48, 170))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'Nama',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(87, 255, 255, 255)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: notelpController,
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 21, 48, 170))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              hintText: 'No telp',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(87, 255, 255, 255)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DropdownButton(
                            value: selectedValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: dropdownItems),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("Rp ${formatter.format(int.parse(widget.harga))}"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: const Color(0xffF18265)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      ///builder: (context) => const SelectSeat(),
                      builder: (context) => SelectSeatView(
                          widget.nobus,
                          namaController.text,
                          widget.harga,
                          selectedValue,
                          widget.tipebus),
                    ),
                  );
                },
                child: const Text(
                  "Pilih Kursi",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "lakilaki", child: Text("Laki - Laki")),
    const DropdownMenuItem(value: "perempuan", child: Text("Perempuan")),
  ];
  return menuItems;
}
