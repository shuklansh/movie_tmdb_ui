import 'package:flutter/material.dart';
import 'package:movie_ui/detailed_Screen.dart';

class TopTv extends StatelessWidget {
  //const TopTv({Key? key}) : super(key: key);

  Map<dynamic, dynamic> tvTrending;
  String apikey;
  String accesstk;

  TopTv(this.tvTrending, this.apikey, this.accesstk);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black,
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(20)),
      child: tvTrending.values.length != 0
          ? ListView.builder(
              itemCount: tvTrending.values.elementAt(1).length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailedScreen(
                              tvTrending.values.elementAt(1)[index]['id'],
                              tvTrending.values.elementAt(1)[index]['name'],
                              tvTrending.values.elementAt(1)[index]['overview'],
                              apikey,
                              accesstk)));
                    },
                    child: Container(
                      //height: 300,
                      width: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://www.themoviedb.org/t/p/original" +
                                    tvTrending.values.elementAt(1)[index]
                                        ['poster_path']),
                          )),
                    ),
                  ),
                );
              })
          : Container(
          width: double.infinity,
          child: Center(
            child: Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("fetching data.." , style: TextStyle(
                  color: Colors.red
              ),),
                SizedBox(width: 10),
                CircularProgressIndicator(
                  color: Colors.red,
                )],
            )),
          )),
    );
  }
}
