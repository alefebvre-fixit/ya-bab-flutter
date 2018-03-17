import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:yabab/groups/group.model.dart';
import 'package:yabab/groups/group.service.dart';

final reference = Firestore.instance.collection('groups');

class CreateGroupWidget extends StatefulWidget {
  @override
  _ExampleWidgetState createState() => new _ExampleWidgetState();
}

/// State for [ExampleWidget] widgets.
class _ExampleWidgetState extends State<CreateGroupWidget> {
  final TextEditingController _controller = new TextEditingController();

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _name;
  String _location;

  void _submit(BuildContext context) {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      Group group = new Group(
          name: _name,
          id: null,
          location: 'Lille'
      );

      GroupService.instance.upsert(group);

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      _performLogin(context);
    }
  }

  void _performLogin(BuildContext context) {
    // This is just a demo, so no actual login here.
    final snackbar = new SnackBar(
      content: new Text('Email: $_name, password: $_location'),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Create new League'),
      ),
      body: new Form(
        key: formKey,
        child: new Column(
          children: <Widget>[
            new ListTile(
              leading: const Icon(CommunityMaterialIcons.trophy),
              title: new TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'Name can\'t be empty.' : null,
                onSaved: (val) => _name = val,
                decoration: new InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.place),
              title: new TextFormField(
                onSaved: (val) => _location = val,
                decoration: new InputDecoration(
                  hintText: "Location",
                ),
              ),
            ),
            new RaisedButton(
                child: new Text('DONE'),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text('This is snackbar .'),
                        action: new SnackBarAction(
                          label: 'ACTION',
                          onPressed: () {
                            _submit(context);
                          },
                        ),
                      ));
                }),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Save', // used by assistive technologies
        child: new Icon(Icons.check),
        onPressed: () {
          _submit(context);
        },
      ),
    );
  }
}
