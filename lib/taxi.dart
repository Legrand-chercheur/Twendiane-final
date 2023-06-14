import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details_taxi.dart';



class taxioption extends StatefulWidget {
  const taxioption({Key? key}) : super(key: key);

  @override
  State<taxioption> createState() => _taxioptionState();
}

class _taxioptionState extends State<taxioption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 171, 34, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
                width: MediaQuery.of(context).size.width/3,
                height: MediaQuery.of(context).size.height/12,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage('assets/t.png'),
                      fit: BoxFit.fill,
                    )
                )
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailTaxi(place: 1,)));

              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100)
                  ),
                  color: Colors.white,
                ),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Une personne'),
                      Container(
                          width: 100,
                          height: 100,
                          child: Image(
                              image: AssetImage("assets/siege.png")
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailTaxi(place: 2,)));
              },
              child: Container(
                color: Colors.white,
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Deux personnes'),
                      Padding(
                        padding: const EdgeInsets.only(left: 120),
                        child: Container(
                            width: 100,
                            height: 100,
                            child: Image(
                                image: AssetImage("assets/siege.png")
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailTaxi(place: 3,)));
              },
              child: Container(
                color: Colors.white,
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trois personnes'),
                      Container(
                          width: 100,
                          height: 100,
                          child: Image(image: AssetImage("assets/siege.png")
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailTaxi(place: 4,)));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
                  color: Colors.white,
                ),
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Quatre personnes'),
                      Container(
                          width: 100,
                          height: 100,
                          child: Image(image: AssetImage("assets/siege.png")
                          )
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
