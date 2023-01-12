import 'package:flutter/material.dart';

import 'package:bdix/Utilities/ping_send.dart';
import 'package:get/get.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:url_launcher/url_launcher.dart';

class NotWorking extends StatefulWidget {
  const NotWorking({Key? key}) : super(key: key);

  @override
  State<NotWorking> createState() => _NotWorkingState();
}

class _NotWorkingState extends State<NotWorking> {
  NetworkHelper networkHelper = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: networkHelper.failedList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // print(snapshot.data);
        if (!snapshot.hasData) {
          return const fluent.ProgressBar(
            strokeWidth: 1,
            value: null,
          );
        } else {
          return Obx(() => SizedBox(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                      () => Material(
                        child: Ink(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () async {
                              if (!await launchUrl(
                                  Uri.parse(snapshot.data[index]))) {
                                throw 'Could not launch url';
                              }
                            },
                            child: ListTile(
                              title: Text(
                                  '${index + 1}.  ${snapshot.data[index]}'),
                              trailing: IconButton(
                                icon: Icon(
                                  // NEW from here...
                                  networkHelper.saved
                                          .contains(snapshot.data[index])
                                      ? fluent.FluentIcons.heart_fill
                                      : Icons.favorite_border_sharp,
                                  color: networkHelper.saved
                                          .contains(snapshot.data[index])
                                      ? Colors.red
                                      : null,
                                  semanticLabel: networkHelper.saved
                                          .contains(snapshot.data[index])
                                      ? 'Remove from saved'
                                      : 'Save',
                                ),
                                onPressed: () async {
                                  setState(() {
                                    if (networkHelper.saved
                                        .contains(snapshot.data[index])) {
                                      networkHelper.saved
                                          .remove(snapshot.data[index]);
                                      networkHelper.saveList();
                                    } else {
                                      networkHelper.saved
                                          .add(snapshot.data[index]);
                                      networkHelper.saveList();
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
        }
      },
    );
  }
}
