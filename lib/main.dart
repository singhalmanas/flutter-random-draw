import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

final key=new GlobalKey<_InputWordsState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Draw Random Items',
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
              new InputWords(key:key),
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
  DrawRandom(){
  }
  _DrawRandomState createState()=>new _DrawRandomState();
 }

  class _DrawRandomState extends State<DrawRandom>{

  String _drawnString="";
  bool isButtonEnabled=true;
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
          onPressed: !isButtonEnabled?null: () =>_drawRandom(),
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
                List<TextItem> _items=key.currentState.messages;
                TextItem _item=(_items.where((x)=>!x.isDrawn).toList()..shuffle()).first;
                int index=_items.indexOf(_item);
                _item.isDrawn=true;
                _drawnString=_item.text;
                _items[index]=_item;
                setState((){
                    _drawnString=_item.text;
                    isButtonEnabled=_items.where((x)=>!x.isDrawn).toList().length>0?true:false;
                });
            }
}


class InputWords extends StatefulWidget{
 
 InputWords({Key key}):super(key:key);
_InputWordsState createState() => new _InputWordsState();
}

class _InputWordsState extends State<InputWords>{
  
  final List<TextItem> _messages = <TextItem>[];
  List<TextItem> get messages =>_messages;
  final inputController = new TextEditingController();

  void removeItem(String text){
    setState((){
      _messages.removeWhere((item)=>item.text==text);
    }); 
  }
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
              //onTap: ()=>   FocusScope.of(context).requestFocus(new FocusNode()),
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
                hintText: "Input Item in List"),
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
    if(text!=null || text!=""){
    TextItem item=new TextItem(
        text:text,
        isDrawn:false
      );
    
      setState((){
        _messages.add(item);
      });
    }
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
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           new Text(text,
            style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
        ), 
        new Container(
          child:new IconButton(
              icon: new Icon(Icons.delete),
              iconSize: 36.0,
              color: Colors.redAccent,
              onPressed: () => _removeItem(text)),
        ),
        ],
      ),
      );
  }
  
  void _removeItem(String text){
      key.currentState.removeItem(text);
  }
} 