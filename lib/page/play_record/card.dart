
import 'package:flutter/material.dart';

import 'card_data.dart';

class CardContainer extends StatelessWidget {
  final CardViewModel viewModel;
  final prarllaxPercent;
  const CardContainer({Key key, this.viewModel, this.prarllaxPercent = 0.0})
      : super(key: key);

   
  @override
  Widget build(BuildContext context) {
     Future<void> showdialog () async {
      return showDialog<void>(context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(viewModel.headerTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(viewModel.title),
                Text(viewModel.subTitle),
              ],
            ),
            
          ),
          actions: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FlatButton(
                    child: Text('确定'), onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                   new FlatButton(
                    child: Text('取消'), onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )            
          ],
        );
      }
        
      );
   }  
    return Container(
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new ClipRRect(
            borderRadius: new BorderRadius.circular(16.0),
            child: new FractionalTranslation(
              translation: Offset(prarllaxPercent * 2, 0.0),
              child: new OverflowBox(
                maxWidth: double.infinity,
                child: new Image.network(
                  viewModel.backdropAssetPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: new Text(
                  viewModel.headerTitle.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              new Expanded(
                child: new Container(),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    viewModel.title.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -5.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                    child: new Text(
                      viewModel.subTitle.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Icon(
                    viewModel.weatherType,
                    color: Colors.white,
                  ),
                  new Text(
                    '35.1℃',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  )
                ],
              ),
              new Expanded(
                child: new Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 60.0),
                child: new Container(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    
                    color: Colors.red[50].withOpacity(0.1),
                    splashColor: Colors.black.withOpacity(0.1),
                    highlightColor: Colors.black.withOpacity(0.1),
                    textColor: Colors.black.withOpacity(0.1),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          '2018/12/13 12:25:13',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        new Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: new Icon(
                            Icons.wb_cloudy,
                            color: Colors.white,
                          ),
                        ),
                        new Text(
                          '11.2mph',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    onPressed: showdialog
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}