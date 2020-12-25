import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mercadoapp/network/remote_data_source.dart';
import 'package:mercadoapp/util/constants.dart';
import 'package:mercadoapp/ui/home/components/body.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.yellowAccent,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}