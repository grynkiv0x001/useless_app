import 'package:flutter/material.dart';


class Browse extends StatelessWidget {

	String value = "Hui";

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: TextField(
					decoration: InputDecoration(
						border: InputBorder.none,
						hintText: "Search..."
					),
					onChanged: (value) { this.value = value; },
					onSubmitted: (value) => print("Data entered: $value"),
				)
			),
			body: Container(
				child: Column(
					children: [
						SizedBox(height: 80,),
						Center(
							child: Text("Some text"),
						),
					],
				),
			),
		);
	}
}