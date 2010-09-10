// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function toggle_thing(thing_id) {
  var thing_full = jq('#thing_content_full_'+thing_id);
  if(thing_full.css('display') == 'none')
  {
    thing_full.css('display','block');
    var thing_content = jq('#thing_content_'+thing_id);
    thing_content.css('display','none');    
    var thing_more = jq('#thing_content_read_more_'+thing_id);
    thing_more.css('display','none');
    var thing_less = jq('#thing_content_read_less_'+thing_id);    
    thing_less.css('display','block');
  }
  else
  {
    thing_full.css('display','none');
    var thing_content = jq('#thing_content_'+thing_id);
    thing_content.css('display','block');
    var thing_more = jq('#thing_content_read_more_'+thing_id);
    thing_more.css('display','block');
    var thing_less = jq('#thing_content_read_less_'+thing_id);    
    thing_less.css('display','none');    
  }
  return false;
}
function display_category_context_message(category) {
  var context = jq("#category_result");
  if(category == 'mean')
  {
    context.text("Sorry to hear that");
  }
  else if(category == "nice")
  {
    context.text("Are you going to brag?");
  }
  else if(category == "stupid")
  {
    context.text("Oh man... hope this is good");
  }
  else if(category == "hurricane")
  {
    context.text("He'll blow you away...");
  }
  else if(category == "funny")
  {
    context.text("Spandex");
  }
  else if(category == "other")
  {
    context.text("Other? Might as well suggest a category");
  }
  else
  {
    context.text("WTF Mate?");
  }
}

function toggle_div(div_id) {
  var div = jq('#'+div_id);
  var divs = jq('#flash_about').children('div').not(div);
  var content_container = jq('#content_container');

  if(div.css('display') == 'none')
  {
    content_container.css('border-top','1px solid #666');
    divs.slideUp(function() {
      div.slideDown();
    });
  }
  else
  {
    content_container.css('border-top','none');
    div.slideUp();
  }
}

function browse_by(option)
{
  var opt = jq(option);
  window.location.href='/things?filter='+opt.val();
}

function cast_vote(d,id)
{
  var auth_token = jq('#auth_token').val();
  jq.ajax({
          url: "/things/vote",
          global: false,
          type: "POST",
          dataType: 'json',
          data: ({
            authenticity_token : auth_token,
            thing_id : id,
            direction : d
          }),
          success: function(obj){
            update_count(id,obj.vote_count);
          },
          error: function(msg){
            show_flash_error(msg, true);
          }
  });
}

function update_count(id,count)
{
  jq('#votes_for_'+id).html('<b>'+count+'</b>');
}

function hide_flash()
{
  var flash = jq("#flash_container");
  if(flash.css('display') == 'block')
  {
    flash.slideUp(jq('#flash_error').slideUp(jq('#flash_notice').slideUp()));
  }
}

function hide_flash_error()
{
  var flash = jq("#flash_container");
  var error = jq('#flash_error');
  var notice = jq('#flash_notice');

  if(flash.css('display') == 'block')
  {
    if(notice.css('display') == 'none')
    {
      error.slideUp(function(){flash.hide();});
    }
    else
    {
      error.slideUp().hide();
    }
  }
}

function hide_flash_notice()
{
  var flash = jq("#flash_container");
  var error = jq('#flash_error');
  var notice = jq('#flash_notice');

  if(flash.css('display') == 'block')
  {
    if(error.css('display') == 'none')
    {
      notice.slideUp(function(){flash.hide();});
    }
    else
    {
      notice.slideUp().hide();
    }
  }
}

function show_flash_notice(msg, hide)
{
  var flash = jq("#flash_container");
  var notice = jq('#flash_notice');
  var flash_close = ' <a class="flash_close" onclick="hide_flash_notice(); return false;" href="#">hide</a>';
  if(hide)
  {
    msg += flash_close;
  }

  if(notice.css('display')== 'none')
  {
    notice.html(msg).slideDown(function(){
      if(flash.css('display') == 'none')
      {
        flash.slideDown();
      }

    });
  }
}

function show_flash_error(msg, hide)
{
  var flash = jq("#flash_container");
  var error = jq('#flash_error');
  var flash_close = ' <a class="flash_close" onclick="hide_flash_error(); return false;" href="#">hide</a>';
  if(hide)
  {
    msg += flash_close;
  }

  if(error.css('display')== 'none')
  {
    error.html(msg).slideDown(function(){
      if(flash.css('display') == 'none')
      {
        flash.slideDown();
      }

    });
  }
}

function scroll_up()
{
  jq('html').animate({scrollTop:0}, 'slow');
}

function process_thing()
{
  var body = jq('#add_new_thing_body');
  var category = jq('#thing_category');
  if( body.val() != "" )
  {
    jq.post("/things/create_ajax", {
              authenticity_token : jq('#auth_token').val(),
              body : body.val(),
              category : category.val()
            },
            function () {
              location = "/things";
            }
    );
  }
  else
  {
    show_flash_error("Please add text to your new snippet.", true);
  }
}

function check_char_count() {
  var text = jq('#add_new_thing_body');
  var max = 450;
  if(text.val().length > max)
  {
    var chars = text.val();
    text.val( chars.substring(0,max) );
  }
  chars = max - text.val().length;
  jq('#character_count').text(chars);
}