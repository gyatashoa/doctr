import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSymptomsSearchDelegate extends SearchDelegate<String?> {
  final List<String> symptoms;
  AddSymptomsSearchDelegate({required this.symptoms})
      : super(
            searchFieldStyle: GoogleFonts.ptSans(fontWeight: FontWeight.w100),
            searchFieldLabel: 'Enter symptom');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final res = symptoms
        .where(
          (element) => element.contains(query),
        )
        .toList();

    return ListView.separated(
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.local_hospital),
        title: Text(res[i]),
        onTap: () => close(context, res[i]),
      ),
      itemCount: res.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final res = symptoms
        .where(
          (element) => element.contains(query),
        )
        .toList();

    return ListView.separated(
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.local_hospital),
        title: Text(res[i]),
        onTap: () => close(context, res[i]),
      ),
      itemCount: res.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
