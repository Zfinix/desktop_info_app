import 'package:desktop_info_app/models/raw_data.dart';
import 'package:desktop_info_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'info_item.dart';

class InfoBuilder extends StatefulWidget {
  const InfoBuilder({
    Key key,
    @required this.rawData,
  }) : super(key: key);

  final RawDataModel rawData;

  @override
  _InfoBuilderState createState() => _InfoBuilderState();
}

class _InfoBuilderState extends State<InfoBuilder> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            width: context.screenWidth(),
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            height: 60,
            child: FlatButton(
              padding: EdgeInsets.all(10),
              color: Colors.blueGrey.withOpacity(.03),
              onPressed: () {
                setState(() {
                  hidden = !hidden;
                });
              },
              child: Center(
                child: Text('${widget.rawData.category}'.replaceAll('SP', '').replaceAll('DataType', ''),
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )),
              ),
            ),
          ),
        ),
        if (!hidden)
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
            width: context.screenWidth(),
            decoration: BoxDecoration(
                color: Colors.white10.withOpacity(.04),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var _ in widget.rawData?.data ?? [])
                  ..._buildListTile(_, context)
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> _buildListTile(dynamic _, BuildContext context) {
    return [
      if (_ is Map)
        ..._buildEntries(_, context)
      else if (_.runtimeType.toString() == 'List<dynamic>')
        for (var __ in _) ..._buildListTile(__, context),
      const YMargin(40),
    ];
  }

  List<Widget> _buildEntries(Map _, BuildContext context) {
    return [
      for (var __ in _?.entries)
        if (__.value is Map)
          ..._buildEntries(__.value, context)
        else if (__.value.runtimeType.toString() == 'List<dynamic>' &&
            (__.value as List).length > 0 &&
            (__.value as List).first.runtimeType != int &&
            (__.value as List).first.runtimeType != String)
          for (var ___ in __.value) ..._buildEntries(___, context)
        else
          InfoItem(entry: __)
    ];
  }
}
