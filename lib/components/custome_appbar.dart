import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/config.dart';

// class CustomeAppBar extends StatefulWidget implements PreferredSize {
//
//    CustomeAppBar({super.key, this.tabTitle, this.route, this.icon, this.actions});
//
//   @override
//   State<CustomeAppBar> createState() => _CustomeAppBarState();
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => const Size.fromHeight(60);
//
//   final String? tabTitle;
//   final String? route;
//   final FaIcon? icon;
//   final List<Widget>? actions;
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
//   @override
//   // TODO: implement child
//   Widget get child => throw UnimplementedError();
//
//
// }
//
// class _CustomeAppBarState extends State<CustomeAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.white,
//       elevation: 0,
//       title: Text(
//         widget.tabTitle!,
//         style: TextStyle(
//           fontSize: 20,
//           color: Config.smallColorText,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       leading: widget.icon !=null ?
//       Container(
//         margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: Config.primaryColor
//         ),
//         child: IconButton(
//           onPressed: (){
//             if(widget.route !=null)
//               {
//                 Navigator.pushNamed(context, widget.route!);
//               }
//             else
//               {
//                 Navigator.pop(context);
//               }
//           },
//           icon: widget.icon!,
//           iconSize: 16,
//           color: Colors.white,
//         ),
//       ) : null,
//       actions: widget.actions ?? null,
//     );
//   }
// }

class CustomeApp extends StatelessWidget implements PreferredSize{
  const CustomeApp({super.key,
    this.tabTitle,
    this.route,
    this.icon,
    this.actions});

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);

  final String? tabTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        tabTitle!,
        style: TextStyle(
          fontSize: 20,
          color: Config.smallColorText,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: icon !=null ?
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Config.primaryColor
        ),
        child: IconButton(
          onPressed: (){
            if(route !=null)
            {
              Navigator.pushNamed(context, route!);
            }
            else
            {
              Navigator.pop(context);
            }
          },
          icon: icon!,
          iconSize: 16,
          color: Colors.white,
        ),
      ) : null,
      actions:actions ?? null,
    );
  }


}
