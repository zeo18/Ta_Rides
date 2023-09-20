import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ta_rides/data/user_data.dart';
import 'package:ta_rides/models/community_info.dart';
import 'package:ta_rides/models/user_info.dart';

final CommunityInformation = [
  Community(
    id: 1101,
    coverImage: 'assets/images/community_images/sharkCover.jpg',
    private: true,
    title: 'Team Shark Cycling',
    description:
        'A united and inclusive cycling team, fueled by a shared love for the sport',
    membersIndex: 24,
    members: [],
    image: 'assets/images/community_images/shark.png',
    ifItsImage: Uint8List.fromList([]),
  ),
  Community(
    id: 1102,
    private: false,
    coverImage: 'assets/images/community_images/cebuCover.jpg',
    title: 'Cebu Brave Cycling',
    description:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    membersIndex: 42,
    members: [],
    image: 'assets/images/community_images/cebu.png',
    ifItsImage: Uint8List.fromList([]),
  ),
  Community(
    id: 1103,
    private: false,
    coverImage: 'assets/images/community_images/LapulapuCover.jpg',
    title: 'Lapu-Lapu Cycling Team ',
    description:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    membersIndex: 55,
    members: [],
    image: 'assets/images/community_images/lapulapu.png',
    ifItsImage: Uint8List.fromList([]),
  ),
  Community(
    id: 1104,
    coverImage: 'assets/images/community_images/danaoCover.jpg',
    private: true,
    title: 'Danao Warriors Team',
    description:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    membersIndex: 4,
    members: [],
    image: 'assets/images/community_images/danao.png',
    ifItsImage: Uint8List.fromList([]),
  ),
  Community(
    id: 1105,
    coverImage: 'assets/images/community_images/cordovaCover.jpg',
    private: true,
    title: 'Cordova Warriors Team',
    description:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    membersIndex: 4,
    members: [],
    image: 'assets/images/community_images/danao.png',
    ifItsImage: Uint8List.fromList([]),
  ),
  Community(
    id: 1106,
    coverImage: 'assets/images/community_images/bantayanCover.jpg',
    private: false,
    title: 'Bantayan Warriors Team',
    description:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    membersIndex: 32,
    members: [],
    image: 'assets/images/community_images/danao.png',
    ifItsImage: Uint8List.fromList([]),
  ),
  Community(
    id: 1107,
    coverImage: 'assets/images/community_images/barbaCover.jpg',
    title: 'Barba Warriors Team',
    private: false,
    description:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    membersIndex: 89,
    members: [],
    image: 'assets/images/community_images/danao.png',
    ifItsImage: Uint8List.fromList([]),
  ),
  Community(
    id: 1108,
    coverImage: 'assets/images/community_images/barbaCover.jpg',
    title: 'Barba Warriors Team 2',
    private: false,
    description:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    membersIndex: 89,
    members: [],
    image: 'assets/images/community_images/danao.png',
    ifItsImage: Uint8List.fromList([]),
  ),
];

final PostCommunity = [
  Post(
    postId: 301,
    communityId: 1102,
    userId: 103,
    isImage: true,
    imagePost: 'assets/images/community_images/barbaCover.jpg',
    usersName: 'christian3',
    caption: 'I love you des',
    commment: [],
    commentNumber: 0,
    heart: 23,
    ifImage: Uint8List.fromList([]),
  ),
  Post(
    postId: 302,
    communityId: 1102,
    userId: 104,
    isImage: false,
    imagePost: '',
    usersName: 'lloyde101',
    caption:
        'Lloyd Gwapo,Lloyd Gwapo,Lloyd Gwapo,Lloyd Gwapo,Lloyd Gwapo,Lloyd Gwapo,Lloyd Gwapo',
    commment: [],
    commentNumber: 0,
    heart: 10,
    ifImage: Uint8List.fromList([]),
  ),
  Post(
    postId: 303,
    communityId: 1102,
    userId: 105,
    isImage: false,
    imagePost: '',
    usersName: 'desiree126',
    caption:
        'Inlove jud kaayo ko christian guys. dmd najud ako najud ni siya minyoan. bye people',
    commment: [],
    commentNumber: 0,
    heart: 12,
    ifImage: Uint8List.fromList([]),
  ),
  Post(
    postId: 304,
    communityId: 1103,
    userId: 101,
    isImage: false,
    imagePost: '',
    usersName: 'jonah101',
    caption:
        'Bisag unsaon pa ninyo kontra nako. di mo ka palag nako. Rwarrrrr HAHAHAHHAHAHAHHA',
    commment: [],
    commentNumber: 0,
    heart: 12,
    ifImage: Uint8List.fromList([]),
  ),
  Post(
    postId: 305,
    communityId: 1103,
    userId: 102,
    isImage: true,
    imagePost: 'assets/images/community_images/cordovaCover.jpg',
    usersName: 'charles2',
    caption:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    commment: [],
    commentNumber: 0,
    heart: 121,
    ifImage: Uint8List.fromList([]),
  ),
];

