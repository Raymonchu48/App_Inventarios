const CACHE_NAME = "inventario-pro-v5";

const APP_SHELL = [
  "./",
  "./index.html?v=5",
  "./styles.css?v=5",
  "./app.js?v=5",
  "./config.js?v=5",
  "./manifest.json?v=5",
  "./logo-banquetes.png",
  "./Banner-Banquetes.png",
  "./icon-192.png",
  "./icon-512.png"
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
        keys.map(key => {
          if (key !== CACHE_NAME) return caches.delete(key);
        })
      )
    )
  );
  self.clients.claim();
});

self.addEventListener("fetch", event => {
  if (event.request.method !== "GET") return;

  event.respondWith(
    caches.match(event.request).then(cached => {
      return cached || fetch(event.request).catch(() => caches.match("./index.html?v=5"));
    })
  );
});
