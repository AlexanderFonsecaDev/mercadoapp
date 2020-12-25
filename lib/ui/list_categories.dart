
import 'package:mercadoapp/model/Catalog.dart';
import 'package:mercadoapp/model/Result.dart';
import 'package:mercadoapp/network/remote_data_source.dart';
import 'package:flutter/material.dart';

class ListCategoriesScreen extends StatefulWidget {
  @override
  _ListCategoriesScreenState createState() => _ListCategoriesScreenState();
}

class _ListCategoriesScreenState extends State<ListCategoriesScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de categorias"),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getCategories(),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                Catalog categoryCollection = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: categoryCollection.categories.length,
                    itemBuilder: (context, index) {
                      return bookListItem(index, categoryCollection, context);
                    });
              } else if (snapshot.data is ErrorState) {
                String errorMessage = (snapshot.data as ErrorState).msg;
                return Text(errorMessage);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Dismissible bookListItem(
      int index, Catalog categoryCollection, BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
      },
      background: Container(
        color: Colors.red,
      ),
      key: Key(categoryCollection.categories[index].name),
      child: ListTile(
        leading: Image.asset("assets/icons/category.png"),
        title: Text(categoryCollection.categories[index].name),
        subtitle: Text(
          categoryCollection.categories[index].name,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        ),
        isThreeLine: true,
        trailing: Text(
          categoryCollection.categories[index].name,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }
}
