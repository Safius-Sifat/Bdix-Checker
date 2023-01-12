import 'package:flutter/material.dart';

import 'package:bdix/Utilities/ping_send.dart';
import 'package:get/get.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:url_launcher/url_launcher.dart';

class Working extends StatefulWidget {
  const Working({Key? key}) : super(key: key);

  @override
  State<Working> createState() => _WorkingState();
}

class _WorkingState extends State<Working> {
  NetworkHelper networkHelper = Get.find();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: networkHelper.successList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const fluent.ProgressBar(value: null);
        } else {
          return Obx(
            () => ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Obx(
                  () => Material(
                    child: Ink(
                      color: Colors.white,
                      child: InkWell(
                        // splashColor: const Color.fromARGB(
                        //     255, 255, 255, 255),
                        onTap: () async {
                          if (!await launchUrl(
                              Uri.parse(snapshot.data[index]))) {
                            throw 'Could not launch url';
                          }
                        },
                        child: ListTile(
                          title: Text('${index + 1}.  ${snapshot.data[index]}'),
                          trailing: IconButton(
                            icon: Icon(
                              // NEW from here...
                              networkHelper.saved.contains(snapshot.data[index])
                                  ? fluent.FluentIcons.heart_fill
                                  : Icons.favorite_outline,
                              color: networkHelper.saved
                                      .contains(snapshot.data[index])
                                  ? Colors.red
                                  : null,
                              semanticLabel: networkHelper.saved
                                      .contains(snapshot.data[index])
                                  ? 'Remove from saved'
                                  : 'Save',
                            ),
                            onPressed: () {
                              setState(() {
                                if (networkHelper.saved
                                    .contains(snapshot.data[index])) {
                                  networkHelper.saved
                                      .remove(snapshot.data[index]);
                                  networkHelper.saveList();
                                } else {
                                  networkHelper.saved.add(snapshot.data[index]);
                                  networkHelper.saveList();
                                }
                              });
                            },
                          ), // ... to here.
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
