import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/employer/EndJobs.dart';
import 'package:freelance2/pages/employer/ActiveJobs.dart';
import 'package:freelance2/pages/employer/contiuneJobs.dart';
import 'PendingAppJobsEmp.dart';

class Jobs extends StatefulWidget {
  User user;
   Jobs(this.user,{Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
          child: Text(
            'PROJELER', style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,),
          ),
         ),
              TabBar(
                indicatorColor: Colors.orange,
                controller: _tabController,

                tabs: [
                  Tab(
                    child: FittedBox(
                   fit: BoxFit.scaleDown,
                  child:  Row(
                    children: [
                      Icon(Icons.work_history_outlined,color: Colors.orange),
                      Text("Aktif",style: TextStyle(color: Colors.black)),],),),
                     // mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child:  Row(
                        children: [
                          Icon(Icons.work_history,color: Colors.orange),
                          Text("Devam Eden",style: TextStyle(color: Colors.black)),],),),
                    // mainAxisAlignment: MainAxisAlignment.center,
                  ),

                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child:  Row(
                        children: [
                          Icon(Icons.work_history,color: Colors.orange),
                          Text("Onay Bekleyen",style: TextStyle(color: Colors.black)),],),),
                    // mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Tab(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child:  Row(
                        children: [
                          Icon(Icons.work,color: Colors.orange),
                          Text("Tamamlanan",style: TextStyle(color: Colors.black)),],),),
                    // mainAxisAlignment: MainAxisAlignment.center,
                  ),
            ],
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ActiveJobs(widget.user),
                    contiuneJobs(widget.user),
                    PendingApp(widget.user),
                    EndJobs(widget.user),


                    // İkinci sekme için gerekli sayfayı buraya ekleyin
                  ],
                ),
              ),
            ],
          ),
        ),
        );


  }
}

