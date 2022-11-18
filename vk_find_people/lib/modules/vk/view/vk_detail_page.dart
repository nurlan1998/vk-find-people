import 'package:flutter/cupertino.dart';
import 'package:vk_find_people/modules/app/widgets/page_background.dart';

class VkDetailPage extends StatelessWidget {
  const VkDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBackground(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Image.network(''),
          SizedBox(height: 10),
          Text(''),
        ],
      ),
    );
  }
}
