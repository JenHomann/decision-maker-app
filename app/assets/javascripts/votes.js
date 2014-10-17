$(document).ready(function(){
 
  $(".choice").on("click", function(){
    $choice = $(this);
    $choice_text = $choice.text();
    
    $its_corresponding_option_div = $choice.parents(".option");
    
    $its_corresponding_hidden_field = $its_corresponding_option_div.children(".hidden_field");

    $its_corresponding_hidden_field.val($choice_text);
    
    $its_corresponding_option_div.hide();
  });
  
  $("#add_contact_field").on("click", function(e){
    e.preventDefault;
    $.ajax("/new_contacts.js");
  });


});

