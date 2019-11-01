import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class home extends StatefulWidget
{
  @override
  HOME  createState()=> HOME();
}
List<StaggeredTile> _staggeredTile = const <StaggeredTile>[

  const StaggeredTile.count(4,2),
  const StaggeredTile.count(2,2),
  const StaggeredTile.count(2,3),
  const StaggeredTile.count(2,3),
  const StaggeredTile.count(2,2)
];
class HOME extends State<home>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color(0xff25242A) ,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.add_alert,color: Colors.white,), onPressed: (){

          })
        ],
        centerTitle: true,
        title: Text("Freg Hotel",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        //color: Color(0xff25242A),
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xff25242A),
              child: Padding(padding: const EdgeInsets.only(top: 04),
                child: new StaggeredGridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  staggeredTiles: _staggeredTile,
                  children: <Widget>
                  [
                    _Example0Tile(Color(0xff65DBB7),Icons.receipt,"Mpesa Receipts",context),
                    _Example0Tile(Color(0xff799FEB),Icons.add_box,"Add Item",context),
                    _Example0Tile(Color(0xffE35672),Icons.move_to_inbox,"Change Item",context),
                    _Example0Tile(Color(0xff967AEC),Icons.bubble_chart,"Statistics",context),
                    _Example0Tile(Color(0xffE89C5B),Icons.hotel,"Accomodation status",context)
                  ],
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  padding: const EdgeInsets.all(4.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _Example0Tile (Color background, IconData icondata, String text, BuildContext context)
{
  return new Card(
    color: background,
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 2.0,
    child: new InkWell(
      onTap: ()
      {
        //next navigation
      },
      child: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 03,left: 03,right: 03),
            child: Align(
              alignment: Alignment.topLeft,
              child: Icon(icondata,color: Colors.white,),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 03,left: 03,right: 03),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(text,style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),),
            ),
          )
        ],
      ),
    ),
  );
}