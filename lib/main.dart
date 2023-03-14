import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List trendingMovies = [];
  String apikeyb = 'dc40ae824bb7df91fbdbb520e8214268';
  String accesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYzQwYWU4MjRiYjdkZjkxZmJkYmI1MjBlODIxNDI2OCIsInN1YiI6IjY0MGU3OWY3MzIzZWJhMDBlZjYxZjcwNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.a_hxUkMzCPzqBlY_wKJJsY-L-NSqzid3WpyebcYFhvY';
  Map maptrending = Map<dynamic, dynamic>();

  Future loadmovies() async {
    TMDB tmdbwithcustomlogs = TMDB(ApiKeys(apikeyb, accesstoken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingmoveis = await tmdbwithcustomlogs.v3.trending.getTrending();
    print('tagtrending');
    print(trendingmoveis);
    setState(() {
      maptrending = trendingmoveis;
    });
  }

  @override
  void initState() {
    //maptrending = loadmovies() as Map;
    loadmovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: Icon(
              Icons.density_medium,
              color: Colors.red,
            ),
            title: Text(
              'movie UI',
              style: TextStyle(color: Colors.red),
            )),
        body:
            //maptrending.values.elementAt(1)[0]['poster_path'].toString()
            Container(
                color: Color.fromRGBO(44, 44, 44, 1.0),
                child: Column(

                  children: [
                    Container(
                      width: double.infinity,
                      color: Color.fromRGBO(44, 44, 44, 1.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: RichText(
                            text: TextSpan(
                                text: "Trending",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 37,
                                  fontWeight: FontWeight.w200,
                                  letterSpacing: 1,
                                ),
                                children: [
                              //TextSpan(text: "Trending"),
                              TextSpan(
                                  text: " Today",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ))
                            ])),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
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
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.black,
                                                Colors.transparent
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
                                  alignment : Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 160,
                                          height : 260,
                                          child: Text(maptrending.values.elementAt(1)[index]['overview'].toString() , style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis
                                          ), maxLines: 16,)),
                                      Container(
                                        height: 50,
                                        width: 160,
                                        child: Text("Rating : "+maptrending.values.elementAt(1)[index]['vote_average'].toStringAsFixed(1) + "/10" , style: TextStyle(
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
                        itemCount: maptrending.values.elementAt(1).length,
                      ),
                    ),
                  ],
                )));
  }
}
