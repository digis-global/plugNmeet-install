window.PLUG_N_MEET_SERVER_URL = 'https://dev-dkyc.digis.lk';

// this is helpful for external plugin development where images or other files located
// in other place.
// window.STATIC_ASSETS_PATH = '';

// custom logo. For best, use direct https link
/*window.CUSTOM_LOGO = {
  main_logo_light: 'https://mydomain.com/logo_light.png',
  main_logo_dark: 'https://mydomain.com/logo_dark.png',
  waiting_room_logo_light: '',
  waiting_room_logo_dark: '',
};*/

//With Dynacast dynamically pauses video layers that are not being consumed by any subscribers, significantly reducing publishing CPU and bandwidth usage.
window.ENABLE_DYNACAST = true;

//When using simulcast, LiveKit will publish up to three versions of the stream at various resolutions. Client can pickup most appropriate one.
window.ENABLE_SIMULCAST = true;

// Available options: 'vp8' | 'h264' | 'vp9' | 'av1' Default: vp8
window.VIDEO_CODEC = 'vp8';

// Available options: 'h90' | 'h180' | 'h216' | 'h360' | 'h540' | 'h720' | 'h1080' | 'h1440' | 'h2160'.
// Default: h720
window.DEFAULT_WEBCAM_RESOLUTION = 'h720';

// Available options: 'h360fps3' | 'h720fps5' | 'h720fps15' | 'h1080fps15' | 'h1080fps30'.
// Default: h1080fps15
window.DEFAULT_SCREEN_SHARE_RESOLUTION = 'h1080fps15';

//For local tracks, stop the underlying MediaStreamTrack when the track is muted (or paused) on some platforms, this option is necessary to disable the microphone recording indicator. Note: when this is enabled, and BT devices are connected, they will transition between profiles (e.g. HFP to A2DP) and there will be an audible difference in playback.
window.STOP_MIC_TRACK_ON_MUTE = true;

// Design customization
// in json format
window.DESIGN_CUSTOMIZATION = `{
  "background_color": "#F9F9F9",
  "background_image": "",
  "left_side_bg_color": "#FFFFFF",
  "right_side_bg_color": "#FFFFFF",
  "custom_css_url": "",
  "custom_logo": "https://digitalservices.lk/wp-content/uploads/2021/04/DIGI-LOGO-2.png"
}`;

// Whiteboard PreloadedLibraryItems which should an array of full library direct URL
// You can get items from here: https://libraries.excalidraw.com
// window.WHITEBOARD_PRELOADED_LIBRARY_ITEMS = [
//   'https://libraries.excalidraw.com/libraries/BjoernKW/UML-ER-library.excalidrawlib',
//   'https://libraries.excalidraw.com/libraries/aretecode/decision-flow-control.excalidrawlib',
//   'https://libraries.excalidraw.com/libraries/dbssticky/data-viz.excalidrawlib',
//   'https://libraries.excalidraw.com/libraries/pgilfernandez/basic-shapes.excalidrawlib',
//   'https://libraries.excalidraw.com/libraries/ocapraro/bubbles.excalidrawlib',
// ];
