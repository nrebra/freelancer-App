import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/employer/Teklif.dart';
import 'package:freelance2/service/Functions.dart';
import 'package:freelance2/widget/employerTextField.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import '../../style/color.dart';

class employerHomePage extends StatefulWidget {
  User user;
   employerHomePage(this.user,{Key? key}) : super(key: key);

  @override
  State<employerHomePage> createState() => _EmployerHomePageState();
}

class _EmployerHomePageState extends State<employerHomePage> {
  final TextEditingController arama = TextEditingController();
  final TextEditingController baslikController = TextEditingController();
  final TextEditingController detayController = TextEditingController();
  final TextEditingController fiyatController = TextEditingController();
  final TextEditingController yetenekController = TextEditingController();
  final TextEditingController tarihController = TextEditingController();


  String name = "";

  void createNewJob() {
    String selectedCategory = 'Yazılım ve Teknoloji'; // Default category
    String selectedStatus = 'Active';



    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          "Yeni İş İlanı",
          style: TextStyle(color: Colors.white),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: employerTextField(baslikController, "Başlık"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: employerTextField(detayController, "Detay"),
              ),
              employerTextField(fiyatController, "Fiyat"),
              employerTextField(yetenekController, "Yetenekler"),
              employerTextField(tarihController, "Son Tarih"),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                dropdownColor: Colors.orange,
                value: selectedCategory,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  }
                },
                items: <String>[
                  'Yazılım ve Teknoloji',
                  'Grafik Tasarım',
                  'Yazı ve Çeviri',
                  'İş ve Yönetimi',
                  'Video Animasyon',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            color: Colors.orange,
            onPressed: () async{
              final jobid = Uuid().v4();

              await saveJobs(
               jobid,
                baslikController.text,
                detayController.text,
                fiyatController.text,
                yetenekController.text,
                  tarihController.text,
                  selectedCategory,
                  widget.user
              );

              baslikController.clear();
              detayController.clear();
              fiyatController.clear();
              yetenekController.clear();
              tarihController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                   content: Text(
                     'İş ilanınız yayınlandı',
                     style: TextStyle(color: Colors.white),
                   ),
                   backgroundColor: Colors.orange,
                   duration: Duration(seconds: 3),
                 ),
             );
              Navigator.pop(context);
            },
            child: const Text(
              "Kaydet",
              style: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            color: Colors.orange,
            onPressed: cancel,
            child: const Text(
              "Geri",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void cancel() {
    Navigator.pop(context);
    //clear();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Appcolor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "ANASAYFA",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),

                  ),
                  InkWell(
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TeklifPage(widget.user)));
                      } ,
                      child: Icon(Icons.add_alert,color: Colors.orange)
                  )
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 33, right: 58),
                child: TextField(
                  style: const TextStyle(color: TextColor),
                  controller: arama,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                      fillColor: const Color(0xff282C34),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 3, color: EnabledColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 3, color: EnabledColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: SizedBox(
                        height: 5,
                        width: 5,
                        child: Lottie.network(
                            "https://assets9.lottiefiles.com/packages/lf20_vhppiil2.json"),
                      ),

                      hintStyle: const TextStyle(
                          color: Color(0xff52575D), fontSize: 13)),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [])
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
          onPressed: createNewJob,
        ),
      ),
    );
  }
}

