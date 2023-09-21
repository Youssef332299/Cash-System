import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../provider/setDataProvider.dart';


class StartShift extends StatefulWidget {
  const StartShift({super.key});

  @override
  State<StartShift> createState() => _StartShiftState();
}

class _StartShiftState extends State<StartShift> {
  @override
  void initState() {
    context.read<SetDataProvider>().loadSections();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            context.read<SetDataProvider>().startShift(context);

          },
          height: MediaQuery.of(context).size.height / 10,
          minWidth: MediaQuery.of(context).size.width / 6,
          elevation: 100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          splashColor: const Color(0xFFF77D8E),
          hoverColor: Colors.black,
          color: Colors.white,
          child: const Text("بدء الوردية",
              style: TextStyle(
                  color: Color(0xFFF77D8E),
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),

        ),
      ),
    );
  }
}

