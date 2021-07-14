import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_builder/services/API_launches.dart';
import 'details.dart';
import 'services/API_launches.dart';
import 'package:future_builder/models/data_model.dart';
import 'package:shimmer/shimmer.dart';

class LaunchView extends StatefulWidget {
  @override
  _LaunchViewState createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {
  String querySearch = '';
  late TextEditingController query;

  //Timer? _debouncer;
  @override
  void initState() {
    query = TextEditingController(text: '');
    query.addListener(onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    query.removeListener(onSearchChanged);
    query.dispose();
    //_debounce?.cancel();
    super.dispose();
  }

  onSearchChanged() {
    // if (_debouncer?.isActive ?? false) _debouncer!.cancel();
    // _debouncer = Timer(
    //   const Duration(milliseconds: 1010),
    //   () {
    if (query.text.length >= 1) {
      setState(() {
        querySearch = query.text;
      });
    } else {
      setState(() {
        querySearch = '';
      });
    }

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
          Container(
            padding: EdgeInsets.all(10),
            child: CupertinoSearchTextField(
              controller: query,
              onChanged: onSearchChanged(),
              onSubmitted: onSearchChanged(),
            ),
          ),
          FutureBuilder(
            future: getLaunches(querySearch),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return buildShimmer();
                    },
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpansionTile(
                        leading: ClipOval(
                          child: CircleAvatar(
                            child: Image.network(
                              snapshot.data[index].imageSmall.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          'Id: ${snapshot.data[index].id}',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w500),
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: InkWell(
                              child: Text(
                                'Date: ${snapshot.data[index].date}\nSuccess: ${snapshot.data[index].success}\nDetails: ${snapshot.data[index].details}',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LaunchDetailView(
                                          snapshot.data[index])),
                                ),
                              },
                            ),
                          ),
                        ],
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
}

Widget buildShimmer() => ListTile(
      leading: ShimmerWidget.circular(width: 64, height: 64),
      title: ShimmerWidget.rectangular(height: 16),
      subtitle: ShimmerWidget.rectangular(height: 14),
    );

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
  }) : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
