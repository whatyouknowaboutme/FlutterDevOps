import 'package:flutter/material.dart';
import 'package:flutterchallenge1/Pages.dart';
import 'dart:ui';
class Indicator extends StatelessWidget{

  final IndicatorViewModel viewModel;

  Indicator(this.viewModel);

  @override
  Widget build(BuildContext context) {

    List<Icon> icons = [];

    for (int i =0; i<viewModel.pages.length;i++)
      {
         final page = viewModel.pages[i];

         var percentActive;
         if (i == viewModel.activeIndex) {
           percentActive = 1.0 - viewModel.slidePercentage;
         } else if (i == viewModel.activeIndex - 1 && viewModel.slideDirection == SlideDirection.lefttoRight) {
           percentActive = viewModel.slidePercentage;
         } else if (i == viewModel.activeIndex + 1 && viewModel.slideDirection == SlideDirection.righttoLeft) {
           percentActive = viewModel.slidePercentage;
         } else {
           percentActive = 0.0;
         }

         icons.add(

          new Icon(
            viewModel: new IndicatorBubbleViewModel(
                page.bottomIcon ,
                page.color,
                (i>viewModel.activeIndex||(i==viewModel.activeIndex && viewModel.slideDirection!=SlideDirection.none)),
                percentActive//i==viewModel.activeIndex?1.0:0.0
            )
            ,
          ),

        );
      }
    return new Column(
      children: <Widget>[
        new Expanded(child: Container()),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: icons,
        )
      ],
    );
  }
}

enum SlideDirection{
   righttoLeft,
    lefttoRight,
  none
}

class IndicatorViewModel{
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercentage;

  IndicatorViewModel(this.pages, this.activeIndex, this.slideDirection,
      this.slidePercentage);


}

class IndicatorBubbleViewModel{
  final String iconpath;
  final Color color;
  final bool isHollow;
  final double active;

  IndicatorBubbleViewModel(this.iconpath, this.color, this.isHollow, this.active);



}

class Icon extends StatelessWidget {
  final IndicatorBubbleViewModel viewModel;

  Icon({this.viewModel});


  @override
  Widget build(BuildContext context) {
    return new Container(
     transform: Matrix4.translationValues(0, -20, 0) ,
     width: 45,
      height: 45,
      //padding: const EdgeInsets.only(left: 15*(1.0- viewModel.active), bottom: 25),
      child: Center(
        child: new Container(
          width: lerpDouble(20.0,45.0,viewModel.active),
          height: lerpDouble(20.0,45.0,viewModel.active),

          decoration:  new BoxDecoration(

            shape: BoxShape.circle,
            color: viewModel.isHollow?Colors.transparent:Colors.white70,
            border: viewModel.isHollow? Border.all(
            color: Colors.white70,
              width: 3
            ):null , //must check if this is allowed


          ),
          child: Opacity(
            opacity: viewModel.active,
            child: new Image.asset(viewModel.iconpath,
                color: viewModel.color),
          ),
        ),
      ),
    );
  }
}


