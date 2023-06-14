import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'details_trajet.dart';


class Resultat extends StatefulWidget {
  var compte,depart,arriver,date_depart,date_arriver;
  Resultat({required this.compte, required this.depart, required this.arriver, required this.date_depart, required this.date_arriver});

  @override
  State<Resultat> createState() => _ResultatState();
}
var essaie;
class _ResultatState extends State<Resultat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    affiche1();
    affiche2();
  }
  String verifier = 'bon';
  Future affiche1()async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var response = await http.post(uri,body: {
      'clic' :'affiche1',
      'depart' : widget.depart,
      'arriver' :widget.arriver,
      'date_depart' : widget.date_depart,
      'date_arriver' : widget.date_arriver,
    });
    if(response.body == "mauvais"){
      setState(() {
        verifier = response.body;
      });
    }
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future affiche2()async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var response = await http.post(uri,body: {
      'clic' :'affiche2',
      'depart' : widget.depart,
      'arriver' :widget.arriver,
      'date_depart' : widget.date_depart,
    });
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body:verifier == "bon"?FutureBuilder(
            future: widget.date_arriver==""? affiche1():affiche2(),
            builder: (context,snapshot){
              List? listes = snapshot.data;
              if(listes != null) {
                return Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(228, 171, 34, 1)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                CupertinoIcons.back, color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 70,),
                          Column(
                            children: [
                              SizedBox(height: 30,),
                              widget.date_arriver == "" ? Text(widget.depart,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ) : Text(widget.depart + ' - ' + widget.arriver,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                              Text(widget.date_depart,
                                style: TextStyle(
                                    color: Colors.white54
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.1,
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 70,),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        print(widget.arriver);
                        print(widget.depart);
                        print(widget.compte);
                        print(widget.date_depart);
                        print(widget.date_arriver);
                        print(essaie);
                      },

                      child: Container(
                        height: 60,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 1.1,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(230, 254, 246, 1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color.fromRGBO(105, 205, 177, 1))
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.qr_code,
                                color: Color.fromRGBO(105, 205, 177, 1)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Les e-billets sont proposées pour les voyages',
                                    style: TextStyle(
                                        color: Color.fromRGBO(105, 205, 177, 1)
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 128.0),
                                    child: Text('marqués par cette icones',
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              105, 205, 177, 1)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: listes.length,
                          itemBuilder: (context, element) {
                            var one = int.parse(widget.compte);
                            if (listes != null) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          detail(Plus: listes[element],
                                            place: widget.compte,)));
                                },
                                child: Container(
                                  child: Column(
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width / 1.1,
                                          height: 180,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius
                                                  .circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 01),
                                                    color: Colors.grey,
                                                    blurRadius: 5
                                                )
                                              ]
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(bottom: 5,
                                                        right: 140,
                                                        top: 10),
                                                    child: Container(
                                                      child: Image(
                                                          image: NetworkImage(
                                                              'https://twend.alwaysdata.net/' +
                                                                  listes[element]['image'])
                                                      ),
                                                      width: 60,
                                                      height: 30,
                                                    ),
                                                  ),
                                                  SizedBox(height: 30,),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(right: 50),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10,),
                                                        Text(
                                                          listes[element]['heure_depart'] +
                                                              ' ',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Color
                                                                .fromRGBO(228,
                                                                171, 34, 1),
                                                            fontWeight: FontWeight
                                                                .bold,
                                                          ),
                                                        ),
                                                        Text('---3h20mn---',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            color: Color
                                                                .fromRGBO(164,
                                                                167, 200, 1),
                                                          ),
                                                        ),
                                                        widget.date_arriver !=
                                                            "" ? Text('' +
                                                            listes[element]['heure_arrive'],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Color
                                                                .fromRGBO(
                                                                228, 171, 34,
                                                                1),
                                                            fontWeight: FontWeight
                                                                .bold,
                                                          ),
                                                        ) : Text(''),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(right: 0),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(right: 60),
                                                          child: Text(
                                                            listes[element]['depart'],
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  65, 83, 132,
                                                                  1),
                                                            ),
                                                          ),
                                                        ),
                                                        widget.date_arriver !=
                                                            "" ? Padding(
                                                          padding: const EdgeInsets
                                                              .only(right: 40),
                                                          child: Text(
                                                            listes[element]['arrive'],
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  65, 83, 132,
                                                                  1),
                                                            ),
                                                          ),
                                                        ) : Text(''),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 110, top: 10),
                                                        child: Icon(
                                                            Icons.qr_code,
                                                            color: Color
                                                                .fromRGBO(
                                                                105, 205, 177,
                                                                1)
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            left: 30, top: 90),
                                                        child: Container(
                                                          width: 120,
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Text('${int.parse(
                                                                  listes[element]['prix']) *
                                                                  one}' +
                                                                  'Fcfa',
                                                                style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                      228, 171,
                                                                      34, 1),
                                                                  fontWeight: FontWeight
                                                                      .bold,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    CupertinoIcons
                                                                        .person_2_fill,
                                                                    size: 17,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                        65, 83,
                                                                        132, 1),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 3,),
                                                                  Text(widget
                                                                      .compte,
                                                                    style: TextStyle(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                          65,
                                                                          83,
                                                                          132,
                                                                          1),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    ' Aller simple',
                                                                    style: TextStyle(
                                                                      color: Color
                                                                          .fromRGBO(
                                                                          65,
                                                                          83,
                                                                          132,
                                                                          1),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator(
                                color: Color.fromRGBO(228, 171, 34, 1),));
                            }
                          }),
                    )
                  ],
                );
              }else{
                return Center(child: CircularProgressIndicator(
                  color: Color.fromRGBO(228, 171, 34, 1),));
              }
            }):Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(228, 171, 34, 1)
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.back,color: Colors.white,),
                        ),
                      ),
                      SizedBox(width: 70,),
                      Column(
                        children: [
                          SizedBox(height: 30,),
                          widget.date_arriver==""?Text(widget.depart,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ):Text(widget.depart+' - '+widget.arriver,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                          Text(widget.date_depart,
                            style: TextStyle(
                                color: Colors.white54
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 1000,
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 70,),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap:(){
                    print(widget.arriver);
                    print(widget.depart);
                    print(widget.compte);
                    print(widget.date_depart);
                    print(widget.date_arriver);
                    print(essaie);
                  },

                  child: Container(
                    height: 60,
                    width: 390,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(230, 254, 246, 1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color.fromRGBO(105, 205, 177, 1))
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.qr_code,
                            color: Color.fromRGBO(105, 205, 177, 1)
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Les e-billets sont proposées pour les voyages',
                                style:TextStyle(
                                    color: Color.fromRGBO(105, 205, 177, 1)
                                ) ,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 128.0),
                                child: Text('marqués par cette icones',
                                  style:TextStyle(
                                      color: Color.fromRGBO(105, 205, 177, 1)
                                  ) ,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100,),
                Container(
                  width: 300,
                    height: 300,
                    child: Lottie.asset('assets/rien.json')
                ),
                Container(
                  child: Text('Aucun trajet disponible',style: TextStyle(
                    fontSize: 17
                  ),),
      ),
              ],
            ),
    );
  }
}
