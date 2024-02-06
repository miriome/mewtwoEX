import 'package:flutter/material.dart';
import 'package:mewtwo/profile/edit_styles_page/edit_styles_page_store.dart';
import 'package:mewtwo/unauth/pages/onboarding/select_style_page/select_style_page.dart';

class EditStylesPage extends SelectStylePage {
  late final EditStylesPageStore editStylesStore;
  EditStylesPage({ Key? key }) : super(key: key) {
    editStylesStore = EditStylesPageStore(store: store)..load();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar( 
        ),
        body: buildBody()
      ),
    );
  }

  @override
  Future<void> onCtaTap(BuildContext context) async {
    final editSuccess = await editStylesStore.editStyles(store.selectedStyles);
    if (editSuccess && context.mounted) {
      Navigator.of(context).pop();
    }
    
  }
}