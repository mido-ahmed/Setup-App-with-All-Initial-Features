import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spacepictures/data/API/api.dart';
import 'package:spacepictures/data/models/mars_photo.dart';
import 'package:spacepictures/data/repo/repo.dart';

import '../../utils/route_constant.dart';

class NasaScreen extends StatelessWidget {
  final api = API();
  List<DateTime?> values = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<MarsPhoto> photos =
              await Repo().fetchPhotos(DateTime(2023, 9, 26));
          debugPrint(photos.length.toString());
          if (photos.isNotEmpty) {
            debugPrint(photos[0].imgSrc);
          }
        },
        child: const Icon(
          Icons.search_rounded,
          size: 30,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single,
                  currentDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2050)),
              value: values,
              onValueChanged: (dates) {
                values = dates;
              },
            ),
          ],
        ),
      ),
    );
  }
}
