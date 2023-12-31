import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController pathologistController = TextEditingController();
  String selectedGender = 'Male'; // Default gender selection
  String selectedPaymentOption = 'Cash'; // Default payment option
  String selectedTime = '';
  List<String> availableTimings = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Appointment'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  // TODO: Show calendar and update selected date
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  );

                  if (pickedDate != null && pickedDate != DateTime.now()) {
                    setState(() {
                      dateController.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    });
                  }
                },
                child: IgnorePointer(
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Appointment Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              SizedBox(height: 16),
              Text('Select Time:',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              // Add a grid of available timings
              SizedBox(height: 5,),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 2.0,
                ),
                shrinkWrap: true,
                itemCount: availableTimings.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedTime = availableTimings[index];
                        timeController.text = selectedTime;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        selectedTime == availableTimings[index]
                            ? Color(0xFF3E69FE)
                            : Colors.grey,
                      ),
                    ),
                    child: Text(availableTimings[index]),
                  );
                },
              ),
              SizedBox(height: 20,),
              TextField(
                controller: pathologistController,
                decoration: InputDecoration(
                  labelText: 'Preferred Pathologist',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(12.0),
                ),
              ),
              SizedBox(height: 16),
              Text('Select Gender:'),
              DropdownButton<String>(
                value: selectedGender,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value!;
                  });
                },
                items: ['Male', 'Female', 'Others'].map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 16),
              Text('Select Payment Option:'),
              DropdownButton<String>(
                value: selectedPaymentOption,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentOption = value!;
                  });
                },
                items: ['Cash', 'Credit Card', 'Debit Card'].map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await bookAppointment(context);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(16.0)),
                ),
                child: Text('Book Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> bookAppointment(BuildContext context) async {
    final AuthProvider authProvider =
    Provider.of<AuthProvider>(context, listen: false);

    try {
      await authProvider.bookAppointment(
        appointmentDate: dateController.text,
        appointmentTime: timeController.text,
        appointmentStatus: determineAppointmentStatus(),
        paymentStatus: determinePaymentStatus(),
        preferredPathologist: pathologistController.text,
        gender: selectedGender,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Appointment booked successfully!'),
        ),
      );
    } catch (e) {
      print('Error booking appointment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error booking appointment. Please try again.'),
        ),
      );
    }
  }

  String determineAppointmentStatus() {
    // TODO: Add logic to determine appointment status based on dates
    // For example, check if the selected date is within the next week
    // Return 'Pending' or 'Confirmed' accordingly
    return 'Pending';
  }

  String determinePaymentStatus() {
    // TODO: Add logic to determine payment status based on selected payment option
    // Return 'Paid' or 'Unpaid' accordingly
    return 'Unpaid';
  }
}

