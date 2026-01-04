import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notify.dart';
import 'fs/item.dart';

class ListEle extends StatefulWidget {
  const ListEle({super.key});

  @override
  _ListEle createState() => _ListEle();
}

class _ListEle extends State<ListEle> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onclickSend(BuildContext context) {
    final tx = _controller.text.trim();
    if (tx.isNotEmpty) {
      setState(() {
        _controller.clear();
        context.read<ListNotifier>().add(Items(tx, false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onSubmitted: (v) => onclickSend(context),
                  controller: _controller,
                  maxLength: 120,
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => onclickSend(context),
                child: const Column(children: [Icon(Icons.add), Text('Add')]),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Consumer<ListNotifier>(
            builder: (context, lis, child) => Expanded(
              child: ListView.builder(
                //Builds a Scrollable List of elements
                itemCount: lis.todos.length,
                itemBuilder: (context, index) {
                  final int innerIndex = (lis.todos.length - 1) - index;
                  final item = lis.todos[innerIndex];

                  return Row(
                    children: [
                      Checkbox(
                        value: item.done,
                        onChanged: (bool? value) {
                          context.read<ListNotifier>().changeDone(
                            innerIndex,
                            value ?? false,
                          );
                        },
                      ),
                      Expanded(
                        child: Text(
                          item.text,
                          style: TextStyle(
                            decoration: item.done
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: 'Delete Item',
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Delete $innerIndex'),
                            content: Text(
                              'Are you sure to delete "${item.text}"',
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              FilledButton(
                                onPressed: () {
                                  context.read<ListNotifier>().deleteId(
                                    innerIndex,
                                  );
                                  Navigator.pop(context, 'Delete');
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.red,
                                  ),
                                ),
                                child: const Row (children: [ Icon(Icons.delete_forever), Text('Delete')]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
