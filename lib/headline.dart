import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  //const Headline({Key? key}) : super(key: key);

  String str1;
  String str2;

  Headline(this.str1,this.str2);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color.fromRGBO(44, 44, 44, 1.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RichText(
            text: TextSpan(
                text: str1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 37,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 1,
                ),
                children: [
                  //TextSpan(text: "Trending"),
                  TextSpan(
                      text: " "+str2,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ))
                ])),
      ),
    );
  }
}
