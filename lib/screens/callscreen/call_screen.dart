import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_instagram_clone/pages/caller_left.dart';
import 'package:flutter_instagram_clone/pages/receiver_left.dart';
import 'package:flutter_instagram_clone/pages/time_left.dart';
import 'package:flutter_instagram_clone/configs/agora_configs.dart';
import 'package:flutter_instagram_clone/models/call.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import 'package:flutter_instagram_clone/resources/call_methods.dart';
import 'package:flutter_instagram_clone/screens/callscreen/call_left.dart';

class CallScreen extends StatefulWidget {
  final Call call;
  final hasDialled;
  CallScreen({this.call, this.hasDialled = true});
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final CallMethods callMethods = CallMethods();
  bool callmade = false;
  bool timecallovered = false;
  bool canceledcall = false;
  // UserProvider userProvider;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  StreamSubscription<DocumentSnapshot> callStreamSubscription;
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool paused = true;
  RtcEngine _engine;
  @override
  void initState() {
    super.initState();
    initialize();
    addPostFrameCallback();
    callerorreceiver();
    // theCallPeriod();
    // initPlatformState();
  }

  // check if the user is caller or receiver
  void callerorreceiver() {
    if (widget.hasDialled) {
      // if the current user hasDialled
      users.doc(_auth.currentUser.uid).update({"caller": true});
    } else {
      // if the current is receiver
      users.doc(_auth.currentUser.uid).update({"caller": false});
    }
  }

  void theCallPeriod() async {
    await Future.delayed(Duration(seconds: 10), () async {
      if (!callmade) {
        setState(() {
          timecallovered = true;
        });
        await callMethods.endCall(call: widget.call);
      }
    });
  }

  void logicofshowingscreens(call) async {
    if (widget.hasDialled && callmade) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CallerLeft(
                    call: widget.call,
                  )));
    }
    // show the receiver end call screen
    if (!widget.hasDialled && callmade) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ReceiverLeft(
                    call: widget.call,
                  )));
    }
    // show the caller screen when the caller left before the receiver answer
    if (widget.hasDialled && canceledcall && !callmade) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => CallLeft(call: widget.call)));
    }
    // show this screen when time of calling is overed
    if (widget.hasDialled && timecallovered) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TimeLeft(
                    call: widget.call,
                  )));
    }
  }

  @override
  void dispose() {
    callStreamSubscription.cancel();
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await _engine.joinChannel(APP_ID, widget.call.channelId, null, 0);
  }

  addPostFrameCallback() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // userProvider = Provider.of<UserProvider>(context, listen: false);
      callStreamSubscription =
          callMethods.callStream(uid: _auth.currentUser.uid).listen((snapshot) {
        switch (snapshot.data()) {
          case null:
            logicofshowingscreens(widget.call);
            break;

          default:
            break;
        }
      });
    });
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        print(info);
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      callMethods.endCall(call: widget.call);
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    list.add(RtcLocalView.SurfaceView());
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  Widget firstCall(view) {
    return Stack(children: [
      Positioned(
        right: 0,
        top: 0,
        left: 0,
        bottom: 0,
        child: Container(
          child: view,
        ),
      ),
      Container(
        color: Colors.black.withOpacity(0.6),
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: paused
                        ? Icon(
                            Feather.video,
                            color: Colors.white,
                          )
                        : Icon(
                            Feather.video_off,
                            color: Colors.white,
                          ),
                    onPressed: _pauseVideo),
                IconButton(
                    icon: !muted
                        ? Icon(
                            Feather.mic,
                            color: Colors.white,
                          )
                        : Icon(
                            Feather.mic_off,
                            color: Colors.white,
                          ),
                    onPressed: _onToggleMute),
                IconButton(
                  icon: Icon(
                    Feather.refresh_ccw,
                    color: Colors.white,
                  ),
                  onPressed: _onSwitchCamera,
                ),
                IconButton(
                    icon: Icon(
                      Entypo.cross,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      setState(() {
                        canceledcall = true;
                      });
                      await callMethods.endCall(call: widget.call);
                    })
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Container(
                height: 100,
                width: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(widget.call.receiverPic),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(height: 30),
              Text(
                widget.call.receiverName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Contacting...",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ])
          ],
        ),
      ),
    ]);
  }

  Widget anSwerCall(view0, view1) {
    return Stack(
      children: [
        // the caller video

        Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Container(
              child: view1,
            )),
        AnimatedPositioned(
          top: 30,
          right: 20,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 200),
          child: Container(
            height: 160,
            width: 110,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0, 3),
                  spreadRadius: 6.0,
                  blurRadius: 5)
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                // color: Colors.red,
                child: view0,
              ),
            ),
          ),
        ),
        _toolbar()
      ],
    );
  }

  Widget ansWerWidget(view0, view1, context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          child: Column(children: [
            Expanded(
                child: Container(
              child: view0,
            )),
            Expanded(
                child: Container(
              child: view1,
            )),
          ]),
        ),
        Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: paused
                        ? Icon(
                            Feather.video,
                            color: Colors.white,
                          )
                        : Icon(
                            Feather.video_off,
                            color: Colors.white,
                          ),
                    onPressed: _pauseVideo),
                IconButton(
                    icon: !muted
                        ? Icon(
                            Feather.mic,
                            color: Colors.white,
                          )
                        : Icon(
                            Feather.mic_off,
                            color: Colors.white,
                          ),
                    onPressed: _onToggleMute),
                IconButton(
                  icon: Icon(
                    Feather.refresh_ccw,
                    color: Colors.white,
                  ),
                  onPressed: _onSwitchCamera,
                ),
                IconButton(
                    icon: Icon(
                      Entypo.cross,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      setState(() {
                        canceledcall = true;
                      });
                      await callMethods.endCall(call: widget.call);
                    })
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: Container(
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                Column(children: [
                  IconButton(
                    icon: Icon(
                      AntDesign.picture,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    "Media",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ]),
                Column(children: [
                  IconButton(
                    icon: Icon(
                      MaterialIcons.people_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )
                ])
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget showanswerwidget(view0, view1) {
    setState(() {
      callmade = true;
    });
    return ansWerWidget(view0, view1, context);
  }

  /// Video layout wrapper
  Widget _viewRows(BuildContext context) {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return widget.hasDialled
            ? firstCall(views[0])
            : Container(
                color: Colors.black,
              );
      case 2:
        return showanswerwidget(views[0], views[1]);
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  /// Info panel to show logs

  void _onCallEnd(BuildContext context) async {
    await callMethods.endCall(call: widget.call);
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  void _pauseVideo() {
    setState(() {
      paused = !paused;
    });
    _engine.enableLocalVideo(paused);
  }

  @override
  Widget build(BuildContext context) {
    theCallPeriod();
    return Scaffold(
      backgroundColor: Colors.black,
      body: _viewRows(context),
    );
  }
}
