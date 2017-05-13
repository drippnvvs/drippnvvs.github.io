(function(d){var h=[];d.loadImages=function(a,e){"string"==typeof a&&(a=[a]);for(var f=a.length,g=0,b=0;b<f;b++){var c=document.createElement("img");c.onload=function(){g++;g==f&&d.isFunction(e)&&e()};c.src=a[b];h.push(c)}}})(window.jQuery);
$.fn.hasAttr = function(name) { var attr = $(this).attr(name); return typeof attr !== typeof undefined && attr !== false; };

var lwi=-1;function thresholdPassed(){var w=$(window).width();var p=false;var cw=0;if(w>=960){cw++;}if(lwi!=cw){p=true;}lwi=cw;return p;}
function em1(){var c="esjqqowwtAhnbjm/dpn";var addr="mailto:";for(var i=0;i<c.length;i++)addr+=String.fromCharCode(c.charCodeAt(i)-1);window.location.href=addr;}

$(document).ready(function() {
r=function(){if(thresholdPassed()){dpi=window.devicePixelRatio;if($(window).width()>=960){$('.js-2').attr('src', (dpi>1) ? 'images/drippn-300.jpg' : 'images/drippn-150.jpg');
$('.js-3').attr('src', (dpi>1) ? 'images/com.atebits.tweetie2-large-176.png' : 'images/com.atebits.tweetie2-large-88.png');
$('.js-4').attr('src', (dpi>1) ? 'images/com.yourcompany.ppclient-large-158.png' : 'images/com.yourcompany.ppclient-large-79.png');
$('.js-5').attr('src', (dpi>1) ? 'images/com.reddit.reddit-large-186.png' : 'images/com.reddit.reddit-large-93.png');
$('.js-6').attr('src', (dpi>1) ? 'images/drippn-170.jpg' : 'images/drippn-85.jpg');
$('.js-8').attr('src', (dpi>1) ? 'images/image-572.jpg' : 'images/image-286.jpg');
$('.js-9').attr('src', (dpi>1) ? 'images/wip3-630-2.png' : 'images/wip3-315-2.png');
$('.js-10').attr('src', (dpi>1) ? 'images/poppywip-678.png' : 'images/poppywip-339.png');
$('.js-12').attr('src', (dpi>1) ? 'images/weather-102-3.jpg' : 'images/weather-51-3.jpg');
$('.js-13').attr('src', (dpi>1) ? 'images/snapchat-102-3.png' : 'images/snapchat-51-3.png');
$('.js-14').attr('src', (dpi>1) ? 'images/news-100.png' : 'images/news-50.png');
$('.js-15').attr('src', (dpi>1) ? 'images/dd-432.png' : 'images/dd-216.png');
$('.js-17').attr('src', (dpi>1) ? 'images/com.hammerandchisel.discord-large-422.png' : 'images/com.hammerandchisel.discord-large-211.png');
$('.js-19').attr('src', 'images/artboard-122.jpg');
$('.js-21').attr('src', (dpi>1) ? 'images/com.atebits.tweetie2-large-176-2.png' : 'images/com.atebits.tweetie2-large-88-2.png');
$('.js-22').attr('src', (dpi>1) ? 'images/com.google.inbox-large-202.png' : 'images/com.google.inbox-large-101.png');
$('.js-23').attr('src', (dpi>1) ? 'images/com.reddit.reddit-large-186-2.png' : 'images/com.reddit.reddit-large-93-2.png');}else{$('.js-2').attr('src', (dpi>1) ? 'images/drippn-100.jpg' : 'images/drippn-50.jpg');
$('.js-3').attr('src', (dpi>1) ? 'images/com.atebits.tweetie2-large-58.png' : 'images/com.atebits.tweetie2-large-29.png');
$('.js-4').attr('src', (dpi>1) ? 'images/com.yourcompany.ppclient-large-52.png' : 'images/com.yourcompany.ppclient-large-26.png');
$('.js-5').attr('src', (dpi>1) ? 'images/com.reddit.reddit-large-62.png' : 'images/com.reddit.reddit-large-31.png');
$('.js-6').attr('src', (dpi>1) ? 'images/drippn-58.jpg' : 'images/drippn-29.jpg');
$('.js-8').attr('src', (dpi>1) ? 'images/image-192.jpg' : 'images/image-96.jpg');
$('.js-9').attr('src', (dpi>1) ? 'images/wip3-218.png' : 'images/wip3-109.png');
$('.js-10').attr('src', (dpi>1) ? 'images/poppywip-226.png' : 'images/poppywip-113.png');
$('.js-12').attr('src', (dpi>1) ? 'images/weather-34.jpg' : 'images/weather-17.jpg');
$('.js-13').attr('src', (dpi>1) ? 'images/snapchat-34.png' : 'images/snapchat-17.png');
$('.js-14').attr('src', (dpi>1) ? 'images/news-32.png' : 'images/news-16.png');
$('.js-15').attr('src', (dpi>1) ? 'images/dd-144.png' : 'images/dd-72.png');
$('.js-17').attr('src', (dpi>1) ? 'images/com.hammerandchisel.discord-large-140.png' : 'images/com.hammerandchisel.discord-large-70.png');
$('.js-19').attr('src', (dpi>1) ? 'images/artboard-82.jpg' : 'images/artboard-41.jpg');
$('.js-21').attr('src', (dpi>1) ? 'images/com.atebits.tweetie2-large-60.png' : 'images/com.atebits.tweetie2-large-30.png');
$('.js-22').attr('src', (dpi>1) ? 'images/com.google.inbox-large-68.png' : 'images/com.google.inbox-large-34.png');
$('.js-23').attr('src', (dpi>1) ? 'images/com.reddit.reddit-large-62.png' : 'images/com.reddit.reddit-large-31.png');}}};
if(!window.HTMLPictureElement){$(window).resize(r);r();}
(function(){$('a[href^="#"]').each(function(){$(this).click(function(){var t=this.hash.length>1?$('[name="'+this.hash.slice(1)+'"]').offset().top:0;return $("html, body").animate({scrollTop:t},400),!1})})})();
var wl = new woolite();
wl.init();
wl.addAnimation($('.js')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-7')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-8')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-11')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-16')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-18')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-20')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-21')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-22')[0], "1.00s", "0.00s", 1, 100);
wl.addAnimation($('.js-23')[0], "1.00s", "0.00s", 1, 100);
wl.start();

});