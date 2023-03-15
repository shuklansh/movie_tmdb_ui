import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:movie_ui/popular_people.dart';
import 'package:movie_ui/top_tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'headline.dart';
import 'single_overview_rating.dart';

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
  String apikeyb = 'apikey';
  String accesstoken = 'acc token';
  Map maptrending = Map<dynamic, dynamic>();
  Map tvTrending = Map<dynamic,dynamic>();
  Map people = Map<dynamic,dynamic>();

  Future loadmovies() async {
    TMDB tmdbwithcustomlogs = TMDB(ApiKeys(apikeyb, accesstoken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingmoveis = await tmdbwithcustomlogs.v3.trending.getTrending();
    Map topTv = await tmdbwithcustomlogs.v3.tv.getTopRated();
    Map peoplePopular = await tmdbwithcustomlogs.v3.people.getPopular();
    //print('tagtrending');
    //print(trendingmoveis);
    print(peoplePopular);
    setState(() {
      people = peoplePopular;
      tvTrending = topTv;
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
      backgroundColor: Color.fromRGBO(44, 44, 44, 1.0),
        appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12)),
            ),
            leading: Icon(
              Icons.density_medium,
              color: Colors.red,
            ),
            title: Text(
              'movie UI',
              style: TextStyle(color: Colors.red , letterSpacing: 1.2),
            )),
        body:
            //maptrending.values.elementAt(1)[0]['poster_path'].toString()
            SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                        height: 450,
                        color: Color.fromRGBO(44, 44, 44, 1.0),
                        child: Column(
                          children: [
                            Headline("Trending","Today"),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                height: 380,
                                width: double.infinity,
                                child: SingleOvRt(maptrending),
                              ),
                            ),//SizedBox(height: 20)
                            //SizedBox(height: 20)
                          ],
                        ),

                    ),
                    Container(
                      height:360,
                      child: Column(
                        children: [
                          Headline("Top of","TV"),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: TopTv(tvTrending),
                            )
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Headline("Popular", "People"),
                    PopularPeople(people)
                  ],
                ),
              ),
            )
    );
  }
}
