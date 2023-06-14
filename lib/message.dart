import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/top_bar.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            decoration: BoxDecoration(
                color: Color.fromRGBO(228, 171, 34, 1)
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Text('Achat effectue',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/2.8,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Veuillez patienter et consulter boite mail pour avoir votre ticket.',
                style: TextStyle(fontSize: 15,),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>navigate(billet: '',arrive: '',depart: '',)), (route) => false);
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
                      'Retourner a la page d\'acceuil',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
