import 'package:flutter/material.dart';

class SingleOvRt extends StatelessWidget {
  //const ({Key? key}) : super(key: key);

  Map<dynamic,dynamic> maptrending;
  SingleOvRt(this.maptrending);

  @override
  Widget build(BuildContext context) {
    return maptrending.values.length!=0? ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Stack(children: [
                      Container(
                        width: 210,
                        height: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/original/' +
                                        maptrending.values
                                            .elementAt(1)[index]
                                        ['poster_path']),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        width: 210,
                        height: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(1, 1, 1, 1.0),
                                  Color.fromRGBO(
                                      173, 3, 0, 0.043137254901960784)
                                ])),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 0,
                        child: Container(
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 0, 20, 20),
                            child: Text(
                                maptrending.values
                                    .elementAt(1)[index]
                                ['name'] !=
                                    null
                                    ? maptrending.values
                                    .elementAt(1)[index]
                                ['name'] as String
                                    : maptrending.values
                                    .elementAt(1)[index]
                                ['title'] as String,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                )),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20, 0, 20, 20),
                            child: Text(
                                maptrending.values
                                    .elementAt(1)[index]
                                ['media_type']
                                    .toString() !=
                                    "tv"
                                    ? "Movie"
                                    : "Tv Series",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                )),
                          ),
                        ),
                      )
                    ]),
//SizedBox(height: 20),
// Align(
//   alignment: Alignment.topLeft,
//   child: Text(maptrending.values.elementAt(1)[index]['name'] != null? maptrending.values.elementAt(1)[index]['name'] as String : maptrending.values.elementAt(1)[index]['title'] as String , style: TextStyle(
//     color: Colors.black,letterSpacing:1,fontSize: 25,fontWeight: FontWeight.w800,
//   ),),
// ),
//SizedBox(height: 20),
//Text(maptrending.values.elementAt(1)[0]['poster_path'].toString()),

//SizedBox(height: 20),
// Text(maptrending.values.elementAt(1)[index]['overview'] as String , style: TextStyle(
//   fontSize: 17, color: Colors.blueGrey
// ),),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Container(
                          width: 160,
                          height: 260,
                          child: Text(maptrending.values.elementAt(
                              1)[index]['overview'].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis
                            ), maxLines: 16,)),
                      Container(
                        height: 50,
                        width: 160,
                        child: Text("Rating : " + maptrending.values.elementAt(
                            1)[index]['vote_average'].toStringAsFixed(1) +
                            "/10", style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w400
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            ]
        );
      },
      itemCount: maptrending.values
          .elementAt(1)
          .length,
    ) :  Container(
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
        ));
  }
}
