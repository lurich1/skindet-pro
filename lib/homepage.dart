import 'package:flutter/material.dart';
import 'package:skin_det/first/Tensorflow.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void selectPage(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Tensorflow();
    }));
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
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("images/homescreenimg.jpg"),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: InkWell(
                  onTap: () => selectPage(context),
                  splashColor: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      shadowColor: Colors.orange,
                      elevation: 10,
                      color: Colors.redAccent,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Analyze",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
