import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/pagination.dart';
import 'package:untitled1/top_bar.dart';

class Defile extends StatefulWidget {
  const Defile({Key? key}) : super(key: key);

  @override
  State<Defile> createState() => _DefileState();
}

class _DefileState extends State<Defile> {
  int indexation = 0;
  late PageController _controller;
  late SharedPreferences prefs;
  bool repeat = false;

  void start() async{
    prefs = await SharedPreferences.getInstance();
    repeat = prefs.getBool('repeat')!;
    setState(() {
    });
    if(repeat){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>navigate(billet: '1',arrive: '',depart: '',)), (route) => false);
    }
  }
  @override
  void initState() {
    _controller =PageController(initialPage: 0);
    super.initState();
    start();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(child: PageView.builder(
                controller:  _controller,
                itemCount: contents.length,
                onPageChanged: (int index){
                  setState(() {
                    indexation = index;
                  });
                },
                itemBuilder: (_,i){
                  return Column(

                    children:<Widget> [
                      Container(
                        child: Lottie.asset(contents[i].image),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Text(contents[i].title,
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Avenir-Heavy',
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(228, 171, 34, 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Text(contents[i].discription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ) ,
                        ),
                      )
                    ],
                  );
                }

            ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    contents.length,
                        (index) => buildDot(index, context)),
              ),
            ),
            Container(
              height: 55,
              margin: EdgeInsets.all(50),
              width: double.infinity,
              child: ElevatedButton(

                child: Text(indexation == contents.length - 1 ?'Continuer':'Suivant'),
                onPressed: () {
                  prefs.setBool('repeat', true);
                  if(indexation == contents.length - 1){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>navigate(billet: '1',arrive: '',depart: '',)), (route) => false);
                  }
                  _controller.nextPage(duration: Duration(
                      milliseconds: 300),
                      curve: Curves.bounceIn);
                },



              ),
            )
          ],
        )

    );
  }
  Container buildDot(int index, BuildContext context){
    return Container(
      height: 10,
      width: indexation == index ? 25: 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(228, 171, 34, 1),
      ),
    );
  }
}
