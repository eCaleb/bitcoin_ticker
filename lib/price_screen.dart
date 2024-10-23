import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String bitcoinValueInCurrency = '?';
  String ethereumValueInCurrency = '?';
  String litecoinValueInCurrency = '?';

  @override
  void initState() {
    super.initState();
    getCryptoData(); // Fetch the crypto data initially
  }

  // Function to fetch the data from CoinAPI for each crypto
  void getCryptoData() async {
    try {
      CoinData coinConvert = CoinData();
      var btcData = await coinConvert.getCoinData('BTC', selectedCurrency);
      var ethData = await coinConvert.getCoinData('ETH', selectedCurrency);
      var ltcData = await coinConvert.getCoinData('LTC', selectedCurrency);

      setState(() {
        bitcoinValueInCurrency = btcData['rate'].toStringAsFixed(2);
        ethereumValueInCurrency = ethData['rate'].toStringAsFixed(2);
        litecoinValueInCurrency = ltcData['rate'].toStringAsFixed(2);
      });
    } catch (e) {
      print(e);
    }
  }

  // Dropdown for Android
  DropdownButton<String> getDropdownButton() {
    List<DropdownMenuItem<String>> dropdownItems = currenciesList.map((String currency) {
      return DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
    }).toList();

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getCryptoData(); // Fetch new data when the currency changes
        });
      },
    );
  }

  // Picker for iOS
  CupertinoPicker getCupertinoIosPicker() {
    List<Text> pickerItems = currenciesList.map((String currency) {
      return Text(currency);
    }).toList();

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getCryptoData(); // Fetch new data when the currency changes
        });
      },
      children: pickerItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValueInCurrency $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethereumValueInCurrency $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 250),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $litecoinValueInCurrency $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? getCupertinoIosPicker()
                : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}
