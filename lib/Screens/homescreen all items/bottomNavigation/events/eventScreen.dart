import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/clientDetailsAdd.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/Client_Details.dart';
import 'package:phototickapp/db/client_function/db_ClientFunction.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class Eventscreen extends StatefulWidget {
  const Eventscreen({
    super.key,
  });

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
      backgroundColor: Color(0xFFEFFBFB),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFFBFB),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'All Events',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFF57CFCE),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
          ),

          // Event Type Filter Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: _selectedEventType,
                hint: Text(
                  'Select Event Type',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                items: _eventTypes.map((eventType) {
                  return DropdownMenuItem<String>(
                    value: eventType,
                    child: Text(
                      eventType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF57CFCE),
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
              builder: (BuildContext context, clientList, Widget? child) {
                final displayedList = filteredClientList.isNotEmpty ||
                        _searchController.text.isNotEmpty ||
                        _selectedEventType != null
                    ? filteredClientList
                    : clientList; // Show all clients initially if no filters are applied

                // Show nothing if no results match the selected event type
                if (displayedList.isEmpty) {
                  return Center(
                    child: Text(
                      'No events found.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                 
                  itemCount: displayedList.length,
                  itemBuilder: (context, index) {
                    final data = displayedList[index];
                    return Padding(
                        padding: const  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'imagesforapp/07c4720d19a9e9edad9d0e939eca304a.jpg'),
                            ),
                            title: Text(
                              data.name,
                             
                            ),
                            subtitle: Text(
                              data.date,
                              
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Clientdetailsadd(
                                        isUpdating: true,
                                        clientToUpdate: data,
                                      );
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _showAlertDeleteClient(context, data.id);
                                    getAllClients();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Details(
                                  clientDetailsClick: data,
                                );
                              }));
                            },
                          ),
                        ));
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
          title: Text(
            'Delete Client',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF57CFCE),
            ),
          ),
          content: Text('Are you sure you want to delete this client?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                deleteClient(id);
                Navigator.pop(context);
                getAllClients();
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
