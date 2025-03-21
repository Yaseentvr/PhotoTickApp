import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/client_details.dart';
import 'package:phototickapp/Screens/client/client_detailsadd.dart';
import 'package:phototickapp/Screens/homescreen%20all%20items/bottom_navigation/events/search_bar_widget.dart';
import 'package:phototickapp/colors/colors.dart';
import 'package:phototickapp/db/client_function/db_ClientFunction.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class Eventscreen extends StatefulWidget {
  const Eventscreen({super.key});

  @override
  State<Eventscreen> createState() => _EventscreenState();
}

class _EventscreenState extends State<Eventscreen> {
  TextEditingController _searchController = TextEditingController();
  List<ClientModel> filteredClientList = [];

  String? _selectedEventType;
  List<String> _eventTypes = [
    'Wedding',
    'Birthday',
    'Corporate',
    'Save The Date',
    'Nikkah',
    'Bride to Be',
    'Product',
    'All'
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      filterClients();
    });
    getAllClients(); // Fetch the client data on initialization
  }

  void filterClients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      // Use the _filterEvents function to filter based on both event type and search query
      filteredClientList = _filterEvents(clientListNotifier.value, query);
    });
  }

  List<ClientModel> _filterEvents(
      List<ClientModel> clientList, String searchQuery) {
    List<ClientModel> filteredList = clientList;

    // Apply event type filter if selected
    if (_selectedEventType != null && _selectedEventType != 'All') {
      filteredList = filteredList
          .where((client) => client.event == _selectedEventType)
          .toList();
    }

    // Apply search query filter
    if (searchQuery.isNotEmpty) {
      String query = searchQuery.toLowerCase();
      filteredList = filteredList.where((client) {
        return client.name.toLowerCase().contains(query) ||
            client.phone.toLowerCase().contains(query) ||
            client.date.toLowerCase().contains(query) ||
            client.location.toLowerCase().contains(query) ||
            client.event.toLowerCase().contains(query);
      }).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor:backgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'All Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color:appBarColor,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(15),
            child: SearchBarWidget(controller: _searchController),
          ),

          // Event Type Filter Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color:boxShadow,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: _selectedEventType,
                hint:  Text(
                  'Select Event Type',
                  style: TextStyle(
                    fontSize: 16,
                    color: grey,
                  ),
                ),
                items: _eventTypes.map((eventType) {
                  return DropdownMenuItem<String>(
                    value: eventType,
                    child: Text(
                      eventType,
                      style:  TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:appBarColor,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedEventType = value;
                    filterClients(); // Update the filter when event type is changed
                  });
                },
                underline: SizedBox(), // Remove the default underline
                isExpanded: true,
              ),
            ),
          ),

          // Event List
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: clientListNotifier,
              builder: (BuildContext context, List<ClientModel> clientList, Widget? child) {
                final displayedList = filteredClientList.isNotEmpty ||
                        _searchController.text.isNotEmpty ||
                        _selectedEventType != null
                    ? filteredClientList
                    : clientList; // Show all clients initially if no filters are applied

                // Show nothing if no results match the selected event type
                if (displayedList.isEmpty) {
                  return  Center(
                    child: Text(
                      'No events found.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: grey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: displayedList.length,
                  itemBuilder: (context, index) {
                    final data = displayedList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        color: white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('imagesforapp/07c4720d19a9e9edad9d0e939eca304a.jpg'),
                          ),
                          title: Text(data.name),
                          subtitle: Text(data.date),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return ClientDetailsAdd(
                                      isUpdating: true,
                                      clientToUpdate: data,
                                    );
                                  }));
                                },
                                icon: Icon(Icons.edit, color:editColor),
                              ),
                              IconButton(
                                onPressed: () {
                                  _showAlertDeleteClient(context, data.id);
                                },
                                icon: Icon(Icons.delete, color: deleteColor),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return Details(clientDetailsClick: data);
                            }));
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showAlertDeleteClient(BuildContext context, String id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title:  Text(
            'Delete Client',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: appBarColor,
            ),
          ),
          content: const Text('Are you sure you want to delete this client?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text(
                'No',
                style: TextStyle(color:grey),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteClient(id);
                Navigator.pop(context);
                getAllClients(); // Refresh the client list
              },
              child: Text(
                'Yes',
                style: TextStyle(color:deleteColor),
              ),
            ),
          ],
        );
      },
    );
  }
}