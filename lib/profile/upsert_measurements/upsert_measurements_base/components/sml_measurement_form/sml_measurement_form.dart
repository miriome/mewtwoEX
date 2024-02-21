import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/components/sml_measurement_form/sml_measurement_form_store.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/upsert_measurements_base_store.dart';

class SmlMeasurementForm extends StatelessWidget {
  final UpsertMeasurementsBaseStore store;
  final SmlMeasurementFormStore formStore = SmlMeasurementFormStore();
  SmlMeasurementForm({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Text("Sizes from my favourite brands"),
            ...formStore.availableClothingCategories.map((type) => buildSingleItem(type))
            ,
          ],
        ),
      );
    });
  }

  Widget buildSingleItem(String category) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(category),
        ...formStore.clothingSizings[category]?.mapIndexed((index, _) => buildBrandSize(category, index)) ?? [],
        SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            formStore.clothingSizings[category]?.add(BrandSizing());
          },
          child: SvgPicture.asset(
            "assets/icons/ic_add.svg",
            height: 30,
            width: 30,
          ),
        ),
      ],
    );
  }

  Widget buildBrandSize(String category, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: FormBuilderDropdown(
              name: '${category}_brand_$index',
              isExpanded: false,
              items: [DropdownMenuItem(value: "test", child: Text("test"))] as List<DropdownMenuItem<String>>,
              onSaved: (text) {
                if (text != null) {
                  formStore.clothingSizings[category]?[index].brand = text;
                }
              },
              decoration: const InputDecoration(
                counterText: "",
                labelText: "Brand",
              )),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: FormBuilderDropdown(
              name: '${category}_size_$index',
              isExpanded: false,
              items: [DropdownMenuItem(value: "test", child: Text("test"))] as List<DropdownMenuItem<String>>,
              onSaved: (text) {
                if (text != null) {
                  formStore.clothingSizings[category]?[index].size = text;
                }
              },
              decoration: const InputDecoration(
                labelText: "Size",
              )),
        ),
        const SizedBox(
          width: 12,
        ),
        SvgPicture.asset(
          'assets/icons/ic_remove2.svg',
          height: 32,
          width: 32,
        ),
      ],
    );
  }
}
