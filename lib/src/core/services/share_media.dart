import 'package:flutter/services.dart';
import 'package:share_extend/share_extend.dart';

class ShareMedia {
  static Future<void> share(String text, String type) async {
    return ShareExtend.share(
      text,
      type,
      extraText: 'Innoscripta test task',
      subject: 'Innoscriptra test task',
      sharePositionOrigin: Rect.largest,
      sharePanelTitle: 'Sharing from Innoscipta test App!',
    );
  }
}
