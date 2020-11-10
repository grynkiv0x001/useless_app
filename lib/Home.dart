import 'package:flutter/material.dart';


class Home extends StatefulWidget {

	@override
	State<StatefulWidget> createState() {
		return _HomeState();
	}
}

class _HomeState extends State<Home> {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Column(
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					SizedBox(height: 40),
					Container(
						child: Text("Something..", style: TextStyle(
							fontSize: 30,
							color: Colors.black87
						),),
						padding: EdgeInsets.only(left: 20),
					),
				],
			),
		);
	}
}