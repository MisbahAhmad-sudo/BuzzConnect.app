import 'package:flutter/material.dart';

class ContactSearch extends StatelessWidget {
  final TextEditingController searchController;

  const ContactSearch({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                // No need to print value, handled by the controller
              },
              decoration: const InputDecoration(
                hintText: "Search Contact",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
