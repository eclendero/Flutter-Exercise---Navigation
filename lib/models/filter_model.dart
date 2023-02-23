class Filters {
  Filters({this.ingredients, this.categories, this.priceLimit});

  final List? ingredients;
  final List? categories;
  final String? priceLimit;

  Map toMap() {
    Map inputs = {
      'ingredients': ingredients,
      'categories': categories,
      'priceLimit': priceLimit
    };
    Map filters = {};
    //Only include those that have inputs
    for (var item in inputs.keys) {
      if (inputs[item].isNotEmpty) {
        filters.addAll({item: inputs[item]});
      }
    }
    return (filters);
  }
}
