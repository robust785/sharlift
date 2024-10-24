import 'package:flutter/material.dart';
import 'package:sharlift/constants/toast_msg.dart';
import 'package:sharlift/features/cart%20tab/services/cart_services.dart';
import 'package:sharlift/features/search/lift%20details/widget/detail_part.dart';
import 'package:sharlift/models/product_model.dart';

class ViewAllDetails extends StatefulWidget {
  static const String routeName = "/view-all-details";
  final ProductModel curProduct;
  const ViewAllDetails({super.key, required this.curProduct});

  @override
  State<ViewAllDetails> createState() => _ViewAllDetailsState();
}

class _ViewAllDetailsState extends State<ViewAllDetails> {
  late Map<String, dynamic> m = {};
  CartServices cartServices = CartServices();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchChosenIDdetails();
  }

  fetchChosenIDdetails() async {
    try {
      m = await cartServices.fetchUserByEmail(widget.curProduct.chosenID);
    } catch (error) {
      // Handle error if fetching fails
      //print('Error fetching user details: $error');
    } finally {
      setState(() {
        isLoading = false; // Update loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Upcoming Ride -",
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
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
                                  widget.curProduct.from,
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
                          param: widget.curProduct.to,
                          title: "To",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DetailPart(
                          param: widget.curProduct.price,
                          title: "Price",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DetailPart(
                          title: "Time",
                          param: widget.curProduct.time_of_start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DetailPart(
                          title: "Date",
                          param: widget.curProduct.date_of_start,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DetailPart(
                          title: "PickUp Point",
                          param: widget.curProduct.pickUpPoint,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DetailPart(
                          title: "Passenger Code",
                          param: widget.curProduct.passengerCode,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DetailPart(
                          title: "Lifter Code",
                          param: widget.curProduct.lifterCode,
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
                                "Lifter Details - ",
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
                            widget.curProduct.profilePhoto,
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
                              '${widget.curProduct.firstName.toUpperCase()} ${widget.curProduct.lastName.toUpperCase()}',
                          title: "Name",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DetailPart(
                          title: "Phone",
                          param: widget.curProduct.phone,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DetailPart(
                          title: "Vehical Name",
                          param: widget.curProduct.vehicalName,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DetailPart(
                          title: "Vehical Number",
                          param: widget.curProduct.vehicalNumber,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DetailPart(
                          title: "Rating of Lifter- ",
                          param: widget.curProduct.ratingLiftsGiven /
                              widget.curProduct.noOfLiftsGiven,
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
                                "Passegnger Details - ",
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
                            m["profilePhoto"],
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.width * 0.7,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DetailPart(
                          param: '${m["firstName"]} ${m["lastName"]}',
                          title: "Name",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DetailPart(
                          title: "Phone",
                          param: '${m["phone"]} ',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DetailPart(
                          title: "Rating of Lifter- ",
                          param: widget.curProduct.ratingLiftsGiven /
                              widget.curProduct.noOfLiftsGiven,
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          height: 50,
                          width: MediaQuery.of(context)
                              .size
                              .width, //height of button
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Color.fromARGB(255, 0, 0, 0)),
                            ),
                            onPressed: () {
                              toastMsg(
                                  msg: "Ride Complete", color_bg: Colors.green);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Mark As Complete",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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
