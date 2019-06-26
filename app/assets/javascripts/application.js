// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .

window.addEventListener('load', function () {
  console.log('Hello from rails!');

  var summaryElements = document.querySelectorAll(".summary");

  for(i = 0; i < summaryElements.length; i++) {
      var element = summaryElements[i]
      var request = new XMLHttpRequest();
      request.open("GET", element.href + ".json" );
      request.responseType = "json";
      request.addEventListener('load', function() {
        var summary = document.getElementById("summary-" + this.response.id);
        var text = "Comments: " + this.response.comments_count + "\nLikes: " + this.response.likes_count + "\nViews: " + this.response.views_count;
        summary.innerText = text;
      })
      element.innerText = "Loading...";
      request.send();
    }

  var comments = document.querySelectorAll(".comment");

  for(i = 0; i < comments.length; i++) {
    var comment = comments[i]
    var score = comment.getElementId("score");
      if (parseInt(score.innerText) <= -1) {
        comment.setAttribute('style','display:none');
        comment.innerText = "This comment has been hidden due to low rating";
      } else {
        comment.setAttribute('style','display:block');
      }
  }
})
