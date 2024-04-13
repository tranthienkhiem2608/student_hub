import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/services/connection_services.dart';

class ProposalViewModel {
  final BuildContext context;
  ProposalViewModel(this.context);

  Future<List<Proposal>> getProposalByProject(int projectId) async {
    print('getProposalStudent');
    try {
      var response = await ConnectionService()
          .get('/api/proposal/getByProjectId/$projectId', {});
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        List<Proposal> proposals = Proposal.fromListMapProposalStudent(
            responseDecode['result']['items']);
        return proposals;
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
