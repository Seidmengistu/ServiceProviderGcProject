import 'package:flutter/material.dart';
import 'package:service_provider/utils/dimensions.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> _data = List.generate(
      100, (i) => i); // generate a sample data ( integers ) list of 100 length
  int _page = 0; // default page to 0
  final int _perPage = 10; // per page items you want to show

  @override
  Widget build(BuildContext context) {
    final dataToShow = _data.sublist(
        (_page * _perPage),
        ((_page * _perPage) +
            _perPage)); // extract a list of items to show on per page basis

    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: Dimensions.height50),
      child: Column(children: [
        Row(children: [
          ElevatedButton(
            onPressed: () => {
              setState(() {
                _page -= 1;
              })
            },
            child: const Text('Prev'),
          ),
          SizedBox(
            width: Dimensions.width30,
          ),
          ElevatedButton(
            onPressed: () => {
              setState(() {
                _page += 1;
              })
            },
            child: const Text('Next'),
          )
        ]),
        ListView.builder(
          shrinkWrap: true,
          itemCount: dataToShow.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${dataToShow[index]}'),
            );
          },
        )
      ]),
    ));
  }
}
