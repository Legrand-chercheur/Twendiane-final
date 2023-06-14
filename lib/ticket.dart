import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/chercher.dart';
import 'package:untitled1/resultat.dart';
import 'package:untitled1/taxi.dart';
import 'package:untitled1/top_bar.dart';
import 'package:intl/intl.dart';

import 'arriver.dart';

class ticket extends StatefulWidget {
  var depart,arrive;
  var billet;
  ticket({required this.depart,required this.arrive,required this.billet});

  @override
  State<ticket> createState() => _ticketState();
}

class _ticketState extends State<ticket> {

  final form=new DateFormat('yyyy-MM-dd');
  DateTime? selectedDate;
  final dateinput=new TextEditingController();
  final dateinput1=new TextEditingController();
  var uidss;

  String? nom;
  String? email;
  String? id;

  @override
  void initState() {
    selectedDate=DateTime.now(); //set the initial value of text field
    super.initState();
    etat();
  }

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
    DateTime dateTime = DateTime.now();

    var VAR='Départ (Votre ville)';
    var VAR1='Arrivée (Votre destination)';

    if(dateinput.text==''){
      if(DateTime.now().month<10){
        dateinput.text=DateTime.now().year.toString()+'-0'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString();
      }else{
        dateinput.text=DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString();
      }

    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 1000,
                height: 250,
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
                        child: nom == null?Text('Ou desirez vous voyager?',style: TextStyle(
                            color: Color.fromRGBO(62, 70, 120, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),):Text("$nom, Ou desirez vous voyager?",style: TextStyle(
                            color: Color.fromRGBO(62, 70, 120, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NbBillets(dep: widget.depart,arr: widget.arrive)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NbBillets(dep: widget.depart,arr: widget.arrive,)));
                        },
                        icon: Icon(CupertinoIcons.person_2_fill,color: Color.fromRGBO(164, 167, 200, 1),),
                      ),
                      Text(widget.billet,style: TextStyle(color: Color.fromRGBO(164, 167, 200, 1),))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0,right: 20.0),
                child: Column(
                  children: [
                    Builder(
                        builder: (context) {
                          return GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>cherche(a: widget.billet,b: widget.arrive,)));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(242, 241, 246, 1),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(CupertinoIcons.smallcircle_fill_circle_fill,color: Color.fromRGBO(164, 167, 200, 1),),
                                  ),
                                  widget.depart==''?Text(
                                    'Départ (Votre ville)',
                                    style: TextStyle(
                                        color: Color.fromRGBO(164, 167, 200, 1)
                                    ),
                                  ):Text(widget.depart)
                                ],
                              ),
                            ),
                          );
                        }
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color.fromRGBO(164, 167, 200, 1)),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Builder(
                          builder: (context) {
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                    VAR = VAR1;
                                    VAR1 = VAR;
                                });
                              },
                              child: Center(
                                child: Icon(CupertinoIcons.arrow_up_arrow_down,color: Color.fromRGBO(164, 167, 200, 1),),
                              ),
                            );
                          }
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>arrive(value: widget.depart,v: widget.billet,)));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 241, 246, 1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Icon(CupertinoIcons.placemark_fill,color: Color.fromRGBO(161, 168, 196, 1),),
                              ),
                              widget.arrive==''?Text(
                                VAR1,
                                style: TextStyle(
                                    color: Color.fromRGBO(164, 167, 200, 1)
                                ),
                              ):Text(widget.arrive)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap:()async{
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2.3,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 241, 246, 1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Icon(CupertinoIcons.calendar,color: Color.fromRGBO(161, 169, 198, 1),),
                                  ),
                                  dateinput.text== ''? Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      '${DateTime.now().year}'+'-'+'${DateTime.now().month}'+'-'+'${DateTime.now().day}',
                                      style: TextStyle(
                                        color:  Color.fromRGBO(62, 70, 120, 1),
                                      ),
                                    ),
                                  ):Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text('${dateinput.text}',style: TextStyle(
                                      color:  Color.fromRGBO(62, 70, 120, 1),
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:()async{
                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput1.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2.2,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(242, 241, 246, 1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  dateinput1.text== ''?Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(CupertinoIcons.add,color: Color.fromRGBO(162, 167, 198, 1),),
                                  ):Text(''),
                                  dateinput1.text== ''? Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'Ajouter un retour',
                                      style: TextStyle(
                                        color:  Color.fromRGBO(162, 167, 198, 1),
                                      ),
                                    ),
                                  ):Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text('${dateinput1.text}',style: TextStyle(color:Color.fromRGBO(62, 70, 120, 1) ),),
                                  ),
                                  dateinput1.text!= ''?Padding(
                                    padding: const EdgeInsets.only(left: 41.0),
                                    child: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            dateinput1.text="";
                                          });
                                        },
                                        icon: Icon(
                                          Icons.clear,size: 15,
                                          color: Color.fromRGBO(62, 70, 120, 1),
                                        )
                                    ),
                                  ):Text("")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Resultat(arriver: widget.arrive, depart: widget.depart, compte: widget.billet, date_depart: dateinput.text,date_arriver: dateinput1.text,)));
                        print(widget.arrive);
                        print(widget.depart);
                        print(widget.billet);
                        print(dateinput.text);
                        print(dateinput1.text);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(228, 171, 34, 1),
                            border: Border.all(color: Color.fromRGBO(228, 171, 34, 1)),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text(
                            'Rechercher sur Twend',style: TextStyle(
                              color: Colors.white
                          ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 35,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>taxioption()));

                      },
                      child: Row(
                        children: [
                          Text(' Besion d\'un taxi?'),
                          SizedBox(width: 5,),
                          Container(
                            width: 50,
                            height: 50,
                            child: Image(image: AssetImage('assets/taxi.jpg')),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Text('Comment cela fonctionne-t-il?',
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(228, 171, 34, 1),
                    fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30,),
              Row(
                children: [
                  SizedBox(width: 20,),
                  Container(
                      height: 37,
                      width: 37,
                      decoration: BoxDecoration(
                          color: CupertinoColors.activeGreen,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(CupertinoIcons.checkmark_alt,color: Colors.white,)
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Text('Cherchez',style: TextStyle(fontSize: 17),),
                        ),
                        SizedBox(height: 10,),
                        Text('Trouvez des bus de voyage au Gabon')
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 20,),
                  CircleAvatar(
                    child: Icon(CupertinoIcons.tickets,color: Color.fromRGBO(162, 167, 198, 1)),
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 220),
                          child: Text('Comparez',style: TextStyle(fontSize: 17),),
                        ),
                        SizedBox(height: 10,),
                        Text('Choisissez le trajet le plus rapide et économique'),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text('parmi les offres de plusieurs partenaires'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  SizedBox(width: 20,),
                  CircleAvatar(
                    child: Icon(CupertinoIcons.bag_fill,color: Color.fromRGBO(162, 167, 198, 1)),
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 225),
                          child: Text('Réservez',style: TextStyle(fontSize: 17),),
                        ),
                        SizedBox(height: 10,),
                        Text('Réservez vos billets peu importe où vous soyez')
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 100,)
            ],
          ),
        )
    );
  }
}

