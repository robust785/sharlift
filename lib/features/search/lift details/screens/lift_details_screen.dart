import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharlift/constants/toast_msg.dart';
import 'package:sharlift/features/search/lift%20details/services/send_request.dart';
import 'package:sharlift/features/search/lift%20details/widget/detail_part.dart';
import 'package:sharlift/models/product_model.dart';
import 'package:sharlift/provider/user_provider.dart';

class LiftDetailsScreen extends StatefulWidget {
  static const String routeName = '/lift-details';
  final ProductModel product;
  const LiftDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<LiftDetailsScreen> createState() => _LiftDetailsScreenState();
}

class _LiftDetailsScreenState extends State<LiftDetailsScreen> {
  final SendRequest r = SendRequest();

  @override
  Widget build(BuildContext context) {
    UserProvider userprovider = Provider.of<UserProvider>(context);
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
          backgroundColor: Colors.white, // Explicitly set to pure white
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
                            widget.product.from,
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
                    param: widget.product.to,
                    title: "To",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    param: widget.product.price,
                    title: "Price",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    title: "Time",
                    param: widget.product.time_of_start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    title: "Date",
                    param: widget.product.date_of_start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    title: "PickUp Point",
                    param: widget.product.pickUpPoint,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DetailPart(
                    title: "Message",
                    param: widget.product.msg,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const DetailPart(
                    title: "Phone",
                    param: "Visible after your request has been accepted.",
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
                          "Rider details - ",
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
                      widget.product.profilePhoto,
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
                        '${widget.product.firstName.toUpperCase()} ${widget.product.lastName.toUpperCase()}',
                    title: "Name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailPart(
                    param: widget.product.vehicalName.toUpperCase(),
                    title: "Vehical",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailPart(
                    param: widget.product.vehicalNumber,
                    title: "Vehical Number",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailPart(
                    param: widget.product.noOfLiftsGiven,
                    title: "Total Lifts Given",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DetailPart(
                    param: widget.product.ratingLiftsGiven /
                        widget.product.noOfLiftsGiven,
                    title: "Rating (out of 5)",
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50,
                    width: MediaQuery.of(context).size.width, //height of button
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        if (widget.product.email == userprovider.user.email) {
                          toastMsg(
                            msg: "Saale khudko hi request bhejega ka ?",
                          );
                        } else {
                          debugPrint(userprovider.user.id.toString());
                          r.requestLift(
                            context: context,
                            // liftID: userprovider.user.id.toString(),
                            liftID: widget.product.id.toString(),
                            requestEmail: userprovider.user.email.toString(),
                          );

                          Navigator.pop(context, true);
                        }
                      },
                      child: const Text(
                        "Request Lift",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
