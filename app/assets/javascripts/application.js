// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  $('.extra a.show-extra').click(function(e){
    e.preventDefault();
    $(this).hide();
    $(this).parents('.extra').find('.more').show();
  });

  var updateList = function() {
    $.getJSON(GameChecker.gamesPath, function(data) {
      var ul = $('ul#my-turns').html('');
      $.each(data, function() {
        var li = '<li class="' + this.nickname + '"><a href="/games/' + this.id + '/play" data-method="post" rel="nofollow">' + this.url + '</a></li>';
        ul.append(li);
      });
    });
  };

  setInterval(updateList, 1000 * 60 * 5); // 5 minutes
})
