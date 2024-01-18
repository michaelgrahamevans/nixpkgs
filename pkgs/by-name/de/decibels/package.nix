{ lib
, desktop-file-utils
, fetchFromGitHub
, gjs
, glib
, gobject-introspection
, gst_all_1
, gtk4
, libadwaita
, meson
, ninja
, pkg-config
, stdenv
, typescript
, wrapGAppsHook4
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "decibels";
  version = "0.1.7";

  src = fetchFromGitHub {
    owner = "vixalien";
    repo = "decibels";
    rev = finalAttrs.version;
    hash = "sha256-vlemZECKLZaVKpuuOSWpN8Bb4wST9UG+aO2rRyv/d0U=";
    fetchSubmodules = true;
  };

  patches = [
    ./register-resources.patch
  ];

  nativeBuildInputs = [
    desktop-file-utils
    gjs
    meson
    ninja
    pkg-config
    typescript
    wrapGAppsHook4
    gobject-introspection
  ];

  buildInputs = [
    glib
    gtk4
    libadwaita
  ] ++ (with gst_all_1; [
    gstreamer
    gst-plugins-base
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ]);

  postInstallPhase = ''
  '';

  meta = with lib; {
    changelog = "https://github.com/vixalien/decibels/releases/tag/${finalAttrs.version}";
    description = "Play audio files";
    homepage = "https://github.com/vixalien/decibels";
    license = licenses.gpl3Only;
    mainProgram = "com.vixalien.decibels";
    maintainers = with maintainers; [ michaelgrahamevans ];
    platforms = platforms.linux;
  };
})
