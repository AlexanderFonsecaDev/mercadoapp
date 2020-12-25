import 'package:flutter/material.dart';
import 'package:mercadoapp/model/Catalog.dart';
import 'package:mercadoapp/model/Result.dart';
import 'package:mercadoapp/network/remote_data_source.dart';

import 'package:mercadoapp/util/constants.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  RemoteDataSource _apiResponse = RemoteDataSource();

  // By default our first item will be selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: FutureBuilder(
          future: _apiResponse.getCategories(),
          builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
            if (snapshot.data is SuccessState) {
              Catalog categoriesCollection = (snapshot.data as SuccessState).value;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesCollection.categories.length,
                  itemBuilder: (context, index) {
                    return buildCategory(index, categoriesCollection);
                  });
            } else if (snapshot.data is ErrorState) {
              String errorMessage = (snapshot.data as ErrorState).msg;
              return Text(errorMessage);
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildCategory(int index,categoriesCollection) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categoriesCollection.categories[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}