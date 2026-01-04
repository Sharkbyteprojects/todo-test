import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notify.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  void deleteAll(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Delete all'),
        content: Text(
          'Are you sure to delete ${context.read<ListNotifier>().todos.length} entrys?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<ListNotifier>().deleteAll();
              Navigator.pop(context, 'Delete');
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red),
            ),
            child: const Row(
              children: [Icon(Icons.delete_forever), Text('Delete')],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextButton(
            onPressed: () => deleteAll(context),
            child: Text("Delete All Todo"),
          ),
        ],
      ),
    );
  }
}
