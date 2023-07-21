import 'package:beegain/config/config.dart';
import 'package:beegain/logic/bloc_export.dart';
import 'package:beegain/models/enquiry/enquiry_model.dart';
import 'package:beegain/utils/utills.dart';
import 'package:flutter/material.dart';

class EnquiryResult extends StatefulWidget {
  const EnquiryResult({super.key});

  @override
  State<EnquiryResult> createState() => _EnquiryResultState();
}

class _EnquiryResultState extends State<EnquiryResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: BlocBuilder<EnquiryCubit, EnquiryState>(
        builder: (context, state) {
          if (state is EnquiryLoadError) {
            return Center(child: Text(state.error));
          }

          if (state is EnquiryLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Config().baseclr,
              ),
            );
          }

          if (state is EnquiryLoaded) {
            return state.lists.isEmpty
                ? const Center(
                    child: Text("No Enquiry found !!"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.lists.length,
                    itemBuilder: (context, index) {
                      var data = state.lists[index];
                      return ListTile(
                          // leading: Text(data.enquiryNo),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "# ${data.enquiryNo}",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              tile(ic: Icons.person, txt: data.rcOwnerName),
                              tile(
                                  ic: Icons.location_city,
                                  txt: data.rcOwnerAddress),
                              tile(ic: Icons.phone, txt: data.primaryMobile),
                            ],
                          ),
                          subtitle: Text(
                            data.address,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          trailing: Column(
                            children: [
                              tile(
                                  ic: Icons.social_distance,
                                  txt: data.kms.toString()),
                              tile(
                                  ic: Icons.gps_fixed,
                                  txt: data.district.toString())
                            ],
                          ));
                    },
                  );
          }

          return Center(
            child: CircularProgressIndicator(
              color: Config().baseclr,
            ),
          );
        },
      ),
    );
  }

  Row tile({required ic, required txt}) {
    return Row(
      children: [
        Icon(
          ic,
          color: Colors.grey,
          size: 20,
        ),
        spaceWidth(5),
        Text(
          txt.toString(),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
