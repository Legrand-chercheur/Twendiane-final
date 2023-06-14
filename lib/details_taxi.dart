import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailTaxi extends StatefulWidget {
  var place;
  DetailTaxi({required this.place});

  @override
  State<DetailTaxi> createState() => _DetailTaxiState();
}
List Taximan = [];
class _DetailTaxiState extends State<DetailTaxi> {
  bool _isVisible = false;
  late int Vari=2;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

/*  void DemanderTaxi()async{

  }*/


  String? nom;
  String? email;
  String? tel;
  String? id;

  void etat()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
      email = prefs.getString('email');
      tel = prefs.getString('tel');
      id = prefs.getString('id');
      print("$nom $email $tel $id");
    });
  }
  Random random = new Random();

  late int RandomTaxi = random.nextInt(Taximan.length);

  late int IndexTaximan = Taximan.indexOf(Taximan[RandomTaxi])+1;
  void EnregistrerPosition(int place,int bagage)async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var reponse = await http.post(uri,body: {
      'clic':'parcourt',
      'id_client': id,
      'id_taximan': IndexTaximan,
      'place': place,
      'bagage':bagage
    });
    if(reponse.body == "bon"){
      print("Patienter votre taxi maintenant...");
    }else{
      print("Reesayez...");
    }
  }


  void RecuperTaximan()async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var reponse = await http.post(uri,body: {
      'clic':'taxi',
    });
    print(reponse.body);
    setState(() {
      Taximan = reponse.body.split(',');
    });
    print(RandomTaxi);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RecuperTaximan();
    etat();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 171, 34, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Container(
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(image: AssetImage('assets/t1.png')),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              SizedBox(height: 20,),
                              Container(
                                width: 290,
                                child:Text("Les Taxis partenaires Twend sont des véhiculs surs de 4 Places maximum pour 5 bagages maximum,conduits par des chauffeurs expérimentés et convivial."),
                              ),
                              Container(
                                width: 290,
                                child:Text("Disponibles à la demande pret de votre lieu de départ et d'arrivé."),
                              ),

                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 70,),
            GestureDetector(
              onTap: (){
                showToast();
              },
              child:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
                  color: Colors.white,
                ),
                height: 150,
                width: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Avec bagage(s)'),
                      Container(
                          width: 150,
                          height: 150,
                          child: Image(
                              image: AssetImage("assets/rm.png")
                          )
                      )
                    ],
                  ),
                ),
              ),

            ),
            Visibility(
                visible: _isVisible,
                child: Container(
                  height: 130,
                  width: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nombre(s) de bagage(s)'),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: (){
                                    if(Vari>=1 && Vari>=2){
                                      setState(() {
                                        Vari = Vari - 1;
                                      });
                                    }
                                    print(Vari);
                                  },
                                  icon: Icon(CupertinoIcons.minus_circled)
                              ),
                              Text('${Vari}'),
                              IconButton(
                                  onPressed: (){
                                    if(Vari<=4){
                                      setState(() {
                                        Vari = Vari + 1;
                                      });
                                    }
                                    print(Vari);
                                  },
                                  icon: Icon(CupertinoIcons.add_circled)
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap:()async{
                          showDialogFunc(context,nom!,tel!,widget.place,Vari);
                        } ,
                        child: Container(
                          width: 400,
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color.fromRGBO(228, 171, 34, 1)),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              'Valider',style: TextStyle(
                                color: Color.fromRGBO(228, 171, 34, 1)
                            ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                )
            ),
            SizedBox(height: 8,),
            GestureDetector(
              onTap: (){
                showDialogFunc(context,nom!,tel!,widget.place,0);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
                  color: Colors.white,
                ),
                height: 150,
                width: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sans bagage'),
                      Container(
                          width: 100,
                          height: 100,
                          child: Image(image: AssetImage("assets/no-bag.png")
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final position =new TextEditingController();
  final destination =new TextEditingController();



  showDialogFunc(context,String? nom, String? tel, place, bagage) {


    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(15),
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(242, 241, 246, 1),
                          border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                        child: TextField(
                          controller: position,
                          decoration: InputDecoration(
                            hintText: "Votre Position",
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(164, 167, 200, 1),
                            ),
                            focusColor: Color.fromRGBO(164, 167, 200, 1),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,

                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(242, 241, 246, 1),
                          border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                        child: TextField(
                          controller: destination,
                          decoration: InputDecoration(
                            hintText: "Votre Destination",
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(164, 167, 200, 1),
                            ),
                            focusColor: Color.fromRGBO(164, 167, 200, 1),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,

                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: ()async{
                        if(nom==null){
                          print('Connectez vous');

                          Navigator.pop(context);

                        }else {
                          print(Taximan[RandomTaxi]);
                          var url = Uri.https('clicksms.net',
                              '/sms/api');
                          var response = await http.post(url, body: {
                            'action' : 'send-sms',
                            'api_key' : 'VHdlbmRzbXM6I1R3ZW5kMjAyMg==',
                            'unicode' : '1',
                            'to' : '241${Taximan[RandomTaxi]}',
                            'from' :'twend.ga',
                            'sms' : 'Vous etes demander par $nom pour une location de '+position.text+' a '+destination.text+'\nNombre de place: '+
                                place +'\nNombre de bagage(s):'+bagage+'\nNumero de telephone du concerne: $tel'
                          });
                          if(response.statusCode == 200){
                            EnregistrerPosition(place,bagage);
                          }
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');

                          Navigator.pop(context);
                        }

                        position.text='';
                        destination.text='';

                      },
                      child: Container(
                        width: 400,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color.fromRGBO(228, 171, 34, 1)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text(
                            'Valider',style: TextStyle(
                              color: Color.fromRGBO(228, 171, 34, 1)
                          ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


