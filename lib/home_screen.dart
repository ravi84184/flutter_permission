import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Devs Nik - Permission"),
        elevation: 2,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Center(
              child: Text(
            "Permission",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              var status = await Permission.camera.status;
              if (status.isDenied) {
                status = await Permission.camera.request();
                if (status.isDenied) {
                  showToast("Camera access denied");
                } else if (status.isPermanentlyDenied) {
                  showToast("Camera access permanently denied");
                } else if (status.isGranted) {
                  showToast("Camera access granted");
                }
              } else if (status.isGranted) {
                showToast("Camera access granted");
              }
            },
            child: const Text("Ask camera permission"),
          ),
          ElevatedButton(
            onPressed: () async {
              var status = await Permission.storage.status;
              print(status.toString());
              if (status.isDenied) {
                status = await Permission.storage.request();
                if (status.isDenied) {
                  showToast("Storage access denied");
                } else if (status.isPermanentlyDenied) {
                  showToast("Storage access permanently denied");
                } else if (status.isGranted) {
                  showToast("Storage access granted");
                }
              } else if (status.isGranted) {
                showToast("Storage access granted");
              }
            },
            child: const Text("Ask storage permission"),
          ),
        ],
      ),
    );
  }

  void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: isError ? Colors.red : null,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
