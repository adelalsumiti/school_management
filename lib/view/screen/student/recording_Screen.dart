import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:school_management/linkapi.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key});

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = "";
  bool playing = false;

  @override
  void initState() {
    super.initState();
    audioRecord = Record();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    if (await audioRecord.hasPermission()) {
      final directory = await getTemporaryDirectory();
      audioPath =
          '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await audioRecord.start(path: audioPath);
      setState(() {
        isRecording = true;
      });
    } else {
      _showSnackbar('Permission denied to record audio.');
    }
  }

  Future<void> stopRecording() async {
    final path = await audioRecord.stop();
    if (path != null) {
      setState(() {
        isRecording = false;
        audioPath = path;
      });
    }
  }

  Future<void> playRecording() async {
    if (audioPath.isNotEmpty) {
      await audioPlayer.play(DeviceFileSource(audioPath));
      setState(() {
        playing = true;
      });
      audioPlayer.onPlayerComplete.listen((_) {
        setState(() {
          playing = false;
        });
      });
    } else {
      _showSnackbar('No recording available to play.');
    }
  }

  Future<void> pauseRecording() async {
    await audioPlayer.pause();
    setState(() {
      playing = false;
    });
  }

  Future<void> uploadAndDeleteRecording() async {
    if (audioPath.isNotEmpty) {
      final file = File(audioPath);
      if (file.existsSync()) {
        final url = Uri.parse(AppLink.addReport);
        final request = http.MultipartRequest('POST', url)
          ..files.add(await http.MultipartFile.fromPath('audio', audioPath));

        final response = await request.send();
        if (response.statusCode == 200) {
          _showSnackbar('Audio uploaded successfully.');
          deleteRecording();
        } else {
          _showSnackbar('Failed to upload audio.');
        }
      } else {
        _showSnackbar('Audio file does not exist.');
      }
    }
  }

  Future<void> deleteRecording() async {
    if (audioPath.isNotEmpty) {
      final file = File(audioPath);
      if (file.existsSync()) {
        await file.delete();
        setState(() {
          audioPath = "";
        });
        _showSnackbar('Recording deleted.');
      } else {
        _showSnackbar('File not found.');
      }
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Recorder'),
      ),
      body: Center(
        child: isRecording
            ? IconButton(
                icon: const Icon(Icons.stop, color: Colors.red, size: 50),
                onPressed: stopRecording,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      playing ? Icons.pause_circle : Icons.play_circle,
                      color: Colors.green,
                      size: 50,
                    ),
                    onPressed: playing ? pauseRecording : playRecording,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 50),
                    onPressed: deleteRecording,
                  ),
                  IconButton(
                    icon: const Icon(Icons.cloud_upload,
                        color: Colors.blue, size: 50),
                    onPressed: uploadAndDeleteRecording,
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.red, size: 50),
                    onPressed: startRecording,
                  ),
                ],
              ),
      ),
    );
  }
}
