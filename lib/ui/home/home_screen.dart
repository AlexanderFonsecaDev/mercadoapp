import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:mercadoapp/model/Result.dart';
import 'package:mercadoapp/network/remote_data_source.dart';
import 'package:mercadoapp/ui/search/search_screen.dart';
import 'package:mercadoapp/util/constants.dart';
import 'package:mercadoapp/ui/home/components/body.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  RemoteDataSource _apiResponse = RemoteDataSource();
  final TextEditingController searchController = new TextEditingController();
  return AppBar(
    backgroundColor: Colors.yellowAccent,
    elevation: 0,
    actions: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              /*Future<Result> search = _apiResponse.searchProducts(value);
                search.then((value) => {

                });*/
            },
            decoration: InputDecoration(
              hintText: "Buscar",
              hintStyle: TextStyle(
                color: kTextColor,
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ),
      IconButton(
        icon: SvgPicture.asset(
          "assets/icons/search.svg",
          // By default our  icon color is white
          color: kTextColor,
        ),
        onPressed: () {
          if(!searchController.text.isEmpty){
            Future<Result> search = _apiResponse.searchProducts(searchController.text);
            search.then((value) => {
                if(value is SuccessState){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreen(
                            productsCollection: (value as SuccessState).value,
                          )
                      )
                  )
                }
            });
            searchController.text = "";
          }else{
            print("BUSCAR");
          }
        },
      ),
      SizedBox(width: kDefaultPaddin / 2)
    ],
  );
}

/*
MaterialPageRoute(
builder: (context) => DetailsScreen(
product: productsCollection.products[index]
)
)*/
