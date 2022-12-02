class Notification {

  String _description = "";
  String _date = "";
  bool _checked = false;

  Notification(String description, String date, bool checked){
    this._description = description;
    this._date = date;
    this._checked = checked;
  }

  String getDescription() {
    return this._description;
  }

  String getDate() {
    return this._date;
  }

  bool isChecked() {
    return this._checked;
  }

  void setDescription(String description) {
    this._description = description;
  }

  void setDate(String date) {
    this._date = date;
  }

  void setChecked(bool checked) {
    this._checked = checked;
  }



}