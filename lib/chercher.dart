import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/top_bar.dart';

class cherche extends StatefulWidget {

  String a,b;


  cherche({required this.a,required this.b});
  @override
  State<cherche> createState() => _chercheState();
}
String name="";

class _chercheState extends State<cherche> {
  String? value;
  Future Ville()async{
    final uri =
    Uri.parse('https://twend.alwaysdata.net/controller_api.php');
    var reponse = await http.post(uri,body: {
      'clic':'ville',
    });
    setState(() {
      if(reponse.body!= ""){
        value = reponse.body;
      }
    });
    print(json.decode(reponse.body));
    return json.decode(reponse.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ville();
  }
  @override
  Widget build(BuildContext context) {
    List? listes;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          Row(
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.multiply,color: Color.fromRGBO(162, 167, 198, 1),)
              ),
              SizedBox(width: 10,),
              Text('Départ',
                style: TextStyle(
                    color: Color.fromRGBO(228, 171, 34, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),)
            ],
          ),
          SizedBox(height: 20,),

          Container(
            width: 400,
            height: 60,
            decoration: BoxDecoration(
                color: Color.fromRGBO(242, 241, 246, 1),
                border: Border.all(color: Color.fromRGBO(97, 105, 147, 1), ),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 20,top: 4),
              child: TextField(

                decoration: InputDecoration(
                  icon: Icon(CupertinoIcons.smallcircle_fill_circle_fill,color: Color.fromRGBO(164, 167, 200, 1),),
                  hintText: "Ville ou Gare",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(164, 167, 200, 1),
                  ),
                  focusColor: Color.fromRGBO(164, 167, 200, 1),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,

                ),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
            child: FutureBuilder(
                future: Ville(),
                builder: (context,snapshot){
                  listes = snapshot.data;
                  if(listes != null){
                    return ListView.builder(
                        itemCount: listes!.length,
                        itemBuilder: (context, element){
                          if(listes![element]['name'].toString().toLowerCase().startsWith(name.toLowerCase())){
                            return ListTile(
                              title: GestureDetector(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => navigate(depart:listes![element]['name'], arrive: widget.b, billet: widget.a,)));
                                },
                                child: Row(
                                  children: [
                                    Icon(CupertinoIcons.placemark_fill,color: Color.fromRGBO(161, 168, 196, 1),),
                                    Text(
                                      listes![element]['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              selected: true,


                            );
                          }
                          return Container();
                        });
                  }else {
                    return Center(child: CircularProgressIndicator(
                      color: Color.fromRGBO(228, 171, 34, 1),));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
