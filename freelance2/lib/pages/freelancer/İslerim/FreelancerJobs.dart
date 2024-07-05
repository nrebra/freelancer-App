import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelance2/pages/employer/EndJobs.dart';
import 'package:freelance2/pages/freelancer/%C4%B0slerim/FreelancerEndjobs.dart';

import 'ContiuneJobs.dart';
import 'FreelancerJobsPage.dart';
import 'PendingApprovalJobs.dart'; // Dosya adını kontrol edin: "ContinueJobs.dart" olmalı.

class FreelancerJobs extends StatefulWidget {
  final User user;
  FreelancerJobs(this.user, {Key? key}) : super(key: key);

  @override
  State<FreelancerJobs> createState() => _FreelancerJobsState();
}

class _FreelancerJobsState extends State<FreelancerJobs> with SingleTickerProviderStateMixin {
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
                'PROJELER',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            TabBar(
              indicatorColor: Colors.orange,
              controller: _tabController,
              tabs: [
                Tab(
                  child: FittedBox(
                  //  fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Icon(Icons.work_history_outlined, color: Colors.orange),
                        SizedBox(width: 5), // İkon ve metin arasına boşluk ekledim.
                        Text("Aktif", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: FittedBox(
                  //  fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Icon(Icons.work_history, color: Colors.orange),
                        SizedBox(width: 5), // İkon ve metin arasına boşluk ekledim.
                        Text("Devam Eden", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: FittedBox(
                    //fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Icon(Icons.work, color: Colors.orange),
                        SizedBox(width: 5), // İkon ve metin arasına boşluk ekledim.
                        Text("Onay Bekleyen", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: FittedBox(
                   // fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Icon(Icons.hourglass_bottom_outlined, color: Colors.orange),
                        SizedBox(width: 5), // İkon ve metin arasına boşluk ekledim.
                        Text("Tamamlanan", style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  MyJobsPage(widget.user),
                  ContiuneJobs(widget.user),
                  PendingApproval(widget.user),
                  FreelancerEndJobs(widget.user),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
