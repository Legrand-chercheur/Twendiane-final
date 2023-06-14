import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'connexion_inscription.dart';



class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  State<Profil> createState() => _ProfilState();
}
  bool? repeat;
  String? nom;
  String? email;
  String? id;


class _ProfilState extends State<Profil> {
  void etat()async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
      email = prefs.getString('email');
      id = prefs.getString('id');
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    etat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/3.5,
              width: MediaQuery.of(context).size.width,
              color:Color.fromRGBO(228, 171, 34, 1),
              child: nom==null?Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Votre profil',style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Profitez des avantages du compte Twend :',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('réservation plus rapide, mise à jour en',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('temps réel voyage et bien plus',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text('encore',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>InsCon()));
                          },
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text('S\'identifier',
                                style: TextStyle(
                                  color: Color.fromRGBO(228, 171, 34, 1),
                                ),),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ):Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Salut, $nom",style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>retrouver()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20,left: 20),
                child: Container(
                  width: 1000,
                  height: 30,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.tickets_fill,color: Color.fromRGBO(66, 84, 134, 1),),
                      SizedBox(width: 10,),
                      Text('Retrouver une réservation',style: TextStyle(color: Color.fromRGBO(66, 84, 134, 1)),),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 30,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Reception()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8,left: 20),
                child: Container(
                  width: 1000,
                  height: 30,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.mail_solid,color: Color.fromRGBO(66, 84, 134, 1),),
                      SizedBox(width: 10,),
                      Text('Boite de réception',style: TextStyle(color: Color.fromRGBO(66, 84, 134, 1)),),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 30,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Parametres()));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8,left: 20),
                child: Container(
                  width: 1000,
                  height: 30,
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.settings_solid,color: Color.fromRGBO(66, 84, 134, 1),),
                      SizedBox(width: 10,),
                      Text('Paramètres',style: TextStyle(color: Color.fromRGBO(66, 84, 134, 1)),),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 30,
            ),

          ],
        ),
      ),
    );
  }
}

class retrouver extends StatefulWidget {
  const retrouver({Key? key}) : super(key: key);

  @override
  State<retrouver> createState() => _retrouverState();
}

class _retrouverState extends State<retrouver> {

  final snackBar = SnackBar(
    content: const Text('Champ vide...'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );

  final aucun = SnackBar(
    content: const Text('Aucune reservation trouvee...'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );

  void Retrouver(String num, String email)async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var reponse = await http.post(uri,body: {
      'clic':'reservation',
      'email' : num,
      'pass' : email,
    });
    if(reponse.body == "bon") {
      var res = reponse.body;
      final reservation = res.split(',');

    }if(reponse.body == "mauvais"){
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(aucun);
    }if(num.isEmpty || email.isEmpty){
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
  final email =new TextEditingController();
  final num =new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 6,top: 10),
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
                Text('Retrouvez une révervation',
                  style: TextStyle(
                      color: Color.fromRGBO(228, 171, 34, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),)
              ],
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width/1.1,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 241, 246, 1),
                  border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                child: TextField(
                  controller: num,
                  decoration: InputDecoration(
                    hintText: "Numero de réservation",
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
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width/1.1,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 241, 246, 1),
                  border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Adresse mail de révervation",
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
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Retrouver(num.text,email.text);
              },
              child: Container(
                width: MediaQuery.of(context).size.width/1.1,
                height: 60,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(228, 171, 34, 1),
                    border: Border.all(color: Color.fromRGBO(228, 171, 34, 1)),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    'Retrouver une réservation',
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


class Parametres extends StatefulWidget {
  const Parametres({Key? key}) : super(key: key);

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text('Paramètre',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifs()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child: Container(
                width: 1000,
                height: 30,
                child: Row(
                  children: [
                    SizedBox(width: 10,),
                    Text('Notifications',style: TextStyle(color: Color.fromRGBO(66, 84, 134, 1)),),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 30,
          ),
          GestureDetector(
            onTap: (){
              showDialogFunc(context, 'assets/twend.png', 'Vous aimez l\'App?', "Dites-nous ce que vous pensez et aidez-nous à améliorer Twend au quotidien.");
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8,left: 20),
              child: GestureDetector(
                onTap: (){
                  showDialogFunc(context, 'assets/twend.png', 'Vous aimez l\'App?', "Dites-nous ce que vous pensez et aidez-nous à améliorer Twend au quotidien.");
                },
                child: Container(
                  width: 1000,
                  height: 30,
                  child: GestureDetector(
                    onTap: (){
                      showDialogFunc(context, 'assets/twend.png', 'Vous aimez l\'App?', "Dites-nous ce que vous pensez et aidez-nous à améliorer Twend au quotidien.");
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Text('Notez-nous',style: TextStyle(color: Color.fromRGBO(66, 84, 134, 1)),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(
            height: 30,
          ),
        ],
      ),
    );
  }
}
showDialogFunc(context, img, title, desc) {
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
              height: 420,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 85),
                          child: Image.asset(
                            img,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 45,bottom: 100),
                          child: IconButton(
                            icon: Icon(Icons.clear,size: 20,color: Color.fromRGBO(62, 70, 120, 1),),
                            onPressed: () {
                              Navigator.pop(context);
                            },

                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // width: 200,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        desc,
                        maxLines: 3,
                        style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 400,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(228, 171, 34, 1),
                        border: Border.all(color: Color.fromRGBO(228, 171, 34, 1)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        'J\'aime !',style: TextStyle(
                          color: Colors.white
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
                        color: Colors.white,
                        border: Border.all(color: Color.fromRGBO(228, 171, 34, 1)),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        'Améliorations possibles',style: TextStyle(
                          color: Color.fromRGBO(228, 171, 34, 1)
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

class Notifs extends StatefulWidget {
  const Notifs({Key? key}) : super(key: key);

  @override
  State<Notifs> createState() => _NotifsState();
}
bool light = false;
bool light1 = false;
class _NotifsState extends State<Notifs> {
  @override
  Widget build(BuildContext context) {
    bool status = false;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
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
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Text('Notification',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Recevez des notification en temps",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Text("réel sur votre voyage",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text("Recevez des notifications en temps"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 33),
                            child: Text("réel  sur les retards et l'embarquement"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 90),
                            child: Text("directement sur votre mobile"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/ph.png")
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text("Notificaton push",
                        style: TextStyle(
                          fontSize: 20,
                        ),),
                      SizedBox(
                        width: 200,
                      ),
                      CupertinoSwitch(
                        activeColor: Color.fromRGBO(228, 171, 34, 1),
                        value: light1,
                        onChanged: (bool value){
                          setState(() {
                            light1 = value;
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Recevez des notification en temps",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100),
                            child: Text("réel sur votre voyage",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Text("Recevez des notifications en temps"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 33),
                            child: Text("réel  sur les retards et l'embarquement"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(

                          ),
                          child: Image.asset("assets/wor.png")
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text("Notificaton push",
                        style:TextStyle(
                            fontSize: 20
                        ),),
                      SizedBox(
                        width: 200,
                      ),
                      CupertinoSwitch(
                        activeColor: Color.fromRGBO(228, 171, 34, 1),
                        value: light,
                        onChanged: (bool value){
                          setState(() {
                            light = value;
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Reception extends StatefulWidget {
  const Reception({Key? key}) : super(key: key);

  @override
  State<Reception> createState() => _ReceptionState();
}

class _ReceptionState extends State<Reception> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text('Boite de reception',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 380,),
          Center(child: Text('Aucune mise a jour disponible.Veuillez verifier ulterieurement.',style: TextStyle(fontSize: 15,),))
        ],
      ),
    );
  }
}