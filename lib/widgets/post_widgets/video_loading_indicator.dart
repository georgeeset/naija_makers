import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:naija_makers/providers/new_post.dart';
import 'package:provider/provider.dart';

class VideoLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<NewPostProvider>(builder: (context, post, child) {
        return StreamBuilder<StorageTaskEvent>(
          stream: post.videoUploadTask.events,
          builder: (context, snapshot) {
            double progress;
            int transferedData = snapshot.data.snapshot.bytesTransferred;
            int totalBytes = snapshot.data.snapshot.totalByteCount;
            progress = (transferedData / totalBytes);
            return snapshot.hasError
                ? IconButton(
                    icon: Icon(Icons.error),
                    onPressed: () => post.addVideo(media: post.videoFile),
                  )
                : CircleAvatar(
                    radius: 30.0,
                    child: CircularProgressIndicator(
                      value: progress,
                    ),
                  );
          },
        );

        // double progress = 0;
        // if (sut != null) {
        //   print('sut isn o t nlull');
        //   sut.events.listen((data) {
        //
        //   });
        // }
        // return Container();
      }),
    );
  }
}
