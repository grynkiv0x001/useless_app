import 'package:flutter/material.dart';

import 'Pages.dart';


class TestApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {

		return MaterialApp(
			title: "Test app",
			theme: ThemeData(
				primarySwatch: Colors.indigo,
			),
			home: Pages()
		);
	}
}

void main() {
	runApp(TestApp());
}