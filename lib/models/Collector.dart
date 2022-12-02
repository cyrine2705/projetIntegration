import 'package:projet_integration/models/Citizen.dart';
import 'package:projet_integration/models/User.dart';

class Collector extends Citizen {
  Collector(User userProfile, String name, String lastname, int recycleCoins)
      : super(userProfile, name, lastname, recycleCoins) {}
}
