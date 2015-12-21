console.log("Basic startup");

self.addEventListener('install', function(event) {
  console.log("Basic installed");
});

self.addEventListener('activate', function(event) {
  console.log("Basic activated");
});
