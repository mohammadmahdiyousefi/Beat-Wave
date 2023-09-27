import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_bloc.dart';
import 'package:justaudioplayer/bloc/allsongs/all_songs_state.dart';
import 'package:justaudioplayer/widget/play_shuffel_button.dart';
import '../bloc/allsongs/all_songs_event.dart';
import '../widget/song _tile.dart';

// ignore: must_be_immutable
class AllSongScreen extends StatelessWidget {
  AllSongScreen({
    super.key,
  });
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSongsBloc, IAllSnogsState>(builder: (context, state) {
      if (state is AllSongsState) {
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onRefresh: () async {
            BlocProvider.of<AllSongsBloc>(context).add(AllSongsEvent());
          },
          child: Scrollbar(
            interactive: true,
            thumbVisibility: true,
            thickness: 6,
            radius: const Radius.circular(10),
            controller: controller,
            child: CustomScrollView(
              controller: controller,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                    child: PlaySuffelbutton("All", state.allsongs)),
                SliverList.builder(
                  itemCount: state.allsongs.length,
                  itemBuilder: (context, index) {
                    return SongTile(index, "All", state.allsongs);
                  },
                ),
              ],
            ),
          ),
        );
      } else if (state is AllsongError) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(state.error),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AllSongsBloc>(context).add(AllSongsEvent());
                  },
                  child: const Text("retry")),
            ],
          ),
        );
      } else if (state is InitAllSongs) {
        return Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ));
      } else if (state is LoadAllsong) {
        return Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        ));
      } else {
        return Center(
          child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<AllSongsBloc>(context).add(AllSongsEvent());
              },
              child: const Text("retry")),
        );
      }
    });
  }
}
