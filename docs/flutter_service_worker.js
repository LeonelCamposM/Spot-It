'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "96b84695227b75fca68bb37d639d54f2",
"assets/assets/error.png": "d36e9407ee04fd82a05e3e8f7db501a0",
"assets/assets/icons/Anchor.png": "c6328d40f2699d2d1cdc4ffa7d6067f6",
"assets/assets/icons/Apple.png": "a0ec923003405fc02c6a26327ede12cb",
"assets/assets/icons/Bomb.png": "972b94e0870759028dbd653681c2ceec",
"assets/assets/icons/Cactus.png": "a8ea215d315af243d2f3dd80896b0688",
"assets/assets/icons/Candle.png": "22cf7f16e0b2c8ba086e4c02d4f97ab4",
"assets/assets/icons/Carrot.png": "9daaa8d0635c3fa9be069737cd2a8100",
"assets/assets/icons/Cheese.png": "a8cde0dec3da29ba3139da805785801f",
"assets/assets/icons/Chessknight.png": "676e0902f6820cbc7cd0e72febe7de84",
"assets/assets/icons/Circle.png": "02b53223a63654175e93eac9bb88e966",
"assets/assets/icons/Clock.png": "e7c45dd237bdf20b5ddfe3b472873afe",
"assets/assets/icons/Clown.png": "982a7cd02b7c73a7ee356df1ec33d72e",
"assets/assets/icons/Diasyflower.png": "ed119e9d363e9d64eb2b8c495df399ee",
"assets/assets/icons/Dinosaur.png": "24c9ea476c1f2778089ca61493423146",
"assets/assets/icons/Dog.png": "0252006726840388e70d0af4c0a8362d",
"assets/assets/icons/Dolphin.png": "45114d28a554342c21e43f85d22e2945",
"assets/assets/icons/Dragon.png": "3fe71b1370f40276a24510c40a06d8eb",
"assets/assets/icons/empty.png": "c9477b1f1820f9acfb93eebb2e6679c2",
"assets/assets/icons/Exclamationmark.png": "fa3f5d00e4ae3584036f6dda1f8a9598",
"assets/assets/icons/Eye.png": "d46fc497a2c2ef7f380ed50505ab1b57",
"assets/assets/icons/Fire.png": "808171a85011342d13fb5b0d00d0187a",
"assets/assets/icons/Fourleafclover.png": "28891a83b56785bb5ec148498dea0806",
"assets/assets/icons/Ghost.png": "ad47c7a157e5b7cff74dbbc34d1964ab",
"assets/assets/icons/Greensplats.png": "5cd6534f40857772c3d651aa19fd6aa0",
"assets/assets/icons/Hammer.png": "b00395b7b8e6939959cf8a8f9cecd3ec",
"assets/assets/icons/Heart.png": "d5ed0c60f0f77f57a5a65f6ca490f120",
"assets/assets/icons/IceCube.png": "90ac57334b97fef34145ea8772f9b9da",
"assets/assets/icons/Igloo.png": "568de53b65c62cd9670079134f499fdb",
"assets/assets/icons/Key.png": "24175439b477d157718ee4da602b8537",
"assets/assets/icons/Ladybird.png": "7aab69c22fc57324ff424dea64774d41",
"assets/assets/icons/LightBulb.png": "3617657fa382244931775607defbfcb9",
"assets/assets/icons/LightningBolt.png": "c414310cc2229dae328060b783b51cf9",
"assets/assets/icons/Lock.png": "d3c15f4a710df7a22bb7c63a54934de5",
"assets/assets/icons/logo.png": "a0edcf1f7b24e6460b9b7327d358ede6",
"assets/assets/icons/MapleLeaf.png": "5d59e835f4dfe5e8069bf41a04fffff2",
"assets/assets/icons/MilkBottle.png": "6d8f285a64e1eb0d5e8f58a1c035206a",
"assets/assets/icons/Moon.png": "762017f5a4c920957ac3ea0ba48bb163",
"assets/assets/icons/Pencil.png": "49c4b63048c673bee87bfe53d939155c",
"assets/assets/icons/PurpleCat.png": "17373fe229ff9669bd3c0b02dc09bc03",
"assets/assets/icons/QuestionMark.png": "3a10f8d052579cece911113fd9797470",
"assets/assets/icons/Redlips.png": "014ca47c13bc21bf389217edceb20ba9",
"assets/assets/icons/ScarecrowMan.png": "992177a3807a4126686ffb98a2705f8c",
"assets/assets/icons/Scissors.png": "30dd116cb75616dcf145da48027156da",
"assets/assets/icons/Snowflake.png": "736cb4664a52429aa517f8d6df648f20",
"assets/assets/icons/Snowman.png": "041d7cd31bc08971b80ece9d6945652b",
"assets/assets/icons/Spider.png": "8068de017c9f33b2fa91b2ca46b95eb0",
"assets/assets/icons/Spidersweb.png": "b4f97416f2cafc0af7dae0d2eb20aa37",
"assets/assets/icons/SpotItLogo.png": "1ece494cf8df580c503d392ddb24a32e",
"assets/assets/icons/Sun.png": "0e4e99f8be2bcb01872a91f74ff6a1fc",
"assets/assets/icons/Sunglasses.png": "7d18856b8c7fe65a6931f1d3d33a5759",
"assets/assets/icons/Target.png": "aaffc760590a0c8af855513d8d738e36",
"assets/assets/icons/Taxi.png": "7c1f09646f6009fa65f3657a4127fca3",
"assets/assets/icons/Tortoise.png": "0b8032ebd5cffce8b971b6244cc3b5d7",
"assets/assets/icons/Trebleclef.png": "dbdd0dc23342824c3bf4f2ba1177ec34",
"assets/assets/icons/Tree.png": "3bcfc6c39637a2f63ba1a4377c90b91f",
"assets/assets/icons/Waterdrop.png": "d8293fc1777a1ca0c6515f75a8bf9e63",
"assets/assets/icons/Yinandyang.png": "fe3f0a615d5809a152a1a090ab613682",
"assets/assets/icons/Zebra.png": "d48bc242a4bf1343b7de84c8f1f19b56",
"assets/assets/logo.png": "a0edcf1f7b24e6460b9b7327d358ede6",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "503a0721b6952549cc19879c056a778b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flutter_number_picker/src/images/ic_add.svg": "cf237243f506f80e96c90882e0212884",
"assets/packages/flutter_number_picker/src/images/ic_minus.svg": "70dcdb7c6bee7ceaca8ecebb0a95961e",
"assets/shaders/ink_sparkle.frag": "bbe8b4e7c3f1381cdf5f137c79d65f3d",
"favicon.png": "2c12a5972e27ea089c44116e5ee85b5d",
"icons/Icon-192.png": "78f4fa79dea820d40b438162c19e0016",
"icons/Icon-512.png": "16faf55c232746d0277a7e40dbb68294",
"icons/Icon-maskable-192.png": "78f4fa79dea820d40b438162c19e0016",
"icons/Icon-maskable-512.png": "16faf55c232746d0277a7e40dbb68294",
"index.html": "d833b5b280b69471101f17550a1eb206",
"/": "d833b5b280b69471101f17550a1eb206",
"main.dart.js": "9aef2cc8567fb6fd0ad69675da4b2c1d",
"manifest.json": "c563f4b23dc0144780babf674762a04a",
"version.json": "d27579576b084b0da52ae12e10619638"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
