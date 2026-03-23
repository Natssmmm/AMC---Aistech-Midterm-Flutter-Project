import 'package:flutter/material.dart';

// Search screen for users or posts
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // Controller for search input
  final TextEditingController searchController = TextEditingController();

  // Stores search results
  List<String> results = [];

  // Function that simulates search results
  void search(String query){

    setState(() {
      results = List.generate(
        10,
            (index) => "Result for '$query' #$index",
      );
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),

      body: Column(
        children: [

          // Search input field
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search users or posts",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: search,
            ),
          ),

          // Display search results
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context,index){

                return ListTile(
                  leading: const CircleAvatar(),
                  title: Text(results[index]),
                );

              },
            ),
          )

        ],
      ),
    );
  }
}