import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:mewtwo/home/model/brand_sizing_model.dart';

class SmlMeasurements extends StatelessWidget {
  final List<BrandSizingModel> brandSizings;

  /// key is clothing type
  late final Map<String, List<({String brandName, String size})>> data;
  SmlMeasurements({Key? key, required this.brandSizings}) : super(key: key) {
    // data =;
    final Map<String, List<({String brandName, String size})>> data = {};
    for (final sizing in brandSizings) {
      if (data[sizing.clothing_type] == null) {
        data[sizing.clothing_type] = [];
      }
      data[sizing.clothing_type]!.add((brandName: sizing.brand_name, size: sizing.size));
    }
    this.data = data;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sizes from my favourite brands",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 16,
          ),
          if (data.keys.isEmpty)
          const Center(child: Text("This user has not entered measurements from their favourite brands yet"),),
          ...data.keys.map((type) => buildSingleItem(type)),
        ],
      ),
    );
  }

  Widget buildSingleItem(String clothingType) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          clothingType,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 16,
        ),
        ...data[clothingType]?.mapIndexed((index, _) => buildBrandSize(clothingType, index)) ?? [],
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget buildBrandSize(String clothingType, int index) {
    return Builder(builder: (context) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: IgnorePointer(
              child: TextField(
                controller: TextEditingController()..text = data[clothingType]![index].brandName,
                  decoration: InputDecoration(
                      labelText: "Brand",
                      helperText: "",
                      hintText: 'Select Brand',
                      floatingLabelStyle: const TextStyle(color: Colors.black),
                      // focusedBorder: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF8474A1))),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF8474A1))),
                      floatingLabelBehavior: FloatingLabelBehavior.always)),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          SizedBox(
            width: 50,
            child: IgnorePointer(
              child: TextField(
                controller: TextEditingController()..text = data[clothingType]![index].size,
                  decoration: InputDecoration(
                      helperText: "",
                      floatingLabelStyle: const TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF8474A1))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF8474A1))),
                      labelText: "Size",
                      hintText: 'Select Size',
                      floatingLabelBehavior: FloatingLabelBehavior.always)),
            ),
          ),
        ],
      );
    });
  }
}
