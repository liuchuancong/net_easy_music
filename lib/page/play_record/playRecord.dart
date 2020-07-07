import 'package:flutter/material.dart';

import 'card_data.dart';
import 'carsoule.dart';

class BottomPopupRecord {
  showCard({BuildContext context}) async {
    await showModalBottomSheet(
        context: context,
        barrierColor:Colors.black.withOpacity(0.3),
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * .7,
            child: Carsoule(
              selectedIndex: heroCards.length - 1,
            )
          );
        });
  }
}
