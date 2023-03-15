import 'package:flutter/material.dart';

class TopTv extends StatelessWidget {
  //const TopTv({Key? key}) : super(key: key);

  Map<dynamic,dynamic> tvTrending;
  TopTv(this.tvTrending);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20)
      ),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                //height: 300,
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image : DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://www.themoviedb.org/t/p/original"+tvTrending.values.elementAt(1)[index]['poster_path']
                      ),

                    )
                ),
              ),
            );}
      ),
    );
  }
}
