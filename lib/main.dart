import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> names = [];
  List<String> _shownNames = [];
  int currentPage = 0;
  int limit = 20;
  String _loadingState = 'loading';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 200; i++) {
      names.add("hello $i");
    }
    _loadNames();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(title: new Text('User')),
        body: Column(children: <Widget>[
          Text(_loadingState),
          Expanded(child:_getListViewWidget()),
        ],)
    );
  }

  Widget _getListViewWidget(){
    ListView lv =  new ListView.builder(
        itemCount: _shownNames.length,
        itemBuilder: (context, index){
          if(index >= _shownNames.length - 5 && !loading){
            _loadNames(); // Getting error when this is called
          }
          return  ListTile(
            title: Text(_shownNames[index]),
          );
        });

    RefreshIndicator refreshIndicator = new RefreshIndicator(
        //key: _refreshIndicatorKey,
        onRefresh: (){
          _loadNames();
          return null;
        },
        child: lv
    );
    return refreshIndicator;
  }

  _loadNames(){
    loading = true;
    setState(() {
      _loadingState = 'loading...';
    });

    new Timer(const Duration(seconds: 5), () {
      setState(() {
        _shownNames.addAll(names.getRange(currentPage, currentPage + limit));
        currentPage += limit;
        _loadingState = 'loaded';
      });
      loading = false;
    });
  }
}