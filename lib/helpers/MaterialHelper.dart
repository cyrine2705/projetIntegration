
import 'dart:convert';

import '../models/Material.dart';

abstract class MaterialHelper {

  static List<Material> fetchMaterials(String encodedMaterialList){

    List<Material> materialList = <Material>[];
    
    for(int i = 0; i < jsonDecode(encodedMaterialList).length; i++){

      materialList.add( Material(
        jsonDecode(encodedMaterialList)[i]["type"]
      ));

    }

    return materialList;

  }
}