/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 21:45:29 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:50:25
 * 
*/

class Tutorial {

	int _id;
	
	String _title;
	String _content;

	int _duration;

	String _category;

	int _starred;
	int _finished;

	String _image;

	Tutorial(this._id, this._title, this._content, this._duration, this._category, this._starred, this._finished, this._image);

	int get getId 		   => _id;
	int get getDuration    => _duration;
	int get getStarred     => _starred;
	int get getFinished    => _finished;
	String get getTitle    => _title;
	String get getContent  => _content;
	String get getCategory => _category;
	String get getImage	   => _image;

	set starred(int stars) => _starred = stars;
	set finished(int finished) => _finished = finished;
	set duration(int duration) => _duration = duration;

	String getTutorialRow() {
		return _title + "\n" + _content + "\n" + 
			   "Average duration: " + _duration.toString() + "\n"
			   "Rating: " + _starred.toString() + "\n"
			   "People completed: " + _finished.toString() + "\n";
	}
}