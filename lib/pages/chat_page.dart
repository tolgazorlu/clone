import 'package:flutter/material.dart';
import '../data/match_store.dart';
import '../theme/colors.dart';
import '../widgets/profile_photo.dart';

class _Message {
  final String text;
  final bool fromMe;
  _Message(this.text, this.fromMe);
}

/// A simple one-to-one chat with a matched person.
class ChatPage extends StatefulWidget {
  final Match match;
  const ChatPage({Key key, this.match}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<_Message> _messages = [];

  @override
  void initState() {
    super.initState();
    MatchStore.instance.markOpened(widget.match);
    _messages.add(_Message(
      'Hey! Great to match with you 😊 What are you up to this weekend?',
      false,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(text, true));
      widget.match.lastMessage = text;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.match.profile;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: ProfilePhoto(url: p.heroPhoto, initial: p.name),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              p.name ?? '',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) return _matchBanner(p.name);
                return _bubble(_messages[index - 1]);
              },
            ),
          ),
          _composer(),
        ],
      ),
    );
  }

  Widget _matchBanner(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (r) => AppColors.flameGradient.createShader(r),
            child: const Icon(Icons.favorite, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            'You matched with $name',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(_Message m) {
    return Align(
      alignment: m.fromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          gradient: m.fromMe ? AppColors.flameGradient : null,
          color: m.fromMe ? null : AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(m.fromMe ? 18 : 4),
            bottomRight: Radius.circular(m.fromMe ? 4 : 18),
          ),
        ),
        child: Text(
          m.text,
          style: TextStyle(
            color: m.fromMe ? Colors.white : AppColors.textPrimary,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _composer() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 12, 8),
        color: AppColors.surface,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(
                  hintText: 'Type a message…',
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _send,
              child: Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  gradient: AppColors.flameGradient,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
