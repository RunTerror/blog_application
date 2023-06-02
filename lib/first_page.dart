import 'package:blog_application/blog/add_blog.dart';
import 'package:blog_application/screens/home_screen.dart';
import 'package:blog_application/screens/profile_update.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Widget> pages = const [HomeScreen(), ProfileUpdate()];
  List<String> titles=["Home Screen", "Profile Screen"];
  var currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(19)),
                  child: const Text("Username"),
                )
              ],
            )),
            ListTile(
              title: const Text("all posts"),
              onTap: () {
                
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text(
          titles[currentpage],
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: pages[currentpage],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const AddBlog();
          }));
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.teal,
        shape: const CircularNotchedRectangle(),
        notchMargin: 40,
        child: Container(
          padding: const EdgeInsets.all(0),
          width: double.infinity,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                color: currentpage==0? Colors.grey: Colors.white,
                  onPressed: () {
                    setState(() {
                      currentpage = 0;
                    });
                  },
                  icon: const Icon(
                    Icons.home,
                    size: 40,
                  )),
              IconButton(
                color: currentpage==1? Colors.grey: Colors.white,
                onPressed: () {
                  setState(() {
                    currentpage = 1;
                  });
                },
                icon: const Icon(
                  Icons.person,
                  size: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
