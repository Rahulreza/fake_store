
import 'package:fakestore/widgets/constant.dart';
import 'package:flutter/material.dart';

class Custom_Buttom extends StatelessWidget {
  Custom_Buttom({
    super.key,this.title,this.onTap,  this.isBlue
  }) ;



  String ?title;
  VoidCallback ?onTap;
  bool? isBlue;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed: onTap,
      minWidth: double.infinity,
      padding: EdgeInsets.only(
          top: 17,
          right: 128,
          left: 128,
          bottom: 17
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: isBlue==true?Colors.transparent:Color(0xffFFFFFF)),
        borderRadius: BorderRadius.circular(28),
      ),
      color: isBlue==true?Color(0xff246BFD):Colors.transparent,
      child: Text("$title",style: myStyle(14,Color(0xffFFFFFF) ),),
    );
  }
}
