import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/date_text_field.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/event_textfield.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/location_textfield.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/name_textfield.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/phone_textfield.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/save_custom_button.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/time_text_field.dart';
import 'package:phototickapp/Screens/client/clientpersonal_worksdetails/client_customs/update_custom_bottom.dart';
import 'package:phototickapp/Screens/client/customfields/budget_textfield_home.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/client_function/db_ClientFunction.dart';
import 'package:phototickapp/db/client_model/client_model.dart';
import 'package:phototickapp/notifications/notification_service.dart';
import 'package:phototickapp/screen_Sizes/screenSize.dart';

class ClientDetailsAdd extends StatefulWidget {
  final ClientModel? clientToUpdate;
  final bool isUpdating;

  const ClientDetailsAdd({
    super.key,
    required this.isUpdating,
    this.clientToUpdate,
  });

  @override
  State<ClientDetailsAdd> createState() => _ClientdetailsaddState();
}

class _ClientdetailsaddState extends State<ClientDetailsAdd> {
  late bool isUpadating;
  late Box<ClientModel> clientBox;

  final _nameHomeController = TextEditingController();
  final _phoneHomeController = TextEditingController();
  final _locationHomeController = TextEditingController();
  final _timeHomeController = TextEditingController();
  final _dateHomeController = TextEditingController();
  final _eventHomeController = TextEditingController();
  final _budgetHomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    NotificationService.initialize();
    requestExactAlarmPermission();
    clientBox = Hive.box<ClientModel>('client_box');
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

  Future<void> requestExactAlarmPermission() async {
    final status = await Permission.scheduleExactAlarm.request();
    log('Exact alarm permission request status from add client: $status');
    if (status.isDenied) {
      log('Exact alarm permission denied by user from add client.');
    } else if (status.isPermanentlyDenied) {
      log('Exact alarm permission permanently denied by user from add client.');
      openAppSettings();
    } else if (status.isGranted) {
      log('Exact alarm permission granted from add client.');
    }
  }

  Future<void> scheduleEventNotifications(DateTime eventDateTime) async {
    final hasPermission = await Permission.scheduleExactAlarm.isGranted;
    log("Exact Alarm Permission Status: $hasPermission");

    if (!hasPermission) {
      log('Exact alarm permission denied.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enable exact alarms in settings.')),
      );
      return;
    }

    try {
      await NotificationService.scheduleEventNotifications(eventDateTime);
    } catch (e) {
      log("Error scheduling notification: $e");
    }
  }

  void _onSave() {
    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      final timeFormat = DateFormat('HH:mm');
      final date = dateFormat.parse(_dateHomeController.text);
      final time = timeFormat.parse(_timeHomeController.text);

      final eventDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

      log('Parsed Event DateTime: $eventDateTime');
      scheduleEventNotifications(eventDateTime);
    } catch (e) {
      log('Error parsing date/time: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid date or time format')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Screensize();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          isUpadating ? 'Update Client Details' : 'Add Client Details',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.bold, color: appBarColor),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: white,
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
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: budget_textfieldHome(
                        budgetHomeController: _budgetHomeController)),
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
                                final DateTime eventDateTime = DateTime.parse(
                                  "${_dateHomeController.text} ${_timeHomeController.text}",
                                );
                                _onSave();
                                addClientSaveButtonClicked();
                                Navigator.pop(context);
                                getAllClients();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill all fields')),
                                );
                              }
                            },
                            child: isUpadating
                                ? updateCustomBottom()
                                : save_customButton(),
                          ),
                        ),
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
        _dateHomeController.text = "${pickedDate.toLocal()}".split(' ')[0];
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
        _timeHomeController.text = "$hour:$minute";
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
          driveLink1: '', // Provide a default value or a valid link
        ),
      );
      return;
    }
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
      driveLink1: '', // Provide a default value or a valid link
    );
    addClient(_client);
    _dateHomeController.clear();
    _timeHomeController.clear();
    _nameHomeController.clear();
    _locationHomeController.clear();
    _eventHomeController.clear();
    _phoneHomeController.clear();
    _budgetHomeController.clear();
  }
}
