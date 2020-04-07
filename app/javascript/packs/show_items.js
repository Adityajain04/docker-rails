function commaSeparateNumber(val){
  while (/(\d+)(\d{3})/.test(val.toString())){
    val = val.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2');
  }
  return val;
}
$('document').ready(function(){ 
	 $('.mini-cart-button').click(function(){
     $('.mini-cart-container').toggleClass('mini-cart-open');
   })
   
   $('.plus').on('click', function(e) {
    var val = parseInt($(this).prev('input').val());
    $(this).prev('input').val(val + 1).change();
  });

  $('.minus').on('click', function(e) {
    var val = parseInt($(this).next('input').val());
    if (val !== 0) {
      $(this).next('input').val(val - 1).change();
    }
  });
  
  $('.add-to-cart-button').on('click', function(e) {
    var val = $(this).attr("rel");
    var price = $(this).attr('sel');
    var qty = $("input#text_"+val).val();
    var productName =$(this).attr('product');
    if($(".mini-cart-items ul li#"+val).length)
    {
      var new_val=parseFloat($("span#price_"+val).text())+(parseFloat(qty)*parseFloat(price));
      $("span#price_"+val).text(new_val.toFixed(2));
      
      var new_qty_val=parseInt($("span#qty_"+val).text())+parseInt(qty);
      $("span#qty_"+val).text(new_qty_val);
    }else{ 
        $('.mini-cart-items ul').append('<li id="'+val+'">'+'<h3>'+productName+'<br/>'+'<span class="item-prices" id="price_'+val+'">'+price+'<span>'+'</h3>'+'<span class="item-quantities" id="qty_'+val+'">'+qty+'</span>'+'</li>');
    };

    var totalPrice = 0.0;
    $(".item-prices").each(function()
    {
        totalPrice += parseFloat($(this).text());
    });
    $('div#total-price > span').text(commaSeparateNumber(totalPrice.toFixed(2)));
    
    var totalQty = 0;
    $(".item-quantities").each(function(){
        totalQty += parseFloat($(this).text());
    });
    $('div#total-items > span').text(totalQty.toFixed(0));
    
    $('.succes-message').show(0).delay(1000).hide(0);
  });

});