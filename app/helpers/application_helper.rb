# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def display_thing_content thing
    content = thing.thing.gsub("\n","<br />")
    if content.size > 450
      "<div style='display: block;' id='thing_content_#{thing.id}' class='thing_content'>#{content[0,450] + "..."}</div>
       <div id='thing_content_read_more_#{thing.id}' class='thing_more'><a class='expand_thing' href='#' onclick='return toggle_thing(#{thing.id});'>more</a></div>
       <div style='display: none;' id='thing_content_full_#{thing.id}' class='thing_content_full'>#{content}</div>
       <div style='display: none;' id='thing_content_read_less_#{thing.id}' class='thing_less'><a class='expand_thing' href='#' onclick='return toggle_thing(#{thing.id});'>shrink</a></div>"
    else
      "<div class='thing_content'>
        #{content}
       </div>"
    end
  end
end