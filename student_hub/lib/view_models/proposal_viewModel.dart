import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:student_hub/models/model/proposal.dart';
import 'package:student_hub/models/model/users.dart';
import 'package:student_hub/services/connection_services.dart';
import 'package:student_hub/view_models/controller_route.dart';

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

  Future<void> postSendApply(Proposal proposal, User user) async {
    print('postSendApply');
    var payload = proposal.toMapProposal();
    try {
      var response = await ConnectionService().post('/api/proposal', payload);
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text:
              'Your proposal has been sent successfully, please wait for the company to respond.',
          title: 'Send Successfully',
          confirmBtnText: 'Next',
          onConfirmBtnTap: () {
            Navigator.pop(context);
            ControllerRoute(context).navigateToHomeScreen(false, user, 0);
          },
        );
      } else {
        print("Failed");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Proposal>> getProposalById(int studentId) async {
    print('getProposalById');
    try {
      var response =
          await ConnectionService().get('/api/proposal/project/$studentId', {});
      var responseDecode = jsonDecode(response);
      if (responseDecode['result'] != null) {
        print("Connected to the server successfully");
        print("Connect server successful");
        print(response);
        List<Proposal> proposals =
            Proposal.fromListMapProposalStudent(responseDecode['result']);
        return proposals;
      } else {
        print("Failed get proposal");
        print(responseDecode);
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
