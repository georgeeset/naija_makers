import 'dart:io';

import 'package:flutter/material.dart';
import 'package:naija_makers/providers/new_post.dart';
import 'package:naija_makers/widgets/post_widgets/video_loading_indicator.dart';
import 'package:naija_makers/widgets/post_widgets/video_play_pause.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'close_button.dart';

class VideoPreview extends StatefulWidget {
  final String link;
  final File videoFile;
  final Function onClosed;
  VideoPreview({this.link, this.videoFile, @required this.onClosed});

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile);
    _controller.addListener(() {
      setState(() {});
    });
    //_controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(
                    _controller,
                  ),
                )
              : Container(
                  width: 10, height: 10, child: CircularProgressIndicator()),
          Center(
              child: Consumer<NewPostProvider>(builder: (context, post, child) {
            return post.mediaUrl == null
                ? VideoLoadingIndicator()
                : PlayPauseOverlay(controller: _controller);
          })),
          Positioned(
            top: 2,
            right: 2,
            child: CloseThumbnailButton(onClosed: widget.onClosed),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    print('viideo controller disposed');
  }
}
