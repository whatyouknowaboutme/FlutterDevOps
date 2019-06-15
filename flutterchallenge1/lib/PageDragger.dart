import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterchallenge1/Indicator.dart';


class PageDragger extends StatefulWidget {

  final StreamController<SlideUpdate> slideUpdateStream;
  final bool canDragLefttoRight;
  final bool canDragRighttoLeft;

  PageDragger({this.slideUpdateStream, this.canDragLefttoRight, this.canDragRighttoLeft});

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {






  static const FULL_TRANSITION_VAL = 300.0;

  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;


  onDragStart(DragStartDetails details)
  {
    dragStart = details.globalPosition;
  }

  onDragEnd(DragEndDetails details)
  {
    dragStart = null;
    widget.slideUpdateStream.add(new SlideUpdate(SlideDirection.none, 0.0,DragState.notdragging));

  }

  onDragUpdate(DragUpdateDetails details)
  {
    
    if (dragStart != null) {
      final newPostion = details.globalPosition;
      final dx = dragStart.dx - newPostion.dx;
      

      if (dx>0 && widget.canDragRighttoLeft)
        {
         slideDirection = SlideDirection.righttoLeft;
        }
      else if(dx<0 && widget.canDragLefttoRight)
        {
          slideDirection = SlideDirection.lefttoRight;
        }else
          {
            slideDirection = SlideDirection.none;
          }

          if (slideDirection != SlideDirection.none) {
            slidePercent = (dx / FULL_TRANSITION_VAL).abs().clamp(0.0, 1.0);
          }
          else
            {
              slidePercent=0.0;
            }
    }

    widget.slideUpdateStream.add(new SlideUpdate(slideDirection, slidePercent,DragState.dragging));
    //print('hey look im sliding $slideDirection by $slidePercent');
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onHorizontalDragStart: onDragStart ,
      onHorizontalDragEnd: onDragEnd,
      onHorizontalDragUpdate: onDragUpdate,
    );
  }
}


enum DragState
{
  dragging,
 notdragging,
//  animated,
//  doneanimated
}

class SlideUpdate
{
  final dragState;
  final direction;
  final slidePercent;

  SlideUpdate(this.direction, this.slidePercent, this.dragState);

}

//class AnimatedDragger
//{
//  static const PERCENT_PER_MILI =0.005;
//  final slideDirection;
//  final transitionGoal;
//
//  AnimationController animationController;
//
//  AnimatedDragger({this.slideDirection, this.transitionGoal,
//    slidePercent, StreamController<SlideUpdate> slideUpdateStream, TickerProvider vsync}){
//    final startSlidePercent = slidePercent;
//    var endSlidePercent;
//    var duration;
//
//    if (transitionGoal== TransitionGoal.open){
//      endSlidePercent=1.0;
//      final slideRemaining =1.0-slidePercent;
//      duration = new Duration(milliseconds: (slideRemaining/PERCENT_PER_MILI).round());
//    }
//    else
//      {
//        endSlidePercent=0.0;
//        duration = new Duration(milliseconds: (slidePercent/PERCENT_PER_MILI).round());
//      }
//    animationController = new AnimationController(vsync: vsync,duration: duration)
//        ..addListener((){
//          slidePercent = lerpDouble(startSlidePercent, endSlidePercent,
//          animationController.value);
//        slideUpdateStream.add(new SlideUpdate(slideDirection, slidePercent, DragState.animated));
//
//        })
//        ..addStatusListener((AnimationStatus status){
//        if (status == AnimationStatus.completed) {
//          slideUpdateStream.add(new  SlideUpdate(slideDirection, endSlidePercent, DragState.doneanimated));//double check
//        }
//        }
//        );
//  }
//
//  run()
//  {
//    animationController.forward(from:0.0);
//  }
//
//  dispose(){
//    animationController.dispose();
//  }
//}
//
//enum TransitionGoal
//{
//  open,
//  close
//}
