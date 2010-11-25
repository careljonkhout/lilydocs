pageIndex = 0
function nextPage() {
  pageIndex = incUnlessMax(pageIndex, imageFiles.length - 1)
  document.getElementById('page').src = imageFiles[pageIndex]
}

function previousPage() {
  pageIndex = decUnlessMin(pageIndex, 0)
  document.getElementById('page').src = imageFiles[pageIndex]
}

function incUnlessMax(i, max) { return i < max ? ++i : i }
function decUnlessMin(i, min) { return i > min ? --i : i }

ajaxLoader= new Image(54,55); 
ajaxLoader.src="https://lilydocs.com/images/site/ajax-loader.gif";

document.on('ajax:before', function(event) {
  $('great_image_wrapper').innerHTML = 
   "<div id='ajax_loader_wrapper'><img src=http://lilydocs.com/images/site/ajax-loader.gif></img></div>";
})

function handleRemote(element) {
  var method, url, params;

  var event = element.fire("ajax:before");
  if (event.stopped) return false;

  if (element.tagName.toLowerCase() === 'form') {
    method = element.readAttribute('method') || 'post';
    url    = element.readAttribute('action');
    params = element.serialize();
  } else {
    method = element.readAttribute('data-method') || 'get';
    url    = element.readAttribute('href');
    params = {};
  }

  new Ajax.Request(url, {
    method: method,
    parameters: params,
    evalScripts: true,

    onComplete:    function(request) { element.fire("ajax:complete", request); },
    onSuccess:     function(request) { element.fire("ajax:success",  request); },
    onFailure:     function(request) { element.fire("ajax:failure",  request); }
  });

  element.fire("ajax:after");
}
