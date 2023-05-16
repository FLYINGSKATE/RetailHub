import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:retailhub/model/ticket_modal.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/custom_strings.dart';
import '../../../constants/string.dart';
import '../../../utill/app_text_style.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/myappbar.dart';
import '../../widgets/nodata_widget.dart';
import '../../widgets/progressbar_widget.dart';
import 'tickets_viewmodel.dart';
import 'dart:math' as math;
class TicketsView extends StatefulWidget {
  const TicketsView({Key? key}) : super(key: key);
  @override
  _TicketsViewState createState() => _TicketsViewState();
}

class _TicketsViewState extends State<TicketsView>
    with SingleTickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder.reactive(
      builder:
          (BuildContext? context, TicketsViewModel? viewModel, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.black,
            appBar: const MyAppBar(
              title: " ",
              isLogo: true,
            ),
            resizeToAvoidBottomInset: false,
            body: _bodyWidget(viewModel!));
      },
      viewModelBuilder: () => TicketsViewModel(),
      onViewModelReady: (TicketsViewModel model) {
        model.initModel(context);
      },
    );
  }

  Widget _bodyWidget(TicketsViewModel viewModel) {
    return viewModel.tickets.length==0?Container(
        color: backgroundColor,
        height: double.infinity,
        width: double.infinity,

        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
            child: Text("No Tickets Found", style: MyTextStyle.apptitle),
          ),
        )):ListView.builder(
        itemCount: viewModel.tickets.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (c,i){
          return TicketCard(viewModel.tickets[i]);
    });
  }


  Widget TicketCard(TicketModal ticket) {

    var size = MediaQuery.of(context).size;
    final boxWidth = size.width;
    const dashWidth = 10.0;
    final dashHeight = 10.0;
    final dashCount = (boxWidth / (2 * dashWidth)).floor();

    return Stack(
      children: [



        Container(
          height:size.height,
          width: size.width*0.9,
          margin: EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40)
          ),
        ),


        Container(
          height:size.height*0.28,
          width: size.width*0.9,
          margin: EdgeInsets.all(40),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(.0),
                Colors.black.withOpacity(1),
              ],
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(ticket.eventImage??"https://www.designboom.com/wp-content/uploads/2019/10/carlo-ratti-italian-pavilion-expo-2020-dubai-designboom-02.jpg"), fit: BoxFit.cover,
            ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
          ),
        ),
        Positioned(
          top:size.height*0.23,left: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xff394512),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(ticket.ticketType??"VIP Section",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
              InkWell(
                onTap: (){

                },
                child: Row(
                  children: [
                    Text(ticket.eventName??"Italia retail expo 2023",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                    SizedBox(width: 4,),
                    Icon(Icons.launch,size:18,color: Colors.white,)
                  ],
                ),
              ),
              Text("The largest retail show in Europe.Will be held in Milan.",style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
        Positioned(
          top:size.height*0.335,left: size.width*0.28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(ticket.ticketHolderName??"Ashraf",style: TextStyle(color: Color(0xff394512),fontSize: 25,fontWeight: FontWeight.bold),),
              Text(ticket.email??"ashrafk.salim1@gmail.com",style: TextStyle(color: Color(0xff394512),fontSize: 16,),),
              Container(height: 10,),
              Text("#"+(ticket.reference??"#09192-191-290-120"),style: TextStyle(color: Color(0xff394512),fontSize: 23,fontWeight: FontWeight.bold),),
              Text(ticket.details??"This is a Ticket Description",style: TextStyle(color: Colors.black),),
            ],
          ),
        ),
        Container(
          height:size.width*0.5,
          width: size.width*0.5,
          margin: EdgeInsets.only(top: size.height*0.47,left: size.width*0.29),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(ticket.qrCode??"https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/QR-code-obituary.svg/220px-QR-code-obituary.svg.png"), fit: BoxFit.cover,
              ),
          ),
        ),
        Positioned(
          bottom: size.height*0.355,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Dash(
                direction: Axis.horizontal,
                length: size.width*0.8,
                dashLength: 12,
                dashColor: Colors.grey),
          ),
        ),
        Positioned(
          left: -40,
          bottom: size.height*0.3,
          child: RotatedBox(
              quarterTurns: 1,
              child: MyArc(diameter: 100)),
        ),
        Positioned(
          right: -32,
          bottom: size.height*0.3,
          child: RotatedBox(
              quarterTurns: 3,
              child: MyArc(diameter: 100)),
        ),

      ],
    );
  }
}



class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({super.key, this.diameter = 200});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}


// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}