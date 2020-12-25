import 'package:flutter/material.dart';
import 'package:mercadoapp/model/Product.dart';

import 'package:mercadoapp/util/constants.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product.title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: kTextColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: kDefaultPaddin),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Precio\n"),
                    TextSpan(
                      text: "\$${product.price}",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          color: kTextColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPaddin),
              Expanded(
                child: Hero(
                  tag: "${product.id}",
                  child: Image.network(
                      product.thumbnail
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}