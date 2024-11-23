import 'package:farmertoconsumer/models/user.dart';
import 'package:farmertoconsumer/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/product-create.dart';

class ProducerProfileScreen extends StatefulWidget {
  const ProducerProfileScreen({Key? key}) : super(key: key);

  @override
  _ProducerProfileScreenState createState() => _ProducerProfileScreenState();
}

class _ProducerProfileScreenState extends State<ProducerProfileScreen> {
  int selectedIndex = 0; // Aktív oldal indexe

  final TextEditingController userDescriptionController = TextEditingController();

  User user = User(id: "1", name: "name", email: "email");
  String savedDescription = "No description given"; // Kezdőérték a leírásnak
  bool isEditing = false; // Állapot a szerkesztési módhoz

  @override
  void dispose() {
    userDescriptionController.dispose(); // Fontos a memória szivárgás elkerüléséhez
    super.dispose();
  }

  void _saveDescription() {
    setState(() {
      savedDescription = userDescriptionController.text.isEmpty
          ? "No description given"
          : userDescriptionController.text;
      isEditing = false; // Kilépés a szerkesztési módból
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Description saved!')),
    );
  }

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        // Ha kilép a szerkesztési módból, töröljük a szöveget
        userDescriptionController.clear();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          SvgPicture.asset('assets/icons/back-arrow.svg', width: 30, height: 30, color: white,),
          Text(
            'Profile', 
            style: TextStyle(color: white),)
        ],
        ),
        backgroundColor: Colors.green
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Producer profile',
              style: TextStyle(color: Colors.green, fontSize: 12, fontStyle: FontStyle.italic),
              ),
            const SizedBox(height: 10),
            Text(
              savedDescription,
              style: const TextStyle(color: Colors.green, fontSize: 16),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _toggleEditing,
              child: Text(
                isEditing ? 'Cancel' : 'Edit',),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white
              )
            ),
            const SizedBox(height: 10),
            if (isEditing) // Feltételes megjelenítés
              Column(
                children: [
                  TextField(
                    controller: userDescriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write yourself...',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveDescription,
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white
                    ),
                  ),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductCreateForm()),
                );
              },
              style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white
                    ),
              child: const Text('Create Product'),
            ),

            // Linkek vízszintes sora
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Vízszintes görgetés
              child: Row(
                children: [
                  _buildLinkButton('Current order(s)', 0),
                  _buildLinkButton('Order history', 1),
                  _buildLinkButton('Product management', 2),
                  _buildLinkButton('Order management', 3),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Dinamikus tartalom
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  _buildOrdersList(), // Korábbi rendelések
                  _buildOrdersList(),
                  _buildUserProductsList(), // Saját termékek
                  _buildOrderConfirmList(), // Elfogadásra váró rendelések
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Link gombokat hoz létre
  Widget _buildLinkButton(String title, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          color: selectedIndex == index ? Colors.green : Colors.black,
        ),
      ),
    );
  }

  // Korábbi rendelések
  Widget _buildOrdersList() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.shopping_bag),
          title: Text('Order 1'),
          subtitle: Text('2024.01.10 - price: 10.000 Ft'),
        ),
        ListTile(
          leading: Icon(Icons.shopping_bag),
          title: Text('Order 2'),
          subtitle: Text('2024.02.15 - price: 15.000 Ft'),
        ),
        ListTile(
          leading: Icon(Icons.shopping_bag),
          title: Text('Order 3'),
          subtitle: Text('2024.03.01 - price: 20.000 Ft'),
        ),
      ],
    );
  }

  
  // Saját termékek listája
  Widget _buildUserProductsList() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.production_quantity_limits),
          title: Text('product 1'),
          subtitle: Text('items left: '),
        ),
        ListTile(
          leading: Icon(Icons.production_quantity_limits),
          title: Text('product 2'),
          subtitle: Text('items left: '),
        ),
        ListTile(
          leading: Icon(Icons.production_quantity_limits),
          title: Text('product 3'),
          subtitle: Text('items left: '),
        ),
      ],
    );
  }

  //Elfogadásra váró rendelések
  Widget _buildOrderConfirmList() {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.production_quantity_limits),
          title: Text('product 1'),
          subtitle: Text('price: 5.000 Ft'),
        ),
        ListTile(
          leading: Icon(Icons.production_quantity_limits),
          title: Text('product 2'),
          subtitle: Text('price: 10.000 Ft'),
        ),
        ListTile(
          leading: Icon(Icons.production_quantity_limits),
          title: Text('product 3'),
          subtitle: Text('price: 20.000 Ft'),
        ),
      ],
    );
  }
}
