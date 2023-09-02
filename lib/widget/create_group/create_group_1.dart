import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';
import 'package:ta_rides/widget/create_group/create_group_2.dart';

class CreateGroup1 extends StatefulWidget {
  const CreateGroup1(
      {super.key,
      required this.user,
      required this.onAddCommunity,
      required this.isPrivate,
      required this.titleText,
      required this.onAddPost});
  final bool isPrivate;
  final String titleText;
  final Users user;
  final Function(Community community) onAddCommunity;
  final Function(Post post) onAddPost;

  @override
  State<CreateGroup1> createState() => _CreateGroup1State();
}

class _CreateGroup1State extends State<CreateGroup1> {
  Uint8List? _image;
  final _descriptionCommunityController = TextEditingController();

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No image selected.');
  }

  @override
  void dispose() {
    _descriptionCommunityController.dispose();
    super.dispose();
  }

  void selectedImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void onThirdPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => CreateGroup2(
                user: widget.user,
                onAddCommunity: widget.onAddCommunity,
                coverImage: _image,
                description: _descriptionCommunityController.text,
                isPrivate: widget.isPrivate,
                titleText: widget.titleText,
                onAddPost: widget.onAddPost,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x3ff0C0D11),
      appBar: AppBar(
        backgroundColor: const Color(0x3ff0C0D11),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add your Cover Photo',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                'Display the skills of your squad',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: const Color(0x3ff797979),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Cover photo',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0x3ff797979),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Stack(
                children: [
                  if (_image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.memory(
                        _image!,
                        fit: BoxFit.cover,
                        width: 395,
                        height: 150,
                      ),
                    )
                  else
                    Container(
                      width: 395,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0x3ff222227),
                      ),
                    ),
                  if (_image == null)
                    Positioned(
                      top: 50,
                      left: 105,
                      child: InkWell(
                        onTap: selectedImage,
                        child: Image.asset(
                            'assets/images/community_images/uploadImage.png'),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Add a Brief Description',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Inform the public of the expected outcome',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: const Color(0x3ff797979),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                controller: _descriptionCommunityController,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Describe your Group',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0x3ff454545),
                    fontSize: 15,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0x3ff454545)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                maxLines: 6,
              ),
              const SizedBox(
                height: 120,
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/community_images/second.png'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0x3ffFF0000),
                        minimumSize: const Size(
                          375,
                          45,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: onThirdPage,
                      child: Text(
                        'Continue',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                      ),
                    ),
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
