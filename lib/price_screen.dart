import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'exchange.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  ExchangeModel model = ExchangeModel();

  int BTCamount;
  int ETHamount;
  int LTCamount;

  void initState(){
    super.initState();

  }

  void updateUI (List exchangeRate){
    setState(() {
      if (exchangeRate == null){
        BTCamount = 0;
        ETHamount = 0;
        LTCamount = 0;
        return;
      }
      double bAmt = exchangeRate[0]['rate'];
      BTCamount = bAmt.toInt();

      double eAmt = exchangeRate[1]['rate'];
      ETHamount = eAmt.toInt();

      double lAmt = exchangeRate[2]['rate'];
      LTCamount = lAmt.toInt();
    });
  }


  String selectedCurrency = 'USD';

  List <DropdownMenuItem> getCurrencyList (){
    List<DropdownMenuItem<String>> newDropdownItem = [];

    for(String currency in currenciesList){

      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      newDropdownItem.add(newItem);
    }
    return newDropdownItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = $BTCamount $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH = $ETHamount $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTC = $LTCamount $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(
                value: selectedCurrency,
                items: getCurrencyList(),
                onChanged: (value) {
                  setState(() async {
                    selectedCurrency = value;

                    var exchangeRate = await computeExchange();
                    updateUI(exchangeRate);

                  });
                }),
          ),
        ],
      ),
    );
  }
  Future <dynamic> computeExchange() async {
    List<dynamic> amounts = [];
    for (String crypto in cryptoList){
      var exchangeRate = await model.getExchangeRate(crypto, selectedCurrency);
      amounts.add(exchangeRate);
    }
    return amounts;
  }

}

// For loop example
 //main(){
//  getSongLyrics();
//}
//void getSongLyrics(){
//  int i=0;
//  for (i=99; i>0; i--){
//    print('$i bottles of beer on the wall,$i bottles of beer,');
//    print('Take one down and pass it around, $i bottles of beer on the wall');
//    print('\n');
//  }
//  if (i == 0){
//    print('No more bottles of beer on the wall, no more bottles of beer,');
//    print('Go to the store and buy some more, 99 bottles of beer on the wall');
//  }
//}

// Another example
//List <int> winningNumbers = [12,6,34,22,41,9];
//
//void main(){
//  List <int> ticket1 = [45,2,9,18,12,33];
//  List <int> ticket2 = [41,17,26,32,7,35];
//
//  checkNumbers(ticket1);
//}
//void checkNumbers(List <int> myNumbers){
//  int matches = 0;
//  for (int item in winningNumbers){
//    if (myNumbers.contains(item)){
//      matches++;
//    }
//  }
//  print('There are $matches matches in your ticket');
//}