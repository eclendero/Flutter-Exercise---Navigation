import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RecipeListCubit extends Cubit<List> {
  RecipeListCubit() : super([]);

  void fetchRecipes() async {
    HttpLink link =
        HttpLink('https://asia-southeast-48343.pktriot.net/graphql');
    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(), //Stores cache data
      ),
    );
    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql("""query{
  recipes(filterRecipeInput:{}){
    title
    scope
  }
}"""),
      ),
    );

    if (queryResult.hasException) {
      print(queryResult.exception.toString());
    }

    print(queryResult.data);

    // List? recipes = queryResult.data?['recipes'];
    // print(recipes);
  }
}
