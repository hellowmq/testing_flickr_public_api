import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wenmq_first_flickr_flutter_app/base/base_tool.dart';
import 'dart:math' as math;
import 'package:wenmq_first_flickr_flutter_app/base/bean/photo.dart';

class CommonBuilder {
  static List<Widget> buildPhotoCardList(List<Photo> photoList) {
    if (photoList == null || photoList.isEmpty) return <Widget>[];
    return photoList.map(buildImageFromPhoto).toList();
  }

  static Widget buildImageFromPhoto(photo) => new Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(photo.title),
                subtitle: Text(photo.toString()),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 10.0),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: buildHeroImage(photo),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  static Widget buildHeroImage(Photo photo) {
    return new PhotoViewWithBasePage(
      buildFadeInImage(photo),
      photo.hashCode.toString(),
      photoUrl: photo.imgUrl,
    );
  }

  static FadeInImage buildFadeInImage(Photo photo) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: photo.imgUrl,
      fit: BoxFit.fill,
    );
  }

  static Image buildNetworkImage(Photo photo) {
    return new Image.network(photo.imgUrl);
  }

  static WidgetBuilder createWidgetBuilder(dynamic widget) {
    assert(widget is Widget);
    return (BuildContext context) => widget;
  }

  static const Icon iconBack = Icon(Icons.arrow_back_ios);

  static Color getRandomColor({int a = 255}) {
    return Color.fromARGB(
      a,
      math.Random().nextInt(255),
      math.Random().nextInt(255),
      math.Random().nextInt(255),
    );
  }
}

class CustomActionSheet {
  static void showSheet(BuildContext context, List<String> titleList,
      CustomActionSheetCallBack callBack,
      {int selectedIndex}) {
    if (selectedIndex == null) {
      selectedIndex = 0;
    }
    double height =
        titleList.length * 48.0 + MediaQuery.of(context).padding.bottom;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0XFFd6d6e0),
          height: height,
          child: Column(
            children: titleList.map((e) {
              return GestureDetector(
                onTap: () {
                  callBack(titleList.indexOf(e));
                  Navigator.pop(context);
                },
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: ColorManager.colorC1,
                      ),
                    ),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: selectedIndex == titleList.indexOf(e)
                          ? Colors.red
                          : ColorManager.color33,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    ).then((e) {
      print(e);
    });
  }
}

class ColorManager {
  static const Color mainTabSelectTextColor = const Color(0xFF222222);
  static const Color mainTabNormalTextColor = const Color(0xFF555555);
  static const Color mainTableViewBgColor =
      const Color(0xFFF8F8F8); //tableView的背景颜色
  static const Color mainColor = const Color(0xFFF6483E); //主色值
  static const Color mainBgColor = const Color(0xFFF8F8F8); //主背景色
  static const Color mainTextBlackColor = const Color(0xFF333333);
  static const Color greyTextBlackColor = const Color(0xFF666666); //
  static const Color mainColor99 = const Color(0xFF999999);
  static const Color loginTipTextColor = const Color(0xFFC1C1C1);
  static const Color loginHintTextColor = const Color(0xFFAAAAAA);
  static const Color lineColor = const Color(0xFFE3E3E3);
  static const Color loginBtnBgColor = const Color(0xFFEEEEEE);
  static const Color accountPwdLoginTextColor = const Color(0xFFD5BB8B);
  static const Color loginThirdPartyCircleBgColor =
      const Color(0xFFDCDCDC); //第三方登录的圆圈背景色
  static const Color loginAgreementColor = const Color(0xFF252525); //登录协议字体颜色
  static const Color forgetPwdTextColor = const Color(0xFF888888);
  static const Color titleTextColor =
      const Color(0xFF1B1B1B); //页面appbar的title颜色值
  static const Color loginWelcomePageBgColor = const Color(0xFFC5A364); //
  static const Color whiteColor = const Color(0xFFFFFFFF);
  static const Color borderOpaqueShadowColor = const Color(0x1A000000);
  static const Color chooseIdentityNormalColor = const Color(0xFF000000);
  static const Color chooseIdentitySelectColor = const Color(0xFF888888);
  static const Color chooseIdentityBtnColor = const Color(0xFFD5BB8B);
  static const Color chooseIdentityBtnBgColor = const Color(0xFFEEEEEE);

  static const Color mainColorF0 = const Color(0xFFF0F0F0);

  /// 首页 有新消息时的圆点的颜色
  static const Color homeNewMessageColor = const Color(0xFFFEFF5E);

  /// 首页搜索框背景色
  static const Color homeSearchBackgroundColor = const Color(0x33FFFFFF);

  /// 首页搜索框中搜索文字的颜色
  static const Color homeSearchNameColor = const Color(0x7FFFFFFF);

  /// 透明无色
  static const Color clearColor = const Color(0x00FFFFFF);

  /// 搜索 取消搜索按钮
  static const Color searchCancelColor = const Color(0xFFDF3132);
  static const Color searchBackgroundColor = const Color(0x1F8E8E93);
  static const Color searchColor = const Color(0xFF999999);
  static const Color navNormalColor = const Color(0xFF666666);
  static const Color navSelectedColor = const Color(0xFFDF3031);

  static const Color redLightColor = const Color(0xFFDF3031);
  static const Color redAddColor = const Color(0xFFEE4050);
  static const Color grayColor = const Color(0xFFF6F6F6);

  static const Color color22 = const Color(0xFF222222);
  static const Color color33 = const Color(0xFF333333);
  static const Color color66 = const Color(0xFF666666);
  static const Color color55 = const Color(0xFF555555);
  static const Color color88 = const Color(0xFF888888);
  static const Color color99 = const Color(0xFF999999);
  static const Color colorDC = const Color(0xFFDCDCDC);
  static const Color colorAA = const Color(0xFFAAAAAA);
  static const Color colorEE = const Color(0xFFEEEEEE);
  static const Color colorF6 = const Color(0xFFF6F6F6);
  static const Color colorF8 = const Color(0xFFF8F8F8);
  static const Color colorE3 = const Color(0xFFE3E3E3);
  static const Color color8E93 = const Color(0xFF8E8E93);
  static const Color colorDF3031 = const Color(0xFFDF3031);
  static const Color colorDD4F50 = const Color(0xFFDD4F50);
  static const Color mainColorGold = const Color(0xFFD5BB8B);
  static const Color colorE7 = const Color(0xFFE7E7E7);
  static const Color colorA4 = const Color(0xFFA4A4A4);
  static const Color black55 = const Color(0x55000000);
  static const Color colorH22 = const Color(0x80222222);

  static const Color colorC1 = const Color(0xFFC1C1C1);

  static const Color colorCC = const Color(0xFFC8C7CC);
  static const Color color30 = const Color(0xFFFF3B30);
  static const Color color1DA1F6 = const Color(0xFF1DA1F6);
  static const Color colorE5 = const Color(0xFFE5E5E5);
}
