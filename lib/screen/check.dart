// import 'package:flutter/material.dart';

// class CustomRadioButton extends StatefulWidget {
//   final bool initialValue;
//   final ValueChanged<bool>? onChanged;

//   const CustomRadioButton({Key? key, this.initialValue = false, this.onChanged}) : super(key: key);

//   @override
//   _CustomRadioButtonState createState() => _CustomRadioButtonState();
// }

// class _CustomRadioButtonState extends State<CustomRadioButton> {
//   late bool _isSelected;

//   @override
//   void initState() {
//     super.initState();
//     _isSelected = widget.initialValue;
//   }

//   void _toggleSelection() {
//     setState(() {
//       _isSelected = !_isSelected;
//       widget.onChanged?.call(_isSelected);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleSelection,
//       child: Container(
//         width: 24,
//         height: 24,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: _isSelected ? Colors.blue : Colors.grey,
//             width: 2.0,
//           ),
//         ),
//         child: _isSelected
//             ? Container(
//                 width: 12,
//                 height: 12,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.blue,
//                 ),
//               )
//             : null,
//       ),
//     );
//   }
// }
