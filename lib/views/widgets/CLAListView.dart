import 'package:casual_learning_app/models/Tutorial.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import "package:flutter/material.dart";


// ignore: must_be_immutable
class CLAListView extends StatefulWidget {

	List<Tutorial> _tutorials;

	CLAListView(List<Tutorial> tutorials) {
		this._tutorials = tutorials;
	}

	@override
	State<StatefulWidget> createState() {

		return _CLAListViewState(this._tutorials);
	}
}

class _CLAListViewState extends State<StatefulWidget> {

	List<Tutorial> _tutorials;
	CLAListItem claListItem;

	_CLAListViewState(List<Tutorial> tutorials) {
		this._tutorials = tutorials;
	}

	@override
	Widget build(BuildContext context) {

		return customListView(this._tutorials);
	}

	Widget customListView(List<Tutorial> tutorials) {

		return ListView.builder(
			padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
			itemCount: tutorials.length,
			itemBuilder: (context, index) {
				claListItem = CLAListItem(tutorials[index]);
				return Container(
					padding: EdgeInsets.only(top: 5.0),
					child: claListItem
				);
			}
		);
	}
}