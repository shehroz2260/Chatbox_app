import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallUIWidgte extends StatelessWidget {
  final String name;
  final String uID;
  final bool videoCall;
  const CallUIWidgte(
      {super.key,
      required this.name,
      required this.uID,
      this.videoCall = false});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 801817548,
        appSign:
            "245fd40f39c712aa56b056186ab4a3862af889a70cd1ec265e2f35c0c9371c6a",
        callID:
            "04AAAAAGYGibMAEGNseGlhcDNkdnNsbGJweHUAwAnuvM9cCzftR7Myxu1GV7EcXXkLtGYYZ6c0rZ3JsX9+2bZlFH59YLzC7Q2Q3v+XrqRmsnEEGDLtku7AIgigw6A/RfvnnP2ggwWoIW7HRTsZPij5ItZ8GeM82OXkQs0lYIjNQkAZPb4OijX++pOAnmFKNDZZFQJ8ZuAduUqRsmogR+5/f029zseN0udVIhqpRCtbPiQaJDWiueCa0FNpKnzmORIR0/2ZBl0gMccFtO6OFG0GvpthsfyfZAj0qTmqCQ==",
        userID: uID,
        userName: name,
        config: videoCall
            ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall());
  }
}
