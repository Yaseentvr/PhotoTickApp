import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/budget_textfield_home.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/date_text_field.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/event_textfield.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/location_textfield.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/name_textfield.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/phone_textfield.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/save_custom_button.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/time_text_field.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/update_custom_bottom.dart';
import 'package:phototickapp/db/client_function/db_ClientFunction.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class Clientdetailsadd extends StatefulWidget {
  final ClientModel? clientToUpdate;
  final bool isUpdating;

  const Clientdetailsadd({
    super.key,
    required this.isUpdating,
    this.clientToUpdate,
  });

  @override
  State<Clientdetailsadd> createState() => _ClientdetailsaddState();
}

class _ClientdetailsaddState extends State<Clientdetailsadd> {
  late bool isUpadating;

  final _nameHomeController = TextEditingController();
  final _phoneHomeController = TextEditingController();
  final _locationHomeController = TextEditingController();
  final _timeHomeController = TextEditingController();
  final _dateHomeController = TextEditingController();
  final _eventHomeController = TextEditingController();
  final _budgetHomeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.clientToUpdate != null) {
      _nameHomeController.text = widget.clientToUpdate!.name;
      _dateHomeController.text = widget.clientToUpdate!.date;
      _phoneHomeController.text = widget.clientToUpdate!.phone;
      _timeHomeController.text = widget.clientToUpdate!.time;
      _locationHomeController.text = widget.clientToUpdate!.location;
      _eventHomeController.text = widget.clientToUpdate!.event;
      _budgetHomeController.text = widget.clientToUpdate!.budget;
      if (widget.isUpdating) {
        isUpadating = true;
      }
    } else {
      isUpadating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Screensize();
    return Scaffold(
      backgroundColor: Color(0xFFEFFBFB),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color(0xFFEFFBFB),
        centerTitle: true,
        title: Text(
          isUpadating ? 'Update Client Details' : 'Add Client Details',
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xFF57CFCE)),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 50),
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: date_textField(
                              dateHomeController: _dateHomeController),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 20, top: 50),
                      child: GestureDetector(
                        onTap: () => _selectTime(context),
                        child: AbsorbPointer(
                          child: timeTextField(
                              timeHomeController: _timeHomeController),
                        ),
                      ),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child:
                      name_textfield(nameHomeController: _nameHomeController),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: location_textfield(
                      locationHomeController: _locationHomeController),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child:
                      eventTextfield(eventHomeController: _eventHomeController),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: phone_textfield(
                      phoneHomeController: _phoneHomeController),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child:  budget_textfieldHome(budgetHomeController: _budgetHomeController)
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              if (_dateHomeController.text.trim().isNotEmpty &&
                                  _timeHomeController.text.trim().isNotEmpty &&
                                  _nameHomeController.text.trim().isNotEmpty &&
                                  _locationHomeController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _phoneHomeController.text.trim().isNotEmpty &&
                                  _eventHomeController.text.trim().isNotEmpty &&
                                  _budgetHomeController.text
                                      .trim()
                                      .isNotEmpty) {
                                addClientSaveButtonClicked();
                                Navigator.pop(context);
                                getAllClients();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('please fill all fields')),
                                );
                              }
                            },
                            child: isUpadating
                                ? updateCustomBottom()
                                : save_customButton(),
                          ),
                        ),
                        // ToDoCustomButton(),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateHomeController.text =
            "${pickedDate.toLocal()}".split(' ')[0]; // Format date
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        final hour = pickedTime.hour.toString().padLeft(2, '0');
        final minute = pickedTime.minute.toString().padLeft(2, '0');
        _timeHomeController.text = "$hour:$minute"; // Format as HH:MM
      });
    }
  }

  Future<void> addClientSaveButtonClicked() async {
    final dateHome = _dateHomeController.text.trim();
    final timeHome = _timeHomeController.text.trim();
    final nameHome = _nameHomeController.text.trim();
    final locationHome = _locationHomeController.text.trim();
    final eventHome = _eventHomeController.text.trim();
    final phoneHome = _phoneHomeController.text.trim();
    final budgetHome = _budgetHomeController.text.trim();

    if (dateHome.isEmpty ||
        timeHome.isEmpty ||
        nameHome.isEmpty ||
        locationHome.isEmpty ||
        eventHome.isEmpty ||
        phoneHome.isEmpty ||
        budgetHome.isEmpty) {
      return;
    }
    if (isUpadating) {
      await updatedClients(
        ClientModel(
          date: dateHome,
          time: timeHome,
          id: widget.clientToUpdate!.id,
          name: nameHome,
          location: locationHome,
          event: eventHome,
          phone: phoneHome,
          budget: budgetHome,
          
        ),
      );
      return;
    }
    print(
        '$dateHome $timeHome $nameHome $locationHome $eventHome $phoneHome $budgetHome');
    String id = randomId2();

    final _client = ClientModel(
        date: dateHome,
        time: timeHome,
        name: nameHome,
        location: locationHome,
        event: eventHome,
        phone: phoneHome,
        budget: budgetHome,
        id: id,
        
        );
    addClient(_client);
    // log(clientListNotifier.value.length.toString());
    _dateHomeController.clear();
    _timeHomeController.clear();
    _nameHomeController.clear();
    _locationHomeController.clear();
    _eventHomeController.clear();
    _phoneHomeController.clear();
    _budgetHomeController.clear();
  }
}
