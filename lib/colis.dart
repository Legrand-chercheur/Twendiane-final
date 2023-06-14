import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class colis extends StatefulWidget {
  const colis({Key? key}) : super(key: key);

  @override
  State<colis> createState() => _colisState();
}

class _colisState extends State<colis> {
  var selectedCurrency, selectedType;
  var select1, selectedType1;
  var select2, selectedType2;
  final type =new TextEditingController();
  final poids =new TextEditingController();
  final details =new TextEditingController();
  final expediteur =new TextEditingController();
  final n_exp =new TextEditingController();
  final n_dest =new TextEditingController();
  final List<String> element = [
    'Moto',
    'Camion',
    'Voiture',
  ];

  String? nom;
  String? email;
  String? id;


  final _formKey = GlobalKey<FormState>();
  late String selectedValue;

  final List<String> genderItems = [
    'Estuaire',
    'Haut-Ogooué',
    'Moyen-Ogooué',
    'Ngounié',
    'Ogooué-Ivindo',
    'Ogooué-Lolo',
    'Ogooué-Maritime',
    'Woleu-Ntem',
    'Nyanga'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    etat();
  }
  String valeur = 'type d\'engin';
  String valeur1 = 'Ville de depart';
  String valeur2 = 'Ville d\'Arrivee';

  void etat()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
      email = prefs.getString('email');
      id = prefs.getString('id');
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4,
                child: Stack(
                  children: [
                    Carousel(
                      images: [
                        NetworkImage(
                            'http://emploie.alwaysdata.net/Twend pub slide.jpg'),
                        NetworkImage(
                            'http://emploie.alwaysdata.net/Twend pub slide2.jpg'),
                        NetworkImage(
                            'http://emploie.alwaysdata.net/Twend pub slide3.jpg'),
                      ],
                      showIndicator: false,
                      borderRadius: false,
                      moveIndicatorFromBottom: 180.0,
                      noRadiusForIndicator: true,
                      overlayShadow: true,
                      overlayShadowColors: Colors.white,
                      overlayShadowSize: 0.7,
                    ),
                    Positioned(
                      bottom: 20,
                      child: nom == null?Text('Estimez votre colis',style: TextStyle(
                          color: Color.fromRGBO(62, 70, 120, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),):Text("$nom, Estimez votre colis",style: TextStyle(
                          color: Color.fromRGBO(62, 70, 120, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    height: 50,

                    child: TextFormField(
                      controller: type,
                      autofocus: false,

                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(241, 242, 246, 9.0),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 50, 20, 15),

                        labelText:"Type de colis" ,
                        labelStyle: TextStyle(color: Color.fromRGBO(110, 118, 146, 9.0),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,

                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(241, 242, 246, 9.0)
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        hint: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            valeur1,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        items: genderItems
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (val){
                          setState(() {
                            valeur1 = val!;
                          });
                        }),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(241, 242, 246, 9.0)
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        hint: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            valeur2,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        items: genderItems
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (val){
                          setState(() {
                            valeur2  = val!;
                          });
                        }),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(241, 242, 246, 9.0)
                    ),
                    child: DropdownButton(
                        isExpanded: true,
                        hint: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            valeur,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        items: element
                            .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (val){
                          setState(() {
                            valeur = val!;
                          });
                        }),
                  ),
                  SizedBox(width: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    height: 50,
                    child: TextFormField(
                      controller: poids,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(241, 242, 246, 9.0),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 50, 20, 15),
                        labelText:"Poids du colis:" ,
                        labelStyle: TextStyle(color:Color.fromRGBO(110, 118, 146, 9.0),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,

                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    height: 80,
                    child: TextFormField(
                      controller: details,
                      autofocus: false,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(241, 242, 246, 9.0),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 50, 20, 15),
                        labelText: "Details du colis:",
                        labelStyle: TextStyle(color:Color.fromRGBO(110, 118, 146, 9.0),),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    height: 50,
                    child: TextFormField(
                      controller: expediteur,
                      autofocus: false,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(241, 242, 246, 9.0),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 50, 20, 15),
                        labelText: "Expediteur:" ,
                        labelStyle: TextStyle(color:Color.fromRGBO(110, 118, 146, 9.0),),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    height: 50,
                    child: TextFormField(
                      controller: n_exp,
                      autofocus: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },

                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(241, 242, 246, 9.0),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 50, 20, 15),

                        labelText: "Numero_Expediteur:",
                        labelStyle: TextStyle(color: Color.fromRGBO(110, 118, 146, 9.0),),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,

                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    height: 50,
                    child: TextFormField(
                      controller: n_dest,
                      autofocus: false,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplir les champs';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(241, 242, 246, 9.0),
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 50, 20, 15),

                        labelText:"Numero_Destinataire:",
                        labelStyle: TextStyle(color: Color.fromRGBO(110, 118, 146, 9.0),),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,

                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 50,),
                  Text('NB: Le kilo est à 1000fcfa',style: TextStyle(color: Color.fromRGBO(110, 118, 146, 9.0),),)
                ],
              ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: ()async{

                },
                child: Container(
                    width: MediaQuery.of(context).size.width/1.1,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(228, 171, 34, 1),
                        border: Border.all(color:Color.fromRGBO(228, 171, 34, 1)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        'Soumettre',style: TextStyle(color: Colors.white),
                      ),
                    )
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
