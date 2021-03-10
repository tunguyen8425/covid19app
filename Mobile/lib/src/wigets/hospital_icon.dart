import 'package:flutter/material.dart';
import 'package:healthpro/src/themes/light_color.dart';
import 'package:healthpro/src/themes/theme.dart';
import 'package:healthpro/src/wigets/title_text.dart';

class ProducIcon extends StatelessWidget {
  // final String imagePath;
  // final String text;
  // final bool isSelected;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: AppTheme.hPadding,
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: LightColor.background,
        border: Border.all(
            color: LightColor.orange,
            width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xfffbf2ef),
             blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(5,5)
              ),
        ],
      ),
      child: Row(
        children: <Widget>[
//          Image.asset(model.image),
          Container(
            child: TitleText(
//              text: model.name,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}
