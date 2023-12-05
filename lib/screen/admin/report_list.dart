import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_rides/models/report_info..dart';
import 'package:intl/intl.dart';
import 'package:ta_rides/screen/admin/report.dart';

class ReportList extends StatefulWidget {
  const ReportList({super.key, required this.reports});

  final Reports reports;

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  String getTimeString(int minutes) {
    if (minutes < 60) {
      return '• $minutes min';
    } else if (minutes < 1440) {
      final hours = (minutes / 60).floor();
      return '• $hours hr';
    } else {
      final days = (minutes / 1440).floor();
      return '• $days days';
    }
  }

  @override
  Widget build(BuildContext context) {
    final postTime = widget.reports.time.toDate();
    final currentTime = DateTime.now();
    final difference = currentTime.difference(postTime);
    final minutes = difference.inMinutes;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
          color: const Color(0xff282828),
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          elevation: 10,
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date Reported : ${DateFormat('yyyy-MM-dd • h:mma').format(widget.reports.timeReported.toDate())}',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Color(0x3ff797979),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        widget.reports.userImageReported,
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.reports.userfirstnameReported.replaceRange(0, 1, widget.reports.userfirstnameReported[0].toUpperCase())} ${widget.reports.userlastnameReported.replaceRange(0, 1, widget.reports.userlastnameReported[0].toUpperCase())}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                          ),
                          Text(
                            '@${widget.reports.userUsernameReported}',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: Color(0x3ff797979),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        getTimeString(minutes),
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Color(0x3ff797979),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.reports.caption,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Reported by: ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    Text(
                      "${widget.reports.userfirstnameReport.replaceRange(0, 1, widget.reports.userfirstnameReport[0].toUpperCase())} ${widget.reports.userlastnameReport.replaceRange(0, 1, widget.reports.userlastnameReport[0].toUpperCase())}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Color(0x3ffE89B05),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(260, 0, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0x3ffFF0000),
                      minimumSize: const Size(
                        25,
                        35,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final delete = await FirebaseFirestore.instance
                          .collection('post')
                          .where('postId', isEqualTo: widget.reports.postId)
                          .get();

                      await delete.docs.first.reference.delete();

                      final deleteReport = await FirebaseFirestore.instance
                          .collection('report')
                          .where('postId', isEqualTo: widget.reports.postId)
                          .get();

                      await deleteReport.docs.first.reference.delete().then(
                            (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const ReportAdmin()),
                            ),
                          );
                    },
                    child: Text(
                      'Delete',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
