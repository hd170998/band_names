import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands =[
    Band(id: '1',name: 'Breaking Benjamin',vote: 0),
    Band(id: '2',name: 'Sum41',vote: 2),
    Band(id: '3',name: 'Hooksbank',vote: 2),
    Band(id: '4',name: 'Thousand Foot Krutch',vote: 1),
    Band(id: '5',name: 'Three days Grace',vote: 5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombres de bandas',style: TextStyle(color: Colors.black87),),
        backgroundColor:  Colors.white,
      ),
      body: ListView.builder(itemCount: bands.length,itemBuilder: (context, index) {
        return _bandTile(bands[index]);
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBand,
        elevation: 1 ,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band,) {
    return Dismissible(
      
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.redAccent,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete,color: Colors.white,),
        ),
      ),
      onDismissed: (direction){bands.removeAt(bands.indexOf(band.id));},
      child: ListTile(

          leading: CircleAvatar(child: Text(band.name[0]),backgroundColor: Colors.blue[100],),
        title: Text(band.name),
        trailing: Text('${band.vote}',style: TextStyle(fontSize: 20),),
        ),
    );
  }
  _addNewBand() {
    final textController = new TextEditingController();
    if(Platform.isAndroid){
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('New band name:'),
          content: TextField(controller: textController,),
          actions: <Widget>[
            MaterialButton(
              onPressed: ()=>addBandToList(textController.text),
              elevation: 5,
              child: Text('Add'),
              textColor: Colors.blue,
            ),
          ],);
      });
    }else{
      showCupertinoDialog(
        context: context,
        builder: (_){
          return CupertinoAlertDialog(
            title: Text('New band Name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: ()=>addBandToList(textController.text),
                isDefaultAction: true,
                child: Text('Add'),
              ),
              CupertinoDialogAction(
                onPressed: ()=>Navigator.pop(context),
                isDestructiveAction: true,
                child: Text('Cancel'),
              ),
            ],
          );
        }
      );
    }

  }
  void addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add(new Band(id: DateTime.now().toString(),name: name,vote: 0));
    }
    setState(() {});
    Navigator.pop(context);

  }
}