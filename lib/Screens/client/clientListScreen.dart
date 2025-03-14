import 'package:flutter/material.dart';
import 'package:phototickapp/Screens/client/clientDetailsAdd.dart';
import 'package:phototickapp/Screens/client/clientPersonalworksdetails/client_Customs/Client_Details.dart';
import 'package:phototickapp/Screens/client/no_event_added_text.dart';
import 'package:phototickapp/db/client_function/db_ClientFunction.dart';
import 'package:phototickapp/db/client_model/client_model.dart';

class Clientlistscreen extends StatefulWidget {
  final ClientModel clientDetailsClick;

  const Clientlistscreen({super.key, required this.clientDetailsClick});

  @override
  State<Clientlistscreen> createState() => _ClientlistscreenState();
}

class _ClientlistscreenState extends State<Clientlistscreen> {
  TextEditingController _searchController1 = TextEditingController();
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
  Widget build(BuildContext context) {
    getAllClients();
    return Scaffold(
      backgroundColor: const Color(0xFFEFFBFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFFBFB),
        centerTitle: true,
        title: Text('Upcoming Events', style: _textStyle(20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            _searchBar(),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: _filterOptions(),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: clientListNotifier,
                builder: (context, clientList, _) {
                  List<ClientModel> filteredList =
                      _filterEvents(clientList, _searchController1.text);
                  return filteredList.isEmpty
                      ? noEventAdded_text()
                      : _clientListView(filteredList);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _floatingAddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Padding _searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController1,
          decoration: InputDecoration(
            hintText: 'Search events...',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          onChanged: (value) {
            setState(() {}); // Trigger rebuild on search input change
          },
        ),
      ),
    );
  }

  Row _filterOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _eventTypeDropdown()), // Placed inside an Expanded to take available space
        // You can add other filters here if needed
      ],
    );
  }

  Widget _eventTypeDropdown() {
    return Padding(
       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        width: double.infinity,
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: DropdownButton<String>(
          value: _selectedEventType,
          hint: const Text(
            'Select Event Type',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          items: _eventTypes.map(
            (eventType) {
              return DropdownMenuItem<String>(
                value: eventType,
                child: Text(
                  eventType,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF57CFCE)),
                ),
              );
            },
          ).toList(),
          onChanged: (value) {
            setState(() {
              _selectedEventType = value;
            });
          },
          underline: Container(), // Removes the default underline
        ),
      ),
    );
  }

  ListView _clientListView(List<ClientModel> filteredList) {
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final data = filteredList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Card(
            shadowColor: const Color(0xFFEFFBFB),
            elevation: 0,
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('imagesforapp/07c4720d19a9e9edad9d0e939eca304a.jpg'),
              ),
              onTap: () => _navigateToDetails(data),
              trailing: _listTileActions(context, data),
              title: Text(data.name),
              subtitle: Text(data.date),
            ),
          ),
        );
      },
    );
  }

  Row _listTileActions(BuildContext context, ClientModel data) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _navigateToUpdateClient(context, data),
          icon: const Icon(Icons.edit, color: Colors.greenAccent),
        ),
        IconButton(
          onPressed: () => _showAlertDeleteClient(context, data.id),
          icon: const Icon(Icons.delete, color: Colors.redAccent),
        ),
      ],
    );
  }

  FloatingActionButton _floatingAddButton() {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF57CFCE),
      foregroundColor: Colors.white,
      onPressed: () => _showClientDetailsBottomSheet(),
      child: const Icon(Icons.add),
    );
  }

  void _navigateToDetails(ClientModel data) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Details(clientDetailsClick: data);
    }));
  }

  void _navigateToUpdateClient(BuildContext context, ClientModel data) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Clientdetailsadd(isUpdating: true, clientToUpdate: data);
    }));
  }

  void _showClientDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Clientdetailsadd(isUpdating: false),
    );
  }

  Future<void> _showAlertDeleteClient(BuildContext context, String id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: const Text('Are you sure?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
            TextButton(
              onPressed: () {
                deleteClient(id);
                Navigator.pop(context);
                getAllClients();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Event Deleted')));
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  List<ClientModel> _filterEvents(List<ClientModel> clientList, String searchQuery) {
    List<ClientModel> filteredList = clientList;

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Start of this week
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6)); // End of this week

    // Filter clients within this week
    filteredList = filteredList.where((client) {
      DateTime eventDate = DateTime.parse(client.date);
      return eventDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
          eventDate.isBefore(endOfWeek.add(Duration(days: 1)));
    }).toList();

    // Filter by event type
    if (_selectedEventType != null && _selectedEventType != 'All') {
      filteredList = filteredList.where((client) => client.event == _selectedEventType!).toList();
    }

    // Search filter
    if (searchQuery.isNotEmpty) {
      String query = searchQuery.toLowerCase();
      filteredList = filteredList.where((client) {
        return client.name.toLowerCase().contains(query) ||
            client.phone.toLowerCase().contains(query) ||
            client.location.toLowerCase().contains(query) ||
            client.event.toLowerCase().contains(query);
      }).toList();
    }

    return filteredList;
  }

  TextStyle _textStyle(double fontSize) {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: const Color(0xFF57CFCE),
    );
  }
}