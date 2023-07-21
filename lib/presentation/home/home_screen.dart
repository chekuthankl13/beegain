import 'package:beegain/config/config.dart';
import 'package:beegain/db/db.dart';
import 'package:beegain/presentation/home/enquirr_result.dart';
import 'package:beegain/repository/api_repository.dart';
import 'package:beegain/utils/utills.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../logic/bloc_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController dateCntr = TextEditingController();

  TextEditingController equiryCntr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config().baseclr,
      body: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: sH(context) / 2,
              width: sW(context),
              color: Config().baseclr,
              child: Image.asset(
                "assets/sigin.png",
                height: 100,
                width: sW(context),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              height: sH(context) / 2,
              width: sW(context),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  spaceHeight(10),
                  fields(
                      txt: "Date",
                      controller: dateCntr,
                      isread: true,
                      onTap: () {
                        pickDateRange(context);
                      },
                      ic: Icons.calendar_month),
                  spaceHeight(20),
                  // fields(
                  //     txt: "",

                  //     controller: equiryCntr,
                  //     ic: Icons.search),
                  spaceHeight(10),
                  ElevatedButton(
                    onPressed: () async {
                      if (dateCntr.text.isEmpty) {
                        errorToast(context, error: "please select the date");
                      } else {
                        navigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => EnquiryCubit(
                                  apiRepository: context.read<ApiRepository>())
                                ..onEnquiry(
                                    fdate: dateCntr.text.split(" to ")[0],
                                    tdate: dateCntr.text.split(" to ")[1],
                                    search: equiryCntr.text),
                              child: const EnquiryResult(),
                            ),
                          ),
                        );
                      }

                      // context.read<EnquiryCubit>().onEnquiry(
                      //     fdate: dateCntr.text.split(" to ")[0],
                      //     tdate: dateCntr.text.split(" to ")[1],
                      //     search: equiryCntr.text);
                      // await DbService().clear();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(sW(context) / 2, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Config().baseclr,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Search"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column fields({
    required txt,
    required TextEditingController? controller,
    isread = false,
    isNote = false,
    void Function()? onTap,
    IconData? ic,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceHeight(10),
        Text(
          txt,
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 12),
        ),
        spaceHeight(5),
        TextFormField(
          controller: controller,
          readOnly: isread ? true : false,
          onTap: isread ? onTap : null,
          decoration: InputDecoration(
              labelText: txt,
              suffixIcon: isread
                  ? Icon(
                      ic,
                      color: Config().baseclr,
                    )
                  : null,
              labelStyle:
                  TextStyle(color: Colors.grey.withOpacity(.5), fontSize: 11),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Config().baseclr)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Config().baseclr)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Config().baseclr)),
              isDense: true,
              filled: true,
              fillColor: Colors.white),
        )
      ],
    );
  }

  ///date pick

  pickDateRange(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000), // the earliest allowable
      lastDate: DateTime.now(), // the latest allowable
      currentDate: DateTime.now(),
      saveText: 'Done',
    );
    if (result != null) {
      var start = DateFormat("yyyy/MM/dd").format(result.start);
      var end = DateFormat("yyyy/MM/dd").format(result.end);

      // dateCntr.text = result.start.toString() + "-" + result.end.toString();

      dateCntr.text = start + " to " + end;
    }
  }
}

// getDateRange(DateTimeRange date) {
//   selectedRange = date;
//   if (selectedRange != null) {
//     startDate = selectedRange!.start;
//     endDate = selectedRange!.end;
//   }
//   notifyListeners();
// }
