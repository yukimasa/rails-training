document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('.delete').forEach(function(a) {
    a.addEventListener('ajax:success', function(e) {
      var td = a.parentNode;
      var tr = td.parentNode;
      tr.style.display = 'none';
    });
  });
});
