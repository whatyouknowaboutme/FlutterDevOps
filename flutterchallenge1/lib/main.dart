import 'package:flutter/material.dart';
import 'package:flutterchallenge1/Pages.dart';

import 'Indicator.dart';
import 'PageReveal.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: Page(),
    );//MaterialApp
  }//widget build
}//end MyApp class

class Page extends StatefulWidget
{


  Page({Key key}): super(key:key);

  _PageState createState() => new _PageState();
}//end Page class

class _PageState extends State<Page>
{



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
        new PageViews(
            pages[0], 1.0
           ),
          new PageReveal(
            0.9,
            new PageViews(
              pages[1],1.0
            ),
          ),
        new Indicator(new IndicatorViewModel(
        pages,
        2,
        SlideDirection.none,
        0))

        ],
      ),//Stack
    );//Scaffold
  }//widget build
}//end class


final pages = [
  new PageViewModel(
      Colors.blueAccent,
      'assets/images/hotels.png',
      'Hotels',
      'All hotels and hostels are sorted by hospitality rating',
      'assets/images/key.png'
  ),
  new PageViewModel(
      Colors.redAccent,
      'assets/images/banks.png',
      'Banks',
      'We carefully verify all banks before adding them into the app',
      'assets/images/wallet.png'
  ),
  new PageViewModel(
    Colors.deepOrangeAccent,
    'assets/images/stores.png',
    'Store',
    'All local stores are categorized for your convenience',
    'assets/images/shopping_cart.png',
  ),
];


