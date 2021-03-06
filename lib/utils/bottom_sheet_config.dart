import 'dart:async';

import 'package:doctr/app/app.locator.dart';
import 'package:doctr/models/api_response.dart';
import 'package:doctr/services/cloud_firestore_services.dart';
import 'package:doctr/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();
  final _cloudService = locator<CloudFirestoreServices>();

  final builders = {
    BottomSheetType.floatingWithTextField: (context, sheetRequest, completer) =>
        _FloatingBoxBottomSheet(
          sendReport: _cloudService.reportAProblem,
          request: sheetRequest,
          completer: completer,
          controller: TextEditingController(text: ''),
        ),
    BottomSheetType.floatingWithTextFieldSync:
        (context, sheetRequest, completer) =>
            _FloatingBoxBottomWithTextFieldSync(
              request: sheetRequest,
              completer: completer,
              controller: TextEditingController(text: ''),
            ),
    BottomSheetType.choice: (context, sheetRequest, completer) =>
        _ChoiceBottomSheet(
          request: sheetRequest,
          completer: completer,
        ),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

enum BottomSheetType {
  floatingWithTextField,
  choice,
  floatingWithTextFieldSync
}

class _FloatingBoxBottomSheet extends StatefulWidget {
  final SheetRequest? request;
  final Future<ApiResponse?> Function(String message) sendReport;
  final Function(SheetResponse)? completer;
  final TextEditingController? controller;
  const _FloatingBoxBottomSheet(
      {Key? key,
      this.request,
      required this.sendReport,
      this.completer,
      @required this.controller})
      : super(key: key);

  @override
  State<_FloatingBoxBottomSheet> createState() =>
      _FloatingBoxBottomSheetState();
}

class _FloatingBoxBottomSheetState extends State<_FloatingBoxBottomSheet> {
  late bool isLoading;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: devSize.height * .2,
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                maxLines: 4,
                minLines: 1,
                controller: widget.controller,
                decoration: const InputDecoration(
                    hintText: 'Enter your message here...'),
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(
                    shape: const CircleBorder(), backgroundColor: primaryColor),
                onPressed: isLoading
                    ? null
                    : () async {
                        if (widget.controller!.text.trim().isEmpty) return;
                        setState(() {
                          isLoading = true;
                        });
                        var res =
                            await widget.sendReport(widget.controller!.text);
                        widget.completer!(SheetResponse(data: res));
                        setState(() {
                          isLoading = false;
                        });
                      },
                child: isLoading
                    ? Transform.scale(
                        scale: .3,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
          ],
        ),
      ),
    );
  }
}

class _FloatingBoxBottomWithTextFieldSync extends StatelessWidget {
  final TextEditingController controller;
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  const _FloatingBoxBottomWithTextFieldSync(
      {Key? key, this.completer, this.request, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: devSize.height * .2,
      margin: const EdgeInsets.all(25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                // maxLines: 4,
                // minLines: 1,
                controller: controller,
                decoration:
                    InputDecoration(hintText: 'Enter ${request?.data} here...'),
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(),
                onPressed: () {
                  if (completer != null) {
                    completer!(SheetResponse(data: controller.text));
                  }
                },
                child: const Text('ADD'))
          ],
        ),
      ),
    );
  }
}

class _ChoiceBottomSheet extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  const _ChoiceBottomSheet(
      {Key? key, required this.request, required this.completer})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
              onPressed: () {
                completer!(SheetResponse(data: 'Symptoms'));
              },
              child: const Text('Symptoms')),
          TextButton(
              onPressed: () {
                completer!(SheetResponse(data: 'Prescriptions'));
              },
              child: const Text('Prescriptions')),
          TextButton(
              onPressed: () {
                completer!(SheetResponse(data: 'Disease'));
              },
              child: const Text('Disease')),
        ],
      ),
    );
  }
}
