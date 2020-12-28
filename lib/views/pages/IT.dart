/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-17 13:37:58 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:28:18
 * 
*/

import 'package:flutter/material.dart';

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class IT extends StatefulWidget {

	String category;

	IT(String category) {
		this.category = category;
	}

	@override
	State<StatefulWidget> createState() {

		return _ITState(this.category);
	}
}

class _ITState extends State<IT> {

	String category;

	_ITState(String category) {
		this.category = category;
	}

	CLAListItem claListItem;

	static List<Tutorial> bubbleSort(List<Tutorial> list) {

		int length = list.length;

		for (int i = 0; i < length - 1; i++) {

			for (int ii = 0; ii < length - i - 1; ii++) {

				if (list[ii].getStarred > list[ii + 1].getStarred) {

					int temp = list[ii].getStarred;

					list[ii].starred = list[ii + 1].getStarred;
					list[ii + 1].starred = temp;

					print(temp);
				}
			}
		}

		return list;
	}

	List<Tutorial> quickSort(List<Tutorial> list, int low, int high) {

		if (low < high) {
			int pivot = partition(list, low, high);

			quickSort(list, low, pivot - 1);
			quickSort(list, pivot + 1, high);
		}

		return list;
	}

	int partition(List<Tutorial> list, int low, int high) {
		
		if (list.isEmpty)
			return 0;

		int pivot = list[high].getDuration;

		int i = low - 1;

		for (int j = low; j < high; j++) {

			if (list[j].getDuration < pivot) {
				i++;
				swap(list, i, j);
				print(list[j].getDuration);
			}
		}
		
		swap(list, i + 1, high);

		return i + 1;
	}

	void swap(List<Tutorial> list, int i, int j) {
		
		int temp = list[i].getDuration;

		list[i].duration = list[j].getDuration;
		list[j].duration = temp;
	}

	@override
	Widget build(BuildContext context) {

		final GlobalKey starredState = GlobalKey();

		DatabaseConnector connector = DatabaseConnector();

		// String _sql = "SELECT * FROM tutorials WHERE category = '${this.category}'";
		String _sql = "SELECT * FROM tutorials";

		List<Tutorial> list = [];

		return Scaffold(
			appBar: CLAAppbar.customAppbar("ІТ: для хобі та роботи"),
			body: FutureBuilder<List<Tutorial>>(
				future: connector.tutorials(_sql),
				initialData: List(),
				builder: (BuildContext context, AsyncSnapshot<List<Tutorial>> snapshot) {
					if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {

						list = snapshot.data;

						return ListView.builder(
							padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
							itemCount: list.length,
							itemBuilder: (context, index) {
								claListItem = CLAListItem(list[index]);
								print(list[index].getTitle);
								return Container(
									padding: EdgeInsets.only(top: 5.0),
									child: claListItem
								);
							},
						);
					} else if (snapshot.hasError) {
						return Center(
							child: Text("Failed: ${snapshot.error}", style: TextStyle(color: Colors.red)),
						);
					}
					return Center(
						child: CircularProgressIndicator()
					);
				}
			),
			bottomNavigationBar: BottomAppBar(
				child: IconButton(
					icon: Icon(Icons.filter_alt_outlined),
					onPressed: () {
						var listiq = quickSort(list, list.length - 1, 0);
						setState(() => list = listiq);
					}
					// onPressed: () {
					// 	showDialog(context: context, child:
					// 		AlertDialog(
					// 			title: Text("Налаштування змісту"),
					// 			content: Column(
					// 				children: [
					// 					SizedBox(
					// 						height: 20
					// 					),
					// 					OutlineButton(
					// 						child: Text("Швидке сортування"),
					// 						onPressed: () {},
					// 					),
					// 					SizedBox(
					// 						height: 20
					// 					),
					// 					OutlineButton(
					// 						child: Text("Сортування вставками"),
					// 						onPressed: () {},
					// 					),
					// 					SizedBox(
					// 						height: 20
					// 					),
					// 					OutlineButton(
					// 						child: Text("Лінійний пошук"),
					// 						onPressed: () {},
					// 					)
					// 				]
					// 			),
					// 			contentPadding: EdgeInsets.all(0.0)
					// 		)
					// 	);
					// }
				)
			)
		);
	}
}