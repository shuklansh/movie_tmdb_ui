import 'package:flutter/material.dart';

class CastScroll extends StatelessWidget {
  //const PopularPeople({Key? key}) : super(key: key);

  List<dynamic> people;

  CastScroll(this.people);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder (
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: people.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 100
                  ,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage("https://www.themoviedb.org/t/p/w300_and_h450_bestv2"+
                              people[index]['profile_path'].toString()
                          )
                      ),
                      shape: BoxShape.circle
                  ),
                ),
                Text(people[index]['name'].toString() , style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                    fontSize: 18
                ),),
                // Text(people
                // ['results'][0].toString(), style: TextStyle(
                //   color: Colors.white
                // ),)
              ],
            ),
          );},
      ),
    );
  }
}
