import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/data/cubit/story/detail_story_cubit.dart';

class MapsDetailPage extends StatefulWidget {
  const MapsDetailPage({
    required this.id,
    required this.detailStoryCubit,
    super.key,
  });

  final String id;
  final DetailStoryCubit detailStoryCubit;

  @override
  State<MapsDetailPage> createState() => _MapsDetailPageState();
}

class _MapsDetailPageState extends State<MapsDetailPage> {
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  final _controller = Completer<GoogleMapController>();

  final markersNotifier = ValueNotifier<Set<Marker>>({});

  Future<void> setMarker(double lat, double lon) async {
    final controller = await _controller.future;
    const placeId = 'STORY_PLACE';

    final marker = Marker(
      markerId: const MarkerId(placeId),
      position: LatLng(lat, lon),
    );

    markersNotifier.value.add(marker);

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lon),
          zoom: 18,
        ),
      ),
    );
  }

  Future<void> disposeController() async {
    final controller = await _controller.future;
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.detailStoryCubit.getDetailStory(widget.id);
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.locationMap)),
      body: BlocConsumer<DetailStoryCubit, DetailStoryState>(
        listener: (context, state) {
          if (state is DetailStoryInitial) {
            widget.detailStoryCubit.getDetailStory(widget.id);
          }
          if (state is DetailStorySuccess) {
            log('jancook');
            if (state.result.lat != null && state.result.lon != null) {
              setMarker(state.result.lat!, state.result.lon!);
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ValueListenableBuilder<Set<Marker>>(
                valueListenable: markersNotifier,
                builder: (context, value, _) {
                  return GoogleMap(
                    onMapCreated: _controller.complete,
                    markers: markersNotifier.value,
                    initialCameraPosition: CameraPosition(
                      target: dicodingOffice,
                      zoom: 5,
                    ),
                  );
                },
              ),
              if (state is DetailStorySuccess)
                Positioned(
                  bottom: 10,
                  right: 10,
                  left: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.95),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            state.result.photoUrl,
                            height: 200,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  state.result.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  state.result.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 15,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
