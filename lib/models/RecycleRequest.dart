import 'package:projet_integration/models/Material.dart';

class RecycleRequest {
  int _id = 0;
  Material _material = new Material("");
  double _quantity = 0;
  String _unit = "";
  String _location = "";
  String _dateSubmitted = "";
  String _status = "";

  RecycleRequest(Material material, double quantity, String unit,
      String location, String dateSubmitted, String status) {
    this._material = material;
    this._quantity = quantity;
    this._unit = unit;
    this._location = location;
    this._dateSubmitted = dateSubmitted;
    this._status = status;
  }

  RecycleRequest.fromServer(int id, Material material, double quantity,
      String unit, String location, String dateSubmitted, String status) {
    this._id = id;
    this._material = material;
    this._quantity = quantity;
    this._unit = unit;
    this._location = location;
    this._dateSubmitted = dateSubmitted;
    this._status = status;
  }

  int getId() {
    return this._id;
  }

  Material getMaterial() {
    return this._material;
  }

  double getQuantity() {
    return this._quantity;
  }

  String getUnit() {
    return this._unit;
  }

  String getLocation() {
    return this._unit;
  }

  String getDateSubmitted() {
    return this._dateSubmitted;
  }

  String getStatus() {
    return this._status;
  }

  void setMaterial(Material material) {
    this._material = material;
  }

  void setQuantity(double quantity) {
    this._quantity = quantity;
  }

  void setUnit(String unit) {
    this._unit = unit;
  }

  void setLocation(String location) {
    this._location = location;
  }

  void setDateSubmitted(String dateSubmitted) {
    this._dateSubmitted = dateSubmitted;
  }

  void setStatus(String status) {
    this._status = status;
  }

  dynamic getData() {
    return {
      "material": this._material.getType(),
      "unit": this._unit,
      "quantity": this._quantity,
      "location": this._location,
      "dateSubmitted": this._dateSubmitted,
      "status": this._status
    };
  }

  static RecycleRequest createRecycleRequest(String type, double quantity,
      String unit, String location, String dateSubmitted, String status) {
    return RecycleRequest(
        Material(type), quantity, unit, location, dateSubmitted, status);
  }

  static RecycleRequest fetchRecycleRequestFromServer(
      int id,
      String type,
      double quantity,
      String unit,
      String location,
      String dateSubmitted,
      String status) {
    return RecycleRequest.fromServer(
        id, Material(type), quantity, unit, location, dateSubmitted, status);
  }
}
