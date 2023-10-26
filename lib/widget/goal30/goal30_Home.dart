import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Goal30Home extends StatefulWidget {
  const Goal30Home({Key? key, required this.yourCategory});

  final String yourCategory;

  @override
  _Goal30HomeState createState() => _Goal30HomeState();
}

class CardItem {
  final String title;
  final String subtitle;

  CardItem({required this.title, required this.subtitle});
}

final _firstPinController = TextEditingController();
final _secondPinController = TextEditingController();
final _thirdPinController = TextEditingController();

class _Goal30HomeState extends State<Goal30Home> {
  List<CardItem> items = [
    CardItem(title: 'Day', subtitle: '1'),
    CardItem(title: 'Day', subtitle: '2'),
    CardItem(title: 'Day', subtitle: '3'),
    CardItem(title: 'Day', subtitle: '4'),
    CardItem(title: 'Day', subtitle: '5'),
    CardItem(title: 'Day', subtitle: '6'),
    CardItem(title: 'Day', subtitle: '7'),
    CardItem(title: 'Day', subtitle: '8'),
    CardItem(title: 'Day', subtitle: '9'),
    CardItem(title: 'Day', subtitle: '10'),
    CardItem(title: 'Day', subtitle: '11'),
    CardItem(title: 'Day', subtitle: '12'),
    CardItem(title: 'Day', subtitle: '13'),
    CardItem(title: 'Day', subtitle: '14'),
    CardItem(title: 'Day', subtitle: '15'),
    CardItem(title: 'Day', subtitle: '16'),
    CardItem(title: 'Day', subtitle: '17'),
    CardItem(title: 'Day', subtitle: '18'),
    CardItem(title: 'Day', subtitle: '19'),
    CardItem(title: 'Day', subtitle: '20'),
    CardItem(title: 'Day', subtitle: '21'),
    CardItem(title: 'Day', subtitle: '22'),
    CardItem(title: 'Day', subtitle: '23'),
    CardItem(title: 'Day', subtitle: '24'),
    CardItem(title: 'Day', subtitle: '25'),
    CardItem(title: 'Day', subtitle: '26'),
    CardItem(title: 'Day', subtitle: '27'),
    CardItem(title: 'Day', subtitle: '28'),
    CardItem(title: 'Day', subtitle: '29'),
    CardItem(title: 'Day', subtitle: '30'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0D11),
      ),
      backgroundColor: const Color(0xFF0C0D11),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 30,
              separatorBuilder: (context, _) => const SizedBox(
                width: 10,
              ),
              itemBuilder: (context, index) => buildCard(items[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Category:',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: widget.yourCategory.isNotEmpty
                        ? widget.yourCategory
                        : 'Category',
                    style: GoogleFonts.montserrat(
                      color: Color(0x3FFFE8AA0A),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Today's Goal:",
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                  ),
                  TextSpan(
                    text: 'Number of km',
                    style: GoogleFonts.montserrat(
                      color: Color(0x3FFFE8AA0A),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Color(0x3FFF181A20),
              height: 240,
              child: Form(
                // key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 13, 0, 0),
                      child: Text(
                        'Pin your point location!',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _firstPinController,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x3fffFFFFF0),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x3fffFFFFF0),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          labelStyle: GoogleFonts.montserrat(
                            color: const Color(0x3fff454545),
                          ),
                          prefixIcon: const Icon(Icons.pin_drop),
                          prefixIconColor: const Color(0x3fffE8AA0A),
                          labelText: '1st Pin Point',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _secondPinController,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x3fffFFFFF0),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x3fffFFFFF0),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          labelStyle: GoogleFonts.montserrat(
                            color: const Color(0x3fff454545),
                          ),
                          prefixIcon: const Icon(Icons.pin_drop),
                          prefixIconColor: const Color(0x3fffFF0000),
                          labelText: '2nd Pin Point',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(60),
                maximumSize: const Size.fromWidth(350),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide.none,
                ),
                backgroundColor: const Color(0x3ffFF0000),
              ),
              onPressed: () {},
              child: Text(
                'Proceed',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(CardItem item) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 80,
          height: 100,
          color: const Color(0xFF181A20),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  item.title,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                  ),
                ),
                Text(
                  item.subtitle,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
