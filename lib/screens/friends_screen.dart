// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import '../providers/friend_provider.dart';
// import '../models/friend.dart';
// import 'dart:developer' as developer;
// import 'dart:convert';

// class FriendsScreen extends StatefulWidget {
//   const FriendsScreen({super.key});

//   @override
//   State<FriendsScreen> createState() => _FriendsScreenState();
// }

// class _FriendsScreenState extends State<FriendsScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   bool isScanning = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<FriendProvider>().loadFriends();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Friends'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.qr_code),
//             onPressed: _showQRCode,
//           ),
//           IconButton(
//             icon: const Icon(Icons.person_add),
//             onPressed: _showAddFriendDialog,
//           ),
//         ],
//       ),
//       body: Consumer<FriendProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (provider.error != null) {
//             return Center(child: Text(provider.error!));
//           }

//           if (provider.friends.isEmpty) {
//             return const Center(child: Text('No friends yet'));
//           }

//           return ListView.builder(
//             itemCount: provider.friends.length,
//             itemBuilder: (context, index) {
//               final friend = provider.friends[index];
//               return ListTile(
//                 leading: CircleAvatar(
//                   child: Text(friend.name[0].toUpperCase()),
//                 ),
//                 title: Text(friend.name),
//                 subtitle: Text(friend.email),
//                 trailing: friend.status == 'pending'
//                     ? Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           TextButton(
//                             onPressed: () => provider.acceptFriendRequest(friend.friendshipId!),
//                             child: const Text('Accept'),
//                           ),
//                           const SizedBox(width: 8),
//                           Text('Pending', style: TextStyle(color: Colors.orange)),
//                         ],
//                       )
//                     : null,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showQRCode() async {
//     final provider = context.read<FriendProvider>();
//     try {
//       final qrData = await provider.generateQrCode();
//       if (!mounted) return;
      
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Your QR Code'),
//           content: SizedBox(
//             width: 200,
//             height: 200,
//             child: QrImageView(
//               data: qrData,
//               version: QrVersions.auto,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Close'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.toString())),
//       );
//     }
//   }

//   void _showAddFriendDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add Friend'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               onPressed: _startQRScanner,
//               child: const Text('Scan QR Code'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _showSearchFriendDialog,
//               child: const Text('Search by Name'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _startQRScanner() {
//     Navigator.pop(context);
//     setState(() => isScanning = true);
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => SizedBox(
//         height: 400,
//         child: Column(
//           children: [
//             Expanded(
//               child: QRView(
//                 key: qrKey,
//                 onQRViewCreated: _onQRViewCreated,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       if (isScanning && scanData.code != null) {
//         setState(() => isScanning = false);
//         controller.dispose();
//         Navigator.pop(context);
//         _processQRCode(scanData.code!);
//       }
//     });
//   }

//   void _processQRCode(String qrData) {
//     developer.log('QR Code: $qrData');
//     try {
//       // Decode base64 string to JSON string
//       final jsonString = utf8.decode(base64.decode(qrData));
//       developer.log('Decoded JSON string: $jsonString');
      
//       final data = Map<String, dynamic>.from(jsonDecode(jsonString));
//       if (data['type'] == 'user' && data['id'] != null) {
//         context.read<FriendProvider>().sendFriendRequest(data['id']);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Friend request sent!')),
//         );
//       } else {
//         throw Exception('Invalid QR code format');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid QR code')),
//       );
//     }
//   }

//   void _showSearchFriendDialog() {
//     Navigator.pop(context);
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Search Friends'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Enter name to search',
//               ),
//               onChanged: (query) async {
//                 if (query.length >= 3) {
//                   final users = await context
//                       .read<FriendProvider>()
//                       .searchUsers(query);
//                   if (!mounted) return;
//                   _showSearchResults(users);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSearchResults(List<Friend> users) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Search Results'),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return ListTile(
//                 title: Text(user.name),
//                 subtitle: Text(user.email),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.person_add),
//                   onPressed: () {
//                     developer.log('Sending friend request to ${user.id}');
//                     context.read<FriendProvider>().sendFriendRequest(user.id);
//                     Navigator.pop(context);
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
