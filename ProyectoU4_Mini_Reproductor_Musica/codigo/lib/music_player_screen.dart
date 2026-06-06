import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/position_data.dart';
import 'package:music_player/seek_bar.dart';
import 'package:rxdart/rxdart.dart'; 
import 'package:google_fonts/google_fonts.dart';

class MusicPlayerScreen extends StatefulWidget{
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> with SingleTickerProviderStateMixin{
  late AudioPlayer _audioPlayer;
  late AnimationController _rotationController;

  bool isPlaying = false;
  int _currentIndex = 0;

  //Estructura para simular una playlist real
  final List<Map<String, String>> _playlist = [
    {
      'title': 'Photograph',
      'artist': 'Ed Sheeran',
      'audio': 'assets/audio/photograph.mp3',
      'image': 'assets/images/artist.jpg',
    },
    {
      'title': 'Nothing´s Gonna Change My Live for You',
      'artist': 'Dave Moffatt & Music Travel Love',
      'audio': 'assets/audio/nothingsGonnaChangeMyLoveforYou.mp3',
      'image': 'assets/images/artist2.jpg',
    },
    {
      'title': 'Can´t Take My Eyes Off You',
      'artist': 'Daniel Boaventura',
      'audio': 'assets/audio/cantTakeMyEyesOffYou.mp3',
      'image': 'assets/images/artist3.jpg',
    },
    {
      'title': 'I Thinks They Call This Love',
      'artist': 'Elliot James Reay',
      'audio': 'assets/audio/iThinkTheyCallThisLove.mp3',
      'image': 'assets/images/artist4.jpg',
    },
    {
      'title': 'My Star',
      'artist': 'Kim Feel',
      'audio': 'assets/audio/myStar.mp3',
      'image': 'assets/images/artist5.jpg',
    },
  ];

  @override
  void initState(){
    super.initState();
    _audioPlayer = AudioPlayer();

    //se inicia el controlador para la animacion de giro
    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _loadAudio();

    //Listener para reaccionar al estado real del reproductor 
    _audioPlayer.playerStateStream.listen((state){
      if (state.playing) {
        _rotationController.repeat(); //sigue girando
        setState(() => isPlaying = true);
      } else {
        _rotationController.stop(); //se detiene
        setState(() => isPlaying = false);
      }

      //escucha para la Playlist
      if (state.processingState == ProcessingState.completed){
        _rotationController.stop();

        if (_currentIndex < _playlist.length -1) {
          _changeTrack(_currentIndex + 1);
          _audioPlayer.play();
        } else {
          setState(() {
            isPlaying = false;
            _currentIndex = 0;
          });
          _loadAudio();
        }
      }
    });
  }

  Future<void> _loadAudio() async {
    try {
      await _audioPlayer.setAsset(_playlist[_currentIndex]['audio']!);
    }catch(e){
      print("Error loading audio: $e");
    }
  }

  //metodos para cambiar de cancion 
  void _changeTrack(int index) async {
    if (index >= 0 && index < _playlist.length){
      _currentIndex = index;
      _rotationController.reset();
      await _loadAudio();
      if (isPlaying){
        _audioPlayer.play();
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
    Rx.combineLatest3<Duration, Duration,
      Duration?, PositionData> (
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream.map((duration) =>
            duration ?? Duration.zero),
          (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration!)
        );
  void _playPause(){
    if(isPlaying){
      _audioPlayer.pause();
    }else {
      _audioPlayer.play();
    }
    setState((){
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context){
    final track = _playlist[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D1445),
        elevation: 0,
        title: Text(
          'InLove', 
          style: GoogleFonts.dancingScript(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        // 4. Fondo con degradado lineal para estilo premium
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D1445), Color(0xFF1A0B2E)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Widget de rotación animada para el disco
              RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
                child: Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withValues(alpha: 0.3),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(track['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              // Textos dinámicos que cambian con la playlist
              Text(
                track['title']!,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                track['artist']!,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),

              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: (newPosition) {
                      _audioPlayer.seek(newPosition);
                    },
                  );
                },
              ),
              const SizedBox(height: 30),

              // 6. Fila de controles interactivos multimedia
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 54,
                    icon: const Icon(Icons.skip_previous, color: Colors.white),
                    // Si es la primera canción, deshabilita el botón
                    onPressed: _currentIndex > 0 ? () => _changeTrack(_currentIndex - 1) : null,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    iconSize: 72,
                    icon: Icon(
                      isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                      color: Colors.pink.shade200, // Color destacado para el botón central
                    ),
                    onPressed: _playPause,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    iconSize: 54,
                    icon: const Icon(Icons.skip_next, color: Colors.white),
                    // Si es la última canción, deshabilita el botón
                    onPressed: _currentIndex < _playlist.length - 1 ? () => _changeTrack(_currentIndex + 1) : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}