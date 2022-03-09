import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
class osm extends StatefulWidget {
  const osm({Key? key}) : super(key: key);

  @override
  _osmState createState() => _osmState();
}

class _osmState extends State<osm> with OSMMixinObserver{

  //etc
  @override
  void initState() {
    super.initState();
    //controller.addObserver(this);
  }
  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      /// put you logic
    }
  }
  @override
  Future<void> mapRestored() async {
    super.mapRestored();
    /// TODO
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

