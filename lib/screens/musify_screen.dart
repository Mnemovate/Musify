import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class Musify extends StatelessWidget {
  const Musify({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MusicPlayerScreen(),
    );
  }
}

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  final List<Song> _playlist = [
    Song(
      title: "Tokyo Streets",
      artist: "Song by NAEMS",
      url: "https://cms-public-artifacts.artlist.io/content/music/aac/929959_929942_NAEMS_-_Tokyo_Streets_-_EX-000533_-_Master_-_75_Bpm_-_280224_-_BOV_-_EXT_-_2444.aac",
      albumArt: "https://artlist-albums.imgix.net/images/11519_929946_929946_NAEMS_-_C1_-_2.5K.jpg?auto=format&fit=max&w=640&q=75 640w, https://artlist-albums.imgix.net/images/11519_929946_929946_NAEMS_-_C1_-_2.5K.jpg?auto=format&fit=max&w=768&q=75 768w, https://artlist-albums.imgix.net/images/11519_929946_929946_NAEMS_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1024&q=75 1024w, https://artlist-albums.imgix.net/images/11519_929946_929946_NAEMS_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1280&q=75 1280w, https://artlist-albums.imgix.net/images/11519_929946_929946_NAEMS_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1440&q=75 1440w, https://artlist-albums.imgix.net/images/11519_929946_929946_NAEMS_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1600&q=75 1600w, https://artlist-albums.imgix.net/images/11519_929946_929946_NAEMS_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1920&q=75 1920w, https://artlist-albums.imgix.net/images/11519_929946_929946_NAEMS_-_C1_-_2.5K.jpg?auto=format&fit=max&w=3840&q=75 3840w",
    ),
    Song(
      title: "No Lie",
      artist: "Song by Niahn ft. GRP",
      url: "https://cms-public-artifacts.artlist.io/content/music/aac/36445_320327_320327__319623_Niahn_Ft.GRP_-_Let_Me_Go__-_No_Lie_-_V4_-_270420_-_INT_-_X_-_2444.aac",
      albumArt: "https://artlist-albums.imgix.net/images/2733_328430_328430_Niahn_ft._GRP_-_C2_-_2.5K.jpg?auto=format&fit=max&w=640&q=75 640w, https://artlist-albums.imgix.net/images/2733_328430_328430_Niahn_ft._GRP_-_C2_-_2.5K.jpg?auto=format&fit=max&w=768&q=75 768w, https://artlist-albums.imgix.net/images/2733_328430_328430_Niahn_ft._GRP_-_C2_-_2.5K.jpg?auto=format&fit=max&w=1024&q=75 1024w, https://artlist-albums.imgix.net/images/2733_328430_328430_Niahn_ft._GRP_-_C2_-_2.5K.jpg?auto=format&fit=max&w=1280&q=75 1280w, https://artlist-albums.imgix.net/images/2733_328430_328430_Niahn_ft._GRP_-_C2_-_2.5K.jpg?auto=format&fit=max&w=1440&q=75 1440w, https://artlist-albums.imgix.net/images/2733_328430_328430_Niahn_ft._GRP_-_C2_-_2.5K.jpg?auto=format&fit=max&w=1600&q=75 1600w, https://artlist-albums.imgix.net/images/2733_328430_328430_Niahn_ft._GRP_-_C2_-_2.5K.jpg?auto=format&fit=max&w=1920&q=75 1920w, https://artlist-albums.imgix.net/images/2733_328430_328430_Niahn_ft._GRP_-_C2_-_2.5K.jpg?auto=format&fit=max&w=3840&q=75 3840w",
    ),
    Song(
      title: "Glistening Ripples Lullaby",
      artist: "Song by Lior Soltz",
      url: "https://cms-public-artifacts.artlist.io/content/music/aac/907255_907225_Lior_Soltz_-_Arpeggiato_-_AO-001792_-_Master_V2_-_78_Bpm_-_BOV_-_ORG_-_2444.aac",
      albumArt: "https://artlist-albums.imgix.net/images/10924_915089_915089_Artist_Cover_-_C1_-_2.5K.jpg?auto=format&fit=max&w=640&q=75 640w, https://artlist-albums.imgix.net/images/10924_915089_915089_Artist_Cover_-_C1_-_2.5K.jpg?auto=format&fit=max&w=768&q=75 768w, https://artlist-albums.imgix.net/images/10924_915089_915089_Artist_Cover_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1024&q=75 1024w, https://artlist-albums.imgix.net/images/10924_915089_915089_Artist_Cover_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1280&q=75 1280w, https://artlist-albums.imgix.net/images/10924_915089_915089_Artist_Cover_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1440&q=75 1440w, https://artlist-albums.imgix.net/images/10924_915089_915089_Artist_Cover_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1600&q=75 1600w, https://artlist-albums.imgix.net/images/10924_915089_915089_Artist_Cover_-_C1_-_2.5K.jpg?auto=format&fit=max&w=1920&q=75 1920w, https://artlist-albums.imgix.net/images/10924_915089_915089_Artist_Cover_-_C1_-_2.5K.jpg?auto=format&fit=max&w=3840&q=75 3840w",
    ),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  Future<void> _setupAudioPlayer() async {
    // Request audio focus
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      if (state.playing != _isPlaying) {
        setState(() {
          _isPlaying = state.playing;
        });
      }
    });
    
    // Listen to duration changes
    _audioPlayer.durationStream.listen((newDuration) {
      if (newDuration != null) {
        setState(() {
          _duration = newDuration;
        });
      }
    });
    
    // Listen to position changes
    _audioPlayer.positionStream.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });
    
    // Load the first song
    await _loadSong(_currentIndex);
  }

  Future<void> _loadSong(int index) async {
    if (index < 0 || index >= _playlist.length) return;
    
    _currentIndex = index;
    await _audioPlayer.stop();
    
    try {
      await _audioPlayer.setUrl(_playlist[index].url);
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void _nextSong() {
    if (_currentIndex < _playlist.length - 1) {
      _loadSong(_currentIndex + 1);
      _audioPlayer.play();
    }
  }

  void _previousSong() {
    if (_currentIndex > 0) {
      _loadSong(_currentIndex - 1);
      _audioPlayer.play();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = _playlist[_currentIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Musify'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Album art
          Expanded(
            flex: 5,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    currentSong.albumArt,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.music_note,
                          size: 80,
                          color: Colors.teal,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          
          // Song info
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  currentSong.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  currentSong.artist,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          // Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Slider(
                  min: 0,
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds.toDouble(),
                  onChanged: (value) {
                    _audioPlayer.seek(Duration(seconds: value.toInt()));
                  },
                  activeColor: Colors.teal,
                  inactiveColor: Colors.teal.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_position)),
                      Text(_formatDuration(_duration)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Controls
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous, size: 36),
                  onPressed: _previousSong,
                ),
                const SizedBox(width: 32),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 42,
                      color: Colors.white,
                    ),
                    onPressed: _playPause,
                  ),
                ),
                const SizedBox(width: 32),
                IconButton(
                  icon: const Icon(Icons.skip_next, size: 36),
                  onPressed: _nextSong,
                ),
              ],
            ),
          ),
          
          // Playlist button
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: TextButton.icon(
              icon: const Icon(Icons.queue_music, color: Colors.teal),
              label: const Text("Daftar Putar", style: TextStyle(color: Colors.teal),),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => _buildPlaylistSheet(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "Daftar Putar",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _playlist.length,
              itemBuilder: (context, index) {
                final song = _playlist[index];
                final isPlaying = index == _currentIndex;
                
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      song.albumArt,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey[300],
                          child: const Icon(Icons.music_note, color: Colors.teal),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    song.title,
                    style: TextStyle(
                      fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
                      color: isPlaying ? Colors.teal : null,
                    ),
                  ),
                  subtitle: Text(song.artist),
                  trailing: isPlaying
                      ? const Icon(Icons.equalizer, color: Colors.teal)
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    _loadSong(index);
                    _audioPlayer.play();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String url;
  final String albumArt;

  Song({
    required this.title,
    required this.artist,
    required this.url,
    required this.albumArt,
  });
}