'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "69622ea9d6e034e327db5282d17d535d",
"index.html": "1186cb5518dcdc6f69b7b30f77ec6374",
"/": "1186cb5518dcdc6f69b7b30f77ec6374",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "e4bd273ac912fce76ee4b85a4fcbe6c6",
"assets/assets/images/purinEntity.png": "4b930287707afde8a6085f14b60a3136",
"assets/assets/images/purinAreaHome_whole.png": "82435d1c3af989316cec853e1a4065e2",
"assets/assets/images/purinAreaHome_floor.png": "b157b1f069f23af4b4b67c4281d425ff",
"assets/assets/images/purinAreaHome_kotatsu_blue.png": "a647471348b599b02746ce64db3c0a0a",
"assets/assets/images/test_bg.png": "e5d528feb82fe15bae08449fde4f3f99",
"assets/assets/images/purinAreaHome_stairs.png": "e6cfc164bb3550309b42107006106bd3",
"assets/assets/images/Kotatsu_blue.png": "3f83d0f2a784f5434cfe38de40c1bfd6",
"assets/assets/images/pomTimer/pomTimerInput_back.png": "340c031443d0ca828ec5367fc1722754",
"assets/assets/images/pomTimer/pomTimer_start_button.png": "178b393dd0d845e6da7def96b6631cf4",
"assets/assets/images/pomTimer/pomTimer_work_pointer.png": "d5873c5792371d70c9aff21e1eb0e261",
"assets/assets/images/pomTimer/pomTimerInput_minus.png": "285d349136a35e108db32d8eed34ad4d",
"assets/assets/images/pomTimer/pomTimerInput_plus.png": "06c04f8f13185d308efe4ce788bb7df6",
"assets/assets/images/pomTimer/pomTimer_background.png": "c6a2f00889a93bf3dc8c20b7497c76a7",
"assets/assets/images/pomTimer/pomTimer_foreground.png": "25a37bbd33a423f5371edf9749a83d8d",
"assets/assets/images/pomPoints_icon.png": "ae1473b14eee9a76831d790e5d7d1abd",
"assets/assets/images/L8.jpg": "fa9e03355919b558536fda083a1bbb14",
"assets/assets/images/SamplePurinArea.png": "f427b21d342d048fc77c43eaa56e187e",
"assets/assets/images/L7.png": "b48cc7c805a5617542d9ec8e53e1afc2",
"assets/assets/images/Kotatsu_default.png": "c6c6b8def1f43ee20c823634e0aa0d71",
"assets/assets/images/purinAreaHome_kotatsu.png": "7215f3be972d6be87dd9e561ef973e07",
"assets/assets/images/SamplePurin.png": "57987c2cbc4ee238ac86cdd7c2edaebe",
"assets/assets/fonts/Fredoka-Regular.ttf": "e1acb36133ba3fedec8ab2610cd61c6b",
"assets/assets/fonts/Nunito-Regular.ttf": "f04f0e9ff969fd52a75deade3a9761cd",
"assets/assets/fonts/Nunito-Medium.ttf": "04058d9f3583d30ece037e060c5b9721",
"assets/assets/fonts/Fredoka-Medium.ttf": "3e8c574c93c92c04130508b454b61529",
"assets/fonts/MaterialIcons-Regular.otf": "8561ec4243c6aeb63c0587f29a891061",
"assets/NOTICES": "6b5b55eccfd0b069912f1381fedb233a",
"assets/FontManifest.json": "129bcfb38b5ec189732faf32c3edccda",
"assets/AssetManifest.bin": "fdb17c0326240dada99973c8494f10ae",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"404.html": "501a43c7cf1d5f40cd426aad55205ab7",
"flutter_bootstrap.js": "906fe11fb476236e2f00db9209e92a58",
"version.json": "394a2183f3fcb67c598e01dfdfd6d7bc",
"main.dart.js": "270a65e2db320591051e24b8c81d6bd1"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
