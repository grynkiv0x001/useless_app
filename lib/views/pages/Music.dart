/*
 * @Author: grynkiv0x001 
 * @Date: 2020-12-18 00:31:54 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:26:15
 * 
*/

import 'package:casual_learning_app/configs/Keys.dart';
import 'package:flutter/material.dart';

import 'package:casual_learning_app/configs/DatabaseConnector.dart';
import 'package:casual_learning_app/views/widgets/CLAListItem.dart';
import 'package:casual_learning_app/views/widgets/CLAAppbar.dart';
import 'package:casual_learning_app/models/Tutorial.dart';


class Music extends StatefulWidget {

	String category;

	Music(String category) {
		this.category = category;
	}

	@override
	State<StatefulWidget> createState() {

		return _MusicState(this.category);
	}
}

class _MusicState extends State<Music> {

	String category;

	_MusicState(String category) {
		this.category = category;
	}

	CLAListItem claListItem;

	List<Tutorial> tuts = List<Tutorial>();
	List<Tutorial> qSortedTuts = List<Tutorial>();
	List<Tutorial> iSortedTuts = List<Tutorial>();
	List<Tutorial> bSortedTuts = List<Tutorial>();

	int gValue;

	bool wasSorted = false;

	setGValue(int val) {
		setState(() {
			gValue = val;
		});
	}

	Future<List<Tutorial>> getAllMusicTutorials() async {

		// String sql = "SELECT * FROM tutorials WHERE category = '${this.category}'";
		String sql = "SELECT * FROM tutorials";

		DatabaseConnector connector = DatabaseConnector();

		List<Tutorial> tutorials = await connector.tutorials(sql);

		setList(tutorials);

		// connector.close();

		return tutorials;
	}

	void setList(List<Tutorial> tutorials) {

		setState(() {
			tuts = tutorials;
		});
	}

	// Three required algorithms
	//
	// #1 Quick Sort
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

	// #2 Insertion sort
	List<Tutorial> insertionSort(List<Tutorial> list, int length) {
		
		for (int j = 1; j < length; j++) {

			int key = list[j].getStarred;

			int i = j - 1;

			while (i >= 0 && list[i].getStarred > key) {

				list[i + 1].starred = list[i].getStarred;
				i = i - 1;
			}

			list[i + 1].starred = key;

			print(key);
		}

		return list;
	}

	// #3 Bubble sort
	List<Tutorial> bubbleSort(List<Tutorial> list) {

		int length = list.length;

		for (int i = 0; i < length - 1; i++) {

			for (int ii = 0; ii < length - i - 1; ii++) {

				if (list[ii].getStarred > list[ii + 1].getStarred) {

					int temp = list[ii].getStarred;

					list[ii].starred = list[ii + 1].getStarred;
					list[ii + 1].starred = temp;
				}
			}
		}

		return list;
	}

	// #4 Merge sort
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

		if (leftIndex < rightIndex) {

			int middleIndex = (rightIndex + leftIndex) ~/ 2;

			mergeSort(list, leftIndex, middleIndex);
			mergeSort(list, middleIndex + 1, rightIndex);

			merge(list, leftIndex, middleIndex, rightIndex);
		}
	}

	// #5 Linear search
	linearSearch(List<Tutorial> array, int x) {
 		
		for(int i = 0; i < array.length; i++)
  	  		if(array[i].getStarred == x)
      			return i;
  	}

	@override
	Widget build(BuildContext context) {

		return Scaffold(
			appBar: CLAAppbar.customAppbar("Мистецтво"),
			body: ListView.builder(
				padding: EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 5.0),
				itemCount: tuts.length,
				itemBuilder: (context, index) {
					claListItem = CLAListItem(tuts[index]);
					return Container(
						padding: EdgeInsets.only(top: 5.0),
						child: claListItem
					);
				},
			),
			bottomNavigationBar: BottomAppBar(
				child: IconButton(
					icon: Icon(Icons.filter_alt_outlined),
					onPressed: () {
						getAllMusicTutorials();
						showDialog(context: context, child:
							AlertDialog(
								title: Text("Налаштування змісту"),
								content: Column(
									children: [
										SizedBox(
											height: 20
										),
										OutlineButton(
											child: Text("Швидке сортування"),
											onPressed: () {
												setState(() {
													getAllMusicTutorials();

													int high = tuts.length - 1;
													int low  = 0;

													qSortedTuts = quickSort(tuts, low, high);
													tuts = qSortedTuts;
												});

												Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => Music("Music")));
											},
										),
										Container(
											child: Text("Сортувати за часом"),
										),
										SizedBox(
											height: 20
										),
										OutlineButton(
											child: Text("Сортування вставками"),
											onPressed: () {
												setState(() {
													getAllMusicTutorials();

													int length = tuts.length;

													iSortedTuts = insertionSort(tuts, length);
													tuts = iSortedTuts;
												});

												Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => Music("Music")));
	
											},
										),
										Container(
											child: Text("Сортувати за к-стю пройдених"),
										),
										SizedBox(
											height: 20
										),
										OutlineButton(
											child: Text("Лінійний пошук"),
											onPressed: () {
												setState(() {
													getAllMusicTutorials();

													bSortedTuts = bubbleSort(tuts);
													tuts = bSortedTuts;
												});

												Keys.navigatorState1.currentState.push(MaterialPageRoute(builder: (context) => Music("Music")));
	
											},
										),
										Container(
											child: Text("Знайти за словом"),
										)
									]
								),
								contentPadding: EdgeInsets.all(0.0)
							)
						);
					}
				)
			)
		);
	}
}