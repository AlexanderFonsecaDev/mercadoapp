import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:mercadoapp/model/Result.dart';
import 'package:mercadoapp/model/Stock.dart';
import 'package:mercadoapp/network/remote_data_source.dart';
import 'package:mercadoapp/ui/details/details_screen.dart';
import 'package:mercadoapp/ui/home/components/categories.dart';
import 'package:mercadoapp/ui/home/components/item_card.dart';
import 'package:mercadoapp/ui/search/search_screen.dart';
import 'package:mercadoapp/util/constants.dart';
import 'package:mercadoapp/ui/home/components/body.dart';

class SearchScreen extends StatefulWidget {
  Stock productsCollection;
  SearchScreen({this.productsCollection});
  @override
  _SearchState createState() => _SearchState(productsCollectionSearch: productsCollection);
}

class _SearchState extends State<SearchScreen> {
  Stock productsCollection;
  int selectedIndex = 0;
  Stock productsCollectionSearch;
  _SearchState({this.productsCollectionSearch});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: Text(
              "Categorias",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Categories(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                  itemCount: productsCollectionSearch.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return ItemCard(
                      product: productsCollectionSearch.products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                  product: productsCollectionSearch.products[index]
                              )
                          )
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
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
