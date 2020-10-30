import 'package:flutter/material.dart';

import 'package:covid19/src/models/form.dart';
import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/options/form_item.dart';
import 'package:covid19/src/utils/functions_utils.dart';
import 'package:covid19/src/utils/widgets.dart';

class FormsPage extends StatefulWidget {
  @override
  _FormsPageState createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  Future<List<FormPerson>> _formsFetched;

  List<FormPerson> _forms = List();

  @override
  void initState() {
    _formsFetched = profileProvider.getForms();
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _createFormList(),
    );
  }

  _createFormList() {
    return FutureBuilder(
      future: _formsFetched,
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else if (snapshot.hasData) {
          _loadData(snapshot.data);

          return ListView(
            children: _forms.map(_createElements).toList(),
          );
        } else
          return Container();
      },
    );
  }

  _loadData(dynamic data) {
    if (data != null) _forms = cast<List<FormPerson>>(data);
  }

  Widget _createElements(FormPerson formPerson) {
    return FormItem(form: formPerson);
  }
}
