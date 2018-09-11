import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs:[
                new Tab(text: 'Input Words'),
                new Tab(text: 'Show Random'),
              ]
            ),
            title: new Text('Random Words Generator'),
          ),
          body: new TabBarView(
            children: [
              new InputWords(),
              new DrawRandom(),
            ],
            ),
            ),
      ),
    );
  }
  // This widget is the root of your application.
  
}

class DrawRandom extends StatefulWidget{
 
  _DrawRandomState createState()=>new _DrawRandomState();
 }

  class _DrawRandomState extends State<DrawRandom>{

  final List<TextItem> _items=generateRandomData();
  String _drawnString="";
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        body:new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "${_drawnString}",
                textScaleFactor: 2.5,
              ),
            ],
        ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () =>_drawRandom(),
                    tooltip:'Draw',
                    child:new Icon(Icons.center_focus_strong),
                  ),
                );
              }
            
              static List<TextItem> generateRandomData() {
                List<TextItem> items=<TextItem>[];
                items.add(new TextItem(text:"text",isDrawn:false));
                items.add(new TextItem(text:"Hi",isDrawn:false));
                items.add(new TextItem(text:"Hello",isDrawn:false));
                items.add(new TextItem(text:"Bye",isDrawn:false));
                items.add(new TextItem(text:"Next",isDrawn:false));
                items.add(new TextItem(text:"Previous",isDrawn:false));
                return items;
              }
          
            void _drawRandom() {
                TextItem _item=(_items.where((x)=>!x.isDrawn).toList()..shuffle()).first;
                int index=_items.indexOf(_item);
                _item.isDrawn=true;
                _drawnString=_item.text;
                _items[index]=_item;
                setState((){
                    _drawnString=_item.text;
                });
            }

}


class InputWords extends StatefulWidget{
 
_InputWordsState createState() => new _InputWordsState();
}

class _InputWordsState extends State<InputWords>{
  
  final List<TextItem> _messages = <TextItem>[];
  final inputController = new TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     //new Scaffold(
      return new Column(
        children:<Widget>[
          new Flexible(
            child:new ListView.builder(
              padding:new EdgeInsets.all(8.0),
              itemBuilder: (_,int index)=>_messages[index],
              itemCount:_messages.length,
            ),
          ),
          new Divider(height:1.0),
          new Container(
            decoration: new BoxDecoration(
              color:Theme.of(context).cardColor),
              child:_buildTextComposer()
          ),
        ]
      );
    //);
  }

  @override
  Widget _buildTextComposer() {
  return new IconTheme(                                            //new
    data: new IconThemeData(color: Theme.of(context).accentColor), //new
    child: new Container(                                     //modified
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: inputController,
              onSubmitted: _handleSubmitted,
              decoration: new InputDecoration.collapsed(
                hintText: "Send a message"),
            ),
          ),
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(Icons.send),
              onPressed: () => _handleSubmitted(inputController.text)),
          ),
        ],
      ),
    ),                                                             //new
  );
}

  void _handleSubmitted(String text) {
    inputController.clear();
    TextItem item=new TextItem(
      text:text,
      isDrawn:false
      );
    
    setState((){
      _messages.insert(0, item);
    });
}

}

class TextItem extends StatelessWidget{
  
  TextItem({this.text,this.isDrawn});
  final String text;
  bool isDrawn;
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical:10.0),
      child: new Text(text,
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ),
      );
  }
  
} 