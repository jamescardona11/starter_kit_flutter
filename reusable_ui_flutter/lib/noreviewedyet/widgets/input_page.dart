import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  static const String id = 'inputpage';

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String _name = '';
  String _email = '';
  String _date = '';
  String? _defaultOptionDropDown = 'Fly';

  final List<String> _powers = ['Fly', 'Streght', 'Intelligience'];

  final TextEditingController _inpuntFieldDateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inputs'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: <Widget>[
          _createInput(),
          const Divider(height: 20),
          _createEmail(),
          const Divider(height: 20),
          _createPassword(),
          const Divider(height: 20),
          _createPerson(),
          const Divider(height: 20),
          _createDate(),
          const Divider(height: 20),
          _createDropdown(),
          const Divider(height: 20),
        ],
      ),
    );
  }

  Widget _createInput() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,

      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        counter: Text('Letters ${_name.length}'),
        hintText: 'Name of person',
        labelText: 'Name',
        helperText: 'Only is the name',
        suffixIcon: const Icon(Icons.accessibility),
        icon: const Icon(Icons.account_circle),
      ),
      onChanged: (value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget _createPerson() {
    return ListTile(
      title: Text('The name is ? $_name'),
      subtitle: Text('The email is ? $_email'),
    );
  }

  Widget _createEmail() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'main email',
        labelText: 'Email',
        suffixIcon: const Icon(Icons.email),
        icon: const Icon(Icons.alternate_email),
      ),
      onChanged: (value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _createPassword() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Pasword',
        labelText: 'password',
        suffixIcon: const Icon(Icons.lock),
        icon: const Icon(Icons.lock_open),
      ),
      onChanged: (value) {},
    );
  }

  Widget _createDate() {
    return TextField(
      controller: _inpuntFieldDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Date',
        labelText: 'Date',
        suffixIcon: const Icon(Icons.calendar_today),
        icon: const Icon(Icons.calendar_view_day),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        _selectDate(context);
      },
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _inpuntFieldDateController.text = _date;
      });
    }
  }

  List<DropdownMenuItem<String>> getOptionsDropdown() {
    List<DropdownMenuItem<String>> list = [];

    for (var element in _powers) {
      list.add(
        DropdownMenuItem(
          value: element,
          child: Text(element),
        ),
      );
    }

    return list;
  }

  Widget _createDropdown() {
    return DropdownButton(
      value: _defaultOptionDropDown,
      items: getOptionsDropdown(),
      onChanged: (String? value) {
        setState(() {
          _defaultOptionDropDown = value;
        });
      },
    );
  }
}
