import 'dart:convert';
import 'dart:ffi';
import 'package:movie_ui/cast_scroll.dart';
import 'package:movie_ui/headline.dart';
import 'package:movie_ui/popular_people.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import './cast_scroll.dart';


class DetailedScreen extends StatefulWidget {
  //const DetailedScreen({Key? key}) : super(key: key);

  int id;
  String accesstk;
  String name;
  String imgthumblink;
  String apikey;
  DetailedScreen(this.id,this.name,this.imgthumblink,this.apikey,this.accesstk);
  @override
  State<DetailedScreen> createState() => _DetailedScreenState(this.id,this.name,this.imgthumblink,this.apikey,this.accesstk);
}

class _DetailedScreenState extends State<DetailedScreen> {
  int id;
  String accesstk;
  String nameseries;
  String thumb;
  String apikey;
  _DetailedScreenState(this.id,this.nameseries,this.thumb,this.apikey,this.accesstk);

  late YoutubePlayerController controller;

  String linkTail = "";
  String response = '';
  List<dynamic> castList =[];

  Future getYTtail() async{
    http.Response responsee;
    http.Response castresposne;

    String url = "http://api.themoviedb.org/3/tv/$id/videos?api_key=$apikey";
    String urlforcast = "https://api.themoviedb.org/3/tv/$id/credits?api_key=$apikey&language=en-US";

    responsee = await http.get(Uri.parse(url));
    castresposne = await http.get(Uri.parse(urlforcast));

    setState(() {
      response = responsee.body;
      castList = json.decode(castresposne.body)['cast'];
      linkTail = json.decode(responsee.body)["results"][0]["key"].toString();
      controller = YoutubePlayerController(
          initialVideoId: linkTail,
          flags: YoutubePlayerFlags(
            hideThumbnail: true,
            hideControls: false,
            loop: false,
            autoPlay: false,
            mute: false,
          )
      );

    });

  }

  @override
  void initState() {
    getYTtail();
    super.initState();
  }

  void dispose(){
    controller.dispose();
    super.dispose() ;
  }

  void deactivate(){
    controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(44, 44, 44, 1.0),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // controller.value.isInitialized?
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    child: Container(

                      height: 300,
                      width: double.infinity,
                      child:
                      YoutubePlayer(
                        controller: controller,
                        showVideoProgressIndicator: false,)
                   ),
                  ),
                ),

                SizedBox(height: 20),
                Headline("",nameseries as String),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(thumb,style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text("CAST" , style: TextStyle(
                    color: Colors.red,
                    letterSpacing: 3,
                    fontSize: 20,
                    fontWeight: FontWeight.w800
                  ),),
                ),
                CastScroll(castList),
                //Text(castList.toString(),style: TextStyle(color: Colors.amber),)
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: (){
        //     setState(() {
        //       if(controller.value.isPlaying == true){
        //         controller.pause();
        //       }else{
        //         controller.play();
        //       }
        //     });
        //   },
        //   child: Icon(controller.value.isPlaying? Icons.play_arrow :Icons.pause),
        // ),
      ),
    );
  }
}
