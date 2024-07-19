import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/ui/widgets/weekly_festivals_card.dart';
import 'package:flutter/material.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  final List<FestivalModel> data;

  SearchViewDelegate(this.data);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text("No results found."),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : data.where((element) {
            final lowerQuery = query.toLowerCase();
            return element.name.toLowerCase().contains(lowerQuery) ||
                element.description.toLowerCase().contains(lowerQuery);
          }).toList();

    if (suggestionList.isEmpty) {
      return Center(
        child: Text("No suggestions available."),
      );
    }

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final festival = suggestionList[index];
        return WeeklyFestivalsCard(festival: festival);
      },
    );
  }
}
