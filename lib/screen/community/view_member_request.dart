import 'package:flutter/material.dart';

import 'package:ta_rides/models/request.dart';

class ViewMemberRequest extends StatefulWidget {
  const ViewMemberRequest({
    super.key,
    required this.request,
  });

  final RequestMember request;
  @override
  State<ViewMemberRequest> createState() => _ViewMemberRequestState();
}

class _ViewMemberRequestState extends State<ViewMemberRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request'),
      ),
      body: Column(
        children: [
          Text(widget.request.firstName),
          Text(widget.request.lastName),
          Text(widget.request.userImage),
          Text(widget.request.userName),
          Text(widget.request.communityId),
        ],
      ),
    );
  }
}
