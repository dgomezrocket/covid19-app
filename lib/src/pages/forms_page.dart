import 'package:flutter/material.dart';

import 'package:covid19/src/models/form.dart';
import 'package:covid19/src/pages/form_page.dart';
import 'package:covid19/src/providers/profile_provider.dart';
import 'package:covid19/src/utils/widgets.dart';
import 'package:covid19/src/utils/styles_options.dart';

class FormsPage extends StatefulWidget {
  @override
  _FormsPageState createState() => _FormsPageState();
}

class _FormsPageState extends State<FormsPage> {
  Future<List<FormPerson>?>? _formsFetched;

  @override
  void initState() {
    super.initState();
    _formsFetched = profileProvider.getForms();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FormPerson>?>(
      future: _formsFetched,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return createCircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          return _buildFormsList(snapshot.data!);
        } else {
          return Center(
            child: Text('No hay formularios disponibles'),
          );
        }
      },
    );
  }

  Widget _buildFormsList(List<FormPerson> forms) {
    if (forms.isEmpty) {
      return Center(
        child: Text('No hay formularios disponibles'),
      );
    }

    return ListView.builder(
      itemCount: forms.length,
      itemBuilder: (context, index) {
        return _buildFormItem(forms[index]);
      },
    );
  }

  Widget _buildFormItem(FormPerson form) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(
          form.title,
          style: title_bold_style,
        ),
        subtitle: Text(form.subtitle),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPage(form: form),
            ),
          );
        },
      ),
    );
  }
}