import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_upload_image/login_in/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String changTitle = "Grid View";
  bool checkView = false;
  File? imageFile;
  String? imageUrl;
  String? myImage;
  String? myname;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _showImageDiaLog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Plaese choose an option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () =>
                    //get fromcamera
                    _getFromCamera(),
                child: const Row(children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.camera,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(color: Colors.red),
                  ),
                ]),
              ),
              InkWell(
                onTap: () => _getFromGallery(),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.image,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      "Gallery",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context); // Remove context parameter
  }

  void _getFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context); // Remove context parameter
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedFile = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedFile != null) {
      setState(() {
        imageFile = File(croppedFile.path);
      });
    }
  }

  void _uploadImage() async {
    if (imageFile == null) {
      Fluttertoast.showToast(msg: "Please select an Image");
    }
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("userImage")
          .child('${DateTime.now()}jpg');
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection("wallpaper")
          .doc(DateTime.now().toString())
          .set({
        "id": _auth.currentUser!.uid,
        "email": _auth.currentUser!.email,
        "userImage": myImage,
        "name": myname,
        "image": imageUrl,
        "downloads": 0,
        "createAt": DateTime.now(),
      });
      Navigator.canPop(context) ? Navigator.pop(context) : null;
      imageFile = null;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void read_userInfor() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      FirebaseFirestore.instance
          .collection("user")
          .doc(currentUser.uid)
          .get()
          .then<dynamic>((DocumentSnapshot snapshot) async {
        myImage = snapshot.get("userImage");
        myname = snapshot.get("name");
      });
    } else {
      // Xử lý trường hợp người dùng chưa đăng nhập hoặc đã đăng xuất
      // Ví dụ: Hiển thị một thông báo hoặc thực hiện các hành động khác
    }
  }

  @override
  void initState() {
    super.initState();
    read_userInfor();
  }

  Widget listViewWideget(String docId, String img, String userImage,
      String name, DateTime date, String userId, int downloads) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        
        elevation: 16,
        shadowColor: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(userImage),
                  ),
                  
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5),
                            child: const Text(
                              " đã thêm ảnh mới.",
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(calculateTimeAgo(date),
                          style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  //
                },
                child: Image.network(
                  img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  //date time
  String calculateTimeAgo(DateTime date) {
    Duration difference = DateTime.now().difference(date);
    if (difference.inMinutes < 1) {
      return 'Vừa xong';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} giờ trước';
    } else {
      return DateFormat("dd-MM-yyyy - HH:mm").format(date);
    }
  }

  Widget gridViewWideget(String docId, String img, String userImg, String name,
      DateTime date, String userId, int downloads) {
    return GridView.count(
      crossAxisCount: 1, // Số lượng cột là 1 để có một cột
      crossAxisSpacing: 1,
      mainAxisSpacing: 1, // Thêm khoảng cách theo chiều dọc
      padding: const EdgeInsets.all(6),
      children: [
        Container(
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: Image.network(
                img,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: Wrap(
          direction: Axis.horizontal,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "1",
                backgroundColor: Colors.deepOrange.shade500,
                onPressed: () {
                  _showImageDiaLog();
                },
                child: const Icon(Icons.camera_enhance),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton(
                heroTag: "2",
                backgroundColor: Colors.purple.shade500,
                onPressed: () {
                  _uploadImage();
                },
                child: const Icon(Icons.cloud_upload),
              ),
            )
          ],
        ),
        appBar: AppBar(
          title: GestureDetector(
            //trang thái xuất hiện view
            onTap: () {
              setState(() {
                changTitle = "Grid View";
                checkView = true;
              });
            },
            onDoubleTap: () {
              setState(() {
                changTitle = "List View";
                checkView = false;
              });
            },
            child: Text(changTitle),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Icon(Icons.exit_to_app),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("wallpaper")
              .orderBy("createAt",
                  descending:
                      true) // Assuming there is a field named 'createdAt'
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                if (checkView == false) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listViewWideget(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['image'],
                        snapshot.data!.docs[index]['userImage'],
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['createAt'].toDate(),
                        snapshot.data!.docs[index]['id'],
                        snapshot.data!.docs[index]['downloads'],
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return gridViewWideget(
                        snapshot.data!.docs[index].id,
                        snapshot.data!.docs[index]['image'],
                        snapshot.data!.docs[index]['userImage'],
                        snapshot.data!.docs[index]['name'],
                        snapshot.data!.docs[index]['createAt'].toDate(),
                        snapshot.data!.docs[index]['id'],
                        snapshot.data!.docs[index]['downloads'],
                      );
                    },
                  );
                }
              } else {
                return const Center(
                  child:
                      Text("There is no tasks", style: TextStyle(fontSize: 20)),
                );
              }
            }
            return const Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}
