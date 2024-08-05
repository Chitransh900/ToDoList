import 'package:flutter/material.dart';
void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<String> box = [];
  String? deletedtodo;
  int? deletetodoindex;
  void addnote()
  {
    showDialog(context: context, builder: (BuildContext context)
    {
     String newtodo = "";
     return AlertDialog(
       title: Text("enter the task",style: TextStyle(fontWeight: FontWeight.bold),),
       content :
         TextField(
           onChanged: (value) {
             newtodo = value;
           },
         ),
         actions: [
           ElevatedButton(onPressed: () {
             setState(() {
               if(newtodo.isNotEmpty)
                 {
                   box.add(newtodo);
                 }
                   Navigator.pop(context);
         }
         );
     },
        child: Text("ADD"),
      ),
    ],
     );
    });
  }
  void deletetodo(int index)
  {
    setState(() {
      deletedtodo = box[index];
      deletetodoindex = index;
      box.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Deleted'${deletedtodo??''}'"),
          action: SnackBarAction(label: "UNDO", onPressed: (){
            setState(() {
              box.insert(deletetodoindex?? 0 , deletedtodo ?? '');
            });
          }),
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF583362),
      appBar: AppBar(title: const Text("Todo-List",style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: const Color(
          0xFFCE77E5),),
      body: ListView.builder(itemCount: box.length,
        itemBuilder: (context, index)
      {
        return Dismissible(key: Key(box[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              deletetodo(index);
            },
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child:
        Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(title: Text(box[index],style: const TextStyle(fontSize: 18),),),
        ),
        );
      }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addnote,
        backgroundColor: const Color(0xFFCE77E5),
        child: const Icon(Icons.add,),
      ),
    );
  }
}

