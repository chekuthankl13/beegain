import 'dart:convert';
import 'dart:developer';

import 'package:beegain/db/db.dart';
import 'package:beegain/models/enquiry/enquiry_model.dart';
import 'package:beegain/repository/api_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'enquiry_state.dart';

class EnquiryCubit extends Cubit<EnquiryState> {
  final ApiRepository apiRepository;
  EnquiryCubit({required this.apiRepository}) : super(EnquiryInitial());

  onEnquiry({required fdate, required tdate, required search}) async {
    try {
      emit(EnquiryLoading());

      var user = await DbService().getUser();
      var k = jsonDecode(user);
      log(k.toString(), name: "k");
      var res = await apiRepository.onEnquiry(
          token: k['token'], fdate: fdate, tdate: tdate, fid: k['fid']);
      if (res['status'] == 'ok') {
        var k = res['data'] as Enq;

        emit(EnquiryLoaded(lists: k.enquirey.enq));
      } else {
        emit(EnquiryLoadError(error: res['message']));
      }
    } catch (e) {
      emit(EnquiryLoadError(error: e.toString()));
    }
  }
}
