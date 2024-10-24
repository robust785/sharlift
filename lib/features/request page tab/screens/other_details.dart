import 'package:flutter/material.dart';
import 'package:sharlift/features/search/lift%20details/services/send_request.dart';
import 'package:sharlift/features/search/lift%20details/widget/detail_part.dart';
import 'package:sharlift/models/request_model.dart';

class OtherDetailsScreen extends StatefulWidget {
  static const String routeName = '/other-details';
  final RequestModel curRequest;
  const OtherDetailsScreen({
    super.key,
    required this.curRequest,
  });

  @override
  State<OtherDetailsScreen> createState() => _OtherDetailsScreenState();
}

class _OtherDetailsScreenState extends State<OtherDetailsScreen> {
  final SendRequest r = SendRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Lift Details-",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'CaviarDreams',
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        elevation: 2, // This ensures no default shadow
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lift details - ",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "From - ",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                            widget.curRequest.from,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    param: widget.curRequest.to,
                    title: "To",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    param: widget.curRequest.price,
                    title: "Price",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    title: "Time",
                    param: widget.curRequest.time_of_start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    title: "Date",
                    param: widget.curRequest.date_of_start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    title: "PickUp Point",
                    param: widget.curRequest.pickUpPoint,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Passenger details - ",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ClipOval(
                    child: Image.network(
                      widget.curRequest.profilePhoto,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.width * 0.7,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DetailPart(
                    param:
                        '${widget.curRequest.firstName.toUpperCase()} ${widget.curRequest.lastName.toUpperCase()}',
                    title: "Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailPart(
                    title: "Phone",
                    param: widget.curRequest.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailPart(
                    param: widget.curRequest.noOfLiftsTaken,
                    title: "Total Lifts Given",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailPart(
                    param: widget.curRequest.ratingLiftsTaken /
                        widget.curRequest.noOfLiftsTaken,
                    title: "Rating (out of 5)",
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
