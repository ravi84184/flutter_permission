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
              if (status.isGranted) {
                // Proceed with camera-related task
                showToast("Camera access granted");
              } else if (status.isDenied) {
                // Request for permission to user
                requestCameraPermission();
              }
            },
            child: const Text("Ask camera permission"),
          ),
          ElevatedButton(
            onPressed: () async {
              // Now you can try this with storage permission.
              var status = await Permission.storage.status;
              if(status.isGranted){
                // Do next step for this
              } else if(status.isGranted){
                // Request for storage permission
                requestStoragePermission();
              }
            },
            child: const Text("Ask storage permission"),
          ),
        ],
      ),
    );
  }

  requestStoragePermission() async {
    var status = await Permission.storage.request();
    if(status.isGranted){
      // Do what you want with permission
    } else if(status.isDenied){
      // Show with this permission how you can improve
    } else if(status.isPermanentlyDenied){
      // Show dialog or open app setting for manual permission.
    }
  }


  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      // Handle denied
      showToast("Camera access denied");
    } else if (status.isPermanentlyDenied) {
      showToast("Camera access permanently denied");
      // Permission permanently denied, show dialog or redirect to app settings
    } else if (status.isGranted) {
      showToast("Camera access granted");
      // Proceed with camara related task.
    }
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
