import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/top_bar.dart';
import 'main.dart';

class InsCon extends StatefulWidget {
  const InsCon({Key? key}) : super(key: key);

  @override
  State<InsCon> createState() => _InsConState();
}
final email =new TextEditingController();
final pass =new TextEditingController();

class _InsConState extends State<InsCon> {

  final snackBar1 = SnackBar(
    content: const Text('Le mot de passe fourni est trop faible'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );
  final snackBar = SnackBar(
    content: const Text('Un compte exciste déjà avec cette email.'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );

  final mauvais = SnackBar(
    content: const Text('Ce compte n\'existe pas'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );

  void Connexions(String name, String code)async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var reponse = await http.post(uri,body: {
      'clic':'con',
      'email' : name,
      'mdp' : code,
    });
    print(reponse.body);
    if(reponse.body != "mauvais"){
      var connecter = reponse.body;
      final compte = connecter.split(',');
      final SharedPreferences sauvegarde = await SharedPreferences.getInstance();
      sauvegarde.setString('id', compte[0]);
      sauvegarde.setString('nom', compte[1]);
      sauvegarde.setString('prenom', compte[2]);
      sauvegarde.setString('email', compte[3]);
      sauvegarde.setString('tel', compte[4]);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>navigate(billet: '',arrive: '',depart: '',)), (route) => false);
    }if(code.length<=5){
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar1);
    }
    if(reponse.body == "mauvais"){
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(mauvais);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3,
              decoration: BoxDecoration(
                color: Color.fromRGBO(228, 171, 34, 1),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.multiply,color: Colors.white,)
                      ),
                      SizedBox(width: 85,),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/twend.png')
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('Vivez pleinement l\'expérience Twend',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Profitez de réservations et de remborsements',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text('plus rapides, ainsi que de réductions grace à notre',
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  Text('programme de parrainage',
                    style: TextStyle(
                      color: Colors.white,
                    ),)
                ],
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
                  readOnly: false,
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Votre adresse email",
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
                  controller: pass,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Votre mot de passe",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(164, 167, 200, 1),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {

                      },
                      icon: Icon(CupertinoIcons.eye_fill),
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
                Connexions(
                    email.text,
                    pass.text
                );
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
                    'Se connecter',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NouveauPass()));
              },
              child: Text('Réinitialiser le mot de passe',
                style: TextStyle(
                    color: Color.fromRGBO(228, 171, 34, 1),
                    fontSize: 15
                ),
              ),
            ),
            SizedBox(height: 30,),
            Text('Vous n\'avez pas de compte?' ,
              style: TextStyle(
                  fontSize: 15,
                  color:Color.fromRGBO(66, 84, 134, 1)
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Connexion()));
              },
              child: Text('Créer un compte',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(228, 171, 34, 1),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  State<Connexion> createState() => _ConnexionState();
}
final mailer =new TextEditingController();
final password =new TextEditingController();
final nom =new TextEditingController();
final prenom =new TextEditingController();
final tel =new TextEditingController();
bool obscur = true;


class _ConnexionState extends State<Connexion> {

