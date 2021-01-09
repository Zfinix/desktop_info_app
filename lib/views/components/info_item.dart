import 'package:desktop_info_app/utils/extensions.dart';
import 'package:desktop_info_app/utils/pretty_json.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    Key key,
    @required this.entry,
  });

  final MapEntry entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.withOpacity(.5),
          ),
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Text('${entry.key}: '.toUpperCase(),
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              )),
        ),
        const YMargin(10),
        Container(
          padding: EdgeInsets.all(20),
          child: Text(
              '${entry.value is Map ? jsonPretty(entry.value) : entry.value}',
              style: GoogleFonts.ubuntu(
                color: Colors.white.withOpacity(.8),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
        ),
        const YMargin(30),
      ],
    );
  }
}
