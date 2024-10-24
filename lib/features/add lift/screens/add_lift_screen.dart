import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sharlift/common/input_new.dart';
import 'package:sharlift/features/add%20lift/services/lift_services.dart';
import 'package:sharlift/provider/user_provider.dart';

class AddLiftScreen extends StatefulWidget {
  static const String routeName = '/add-lift-screen';
  const AddLiftScreen({super.key});

  @override
  State<AddLiftScreen> createState() => _AddLiftScreenState();
}

class _AddLiftScreenState extends State<AddLiftScreen> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController pickupPointController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  LiftServices liftServices = LiftServices();

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        dateController.text =
            "${picked.day.toString()}-${picked.month.toString()}-${picked.year.toString()}";
        debugPrint(dateController.text);
      });
    }
  }

  Future<void> selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context).toString();
        debugPrint(timeController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Add Lift",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width - 30,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    From ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  InputNew(hinttext: 'From', controller: fromController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Destination ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  InputNew(hinttext: 'Destination', controller: toController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "     Price",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50, //height of input field
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      enabled: true,
                      style: const TextStyle(
                        fontSize:
                            20.0, //size badhega isse jo text type hoga uska
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.currency_rupee_sharp,
                          size: 24,
                          color: Colors.grey,
                          weight: 10,
                        ),
                        filled: true,
                        hintText: "Rs 20",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Time ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50, //height of input field
                    child: TextField(
                      onTap: () {
                        selectTime();
                      },
                      // keyboardType: TextInputType.numberWithOptions(,
                      controller: timeController,
                      readOnly: true,
                      enabled: true,
                      style: const TextStyle(
                        fontSize:
                            20.0, //size badhega isse jo text type hoga uska
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Time",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Date ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    height: 50, //height of input field
                    child: TextField(
                      onTap: () {
                        selectDate();
                      },
                      // keyboardType: TextInputType.numberWithOptions(,
                      controller: dateController,
                      readOnly: true,
                      enabled: true,
                      style: const TextStyle(
                        fontSize:
                            20.0, //size badhega isse jo text type hoga uska
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Date",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Pickup Point ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    //height of input field
                    child: TextField(
                      // keyboardType: TextInputType.numberWithOptions(,
                      controller: pickupPointController,
                      maxLines: 3,
                      enabled: true,
                      style: const TextStyle(
                        fontSize:
                            20.0, //size badhega isse jo text type hoga uska
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        hintText:
                            "Ex - Dwarka Circle in front of hotel Punjab.'Ex- I will leave exactly at the given time.'",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "    Message  ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    //height of input field
                    child: TextField(
                      // keyboardType: TextInputType.numberWithOptions(,
                      controller: messageController,
                      maxLines: 2,
                      enabled: true,
                      style: const TextStyle(
                        fontSize:
                            20.0, //size badhega isse jo text type hoga uska
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'Ex- I will go via flyover.',
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              height: 50,
              width: MediaQuery.of(context).size.width, //height of button
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.black),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Alert",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                          "Are you sure you want to publish the Lift ?",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                              child: const Text("Yes"),
                              onPressed: () {
                                liftServices.addProduct(
                                  context: context,
                                  completeFromLifter: false,
                                  completeFromPassenger: false,
                                  giverId: Provider.of<UserProvider>(context,
                                          listen: false)
                                      .user
                                      .id,
                                  from: fromController.text,
                                  to: toController.text,
                                  price: int.parse(priceController.text),
                                  time_of_start: timeController.text,
                                  date_of_start: dateController.text,
                                  pickUpPoint: pickupPointController.text,
                                  msg: messageController.text,
                                  status: "online",
                                  email: Provider.of<UserProvider>(context,
                                          listen: false)
                                      .user
                                      .email,
                                  firstName: Provider.of<UserProvider>(context,
                                          listen: false)
                                      .user
                                      .firstName,
                                  lastName: Provider.of<UserProvider>(context,
                                          listen: false)
                                      .user
                                      .lastName,
                                  phone: Provider.of<UserProvider>(context,
                                          listen: false)
                                      .user
                                      .phone,
                                  vehicalName: Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .user
                                      .vehicalName,
                                  vehicalNumber: Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .user
                                      .vehicalNumber,
                                  noOfLiftsGiven: Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .user
                                      .noOfLiftsGiven,
                                  ratingLiftsGiven: Provider.of<UserProvider>(
                                          context,
                                          listen: false)
                                      .user
                                      .ratingLiftsGiven,
                                );
                                Navigator.of(context).pop();
                              }),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  "Publish Lift",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