  void Inscription()async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var response = await http.post(uri,body: {
      'clic':'ins',
      'nom' : nom.text,
      'prenom' :prenom.text,
      'email' : mailer.text,
      'mdp' : password.text,
      'tel' : tel.text
    });
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200){
      if(response.body == 'bon'){
        Navigator.pop(context);
      }
      if(response.body == 'existe'){
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      if(response.body == 'mauvais'){
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(non);
      }
    }else{
      print('probleme de requete');
    }
    if(response.body==""){
      print('le code est bete');
    }
    if(password.text.length <= 5){
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar1);
    }
  }

  final snackBar1 = SnackBar(
    content: const Text('Le mot de passe fourni est trop faible'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );
  final snackBar = SnackBar(
    content: const Text('Un compte exciste déjà avec cette email.'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );
  final non = SnackBar(
    content: const Text('Echec de l\'inscription'),
    action: SnackBarAction(
      label: 'Re-essayez',
      onPressed: () {

      },
    ),
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 1000,
              height: MediaQuery.of(context).size.height/4,
              decoration: BoxDecoration(
                color: Color.fromRGBO(228, 171, 34, 1),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.back,color: Colors.white,)
                      ),
                      SizedBox(width: 85,),
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/twend.png')
                      ),
                      SizedBox(width: 85,),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: IconButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                            },
                            icon: Icon(CupertinoIcons.multiply,color: Colors.white,)
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('Vivez pleinement l\'expérience Twend',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Profitez de réservations et de remborsements',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text('plus rapides, ainsi que de réductions grace à notre',
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  Text('programme de parrainage',
                    style: TextStyle(
                      color: Colors.white,
                    ),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2.5,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 241, 246, 1),
                      border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                    child: TextField(
                      controller: prenom,
                      decoration: InputDecoration(
                        hintText: "Prenom",
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
                SizedBox(width: 15,),
                Container(
                  width: MediaQuery.of(context).size.width/2.5,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 241, 246, 1),
                      border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                    child: TextField(
                      controller: nom,
                      decoration: InputDecoration(
                        hintText: "Nom",
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
              ],
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width/1.22,
              height: 60,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 241, 246, 1),
                  border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                child: TextField(
                  controller: mailer,
                  decoration: InputDecoration(
                    hintText: "Votre adresse email",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2.5,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 241, 246, 1),
                      border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                    child: TextField(
                      controller: tel,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Téléphone",
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
                SizedBox(width: 15,),
                Container(
                  width: MediaQuery.of(context).size.width/2.5,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(242, 241, 246, 1),
                      border: Border.all(color: Color.fromRGBO(97, 105, 147, 0), ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
                    child: TextField(
                      obscureText: obscur,
                      controller: password,
                      decoration: InputDecoration(
                          hintText: "Votre mot de passe",
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(164, 167, 200, 1),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                if(obscur=true){
                                  setState(() {
                                    obscur = false;
                                  });
                                }

                              });
                              setState(() {
                                if(obscur=false){
                                  obscur = true;
                                }
                              });
                            },
                            icon: Icon(CupertinoIcons.eye_fill),
                          ),
                          focusColor: Color.fromRGBO(164, 167, 200, 1),
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none

                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Inscription();
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
                    'Créer un compte',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: Text('En créant votre compte vous acceptez nos' ,
                style: TextStyle(
                    fontSize: 15,
                    color:Color.fromRGBO(66, 84, 134, 1)
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 15,),
                Text('conditions d\'utilisation',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(228, 171, 34, 1),
                  ),
                ),
                SizedBox(width: 3,),
                Text('et notre' ,
                  style: TextStyle(
                      fontSize: 15,
                      color:Color.fromRGBO(66, 84, 134, 1)
                  ),
                ),
                SizedBox(width: 3,),
                Text('politique de confidentialité',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(228, 171, 34, 1),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


class NouveauPass extends StatefulWidget {
  const NouveauPass({Key? key}) : super(key: key);

  @override
  State<NouveauPass> createState() => _NouveauPassState();
}

final _email =new TextEditingController();
class _NouveauPassState extends State<NouveauPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              decoration: BoxDecoration(
                color: Color.fromRGBO(228, 171, 34, 1),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.multiply,color: Colors.white,)
                      ),
                      SizedBox(width: 85,),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/twend.png')
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('Vivez pleinement l\'expérience Twend',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text('Profitez de réservations et de remborsements',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text('plus rapides, ainsi que de réductions grace à notre',
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  Text('programme de parrainage',
                    style: TextStyle(
                      color: Colors.white,
                    ),)
                ],
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
                  controller: _email,
                  readOnly: false,
                  decoration: InputDecoration(
                    hintText: "Votre adresse email",
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
              onTap: ()async{
                Navigator.of(context).pop();
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
                    'Valider',
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
