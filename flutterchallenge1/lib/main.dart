import 'package:flutter/material.dart';
import 'package:flutterchallenge1/Pages.dart';
import 'package:flutterchallenge1/PageDragger.dart';

import 'dart:async';
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

  StreamController<SlideUpdate> slideUpdateStream;
  int activeIndex =0;
  int nextPageIndex =0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;


_PageState(){
  slideUpdateStream = new StreamController<SlideUpdate>();
//  AnimatedDragger animatedDragger;

  slideUpdateStream.stream.listen((SlideUpdate event){
  setState(() {
    if (event.dragState == DragState.dragging) {
      slideDirection = event.direction;
      slidePercent = event.slidePercent;

      if (slideDirection==SlideDirection.lefttoRight)
        {
          nextPageIndex=activeIndex-1;
        }
      else if (slideDirection==SlideDirection.righttoLeft)
        {
          nextPageIndex = activeIndex+1;
        }
      else
        {
          nextPageIndex=activeIndex;
        }
      //nextPageIndex = (slideDirection==SlideDirection.lefttoRight?activeIndex-1:activeIndex+1).clamp(0, pages.length-1);

      print("Next Page $nextPageIndex");
    } else if (event.dragState == DragState.notdragging)
      {
        print(slidePercent);
        print("$slideDirection");
        if (slidePercent>0.5)
          {
            activeIndex = slideDirection==SlideDirection.lefttoRight?activeIndex-1:activeIndex+1;
          }
        print(activeIndex);
        slideDirection = SlideDirection.none;
        slidePercent = 0.0;
      }
  });
  });
}

@override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
        new PageViews(
            pages[activeIndex], 1.0
           ),
          new PageReveal(
            slidePercent,
            new PageViews(
              pages[nextPageIndex],slidePercent
            ),
          ),
        new Indicator(new IndicatorViewModel(
        pages,
        this.activeIndex,
        this.slideDirection,
        this.slidePercent)),
          new PageDragger(
            slideUpdateStream: this.slideUpdateStream,
            canDragLefttoRight: activeIndex>0 ,
            canDragRighttoLeft: activeIndex<pages.length-1,
          )


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
  )
];


