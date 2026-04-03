const CACHE_NAME = "inventario-banquetes-pwa-v1";

const APP_SHELL = [
  "/App_Inventarios/",
  "/App_Inventarios/index.html",
  "/App_Inventarios/styles.css",
  "/App_Inventarios/app.js",
  "/App_Inventarios/config.js",
  "/App_Inventarios/manifest.json",
  "/App_Inventarios/logo-banquetes.png",
  "/App_Inventarios/Banner-Banquetes.png",
  "/App_Inventarios/icon-192.png",
  "/App_Inventarios/icon-512.png"
];

self.addEventListener("install", event => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(cache => cache.addAll(APP_SHELL))
  );
  self.skipWaiting();
});

self.addEventListener("activate", event => {
  event.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys
          .filter(key => key !== CACHE_NAME)
          .map(key => caches.delete(key))
      )
    )
  );
  self.clients.claim();
});

self.addEventListener("fetch", event => {
  if (event.request.method !== "GET") return;

  event.respondWith(
    caches.match(event.request).then(cached => {
      return cached || fetch(event.request).catch(() => caches.match("/App_Inventarios/index.html"));
    })
  );
});
