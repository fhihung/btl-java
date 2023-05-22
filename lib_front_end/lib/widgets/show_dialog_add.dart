// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'pa';

// class DialogAddBook extends StatelessWidget {
//   const DialogAddBook({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add a new book'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _titleController,
//                 decoration: InputDecoration(
//                   labelText: 'Title',
//                 ),
//               ),
//               TextField(
//                 controller: _authorController,
//                 decoration: InputDecoration(
//                   labelText: 'Author',
//                 ),
//               ),
//               TextField(
//                 controller: _quantityController,
//                 decoration: InputDecoration(
//                   labelText: 'Quantity',
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             ElevatedButton(
//               child: Text('Save'),
//               onPressed: () {
//                 final title = _titleController.text;
//                 final author = _authorController.text;
//                 final quantity = int.tryParse(_quantityController.text) ?? 0;
//                 final book =
//                     Book(title: title, author: author, quantity: quantity);
//                 BookService.add(book);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );;
//   }
// }
