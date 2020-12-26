import 'package:flutter/material.dart';
import 'package:mercadoapp/model/Stock.dart';
import 'package:mercadoapp/network/remote_data_source.dart';
import 'package:mercadoapp/util/constants.dart';
import 'package:mercadoapp/ui/home/components/categories.dart';
import 'package:mercadoapp/ui/home/components/item_card.dart';
import 'package:mercadoapp/model/Result.dart';
import 'package:mercadoapp/ui/details/details_screen.dart';



class Body extends StatelessWidget {
  RemoteDataSource _apiResponse = RemoteDataSource();

  Stock productsCollection;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: FutureBuilder(
                future: _apiResponse.getProducts("MCO1747"),
                builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
                  if (snapshot.data is SuccessState) {
                    Stock productCollection = (snapshot.data as SuccessState).value;
                    return GridView.builder(
                        itemCount: productCollection.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: kDefaultPaddin,
                          crossAxisSpacing: kDefaultPaddin,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          return ItemCard(
                            product: productCollection.products[index],
                            press: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        product: productCollection.products[index]
                                    )
                                )
                            ),
                          );
                        });
                  } else if (snapshot.data is ErrorState) {
                    String errorMessage = (snapshot.data as ErrorState).msg;
                    return Text(errorMessage);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ],
    );
  }
}