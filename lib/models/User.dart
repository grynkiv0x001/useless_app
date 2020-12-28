/*
 * @Author: grynkiv0x001 
 * @Date: 2020-11-29 21:45:18 
 * @Last Modified by: grynkiv0x001
 * @Last Modified time: 2020-12-18 04:45:02
 * 
*/

class User {

	int	   _id;
	String _email;
	String _fullname;
	String _password;

	int _finished;
	int _starred;

	bool   _isLogged;

	User(this._id, this._fullname, this._email, this._password, this._finished, this._starred);

	User.fromMap(dynamic obj) {
		this._id 	   = obj["id"];
		this._email    = obj["email"];
		this._fullname = obj["fullname"];
		this._password = obj["password"];
		this._finished = obj["finished"];
		this._starred  = obj["starred"];
	}

	set setEmail(String str) 	  => _email    = str;
	set setFullname(String str)   => _fullname = str;
	set setPassword(String str)   => _password = str;
	set setIslogged(bool state)   => _isLogged = state;
	set setFinished(int finished) => _finished = finished;
	set setStarred(int starred)   => _starred  = starred;

	int    get getId 	   => _id;
	String get getEmail	   => _email;
	String get getFullname => _fullname;
	String get getPassword => _password;
	int    get getFinished => _finished;
	int    get getStarred  => _starred;

	bool   get getIsLogged => _isLogged;

	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		
		map["id"] 		= _id;
		map["email"] 	= _email;
		map["fullname"] = _fullname;
		map["password"] = _password;
		map["finished"] = _finished;
		map["starred"]  = _starred;

		return map;
	}

	String getUserInfo() {
		return _id.toString() + ". " + _fullname + " " + _email + " " + _password + " " + _finished.toString() + " " + _starred.toString();
	}
}