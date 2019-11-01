import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freek/screensize_reducer.dart';

class view extends StatefulWidget
{
  final number;
  final name;
  view({Key key,
    this.number,this.name}): super (key: key);

  @override
  View createState() => View();
}
class View extends State<view>
{
  Widget _Stream(){
    return new StreamBuilder<QuerySnapshot>(
        stream:
        Firestore.instance.collection("Freg leaves hotel").snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot>snapshot) {
          if (snapshot.hasError)
          {
            return Center(
                child:Text("Error occured..")
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height:screenHeight(context,dividedBy: 1),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                ],
              );
            default:
              if(widget.number == 1 || widget.number == 5 )//accomodation
                  {
                return ListView(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  primary: false,
                  shrinkWrap: true,
                  children: buildList(snapshot.data.documents, context),
                );
              }else if (widget.number == 2|| widget.number == 3)//food
                  {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: buildGrid(snapshot.data.documents,context),
                );
              }
              else
              {
                return Card();
              }

          }
        }
    );
  }
  List<Widget> buildGrid(List<DocumentSnapshot> documents,BuildContext context)
  {
    List<Widget> _gridview = [];
    if(widget.number == 2)
    {
      for(DocumentSnapshot document in documents){
        if (document.data['ID'] == 0 ||document.data['ID'] == 1  ||  document.data['ID'] ==  2   ){
          _gridview.add(buildGridItem(document,context));
        }

      }
    }else if(widget.number == 3)
    {
      for(DocumentSnapshot document in documents){
        if (document.data['ID'] == 3 ||document.data['ID'] == 4  ||  document.data['ID'] ==  5 || document.data['ID'] == 6 || document.data['ID']== 7 ){
          _gridview.add(buildGridItem(document,context));
        }

      }
    }

    return _gridview;
  }
  //oN TAP FOR GRIDVIEW is here.
  Widget buildGridItem(DocumentSnapshot document,BuildContext context)
  {

    return new GestureDetector(
        child: new Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2.0,
          margin: const EdgeInsets.only(left: 2, right: 2, bottom: 2,top: 2),
          child: new Stack(
            children: <Widget>[
              new Hero(
                tag: document.data['url'],
                child: new FadeInImage(
                  placeholder: new AssetImage("albums/bird.jpg"),
                  image: new NetworkImage(document.data['url']),
                  fit: BoxFit.fill,
                  height: screenHeight(context,dividedBy: 3.5),
                ),
              ),
              new Align(
                child: new Container(
                  padding: const EdgeInsets.all(3.0),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          document.data['name'],
                          //  "Bird meat",
                          style:new TextStyle(color: Colors.white)
                      ),
                      new Text("\$" +'${
                          document.data['price']
                      // "200"
                      }',
                          style: new TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          )
                      ),
                    ],
                  ),
                  color: Colors.black.withOpacity(0.7),
                  width: double.infinity,
                ),
                alignment: Alignment.bottomCenter,
              )
            ],
          ),
        ),
        onTap: ()
        {

        }
    );

  }
  List<Widget> buildList(List<DocumentSnapshot> documents, BuildContext context) {
    List<Widget> _list = [];

    if(widget.number == 1)
    {
      for(DocumentSnapshot document in documents)
      {

        if(document.data['ID'] == 8)
        {
          _list.add(buildListitems(document,context));
        }
      }
    }else if(widget.number == 5)
    {
      for(DocumentSnapshot document in documents)
      {

        if(document.data['ID'] == 9)
        {
          _list.add(buildListitems(document,context));
        }
      }
    }

    return _list;
  }
  Widget buildListitems(DocumentSnapshot document, BuildContext context)
  {
    return GestureDetector
      (
      onTap: ()
      {
        //action
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        margin: EdgeInsets.only(top:05 , bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
              child: FadeInImage
                (
                placeholder: new AssetImage("album/bill.png"),
                image: NetworkImage(document.data['url']),
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(document.data['name'],
                    style: TextStyle(
                        color: Colors.cyan[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 05,right: 05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      Text(document.data['price'],
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xff25242A),
              child: Padding(
                padding: EdgeInsets.only(top: 29, bottom: 10),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          dispose();
                          Navigator.pop(context);
                        }),
                    SizedBox(width: 50),
                    Text(widget.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),
            ),
            _Stream()
          ],
        ),
      ),
    );
  }
}