import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Tensorflow extends StatefulWidget {
  const Tensorflow({super.key});

  @override
  _TensorflowState createState() => _TensorflowState();
}

class _TensorflowState extends State<Tensorflow> {
  late List _outputs;
  late File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output!;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "SknApp",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: Colors.red,
          elevation: 0,
        ),
        body: Container(
          // height: MediaQuery.of(context).size.height,
          color: Colors.black45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _loading
                  ? SizedBox(
                      height: 300,
                      width: 300,
                    )
                  : Container(
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _image == null ? Container() : Image.file(_image),
                          const SizedBox(
                            height: 20,
                          ),
                          _image == null
                              ? Container()
                              : _outputs != null
                                  ? Text(
                                      _outputs[0]["label"],
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    )
                                  : Container(child: const Text(""))
                        ],
                      ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FloatingActionButton(
                tooltip: 'Pick Image',
                onPressed: pickImage,
                backgroundColor: Colors.redAccent,
                child: Icon(
                  Icons.add_a_photo,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
