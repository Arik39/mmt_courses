import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ModuleTile extends StatefulWidget {
  final int index;
  final String title;

  ModuleTile({Key? key, required this.index, required this.title})
      : super(key: key);

  @override
  State<ModuleTile> createState() => _ModuleTileState();
}

class _ModuleTileState extends State<ModuleTile> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 12),
              child: Text(
                widget.index.toString(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(top: 16, left: 16, bottom: 16, right: 17.5),
                height: 48,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _isOpen = !_isOpen;
                          });
                        },
                        child: Center(
                          child: SvgPicture.asset(_isOpen
                              ? "assets/images/minimize.svg"
                              : "assets/images/down_arrow.svg"),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
        Visibility(
          visible: _isOpen,
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.only(left: 20, top: 12),
            padding: EdgeInsets.only(left: 13, top: 6, bottom: 6),
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2, child: Text("1.1")),
                Expanded(
                    flex: 10,
                    child: Text("How can you access the MMTC Course?")),
                Expanded(
                    flex: 2,
                    child: Container(
                        width: 20,
                        child: SvgPicture.asset("assets/images/play.svg")))
              ],
            ),
          ),
        )
      ],
    );
  }
}
