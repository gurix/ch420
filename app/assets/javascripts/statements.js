$(document).ready(function(){
  $('.statement p').each(function(){
    var trimLength = 300;
    var trimMargin = 1.2; // don't trim just a couple of words
    if($(this).text().length > (trimLength * trimMargin)) {
      var text = $(this).text();
      var trimPoint = $(this).text().indexOf(" ", trimLength);
      var newContent = text.substring(0, trimPoint)+'<span class="read-more">'+text.substring(trimPoint)+'</span><span class="toggle">... <a href="#">' + I18n.t("pages.statements.read_more");
 + '</a></span>';
      $(this).html(newContent);
    }
  });
  $('.toggle a').click(function(e){
    e.preventDefault();
    var para = $(this).closest('p');
    var initialHeight = $(this).closest('p').innerHeight();
    para.find('.read-more').show();
    para.find('.toggle').hide();
    var newHeight = para.innerHeight();
    para.css('max-height', initialHeight+'px');
    para.animate({ maxHeight: newHeight }, 300, function(){
      para.css('max-height', 'none');
    });
  });
});