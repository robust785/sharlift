import 'package:flutter/material.dart';
import 'package:sharlift/common/loading_screen.dart';
import 'package:sharlift/features/request%20page%20tab/screens/other_details.dart';
import 'package:sharlift/features/request%20page%20tab/services/request_services.dart';
import 'package:sharlift/models/request_model.dart';

class RequestPage extends StatefulWidget {
  static const String routeName = "/request-tab";

  const RequestPage({
    super.key,
  });

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  List<RequestModel>? requests;
  final RequestServices requestServices = RequestServices();

  @override
  void initState() {
    super.initState();
    fetchRequestPlease();
    debugPrint('hello $requests');
  }

  fetchRequestPlease() async {
    requests = await requestServices.fetchRequests(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return requests == null
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.08,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Requests -",
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
            body: ListView.builder(
              itemCount: requests!.length,
              itemBuilder: (context, index) {
                final currRequest = requests![index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                      margin: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("From: ${currRequest.from.toUpperCase()}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("To: ${currRequest.to.toUpperCase()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Request By- ${currRequest.firstName.toUpperCase()} ${currRequest.lastName.toUpperCase()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            height: 50,
                            width: MediaQuery.of(context)
                                .size
                                .width, //height of button
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.green),
                              ),
                              onPressed: () {
                                requestServices
                                    .acceptRequest(
                                        context: context,
                                        acceptedEmail:
                                            currRequest.email.toString(),
                                        liftID: currRequest.id ?? "")
                                    .then((_) {
                                  // Use setState to rebuild the widget after the request is processed
                                  setState(() {
                                    fetchRequestPlease();
                                  });
                                });
                              },
                              child: const Text(
                                "Accept ✅",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 236, 236, 236)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                                    Color.fromARGB(255, 255, 0, 0)),
                              ),
                              onPressed: () {
                                debugPrint(currRequest.id);
                                // requestServices.declineRequest(
                                //     context: context,
                                //     declinedEmail: currRequest.email,
                                //     liftID: currRequest.id ?? "");

                                requestServices
                                    .declineRequest(
                                        context: context,
                                        declinedEmail: currRequest.email,
                                        liftID: currRequest.id ?? "")
                                    .then((_) {
                                  // Use setState to rebuild the widget after the request is processed
                                  setState(() {
                                    fetchRequestPlease();
                                  });
                                });
                              },
                              child: const Text(
                                "Decline",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                                Navigator.pushNamed(
                                    context, OtherDetailsScreen.routeName,
                                    arguments: currRequest);
                              },
                              child: const Text(
                                "Passenger Details",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ], //this is end
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