final commentCommunity = [
  Comment(
    postId: 301,
    comment: 'hala grabe na ba ani',
    usersName: 'lloyde101',
    userImage: '',
  ),
  Comment(
    postId: 301,
    comment: 'i love u too',
    usersName: 'desiree126',
    userImage: '',
  ),
  Comment(
    postId: 303,
    comment: 'i love you too baby',
    usersName: 'christian3',
    userImage: '',
  ),
];

final privateCommunity = [
  IfPrivate(
      privateCommunityId: 1101,
      choiceQuestion:
          'In 2011, Markus Stöckl gained a speed of 102 mph when he rode his bike down... what?',
      choices: [
        'A volcano',
        'A mountain',
        'A glacier',
        'A cliff',
      ],
      cheboxesQuestion: '',
      cheboxes: [],
      writtenQuestion: '',
      writtenAnswer: '',
      writeRules: '',
      detailsRules: ''),
  IfPrivate(
      privateCommunityId: 1101,
      choiceQuestion: '',
      choices: [],
      cheboxesQuestion: 'What is the name of the world’s first mountain bike?',
      cheboxes: [
        'The Mongoose',
        'The Klunker',
        'The Stumpjumper',
        'The Rockhopper',
      ],
      writtenQuestion: '',
      writtenAnswer: '',
      writeRules: '',
      detailsRules: ''),
  IfPrivate(
      privateCommunityId: 1101,
      choiceQuestion: '',
      choices: [],
      cheboxesQuestion: '',
      cheboxes: [],
      writtenQuestion:
          'Bicycles became a word several years after their invention. What were they called originally?',
      writtenAnswer: 'When was the Penny-farthing invented',
      writeRules: '',
      detailsRules: ''),
  IfPrivate(
    privateCommunityId: 1101,
    choiceQuestion: '',
    choices: [],
    cheboxesQuestion: '',
    cheboxes: [],
    writtenQuestion: '',
    writtenAnswer: '',
    writeRules:
        'Riding a bike is a healthy, fun and safe activity. However, it isnt without some risk.',
    detailsRules:
        'All laws mentioned here were compiled as part of a research project in the fall of 2012 and may be subject to change. We update laws as we work with our member advocacy organizations to pass better laws and as advocates or the public tell us about changes. ',
  ),
  IfPrivate(
    privateCommunityId: 1104,
    choiceQuestion: '',
    choices: [],
    cheboxesQuestion: '',
    cheboxes: [],
    writtenQuestion: '',
    writtenAnswer: '',
    writeRules:
        'We update laws as we work with our member advocacy organizations to pass better laws and as advocates or the public tell us about changes.',
    detailsRules:
        'These highlights only cover statewide laws and are not comprehensive.',
  ),
  IfPrivate(
      privateCommunityId: 1101,
      choiceQuestion:
          ' We update laws as we work with our member advocacy organizations to pass better laws and as advocates or the public tell us about changes.',
      choices: [
        'State Bike Laws',
        'Bike Laws',
        'other traffic laws',
        'Bike Lawses',
      ],
      cheboxesQuestion: '',
      cheboxes: [],
      writtenQuestion: '',
      writtenAnswer: '',
      writeRules: '',
      detailsRules: ''),
];
