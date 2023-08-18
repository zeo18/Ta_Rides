import 'package:ta_rides/models/community_info.dart';

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
  ),
];

final PostCommunity = [
  Post(
    communityId: 1102,
    userId: 103,
    isImage: true,
    imagePost: 'assets/images/community_images/barbaCover.jpg',
    usersName: 'christian3',
    caption:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    commment: [],
    commentNumber: 0,
    heart: 0,
  ),
  Post(
    communityId: 1102,
    userId: 104,
    isImage: false,
    imagePost: '',
    usersName: 'lloyde101',
    caption: 'Lloyd Gwapo.A united and inclusive cycling team, fueled by a',
    commment: [],
    commentNumber: 0,
    heart: 0,
  ),
  Post(
    communityId: 1102,
    userId: 105,
    isImage: false,
    imagePost: '',
    usersName: 'desiree126',
    caption:
        'A united and inclusive cycling team, fueled by a shared love for the sport.',
    commment: [],
    commentNumber: 0,
    heart: 0,
  ),
];