//nombre de tickets
class NbBillets extends StatefulWidget {
  var dep,arr;
  NbBillets({required this.dep,required this.arr});

  @override
  State<NbBillets> createState() => _NbBilletsState();
}

class _NbBilletsState extends State<NbBillets> {

  late int Var=2;
  late int Var1=0;
  late int Var2=0;
  late int total=0;
  late int Compare=8;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 10,top: 10),
        child: Column(
          children: [
            SizedBox(height: 25,),
            Row(
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.multiply,color: Color.fromRGBO(162, 167, 198, 1),)
                ),
                SizedBox(width: 10,),
                Text('Sélectionner le nombre de billets',
                  style: TextStyle(
                      color: Color.fromRGBO(228, 171, 34, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),)
              ],
            ),
            Divider(),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Text('Adulte'),
                    ),
                    Text('26+ années')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 220.0),
                  child: IconButton(
                      onPressed: (){
                        if(Var>=1){
                          setState(() {
                            Var = Var - 1;
                            Compare = Compare + 1;
                          });
                        }
                        print(Var);
                      },
                      icon: Icon(CupertinoIcons.minus_circled)
                  ),
                ),
                Text('${Var}'),
                IconButton(
                    onPressed: (){
                      if(Var<=Compare){
                        setState(() {
                          Var = Var + 1;
                          Compare = Compare - 1;
                        });
                      }
                      print(Compare);
                      print(Var);
                    },
                    icon: Icon(CupertinoIcons.add_circled)
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Text('Adulte'),
                    ),
                    Text('26+ années')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 220.0),
                  child: IconButton(
                      onPressed: (){
                        if(Var1>=1){
                          setState(() {
                            Var1 = Var1 - 1;
                            Compare = Compare + 1;
                          });
                        }
                      },
                      icon: Icon(CupertinoIcons.minus_circled)
                  ),
                ),
                Text('${Var1}'),
                IconButton(
                    onPressed: (){
                      if(Var1<=Compare){
                        setState(() {
                          if(Compare>=1){
                            Var1 = Var1 + 1;
                            Compare = Compare - 1;
                          }
                        });
                        print(Compare);
                        print(Var1);
                      }
                    },
                    icon: Icon(CupertinoIcons.add_circled)
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Text('Adulte'),
                    ),
                    Text('26+ années')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 220.0),
                  child: IconButton(
                      onPressed: (){
                        if(Var2>=1){
                          setState(() {
                            Var2 = Var2 - 1;
                            Compare = Compare + 1;
                          });
                        }
                      },
                      icon: Icon(CupertinoIcons.minus_circled)
                  ),
                ),
                Text('${Var2}'),
                IconButton(
                    onPressed: (){
                      if(Var2<=Compare){
                        setState(() {
                          Var2 = Var2 + 1;
                          if(Compare>2){
                            Compare = Compare - 1;
                          }
                        });
                        print(Compare);
                        print(Var2);
                      }
                    },
                    icon: Icon(CupertinoIcons.add_circled)
                ),
              ],
            ),
            SizedBox(height: 480,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>navigate(depart: widget.dep,arrive: widget.arr, billet: total.toString(),)));
                total = Var + Var1 + Var2;
                print(total);
              },
              child: Container(
                width: 380,
                height: 60,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(228, 171, 34, 1),
                    border: Border.all(color: Color.fromRGBO(228, 171, 34, 1)),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    'Confirmer',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

//besoin dun taxi
class taxi extends StatefulWidget {
  const taxi({Key? key}) : super(key: key);

  @override
  State<taxi> createState() => _taxiState();
}

class _taxiState extends State<taxi> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
