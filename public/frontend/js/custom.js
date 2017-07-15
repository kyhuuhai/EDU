$(document).ready(function() {
  
  /** Slider Image **/
  $('.js-slide').slick({
    autoplay: true,
    arrows: false,
    dots: false,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear'
  });

  /** Slider Class **/

  $('.js-class').slick({
    autoplay: false,
    arrows: true,
    dots: true,
    infinite: true,
    speed:700,
    slidesToShow: 4,
    slidesToScroll: 2,
    cssEase: 'linear'
  });

  /** Slider Partner **/

  $('.js-partner').slick({
    autoplay: true,
    arrows: false,
    dots: false,
    infinite: true,
    speed:500,
    slidesToShow: 6,
    slidesToScroll: 2,
    cssEase: 'linear'
  });

  $('.js-ontop').click(function(){
  	$('html, body').animate({scrollTop:0}, '2000');
  	return false;
  });
});