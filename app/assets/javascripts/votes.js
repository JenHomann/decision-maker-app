$(document).ready(function(){
 
  $(".choice").each(function(e){
    $(".choice").on("click", function(){
      $choice = $(this);
      $choice_text = $choice.text(); // Either "Yes" or "No".
      
      $its_corresponding_option_div = $(".option");
      
      $its_corresponding_hidden_field = $("#contact_votes_attributes_0_response");
      
      $its_corresponding_hidden_field.val($choice_text);
      
      $its_corresponding_option_div.hide();
    })
  });

});