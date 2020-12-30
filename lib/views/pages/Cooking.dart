/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-17 13:49:10 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:30:36
 * 
*/

import 'package:casual_learning_app/views/widgets/CLAListView.dart';
import 'package:flutter/material.dart';

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class Cooking extends StatefulWidget {

	String category;

	Cooking(String category) {
		this.category = category;
	}

	@override
	State<StatefulWidget> createState() {

		return _CookingState(this.category);
	}
}

class _CookingState extends State<Cooking> {

	String category;

	_CookingState(String category) {
		this.category = category;
	}

	CLAListItem claListItem;
	CLAListView claListView;

	List<Tutorial> tuts = List<Tutorial>();

	Future<List<Tutorial>> getAllMusicTutorials(String sql) async {

		DatabaseConnector connector = DatabaseConnector();

		List<Tutorial> tutorials = await connector.tutorials(sql);

		return tutorials;
	}

	void reallyGetMusicTuts(String sql) async {

		var tmp = await getAllMusicTutorials(sql);

		setState(() {
			tuts = tmp;
			claListView = CLAListView(tuts);
		});
	}

	@override
	void dispose() {
		tuts = null;
		claListView = null;
		super.dispose();
	}

	// #1 Merge sort
	void merge(List<Tutorial> list, int leftIndex, int middleIndex, int rightIndex) {

		int leftSize = middleIndex - leftIndex + 1;
		int rightSize = rightIndex - middleIndex;

		List<Tutorial> leftList = new List<Tutorial>(leftSize);
		List<Tutorial> rightList = new List<Tutorial>(rightSize);

		for (int i = 0; i < leftSize; i++) leftList[i] = list[leftIndex + i];
		for (int j = 0; j < rightSize; j++) rightList[j] = list[middleIndex + j + 1];

		int i = 0, j = 0;
		int k = leftIndex;

		while (i < leftSize && j < rightSize) {

			if (leftList[i].getDuration <= rightList[j].getDuration) {

				list[k].duration = leftList[i].getDuration;
				i++;

			} else {
				list[k].duration = rightList[j].getDuration;
				j++;
			}

			k++;
		}

		while (i < leftSize) {

			list[k].duration = leftList[i].getDuration;

			i++;
			k++;
		}

		while (j < rightSize) {

			list[k].duration = rightList[j].getDuration;

			j++;
			k++;
		}
	}

	void mergeSort(List<Tutorial> list, int leftIndex, int rightIndex) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE category = '${this.category}' ORDER BY duration ASC");

		if (leftIndex < rightIndex) {

			int middleIndex = (rightIndex + leftIndex) ~/ 2;

			mergeSort(list, leftIndex, middleIndex);
			mergeSort(list, middleIndex + 1, rightIndex);

			merge(list, leftIndex, middleIndex, rightIndex);
		}
	}	

	// #2 Binary search
	Tutorial binarySearch(List<Tutorial> arr, String userValue, int min, int max) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE category = '${this.category}' ORDER BY title ASC");

		if (max >= min) {

			int mid = ((max + min) / 2).floor();

			if (arr[mid].getTitle.contains(userValue))
				return arr[mid];
			else
				binarySearch(arr, userValue, min, mid - 1);
		}
	
		return null;
	}

	// #3 Heap Sort
	void heapify(List<Tutorial> list, int n, int i) {
	
		int largest = i;
		
		int l = 2 * i + 1;
		int r = 2 * i + 2;

		if (l < n && list[l].getFinished > list[largest].getFinished) {
			largest = l;
		}

		if (r < n && list[r].getFinished > list[largest].getFinished) {
			largest = r;
		}

		if (largest != i) {
			swapList(list, i, largest);
			heapify(list, n, largest);
		}
	}

	void swapList(List<Tutorial> list, int i, int largest) {

		int swap = list[i].getFinished;

		list[i].finished = list[largest].getFinished;
		list[largest].finished = swap;
	}

	List<Tutorial> heapSort(List<Tutorial> list) {

		reallyGetMusicTuts("SELECT * FROM tutorials WHERE category = '${this.category}' ORDER BY starred ASC");
		
		int n = list.length;
	
		for (int i = (n ~/ 2 ) ; i >= 0; i--){
			heapify(list, n, i);
		}

		for (int i = n - 1; i >= 0; i--) {
			swap(list, i);
			heapify(list, i, 0);
		}

		return list;
	}

	void swap(List<Tutorial> list, int i) {
	
		int temp = list[0].getFinished;

		list[0].finished = list[i].getFinished;
		list[i].finished = temp;
	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: CLAAppbar.customAppbar("Кулінарія"),
			body: claListView,
			bottomSheet: Row(
				children: [
					Text("Сортування за часом/відстеженнями та пошук за ключем"),
				],
				mainAxisAlignment: MainAxisAlignment.center
			),
			bottomNavigationBar: ButtonBar(
				alignment: MainAxisAlignment.spaceBetween,
				children: [
					RaisedButton(
						child: Text("Злиттям"),
						shape: StadiumBorder(),
						color: Colors.pink,
						onPressed: () {
							claListView = null;
							setState(() => mergeSort(tuts, 0, tuts.length));
						},
					),
					RaisedButton(
						child: Text("Пірамідальне"),
						shape: StadiumBorder(),
						color: Colors.pink,
						onPressed: () {
							claListView = null;
							setState(() => heapSort(tuts));
						},
					),
					RaisedButton(
						child: Text("Бінарний пошук"),
						shape: StadiumBorder(),
						color: Colors.pink,
						onPressed: () {
							claListView = null;
							setState(() => binarySearch(tuts, "соус", 1, tuts.length));
						},
					)
				]
			)
		);
	}
}