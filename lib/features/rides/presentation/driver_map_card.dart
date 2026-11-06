import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMapCard extends StatefulWidget {
  final LatLng passengerPos;
  final LatLng? driverPos;
  final String? distanceText;

  const DriverMapCard({
    super.key,
    required this.passengerPos,
    this.driverPos,
    this.distanceText,
  });

  @override
  State<DriverMapCard> createState() => _DriverMapCardState();
}

class _DriverMapCardState extends State<DriverMapCard> {
  GoogleMapController? _controller;

  @override
  void didUpdateWidget(covariant DriverMapCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.driverPos != widget.driverPos) _fitBoth();
  }

  void _fitBoth() {
    final d = widget.driverPos;
    if (d == null || _controller == null) return;
    final p = widget.passengerPos;

    try {
      final bounds = LatLngBounds(
        southwest: LatLng(
          p.latitude < d.latitude ? p.latitude : d.latitude,
          p.longitude < d.longitude ? p.longitude : d.longitude,
        ),
        northeast: LatLng(
          p.latitude > d.latitude ? p.latitude : d.latitude,
          p.longitude > d.longitude ? p.longitude : d.longitude,
        ),
      );
      _controller?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 40));
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('passenger'),
        position: widget.passengerPos,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
      if (widget.driverPos != null)
        Marker(
          markerId: const MarkerId('driver'),
          position: widget.driverPos!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
    };

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: widget.passengerPos, zoom: 15),
              markers: markers,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (c) {
                _controller = c;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(const Duration(milliseconds: 300), _fitBoth);
                });
              },
            ),
            if (widget.distanceText != null)
              Positioned(
                top: 10,
                left: 12,
                right: 12,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.distanceText!,
                          style: GoogleFonts.sourceSerif4(
                            color: const Color(0xFF1F2937),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'مباشر',
                          style: GoogleFonts.sourceSerif4(
                            color: const Color(0xFF6B7280),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
