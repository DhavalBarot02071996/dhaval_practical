import 'package:dhaval_practical_demo/api/api_client.dart';
import 'package:dhaval_practical_demo/models/contact_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late Future<ContactListModel> contactListModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactListModel = ApiClient.network.loadContacts("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact List"),),
      body: FutureBuilder(
          future: contactListModel,
          builder: (context, AsyncSnapshot<ContactListModel> snapshot) {
            List<Data> allContactData;
            if (snapshot.hasData) {
              allContactData = snapshot.data!.data;
              return createContactList(allContactData, context);
            } else {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.blue),
                    ),
                  ));
            }
          }),
    );
  }
}

Widget createContactList(List<Data> allContactData, BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: allContactData.length,
    itemBuilder: (context, int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          child: ListTile(
            leading:FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              fadeInCurve: Curves.easeInCubic,
              image: allContactData[index].avatar, placeholder: "assets/images/user_placeholder.png",
            ),
            title:Text(
              allContactData[index].firstName + "\t" +allContactData[index].lastName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              allContactData[index].email,
            ),
          ),
        ),
      );
    },
  );
}
