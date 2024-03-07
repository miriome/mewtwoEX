import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/upsert_measurements_base_store.dart';

class SmlMeasurementForm extends StatelessWidget {
  final UpsertMeasurementsBaseStore store;

  const SmlMeasurementForm({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formStore = store.smlMeasurementStore;
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
            ...formStore.availableClothingTypes.map((type) => buildSingleItem(type)),
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

  Widget buildSingleItem(String clothingType) {
    final formStore = store.smlMeasurementStore;
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
        ...formStore.clothingSizings[clothingType]?.mapIndexed((index, _) => buildBrandSize(clothingType, index)) ?? [],
        GestureDetector(
          onTap: () {
            formStore.addSize(clothingType);
          },
          child: SvgPicture.asset(
            "assets/icons/ic_add.svg",
            height: 30,
            width: 30,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget buildBrandSize(String clothingType, int index) {
    final formStore = store.smlMeasurementStore;
    final brandSizing = formStore.clothingSizings[clothingType]![index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Observer(builder: (context) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: FormBuilderDropdown(
                  key: ValueKey("${brandSizing.key}_brand"),
                  name: "${brandSizing.key}_brand",
                  items: formStore
                      .getBrandOptions(clothingType: clothingType, sizingIndex: index)
                      .map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis)))
                      .toList(),
                  initialValue: brandSizing.brandName,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: "Select a brand"),
                    (val) {
                      final brandNamesInClothingType = formStore.clothingSizings[clothingType]
                              ?.map((element) => element.brandName).toList() ?? [];
                      if (brandNamesInClothingType.count((brandName) => val == brandName) > 1) {
                        return "Repeated brand, please select another";
                      }
                      return null;
                    }
                  ]),
                  onChanged: (text) {
                    if (text != null) {
                      brandSizing.brandName = text;
                      if (!store.formKey.currentState!.isValid) {
                        store.formKey.currentState!.validate();
                      }
                      
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Brand",
                      hintText: 'Select Brand',
                      errorStyle: const TextStyle(fontSize: 8),
                      errorMaxLines: 2,
                      floatingLabelStyle: TextStyle(
                          color: brandSizing.brandName.isNotEmpty ? Theme.of(context).primaryColor : Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: brandSizing.brandName.isNotEmpty ? Theme.of(context).primaryColor : Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: brandSizing.brandName.isNotEmpty ? Theme.of(context).primaryColor : Colors.black)),
                      floatingLabelBehavior: FloatingLabelBehavior.always)),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: FormBuilderDropdown(
                  key: ValueKey("${brandSizing.key}_size"),
                  name: "${brandSizing.key}_size",
                  validator: FormBuilderValidators.required(errorText: "Select a size"),
                  initialValue: brandSizing.size,
                  items: formStore
                      .getSizeOptions(clothingType: clothingType, sizingIndex: index)
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                          )))
                      .toList(),
                  onChanged: (text) {
                    if (text != null) {
                      brandSizing.size = text;
                      store.formKey.currentState!.validate();
                    }
                  },
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(fontSize: 8),
                      floatingLabelStyle:
                          TextStyle(color: brandSizing.size.isNotEmpty ? Theme.of(context).primaryColor : Colors.black),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: brandSizing.size.isNotEmpty ? Theme.of(context).primaryColor : Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: brandSizing.size.isNotEmpty ? Theme.of(context).primaryColor : Colors.black)),
                      labelText: "Size",
                      hintText: 'Select Size',
                      errorMaxLines: 2,
                      floatingLabelBehavior: FloatingLabelBehavior.always)),
            ),
            const SizedBox(
              width: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: GestureDetector(
                onTap: () {
                  formStore.removeSize(clothingType: clothingType, index: index);
                  store.formKey.currentState!.removeInternalFieldValue("${brandSizing.key}_size");
                  store.formKey.currentState!.removeInternalFieldValue("${brandSizing.key}_brand");
                  store.formKey.currentState!.validate();
                },
                child: SvgPicture.asset(
                  'assets/icons/ic_remove2.svg',
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
