import 'dart:convert';
import 'package:desktop_info/desktop_info.dart';
import 'package:desktop_info_app/models/raw_data.dart';
import 'package:desktop_info_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/info_builder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  Map raw = {};
  List<RawDataModel> _listRawData = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  Future<void> load() async {
    try {
      setState(() {
        raw = {};
        _listRawData = [];
        isLoading = true;
      });

      var _temp = await MacOSInfo.systemInfo(
        resultType: MacOSInfoResultType.json,
        type: MacOSInfoType.basic,
      );

      setState(() {
        raw = jsonDecode(_temp);
      });

      _format();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Flutter MacoS Info',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.replay_rounded),
            color: Colors.white,
            onPressed: () {
              load();
            },
          ),
        ],
      ),
      body: _listRawData.isEmpty
          ? Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            )
          : ListView(
              children: [
                for (var rawData in _listRawData ?? [])
                  InfoBuilder(rawData: rawData)
              ],
            ),
    );
  }

  void _format() {
    try {
      raw.forEach((key, value) {
        _listRawData.add(RawDataModel(key.toString(), value));
      });
      _listRawData.removeWhere((e) => e.data == null || e.data.isEmpty);
      setState(() => isLoading = false);
    } catch (e) {
      print(e.toString());
    }
  }
}
