import 'dart:convert';
import 'dart:ffi';
import 'package:movie_ui/headline.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;


class DetailedScreen extends StatefulWidget {
  //const DetailedScreen({Key? key}) : super(key: key);

  int id;
  String name;
  String imgthumblink;
  String apikey;
  DetailedScreen(this.id,this.name,this.imgthumblink,this.apikey);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState(this.id,this.name,this.imgthumblink,this.apikey);
}

class _DetailedScreenState extends State<DetailedScreen> {
  int title;
  String nameseries;
  String thumb;
  String apikey;
  _DetailedScreenState(this.title,this.nameseries,this.thumb,this.apikey);

  //late VideoPlayerController controller;
  late YoutubePlayerController controller;

  String linkTail = "";
  //String YTlink='';
  String response = '';
  Map YTlink= Map<dynamic,dynamic>();
  //String linkresponse='';

  Future getYTtail() async{
    http.Response responsee;
    String url = "http://api.themoviedb.org/3/tv/$title/videos?api_key=$apikey";
    responsee = await http.get(Uri.parse(url));

    setState(() {
      response = responsee.body;
      linkTail = json.decode(responsee.body)["results"][0]["key"].toString();

      // controller = VideoPlayerController.network("https://www.youtube.com/watch?v=$linkTail")
      //   ..initialize().then((_) {
      //     setState(() {});
      //   });

      controller = YoutubePlayerController(
          initialVideoId: linkTail,
          flags: YoutubePlayerFlags(
            hideThumbnail: true,
            hideControls: false,
            loop: false,
            autoPlay: false,
            mute: false,
          )
        // flags: YoutubePlayerFlags(
        //   autoPlay: false,
        //   mute: false,
        //   forceHD: false,
        // ),
      );
      print(response);
      print(linkTail);
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
                        showVideoProgressIndicator: false,)),
                  ),
                ),
                    // thumbnail: Container(
                    //   width: double.infinity,
                    // height: double.infinity,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: NetworkImage("https://www.themoviedb.org/t/p/original"+thumb)
                    //   )
                    // ),
                  //   ),
                  // ),),
                SizedBox(height: 20),
                Headline(nameseries as String,''),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(thumb,style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),),
                )
                //Text(json.decode(response)["results"][0]["key"].toString())
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              if(controller.value.isPlaying == true){
                controller.pause();
              }else{
                controller.play();
              }
            });
          },
          child: Icon(controller.value.isPlaying? Icons.play_arrow :Icons.pause),
        ),
      ),
    );
  }
}
