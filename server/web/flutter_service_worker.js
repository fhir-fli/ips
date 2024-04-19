'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"manifest.json": "0ef0368e9504055d5f2c6e0550b89e15",
"main.dart.js": "bdc6597a6ccfe35939e736a406a842bf",
"assets/NOTICES": "91c473f484155e95a691c2eb69397979",
"assets/fonts/MaterialIcons-Regular.otf": "6924eed28d257341c15f4f715c6c1564",
"assets/assets/images/fingerprint-light2.png": "ffe53080e1c12ba842b062dfa7ce884c",
"assets/assets/images/atsign.png": "3d36b67403145561c94869a8353983e2",
"assets/assets/images/fingerprint-light1.png": "c6739aa8601f8d7672d49abbd0f6e816",
"assets/assets/images/fingerprint-dark.png": "851a6d74e7b2ef5d30f333af9fccbf47",
"assets/assets/images/atsign-logo.png": "c0a5c77a2a014cab67290bc3f7d1ab90",
"assets/assets/images/ips-logo.png": "fb27aa6e069c82dc521e5b93cd03a961",
"assets/assets/images/fingerprint-light.png": "7f16ccb7e4882f8063b6cfca98ec6767",
"assets/assets/samples/US_no_info_with_Advance_Directive.json": "725da15b532097f1cb7227925da07d50",
"assets/assets/samples/US_Washington_GDHP_original.json": "82255b0077f53ed561c3de347568cf83",
"assets/assets/samples/IPS_health_RIS_minimal.json": "27bcdb98218dbbf8cf5282755da753f3",
"assets/assets/samples/US_Dynamic_Health_IT_Happy_Kid_FHIR_Bundle-IPS.json": "da0b4d77470e926f5b4deeb80ac53b54",
"assets/assets/samples/AT_ELGA_GmbH_01.json": "606a418c663f51eb41223c7869e0be2f",
"assets/assets/samples/DE_no_info_with_Advance_Directive.json": "1961edc5a12695b3971504cab97ca521",
"assets/assets/samples/HK_IPS_Sample2.json": "7b4f158b6da1705a94330d4aa237a296",
"assets/assets/samples/US_Interoperability_Institute_Troy%2520Dudley%2520Gross-IPS.json": "1caa3d79644c285b7d7ccc8944fa6e8a",
"assets/assets/samples/HK_IPS_Sample3.json": "ff06c622f56efb9a935167169a935ada",
"assets/assets/samples/IPS_IG_bundle-minimal.json": "4da5a4109740d54797e3d517cf79e400",
"assets/assets/samples/CY_194315.json": "dfe9cb3c563c29a0ba4fdb8fcf1072e0",
"assets/assets/samples/CY_Peroni.json": "27251fb46facc120fff7318d62f033f1",
"assets/assets/samples/US_Washington_GDHP.json": "dd3d4ade70a2178bb6f6c45c00ecf035",
"assets/assets/samples/US_ePatientDave_medRequests_original_noNarrative.json": "8433399c9ed3cc12072236f8e674cc40",
"assets/assets/samples/IPS_IG-bundle-01.json": "65a20b8c54a86d86c00a40a540e5b3a6",
"assets/assets/samples/EU_Giorgio_Cangioli_01.json": "7c4e6a8dac46f3dd69df373c37b8cf31",
"assets/assets/samples/NZ_Peter_Jordan_NNJ9186.json": "31a57dd730fc29ce15e598be0239c9d6",
"assets/assets/samples/NZ_Peter_Jordan_AAA1234.json": "dc6e54430c695801e5a434075df444e9",
"assets/assets/samples/US_Interoperability_Institute_Louis_Daniel_Saunders-IPS.json": "19ed87df398c77f6d61b54309f30c180",
"assets/assets/samples/HK_IPS_Sample_with_medication.json": "75b7bf734cdfd3e84e02f974b390a403",
"assets/assets/samples/US_Interoperability_Institute_Jared_Bruce_Adams-IPS.json": "7ddf05e36418f5143eb8c6b786d5ff70",
"assets/assets/samples/CY_Andreas_Ioannou_01.json": "9a18b58b61fd9c03010b2a53ac07cfbe",
"assets/assets/samples/UK_NHSx_IPS_Example_02-modified.json": "7f5e4888ecb846e6595b97a69e4fb662",
"assets/assets/samples/AR_Repository_Example_01.json": "89ea557dc77e5e007af6fec2a05d9bf1",
"assets/assets/samples/AR_Repository_Example_02.json": "baaa933134412b27313b6d67db358a2b",
"assets/assets/samples/CA_Bundle_FullsomeScenario1.json": "ebce8d26a273067660c89aaef2f80294",
"assets/assets/samples/HK_IPS_Sample1.json": "7b42126bceb0c25b69af49be7c3b30a3",
"assets/assets/samples/AT-elga2.json": "47d8ef1945fb342b4bef60a09120fbe1",
"assets/assets/samples/TW_Li-Hui_Lee_01-modified.json": "18889cac7d9f63e7fda90e23456a304a",
"assets/assets/samples/US_ePatientDave_medRequest_with_Narrative.json": "343c25696c7f8ebfebdbe72d84050975",
"assets/assets/samples/CA_PuraJuniper_01.json": "699c74b5fa5dd53f04d1f33fc3095f11",
"assets/assets/samples/DK_Jens_Villadsen_01.json": "8e3858537371ff562091285246245e6d",
"assets/assets/samples/IPS_IG_bundle-no-info-required-sections.json": "714b22a244fb39f5b1d27249d8ffc199",
"assets/assets/samples/CA_PuraJuniper_01-modified.json": "fc3624c15dbaf1fb4a7796d5e7d67c76",
"assets/assets/samples/US_Interoperability_Institute_Rose%2520Cox%2520Burnett-IPS.json": "0233c6b0844cbfa670a7f2040bf1ae61",
"assets/assets/samples/CH_HL7CH_Examples_01.json": "85efae64036dc9e55985e7a355fcb0b0",
"assets/assets/samples/UK_NHSx_IPS_Example_01-modified.json": "6757624a7ca10ff534444ef0ab1cbdca",
"assets/assets/samples/CA-IPS-Bundle1Example.json": "5e7f57736c0d04ed492d7b752a91b7b5",
"assets/assets/samples/US_Interoperability_Institute_Pearl%2520Holmes%2520Levine-IPS.json": "ef66df2c5702662d136858c01aef56fc",
"assets/assets/samples/EU_Giorgio_Cangioli_03.json": "7fc2b7a0fdc5293428ab4ab8912645f5",
"assets/assets/samples/CY_249867.json": "f63248e4be698e4abe15133e52cf7838",
"assets/assets/samples/EU_Giorgio_Cangioli_02.json": "699c4378190014ac1d89dbe5b10b9a52",
"assets/assets/samples/IPS_IG_bundle-emptyReason.json": "e00a8398d73584c44a492fabf5cc201c",
"assets/assets/samples/US_ePatientDave_medStatements_original_noNarrative.json": "c88e1ca6db84dfd870053fc38b82e698",
"assets/assets/samples/US_ePatientDave_medStatements_with_Narrative.json": "82c6a0f9847a36731b1577f3a0e06169",
"assets/assets/samples/NL_core_patient_01.json": "30548ab165522ddc119844b114291c79",
"assets/AssetManifest.json": "75f7fdad78e50af62cf53743442bb3c6",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin": "32035c86a359589f865ce22d24c7850c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "1498ca9f5fe190485822793872d4e8b1",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"index.html": "8a5fccca56b758ef8c4cae3bf5424283",
"/": "8a5fccca56b758ef8c4cae3bf5424283",
"version.json": "00a5b52d9c2759a37e11d3d6e632e0b7"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
