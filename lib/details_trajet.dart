import 'dart:math';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/connexion_inscription.dart';
import 'package:untitled1/message.dart';

class detail extends StatefulWidget {

  var place;
  var Plus;
  detail({required this.Plus, required this.place});

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  final String title="Ticket E-twend";
  double taille = 800;
  double taille1 = 500.0;

  String? nom;
  String? email;
  String? tel;
  String? id;

  void etat()async{
    final prefs = await SharedPreferences.getInstance();
    nom = prefs.getString('nom');
    email = prefs.getString('email');
    tel = prefs.getString('tel');
    id = prefs.getString('id');
  }
  var PrixUnit=0;
  var Nb_place=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    etat();
  }
  @override
  Widget build(BuildContext context) {
    PrixUnit = int.parse(widget.Plus['prix']);
    Nb_place = int.parse(widget.place);

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.grey[200],
            body: Container(
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 1000,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(228, 171, 34, 1)
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.back,color: Colors.white,),
                        ),
                        SizedBox(width: 130,),
                        Column(
                          children: [
                            SizedBox(height: 30,),
                            Text(widget.Plus['depart']+' - '+widget.Plus['arrive'],
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                            Text(widget.Plus['date_depart'],
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
                    width: MediaQuery.of(context).size.width/1.1,
                    height: MediaQuery.of(context).size.height/3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.bus),
                              Text('ALLER CHOISI')
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(widget.Plus['date_depart']+'.       ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Text(widget.Plus['heure_depart']+' - '+widget.Plus['heure_arrive']),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                  width:70,
                                  child: Image.network('https://twend.alwaysdata.net/'+widget.Plus['image'])
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.Plus['heure_depart']),
                            ),
                            Icon(CupertinoIcons.bus),
                            Text(widget.Plus['depart']+" (Aller)"),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 233),
                          child: Text('|',
                            style: TextStyle(
                                fontSize: 25
                            ),),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.Plus['heure_arrive']),
                            ),
                            Icon(CupertinoIcons.placemark_fill,color: Colors.redAccent,),
                            Text(widget.Plus['arrive']+" (Retour)"),
                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.1,
                      height: MediaQuery.of(context).size.height/4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: nom == null ?Column(
                          children: [
                            Lottie.asset('assets/bus.json',height: MediaQuery.of(context).size.height/5,width: MediaQuery.of(context).size.width/1.1),
                            Text("Veuillez vous connecter svp",style: TextStyle(
                              fontSize: 20,
                            ),),
                          ],
                        ):Image(image: AssetImage('assets/TwendApp.png')),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/5.3,
                    child: Carousel(
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
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/12,
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    child: GestureDetector(
                      onTap: (){
                        if(tel == null){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>InsCon()));
                        }else{
                          if(tel?.contains('07') == true){
                            Paiement("AM","077499109");
                          }else{
                            Paiement("MC","065478226");
                          }
                        }

                      },
                      child: Center(
                        child: Container(
                          width: 400,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(228, 171, 34, 1),
                              border: Border.all(color: Color.fromRGBO(228, 171, 34, 1)),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              'Confirmer '+'${PrixUnit*Nb_place}'+'Fcfa',style: TextStyle(
                                color: Colors.white
                            ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );

  }
  final snackBar = SnackBar(
    content: const Text('Un ecompte exciste déjà avec cette email.'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );
  void Paiement(String mode,String marchand)async{
    var url = Uri.https('www.mypvit.com',
        '/pvit-secure-full-api.kk');
    var response = await http.post(url, body: {
      'tel marchand': marchand,
      'montant': '${PrixUnit*Nb_place}',
      'ref': getRandomString(10),
      'tel client': tel,
      'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.TWNMQk8xT0FiZjk5SXBrYmxscVNncXlFWU9GU3NWM0tJa0Z4YVZhVG00Ynd2YXAvWGFsQ0NjRVdKYXRVVXlmZmU5eGJmUlFDdit0U2FQeXlJbmdVU1lmSUlxem5XSTQyVEx6TEFvaTd1aXpWZStBeGdPWVRXbjYyR0t1THRnVzFBT0pPUkVmMWVSNzE5cEJyL3RXRTIzUGtHN2NyQmMwSThYQ2x0SWpMZW9VajcvZFhBaytkekszVmdOVmxmVm5NQzFIUk1WaEFMNmMrN0U4aCtMckRCNVl2VjFzbUVTOHZ4bnh2dWVsMG4zRkUvYlRMaVUvc2N3K1B4S1lRUUt0Mzo6UzVYSXJyaTAvM3UybWZUMk9oNWZKdz09.1HskF+PR96h/XaKlvwVJLNlaMyQ6zRA5OtGUIJ/CkTc=',
      'action': '1',
      'service': 'REST',
      'operateur': mode,
      'agent': 'caisse3',
    });
    print(PrixUnit);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode==200){
      AcheterTicket();
    }
  }
  void AcheterTicket()async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var response = await http.post(uri,body: {
      'clic':'reserver',
      'id_client' : id,
      'nombre_place' :widget.place,
      'total' : '${PrixUnit*Nb_place}',
      'id_trajet' : widget.Plus['id'],
    });
    print(response.body+' ${PrixUnit*Nb_place}'+widget.place);
    print(response.statusCode);
    if(response.statusCode == 200){
      if(response.body == 'bon'){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=>Email()));
      }
      if(response.body == 'mauvais'){
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }else{
      print('probleme de requete');
    }
    if(response.body==""){
      print('le code est bete');
    }
  }

}
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

