import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_builder/services/API_launches.dart';
import 'details.dart';
import 'dart:async';
import 'services/API_launches.dart';

class LaunchView extends StatefulWidget {
  const LaunchView({Key? key}) : super(key: key);

  @override
  _LaunchViewState createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {
  String querySearch = '';
  TextEditingController? query;
  //Timer? _debouncer;
  _LaunchViewState();

  _onSearchChanged() {
    query?.text = '';
    // if (_debouncer?.isActive ?? false) _debouncer!.cancel();
    // _debouncer = Timer(
    //   const Duration(milliseconds: 1010),
    //   () {
    setState(() {
      querySearch = query!.text;
    });
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Launches',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          buildSearch(),
          FutureBuilder(
            future: getLaunches(querySearch),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                        child: ExpansionPanelList(
                          animationDuration: Duration(milliseconds: 1000),
                          dividerColor: Colors.red,
                          elevation: 1,
                          children: [
                            ExpansionPanel(
                              body: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      leading: ClipOval(
                                        child: CircleAvatar(
                                          child: Image.network(
                                            snapshot.data[index].imageSmall
                                                .toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Success: ${snapshot.data[index].success}\nDate: ${snapshot.data[index].date}\nDetails: ${snapshot.data[index].details}',
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 15,
                                            letterSpacing: 0.3,
                                            height: 1.3),
                                      ),
                                      onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LaunchDetailView(
                                                      snapshot.data[index])),
                                        ),
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Id: ${snapshot.data[index].id}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              },
                              isExpanded: snapshot.data[index].isExpanded,
                              canTapOnHeader: true,
                            )
                          ],
                          expansionCallback: (int item, bool status) {
                            setState(() {
                              snapshot.data[index].isExpanded =
                                  !snapshot.data[index].isExpanded;
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => Container(
        padding: EdgeInsets.all(10),
        child: CupertinoSearchTextField(
          controller: query,
          onChanged: _onSearchChanged(),
        ),
      );
}
