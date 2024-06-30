import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/contactController.dart';
import 'widget/contactSearch.dart';
import 'widget/newContactTile.dart';
import '../Gropup/NewGroup/newGroup.dart';
import '../user_list_widget.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;
    TextEditingController searchController = TextEditingController();
    ContactController contactController = Get.put(ContactController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Select Contact'),
        actions: [
          Obx(
                () => IconButton(
              onPressed: () {
                isSearchEnable.value = !isSearchEnable.value;
              },
              icon: isSearchEnable.value
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
                  () => isSearchEnable.value
                  ? ContactSearch(searchController: searchController)
                  : const SizedBox(),
            ),
            const SizedBox(height: 10),
            newContactTile(
                btnName: "New Contact", icon: Icons.person_add, ontap: () {}),
            newContactTile(
              btnName: "New Group",
              icon: Icons.group_add,
              ontap: () {
                Get.to(const NewGroup());
              },
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  "Contacts on BuzzConnect",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 500,
              child: UserListWidget(searchController: searchController),
            ),
          ],
        ),
      ),
    );
  }
}
