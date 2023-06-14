import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/profil.dart';
import 'package:untitled1/ticket.dart';

import 'colis.dart';

class navigate extends StatefulWidget {
  var depart,arrive,billet;
  navigate({required this.depart,required this.arrive,required this.billet});

  @override
  State<navigate> createState() => _navigateState();
}

class _navigateState extends State<navigate> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SegmentedTabControl(
                  // Customization of widget
                  radius: const Radius.circular(12),
                  backgroundColor: Colors.white,
                  indicatorColor: Color.fromRGBO(228, 171, 34, 1),
                  tabTextColor: Colors.black45,
                  selectedTabTextColor: Colors.white,
                  squeezeIntensity: 2,
                  height: 45,
                  tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  // Options for selection
                  // All specified values will override the [SegmentedTabControl] setting
                  tabs: [
                    SegmentTab(
                      label: 'Ticket',
                      // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                      color: Color.fromRGBO(228, 171, 34, 1),
                    ),
                    SegmentTab(
                      label: 'Colis',
                      backgroundColor: Colors.white,
                      selectedTextColor: Colors.white,
                      textColor: Colors.black26,
                    ),
                    const SegmentTab(label: 'profil'),
                  ],
                ),
              ),
              // Sample pages
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ticket(arrive: widget.arrive,depart:widget.depart,billet: widget.billet,),
                    colis(),
                    Profil(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SampleWidget extends StatelessWidget {
  const SampleWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
      child: Text(label),
    );
  }
}