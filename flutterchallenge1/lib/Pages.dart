import 'package:flutter/material.dart';


class PageViews extends StatelessWidget
{
  final PageViewModel viewModel;

  PageViews(this.viewModel);

  @override
  Widget build(BuildContext context) {
  return new Container(
    width: double.infinity,
    color: viewModel._color,//Colors.blueAccent,
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom:20.0),
          child: new Image.asset(viewModel._iconAssestIcon,width: 200.0, height: 200),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0), //should i add padding above
          child: new Text(viewModel._title,
            style: new TextStyle(
              color: Colors.white,
              fontFamily: 'FlamanteRoma',
              fontSize: 34.0,
            ),//Header Style Text
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),//don't really need in my opinion -> lets double check
          child: new Text(viewModel._body,
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.white,
                  fontFamily: 'FlamanteRomaItalics',
                  fontSize: 18.0)
          ),
        ),

      ],
    ),

  );//Container
  }
}

class PageViewModel
{
  final Color _color;
  final String _title;
  final String _body;
  final String _iconAssestIcon;
  final String _bottomIcon;

  PageViewModel(this._color,this._iconAssestIcon, this._title, this._body ,this._bottomIcon);


}


