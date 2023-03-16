import 'package:flutter/material.dart';

class PopularPeople extends StatelessWidget {
  //const PopularPeople({Key? key}) : super(key: key);

  Map<dynamic,dynamic> people;

  PopularPeople(this.people);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: people.values.length!=0? ListView.builder (
        scrollDirection: Axis.horizontal,
        itemCount: people['results'].length,
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
                              people['results'][index]['profile_path'].toString()
                          )
                      ),
                      shape: BoxShape.circle
                  ),
                ),
                Text(people['results'][index]['name'].toString() , style: TextStyle(
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
      ) :  Container(
          width: double.infinity,
          child: Center(
            child: Expanded(child: Text("fetching data.." , style: TextStyle(
                color: Colors.red
            ),)),
          )),
    );
  }
}
