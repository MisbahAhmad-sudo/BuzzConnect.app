import 'package:flutter/material.dart';

import '../config/images.dart';

class UserTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  final void Function()? onTap;
  final String imageUrl;
  final String? role;

  const UserTile({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.onTap,
    required this.imageUrl, this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool hasProfileImage = imageUrl.isNotEmpty; // Check if imageUrl is not empty

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.purple, // Change the color as needed
                  width: 2, // Adjust the width of the border
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: hasProfileImage // Use hasProfileImage to determine which image to show
                    ? Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                )
                    : Image.network(
                  AssetsImage.defaultProfileUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userEmail,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  role!,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
