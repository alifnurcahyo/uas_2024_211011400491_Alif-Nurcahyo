// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> cryptoPrices = [];
  final double usdToIdrRate = 15000.0; // Kurs konversi USD ke IDR

  @override
  void initState() {
    super.initState();
    fetchCryptoPrices();
  }

  Future<void> fetchCryptoPrices() async {
    final response =
        await http.get(Uri.parse('https://api.coinlore.net/api/tickers/'));

    if (response.statusCode == 200) {
      setState(() {
        cryptoPrices = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load crypto prices');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 205, 243, 145),
        title: Text(
          position: Center(child: ,)
          'HARGA CRYPTO',
          style: TextStyle(
            color: Color.fromARGB(255, 101, 24, 24),
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cryptoPrices.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cryptoPrices.length,
              itemBuilder: (context, index) {
                // Hitung harga dalam IDR
                double priceInIdr =
                    double.parse(cryptoPrices[index]['price_usd']) *
                        usdToIdrRate;

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cryptoPrices[index]['name']),
                      Text(
                        '\$${cryptoPrices[index]['price_usd']} USD\n${priceInIdr.toStringAsFixed(2)} IDR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
