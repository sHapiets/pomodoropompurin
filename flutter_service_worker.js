'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon.png": "13a5edbdf77f98b79dd8d25ec316b727",
"assets/assets/audio/track_playful.mp3": "1502537f40038626888805f775b905c8",
"assets/assets/images/Kotatsu_blue.png": "3f83d0f2a784f5434cfe38de40c1bfd6",
"assets/assets/images/study_table_sprites/wooden.png": "94fc3984123dc69e2f3f1859ea743983",
"assets/assets/images/kotatsu_sprites/pudding.png": "c6c6b8def1f43ee20c823634e0aa0d71",
"assets/assets/images/kotatsu_sprites/aqua.png": "3f83d0f2a784f5434cfe38de40c1bfd6",
"assets/assets/images/test_bg.png": "e5d528feb82fe15bae08449fde4f3f99",
"assets/assets/images/SamplePurin.png": "57987c2cbc4ee238ac86cdd7c2edaebe",
"assets/assets/images/exterior_sprites/plain.png": "6ba004bf1534298215d73c4f9bf0a629",
"assets/assets/images/floor_sprites/smooth.png": "59a0cd829286969485c4fe598357b900",
"assets/assets/images/purin_sprites/summer_icon.png": "1aee87761f85881d60fdc32339fac28b",
"assets/assets/images/purin_sprites/boku_icon.png": "85291f7e619e0bb6dd14cd6683e3ec81",
"assets/assets/images/purin_sprites/boku_spritesheet.png": "50512a19111dcc92f6e98d4735c2c8a4",
"assets/assets/images/purin_sprites/summer_spritesheet.png": "8f5551037c7619eb72eca68bc44051f6",
"assets/assets/images/purin_sprites/bee_icon.png": "24a63cd5e5a4fda351a61daa6ac8722d",
"assets/assets/images/purin_sprites/pika_icon.png": "c1cbe4a28cd9478c36413b5670b77db6",
"assets/assets/images/purin_sprites/yana_icon.png": "1cad3b61a8e2108e12fda164a45067b4",
"assets/assets/images/purin_sprites/pumpkin_spritesheet.png": "0281e14c08348e33c3d6ab3ac8b2970a",
"assets/assets/images/purin_sprites/pumpkin_icon.png": "a764f761751953d1f1c02f3d06c74ca4",
"assets/assets/images/purin_sprites/bee_spritesheet.png": "976bc5bdbd5642db2a2c066d130a5b98",
"assets/assets/images/purin_sprites/yana_spritesheet.png": "d77fbf36aafb67daf3fb0df8f63ebbbf",
"assets/assets/images/purin_sprites/pika_spritesheet.png": "8d92f6027f7da3c875d2ad15290e1c13",
"assets/assets/images/purinAreaHome_stairs.png": "e6cfc164bb3550309b42107006106bd3",
"assets/assets/images/purinAreaHome_kotatsu_blue.png": "a647471348b599b02746ce64db3c0a0a",
"assets/assets/images/consumable_sprites/pancakes/3.png": "908114ffc28f21ade8c8da8b3ae8a7c0",
"assets/assets/images/consumable_sprites/pancakes/2.png": "ca9783188d777719d47e99ebe537f7ff",
"assets/assets/images/consumable_sprites/pancakes/1.png": "17f1b7975cd00d336f1db2ae71ba2f95",
"assets/assets/images/consumable_sprites/pudding/2.png": "306650f6d889f26d34b8ab5f4c03a339",
"assets/assets/images/consumable_sprites/pudding/1.png": "481a6ecf723ffcefe431bf15e168e386",
"assets/assets/images/consumable_sprites/hamburg_steak/3.png": "20eb5ce86045ef03ff45e5a92593c7c4",
"assets/assets/images/consumable_sprites/hamburg_steak/2.png": "201b08ebe47774df965662c8aa978735",
"assets/assets/images/consumable_sprites/hamburg_steak/5.png": "31a7cfc6329fded330c5b7cad6e680ae",
"assets/assets/images/consumable_sprites/hamburg_steak/1.png": "cde73443ad536b4af7d449b0afaa3876",
"assets/assets/images/consumable_sprites/hamburg_steak/4.png": "2d36a9a2488dada30c0a96a7c8d2d981",
"assets/assets/images/consumable_sprites/pizza/3.png": "7077b1f369ea26c8c24a14b6663e87f6",
"assets/assets/images/consumable_sprites/pizza/2.png": "56d43360aef867a2c418c1111cc66b95",
"assets/assets/images/consumable_sprites/pizza/1.png": "beb25dfc2519942696434d08e9aab990",
"assets/assets/images/consumable_sprites/pizza/4.png": "61734ba4952ff5d83cef4f7d3edb035c",
"assets/assets/images/pomPoints_icon.png": "c4ab1198afcc357bd87923f8813f3629",
"assets/assets/images/ingridient_sprites/cookedRice.png": "e2d4f6537105734ad026e15acb637d37",
"assets/assets/images/ingridient_sprites/flour.png": "9fc72a87aca565df9aaf752eac7d3270",
"assets/assets/images/ingridient_sprites/puddingBatter.png": "4588584654db2cd06a88759d115a9d25",
"assets/assets/images/ingridient_sprites/pizzaToppings.png": "2e3485dfa7173c98944ee9b8ec9ece9a",
"assets/assets/images/ingridient_sprites/tomato.png": "3afbc2ae21ee56de56613d4ad91e2731",
"assets/assets/images/ingridient_sprites/washedRice.png": "086c2d3e8f9a92122e306aca8aff8fc8",
"assets/assets/images/ingridient_sprites/dough.png": "6b04bc61fd2a082aed005acc94150c8d",
"assets/assets/images/ingridient_sprites/milk.png": "f544b8d2be5c2cd19c75b7598f929b9e",
"assets/assets/images/ingridient_sprites/riceGrains.png": "a19bfe2f96c29c4f72da7f8255f0fbb3",
"assets/assets/images/ingridient_sprites/butter.png": "810b6eea482cf6fd623048b7d816b524",
"assets/assets/images/ingridient_sprites/pancakeBatter.png": "617814bcddf2a306f2e1f37769ea2133",
"assets/assets/images/ingridient_sprites/eggs.png": "d7c15010f70ede06f987b6b28b32ccb2",
"assets/assets/images/ingridient_sprites/puddingCream.png": "8cac29f64639ca7eee04c67b11f83577",
"assets/assets/images/ingridient_sprites/onion.png": "6f4e9171cbce230ffbf59879427080f2",
"assets/assets/images/ingridient_sprites/olives.png": "36d374ef321b9b58389a889b883694a4",
"assets/assets/images/ingridient_sprites/patty.png": "d51a99450257c704e11e6b23855af1c0",
"assets/assets/images/ingridient_sprites/groundPork.png": "d3b1b8e8c6cefcb2042625e6062ef952",
"assets/assets/images/ingridient_sprites/choppedOnions.png": "92b71d041463ce63f76203a7e9d2b6af",
"assets/assets/images/ingridient_sprites/yeast.png": "f7910bc71421b0fb2b274c20dd8c5e18",
"assets/assets/images/interior_wall_sprites/smooth.png": "bd6d6880101a2e82ee44d7402c9d5761",
"assets/assets/images/shop_sprites/shop.png": "9f7983391f1321f85d31a692d231cdb7",
"assets/assets/images/L7.png": "b48cc7c805a5617542d9ec8e53e1afc2",
"assets/assets/images/purinAreaHome_kotatsu.png": "7215f3be972d6be87dd9e561ef973e07",
"assets/assets/images/kitchen_processors_sprites/mixer.png": "5dc0d30f25633512924701753d420d38",
"assets/assets/images/kitchen_processors_sprites/sink.png": "f6684d5e40db5ed7a414e655e47a3e80",
"assets/assets/images/kitchen_processors_sprites/oven.png": "b1485bd8a19799d9f261b3d9ffe44a51",
"assets/assets/images/kitchen_processors_sprites/stove.png": "23d6c66e664670d42373fca6d3bb4aa8",
"assets/assets/images/kitchen_processors_sprites/choppingBoard.png": "33711880d241c2d01efc30c118924475",
"assets/assets/images/SamplePurinArea.png": "f427b21d342d048fc77c43eaa56e187e",
"assets/assets/images/purinEntity.png": "4b930287707afde8a6085f14b60a3136",
"assets/assets/images/cursors/move.png": "88f334b53e5ff56d854af075de9df536",
"assets/assets/images/pomTimer/pomTimerInput_plus.png": "06c04f8f13185d308efe4ce788bb7df6",
"assets/assets/images/pomTimer/pomTimer_start_button.png": "178b393dd0d845e6da7def96b6631cf4",
"assets/assets/images/pomTimer/pomTimer_foreground.png": "25a37bbd33a423f5371edf9749a83d8d",
"assets/assets/images/pomTimer/pomTimerInput_back.png": "340c031443d0ca828ec5367fc1722754",
"assets/assets/images/pomTimer/pomTimer_work_pointer.png": "81acbc1f4a86bbcc75bab59503eec0fb",
"assets/assets/images/pomTimer/pomTimer_background.png": "c6a2f00889a93bf3dc8c20b7497c76a7",
"assets/assets/images/pomTimer/pomTimerInput_minus.png": "285d349136a35e108db32d8eed34ad4d",
"assets/assets/images/pomTimer/pomTimer_break_pointer.png": "a1c1e2ab05c188483f01f477c299e6fe",
"assets/assets/images/kitchen_sprites/default.png": "95cfe515e425606c784d6167610b23a8",
"assets/assets/images/futon_sprites/cyan.png": "8968d8e2e4686f60049bfff6f3054629",
"assets/assets/images/blanket_sprites/cyan.png": "b0fa2fc4623a8656229ce7a6f4f246e1",
"assets/assets/images/refrigerator_sprites/default.png": "378db74ad50c2e816b28cdbbcab84f7f",
"assets/assets/images/study_chair_sprites/default.png": "e5ac09931d4bd6e6511f8f6d5b9e4cb7",
"assets/assets/images/L8.jpg": "fa9e03355919b558536fda083a1bbb14",
"assets/assets/images/character_icons/koupen/shadow.png": "75af9eae8ea3c2cdd0c17680781f2c5e",
"assets/assets/images/character_icons/koupen/curious.png": "8ac0c3218b674ec60bdb328e7c1b07b4",
"assets/assets/images/character_icons/koupen/thinking.png": "f50140d4433680931bb11c5f90b62e74",
"assets/assets/images/character_icons/koupen/happy.png": "712e74557d5ea3bc55f2dcb6d596710c",
"assets/assets/images/character_icons/koupen/blank.png": "a4101f7378cbbdf705addb95c6ee75d2",
"assets/assets/images/character_icons/koupen/troubled.png": "4b9cfbba83bdc076f39a0000237f7c36",
"assets/assets/images/character_icons/koupen/dazzle.png": "aaf48c76a307d18a8f7d72a88bc4db25",
"assets/assets/images/character_icons/koupen/shocked.png": "bb8f396e115fcd01da062b8244b986e4",
"assets/assets/images/character_icons/purin/shadow.png": "7106ffc0783fda1004b6b7bc4651182e",
"assets/assets/images/character_icons/purin/pumped.png": "d4e0a55dd9592cf0f2c124c23b3b44cd",
"assets/assets/images/character_icons/purin/eating.png": "b9dad22cf00d2a7a0dedce4d346f5ab7",
"assets/assets/images/character_icons/purin/curious.png": "097084a9d4d5171920ab1654a776a9f2",
"assets/assets/images/character_icons/purin/thinking.png": "c760f3779f0392b44d43aaf86b918887",
"assets/assets/images/character_icons/purin/happy.png": "02bea13a2403c1b76854c97b7ab1d7bd",
"assets/assets/images/character_icons/purin/down.png": "e17537117c91bcbedebeb48f2fdae15f",
"assets/assets/images/character_icons/purin/calm.png": "267bd80a734ac712558bd6c9cd9a0ec2",
"assets/assets/images/character_icons/purin/blank.png": "d703340459dda2a79fee79ccfdea232c",
"assets/assets/images/character_icons/purin/excited.png": "a50d831367d7d6c415ebea170aad5f7f",
"assets/assets/images/character_icons/purin/please.png": "026b255d70a744f90ac84506118d1a44",
"assets/assets/images/character_icons/objects/mixer_shadow.png": "162b4199acf2397fca225a284b9660f5",
"assets/assets/images/character_icons/objects/mixer.png": "4c64dc5a228ae91f3e272620b48a8850",
"assets/assets/images/character_icons/objects/stove.png": "5dd6e26d9b1acb93d412f26ae758df4b",
"assets/assets/images/purinAreaHome_floor.png": "b157b1f069f23af4b4b67c4281d425ff",
"assets/assets/images/purinAreaHome_whole.png": "82435d1c3af989316cec853e1a4065e2",
"assets/assets/images/Kotatsu_default.png": "c6c6b8def1f43ee20c823634e0aa0d71",
"assets/assets/fonts/Nunito-Medium.ttf": "04058d9f3583d30ece037e060c5b9721",
"assets/assets/fonts/Fredoka-Regular.ttf": "e1acb36133ba3fedec8ab2610cd61c6b",
"assets/assets/fonts/Nunito-Regular.ttf": "f04f0e9ff969fd52a75deade3a9761cd",
"assets/assets/fonts/Fredoka-Medium.ttf": "3e8c574c93c92c04130508b454b61529",
"assets/NOTICES": "1a56340add802183b334295c5be63138",
"assets/AssetManifest.bin.json": "0bd94507f28ed780f65bcfcf97125509",
"assets/fonts/MaterialIcons-Regular.otf": "ded4d424d9ddf7d6fa3a66e695907afd",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "1de8434e8093104ca65d8f9317bbea53",
"assets/FontManifest.json": "129bcfb38b5ec189732faf32c3edccda",
"index.html": "8412bdc923351c7ab5486c8e747155d5",
"/": "8412bdc923351c7ab5486c8e747155d5",
"manifest.json": "cb84f0b131c29597a91ada8b3f26defe",
"flutter_bootstrap.js": "b9fd034de8a4576c4d6f23f1782262fd",
"main.dart.js": "8caa84e4c5f4e255cda328aae7501704",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"404.html": "501a43c7cf1d5f40cd426aad55205ab7",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"version.json": "394a2183f3fcb67c598e01dfdfd6d7bc",
"icons/Icon-maskable-512.png": "ce6ce04e5bbf2dfd5dd941e69910db41",
"icons/Icon-512-ios.png": "3358cc58285545b882f3c92542a4003e",
"icons/Icon-maskable-192.png": "079c54f63408648365d4c9c8635205a3",
"icons/Icon-192.png": "df1eed2e0834767c81e9659ebca12c2e",
"icons/Icon-512.png": "e363ce80552fbbf07d93cb9c8769b954"};
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
