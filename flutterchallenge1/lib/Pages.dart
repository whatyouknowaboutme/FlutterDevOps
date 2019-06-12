import 'package:flutter/material.dart';


class PageViews extends StatelessWidget
{
  final PageViewModel viewModel;
  final double opacity;

  PageViews(this.viewModel, this.opacity);

  @override
  Widget build(BuildContext context) {
  return new Container(
    width: double.infinity,
    color: viewModel.color,//Colors.blueAccent,
    child: Opacity(
      opacity: this.opacity,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         new Transform(
           transform: new Matrix4.translationValues(0.0,50.0*(1-opacity),0),
            child: Padding(
              padding: const EdgeInsets.only(bottom:20.0),
              child: new Image.asset(viewModel.iconAssestIcon,width: 200.0, height: 200),
            ),
          ),
          new Transform(
          transform: Matrix4.translationValues(0.0, 30.0 *(1-opacity), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0), //should i add padding above
              child: new Text(viewModel.title,
                style: new TextStyle(
                  color: Colors.white,
                  fontFamily: 'FlamanteRoma',
                  fontSize: 34.0,
                ),//Header Style Text
              ),
            ),
          ),
          new Transform(
            transform: Matrix4.translationValues(0.0, 20*(1-opacity), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),//don't really need in my opinion -> lets double check
              child: new Text(viewModel.body,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white,
                      fontFamily: 'FlamanteRomaItalics',
                      fontSize: 18.0)
              ),
            ),
          ),

        ],
      ),
    ),

  );//Container
  }
}

class PageViewModel
{
  final Color color;
  final String title;
  final String body;
  final String iconAssestIcon;
  final String bottomIcon;

  PageViewModel(this.color,this.iconAssestIcon, this.title, this.body ,this.bottomIcon);


}


