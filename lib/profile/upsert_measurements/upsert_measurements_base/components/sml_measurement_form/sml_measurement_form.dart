import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sizes from my favourite brands",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 16,
            ),
            ...formStore.availableClothingCategories.map((type) => buildSingleItem(type)),
            const SizedBox(
              height: 24,
            ),
            FormBuilderSwitch(
              name: "measurementPrivacy",
              initialValue: store.hideFromNonFollowers,
              title: const Text(
                "Hide my measurements from people who do not follow me",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              onSaved: (hide) {
                store.hideFromNonFollowers = hide ?? false;
              },
              inactiveTrackColor: const Color(0xFF7D7878),
              decoration: const InputDecoration(enabledBorder: InputBorder.none, contentPadding: EdgeInsets.zero),
            ),
          ],
        ),
      );
    });
  }

  Widget buildSingleItem(String category) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ...formStore.clothingSizings[category]?.mapIndexed((index, _) => buildBrandSize(category, index)) ?? [],
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            formStore.addSize(category);
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
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: FormBuilderDropdown(
                  name: "${formStore.clothingSizings[category]![index].key}_brand",
                  isExpanded: false,
                  
                  items: const [DropdownMenuItem(value: "test", child: Text("test"))],
                  validator: FormBuilderValidators.required(),
                  onChanged: (text) {
                    if (text != null) {
                      formStore.clothingSizings[category]?[index].brand = text;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Brand",
                      hintText: 'Select Brand',
                      floatingLabelStyle: TextStyle(
                          color: formStore.clothingSizings[category]![index].brand.isNotEmpty
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: formStore.clothingSizings[category]![index].brand.isNotEmpty
                                  ? Theme.of(context).primaryColor
                                  : Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: formStore.clothingSizings[category]![index].brand.isNotEmpty
                                  ? Theme.of(context).primaryColor
                                  : Colors.black)),
                      floatingLabelBehavior: FloatingLabelBehavior.always)),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: FormBuilderDropdown(
                  name: "${formStore.clothingSizings[category]![index].key}_size",
                  isExpanded: false,
                  validator: FormBuilderValidators.required(),
                  items: const [DropdownMenuItem(value: "test", child: Text("test"))],
                  onChanged: (text) {
                    if (text != null) {
                      formStore.clothingSizings[category]?[index].size = text;
                    }
                  },
                  decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(
                          color: formStore.clothingSizings[category]![index].size.isNotEmpty
                              ? Theme.of(context).primaryColor
                              : Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: formStore.clothingSizings[category]![index].size.isNotEmpty
                                  ? Theme.of(context).primaryColor
                                  : Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: formStore.clothingSizings[category]![index].size.isNotEmpty
                                  ? Theme.of(context).primaryColor
                                  : Colors.black)),
                      labelText: "Size",
                      hintText: 'Select Size',
                      floatingLabelBehavior: FloatingLabelBehavior.always)),
            ),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: () {
                formStore.removeSize(category: category, index: index);
              },
              child: SvgPicture.asset(
                'assets/icons/ic_remove2.svg',
                height: 32,
                width: 32,
              ),
            ),
          ],
        ),
      );
    });
  }
}
