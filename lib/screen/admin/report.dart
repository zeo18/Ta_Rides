import 'package:flutter/material.dart';
import 'package:ta_rides/screen/admin/report_list.dart';
import 'package:ta_rides/widget/all_controller/report_controller.dart';

class ReportAdmin extends StatefulWidget {
  const ReportAdmin({super.key});

  @override
  State<ReportAdmin> createState() => _ReportAdminState();
}

class _ReportAdminState extends State<ReportAdmin> {
  ReportController reportController = ReportController();

  @override
  void initState() {
    reportController.getReport();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        title: Text(
          'Report',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: AnimatedBuilder(
          animation: reportController,
          builder: (context, snapshot) {
            if (reportController.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (reportController.reports == null) {
              return Center(
                child: Text(
                  'No Report',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                ),
              );
            }

            return ListView.builder(
              itemCount: reportController.reports?.length,
              itemBuilder: (context, index) => ReportList(
                reports: reportController.reports![index],
              ),
            );
          }),
    );
  }
}
