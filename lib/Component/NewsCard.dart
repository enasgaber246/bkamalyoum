import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'TextTitle.dart';

class NewsCard extends StatelessWidget {
  String title, body, imageUrl;

  NewsCard(this.title, this.body, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
             TextTitle(
                title,
                Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.center,
              ),

            Container(
              padding: EdgeInsets.all(50.sp),
              child: TextTitle(
                body,
                Theme.of(context).textTheme.bodyText1,
                fontSize: 10,
              ),
            ),
            (imageUrl == null)
                ? SizedBox(
                    width: 100.sp,
                    height: 100.sp,
                  )
                : Container(
                    width: double.infinity,
                    height: 500.sp,
                    padding: EdgeInsets.all(50.0.sp),
                    child: Image.network(
                      'https://bkamalyoum.com/uploads/small/${imageUrl}',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
            // Image.network(
            //   imageUrl,
            //   fit: BoxFit.fill,
            //   loadingBuilder: (BuildContext context, Widget child,
            //       ImageChunkEvent loadingProgress) {
            //     if (loadingProgress == null) return child;
            //     return Center(
            //       child: CircularProgressIndicator(
            //         value: loadingProgress.expectedTotalBytes != null
            //             ? loadingProgress.cumulativeBytesLoaded /
            //             loadingProgress.expectedTotalBytes
            //             : null,
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
