$(document).ready(function(){
 
  $(".choice").on("click", function(e){
      $choice = $(this);
      $choice_text = $choice.text(); // Either "Yes" or "No".
      
      $its_corresponding_option_div = $(".button radius");
      
      $its_corresponding_hidden_field = $("#contact_votes_attributes_0_response");
      
      $its_corresponding_hidden_field.val($choice_text);
      
      $its_corresponding_option_div.hide();
    });

});


// $( "span" ).click(function() {
//   $( "li" ).each(function() {
//     $( this ).toggleClass( "example" );
//   });
// });