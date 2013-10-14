function onPage(page){
  return $("body").hasClass(page);
}
function loadingIcon(target){
  var loaderSymbols = ['0', '1', '2', '3', '4', '5', '6', '7']; 
	var loaderIndex = 0;
	loadAction = setInterval(function(){
		loaderIndex = loaderIndex  < loaderSymbols.length - 1 ? loaderIndex + 1 : 0;
		$(target).addClass("symbols").html(loaderSymbols[loaderIndex]);
	}, 100);
}
$(function(){
//  $("a").hover(function(){
//    if($(this).css("display") == "block"){$(this).addClass("bold")}
//    }, function(){$(this).removeClass("bold")});
//show/hide flash messages
	if($('.msg').html() != ""){
		$('.messages').show(0);
	}
	setTimeout(function(){
		$('.messages').fadeOut(200);
	}, 3500);
  
  
//login dropdown
  $(".login_button a").click(function(e){
  	$(".login_expanded").toggle();
  	return false;
  });
//home page acre is text reveal
  if(onPage("pages-index")){
    var acre_col_init_height;
    $(".acre_text_content a").click(function(e){
      acre_col_init_height = $(".acre.col .panel").height();
    	$(this).closest(".acre_text_content").addClass("lessened").hide();
    	$(".extra_acre_text_content").show();
    	$(".acre.col .panel").css("height", "auto");
    	return false;
    });
    $(".extra_acre_text_content a").click(function(e){
    	$(this).closest(".extra_acre_text_content").hide();
    	$(".lessened").show();
    	$(".acre.col .panel").css("height", acre_col_init_height);
    	return false;
    });
  }
//contact page dropdowns
  if(onPage("pages-contact")){
    $(".dropdown_panel a").click(function(e){
      $(".job-postings").hide();
    	$(this).closest(".dropdown_panel").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
    	var toggle = $(this).data("toggle");
    	$("."+toggle).toggle();
    	if(toggle == "tenant_application"){
        $(".contact_text").toggle();
    	}
    	return false;
    });
  }
  $(".beginApplication, .contact_text h2").click(function(e){
  	//$(".application").find(".dropdown_panel").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
  	//var toggle = $(".application").find(".dropdown_panel a").data("toggle");
  	$(".tenant_application").toggle();
  	$(".contact_text").toggle();
  });
//contact loaders
  if(onPage("pages-contact")){
    $("#new_subscription input[type=submit], #new_resume input[type=submit]").click(function(e){
    	var target = $(this).closest(".panel").find(".processingSubmission");
    	loadingIcon(target);
    });
  }
//contact page file selection path update
  if(onPage("pages-contact")){
    $("#resume_resume_document").change(function(){
      $(this).closest(".control-group.file").find("label").html($(this).val());
    });
  }
//contact page resume select change
  if(onPage("pages-contact") || onPage("resumes-new")){
    $("#specialty_fake").ddslick({
      width: 209,
      onSelected: function(data){
        if(data.selectedData.value == "other"){
          $(".resume_specialty.hidden").removeClass("hidden");
          marker = $('<span />').insertBefore('#resume_specialty');
          $('#resume_specialty').detach().attr('type', 'text').insertAfter(marker).removeClass("hidden").css({"width": "205px", "margin-top": "5px"}).focus();
          marker.remove();
        	$("input#resume_specialty").val("Please specify");
        	$("input#resume_specialty").select();
        	$(".direct_app, .direct_app_header").hide();
        } else {
          $(".direct_app, .direct_app_header").hide();
        	$("input#resume_specialty").val(data.selectedData.value);
        	if($(".direct_app."+data.selectedData.value.replace(/ /g, "_").replace("/", "_")).length > 0){
        		$(".direct_app_header").show();
        	}
        	$(".direct_app."+data.selectedData.value.replace(/ /g, "_").replace("/", "_")).show();
        }
      }
    });
  }
//contact page tenant application select change
  if(onPage("pages-contact")){
    $("#funding_status_fake").ddslick({
      width: 254,
      onSelected: function(data){
        if(data.selectedData.value == "other"){
          $(".tenant_application_funding_status.hidden").removeClass("hidden");
          marker = $('<span />').insertBefore('#tenant_application_funding_status');
          $('#tenant_application_funding_status').detach().attr('type', 'text').insertAfter(marker).removeClass("hidden").css({"width": "247px", "margin-top": "5px"}).focus();
          marker.remove();
          $(".control-group.tenant_application_funding_status").css({"clear": "both", "float": "right"});
          $(".tenant_application_form_basics").css("margin-bottom", "0");
        	$("input#tenant_application_funding_status").val("Please specify");
        	$("input#tenant_application_funding_status").select();
        } else {
        	$("input#tenant_application_funding_status").val(data.selectedData.value);
        }
      }
    });
  }
//contact page contact tenant select change
  if(onPage("pages-contact")){
    $("#select_tenant_contact").ddslick({
      width: 140,
      onSelected: function(data){
        $("input#message_email").val(data.selectedData.value);
      }
    });
  }
//hide job posts
  $(".jobs_back_link").click(function(e){
    e.preventDefault();
  	$(".job-postings").hide();
  });
//contact page tenant application back link
  if(onPage("pages-contact")){
    $(".tenant_application_back_link").click(function(e){
    	$(".contact_text").toggle();
    	$(".tenant_application").toggle();
    	$(".application_resume_and_newsletter .application .dropdown_panel").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
    	return false;
    });
  }
//news page search focus
  if(onPage("pages-news")){
    $(".news_search_input").focus(function(){
      if($(this).val() == "Search"){
        $(this).val("");
      }
    }).blur(function(){
      if($(this).val() == ""){
        $(this).val("Search");
      }
    });
  }
  if(onPage("administration-news")){
    $(".news_search_input").focus(function(){
      if($(this).val() == "Search"){
        $(this).val("");
      }
    }).blur(function(){
      if($(this).val() == ""){
        $(this).val("Search");
      }
    });
  }
//news search
  if(onPage("pages-news")){
    $(".news_search_input").keydown(function(e){
      if(e.keyCode == 13){
        var term = $(this).val();
        $.post("/search", {query: term}, function(){});
        return false;
      }
    });
  }
  if(onPage("administration-news")){
    $(".news_search_input").keydown(function(e){
      if(e.keyCode == 13){
        var term = $(this).val();
        $.post("/search", {query: term}, function(){});
        return false;
      }
    });
  }
//autofill input bg fix
  if (navigator.userAgent.toLowerCase().indexOf("chrome") >= 0){
    var _interval = window.setInterval(function (){
      var autofills = $('input:-webkit-autofill');
      if (autofills.length > 0){
        window.clearInterval(_interval); // stop polling
        autofills.each(function(){
          var clone = $(this).clone(true, true);
          $(this).after(clone).remove();
        });
      }
    }, 200);
  }
//display answers
  $(".viewAnswers").click(function(e){
    e.preventDefault();
    $(this).closest(".question").width($(".questionContainer").width()-70);
    $(this).closest(".question").find(".questionContent").css({"border-bottom": "1px dotted #ccc", "padding-bottom": "20px"});
    $(this).closest(".question").find(".answers").slideDown(200);
  });
//accept answers
  $(".acceptAnswer").click(function(e){
    e.preventDefault();
    var that = $(this);
    var answerid = $(this).attr("data-answer_id").replace(/\D/g, "");
    var action = $(this).attr("data-action");
    $.post("/acceptanswer", {id: answerid, option: action}, function(){$(that).closest("li").toggleClass("acceptedAnswer");});
  });
//datepicker
  $('#event_datetimepicker, #event_datetimepicker2, #post_datetimepicker, #article_datetimepicker, #grant_datetimepicker, #google_datetimepicker, #job_datetimepicker').datetimepicker({
    language: "en",
    pick12HourFormat: true
  });
//registrations tenant select
  if(onPage("registrations") || onPage("invitations")){
    $("#tenant_id_fake").ddslick({
      width: 220,
      onSelected: function(data){
        $("input#user_tenant_id").val(data.selectedData.value);
      }
    });
  }
//related tenants select
  if(onPage("posts-new") || onPage("providers-new") || onPage("grants-new") || onPage("contacts-new") || onPage("news_sites-new")){
    var item = $("form").attr("id").replace("new_", "");
    $("#tenant_fake").ddslick({
      width: 650,
      onSelected: function(data){
        if($("input#"+item+"_tenant").val().length == 0){
          $("input#"+item+"_tenant").val(data.selectedData.text);
        } else {
          $(".dd-selected-text").html($("input#"+item+"_tenant").val()+", "+data.selectedData.text);
          $("input#"+item+"_tenant").val($("input#"+item+"_tenant").val()+", "+data.selectedData.text);
        }
      }
    });
  }
  if(onPage("posts-edit") || onPage("providers-edit") || onPage("grants-edit") || onPage("contacts-edit") || onPage("news_sites-edit")){
    var item = $("form").attr("id").replace("edit_", "").replace(/_.*/, "");
    var currently_selected = $("input#"+item+"_tenant").val();
    waiting = setInterval(function(){
      if($(".dd-selected").length!=0){
        $(".dd-selected").html("<label class=\"dd-selected-text\">"+currently_selected+"</label>");
        clearInterval(waiting);
      }
    }, 500);
    $("#tenant_fake").ddslick({
      width: 650,
      selectText: currently_selected,
      onSelected: function(data){
        if($("input#"+item+"_tenant").val().length == 0){
          $("input#"+item+"_tenant").val(data.selectedData.text);
        } else {
          $(".dd-selected-text").html($("input#"+item+"_tenant").val()+", "+data.selectedData.text);
          $("input#"+item+"_tenant").val($("input#"+item+"_tenant").val()+", "+data.selectedData.text);
        }
      }
    });
  }
//dashboard news filter select
  if(onPage("administration-dashboard")){
    $("#dashboard_news_filter").ddslick({
      width: 220,
      onSelected: function(data){
        filter = data.selectedData.value;
        console.log(filter);
        loadingIcon(".entries");
        $.post("/dashboard-news-filter", {filter: filter}, function(){});
      }
    });
  }
//hide empty ddslick options
  $(".dd-select").click(function(e){
  	if($(this).next(".dd-options").find(".dd-option").eq(0).html().length < 1){
  	 $(this).next(".dd-options").find(".dd-option").eq(0).hide();
  	}
  });
//choose google calendar
  $(".calendarSelect a").click(function(e){
  	var calendar = $(this).data("calendar");
  	$.post("/calendar-select", {calendar: calendar}, function(){});
  	return false;
  });
//event category toggle
  $(".events_key .circle a").click(function(e){
  	$(this).parent().toggleClass("off");
  	var event_type = $(this).data("event-type");
  	console.log(event_type);
  	$(".events_list ."+event_type).toggle();
  	return false;
  });
//resources dropdowns
  if(onPage("administration-resources")){
    $(".select_database .dropdown_panel a").click(function(e){
      $(".single_resource_display").hide();
      $(".multiple_resource_display").show();
      var html = $(this).data("html");
      $(this).html("Back to Resources");
    	$(this).closest(".dropdown_panel").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
    	$(this).closest(".select_database").siblings().find(".dropdown_panel-down").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
    	$(this).closest(".select_database").siblings().each(function(){
    	 var otherhtml = $(this).find("a").data("html");
    	 $(this).find("a").html(otherhtml);
    	});
    	var toggle = $(this).data("toggle");
    	$("."+toggle).toggle();
    	var formToggle = $(this).data("form-toggle");
    	$("."+formToggle).toggle();
    	$(".resource_list:not(."+toggle+")").hide();
    	$(".add_resource:not(."+formToggle+")").hide();
    	if($(this).closest(".dropdown_panel").hasClass("dropdown_panel-right")){
    	 $(".main_resource_list").toggle();
    	 $(this).html(html);
    	} 
    	var groups = $("."+toggle+" .resource_group").length;
    	var left = document.createElement("div");
    	$(left).css({"float":"left","margin-right":"20px"});
    	var right = document.createElement("div");
    	$(right).css({"float":"right"});
    	$("."+toggle+" .resource_display").prepend(left);
    	$("."+toggle+" .resource_display").prepend(right);
    	$(left).append($("."+toggle+" .resource_group").slice(0,(groups/2)));
    	$(right).append($("."+toggle+" .resource_group").slice((groups/2),groups));
    	return false;
    });
  }
//admin contact page contact select change
  if(onPage("administration-contact")){
    $("#select_contact").ddslick({
      width: 131,
      onSelected: function(data){
        $("input#message_email").val(data.selectedData.value);
      }
    });
  }
//resource search
  if(onPage("administration-resources")){
    $(".search > .search_by").click(function(e){
    	$(this).parent().find(".search_expanded").show();
    	$(".search_expanded > .search_by").click(function(e){
    		$(this).parent().hide();
    	});
    });
    $(".search_list a").click(function(e){
      var searchtype = $(this).data("search");
      var resourcetype = $(this).data("resource");
    	if(searchtype == "keyword"){
    	 $(this).closest(".search").find(".search_keyword").show();
    	 $(this).closest(".search").find(".search_expanded").hide();
    	 $(".resource_search_input").keydown(function(e){
        if(e.keyCode == 13){
          var term = $(this).val();
          var resource = $(this).next(".resource_search_type").val();
          $.post("/resource-search", {query: term, resource: resource}, function(){});
          return false;
        }
      });
    	} else {
    	 $.post("/filter-resources", {resource: resourcetype, filter: searchtype}, function(){});
    	 $(this).closest(".search").find(".search_expanded").hide();
    	}
    	return false;
    });
    $(".resource_search_input").focus(function(){
      if($(this).val() == "Type keyword here"){
        $(this).val("");
      }
    }).blur(function(){
      if($(this).val() == ""){
        $(this).val("Type keyword here");
      }
    });
  }
//add provider
  if(onPage("administration-resources")){
    
    $(".add_resource .dropdown_panel a").click(function(e){
    	$(this).closest(".dropdown_panel").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
    	var toggle = $(this).data("toggle");
    	$("."+toggle).toggle();
    	return false;
    });
    
    $(".add_resource_form .heading h2").click(function(e){
    	$(this).closest(".add_resource_form").hide();
    	$(this).closest(".add_resource").find(".dropdown_panel").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
    });
    
    $("#provider_specialty_fake").ddslick({
      width: 215,
      onSelected: function(data){
        if(data.selectedData.value == "other"){
          $(".provider_specialty.hidden").removeClass("hidden");
          marker = $('<span />').insertBefore('#provider_specialty');
          $('#provider_specialty').detach().attr('type', 'text').insertAfter(marker).removeClass("hidden").css({"width": "205px", "margin-top": "5px"}).focus();
          marker.remove();
        	$("input#provider_specialty").val("Please specify");
        	$("input#provider_specialty").select();
        } else {
        	$("input#provider_specialty").val(data.selectedData.value);
        }
      }
    });
    $("#resume_specialty_fake").ddslick({
      width: 207,
      onSelected: function(data){
        if(data.selectedData.value == "other"){
          $(".resume_specialty.hidden").removeClass("hidden");
          marker = $('<span />').insertBefore('#resume_specialty');
          $('#resume_specialty').detach().attr('type', 'text').insertAfter(marker).removeClass("hidden").css({"margin-left": "108px", "margin-top": "5px"}).focus();
          marker.remove();
        	$("input#resume_specialty").val("Please specify");
        	$("input#resume_specialty").select();
        } else {
        	$("input#resume_specialty").val(data.selectedData.value);
        }
      }
    });
    $("#tool_specialty_fake").ddslick({
      width: 215,
      onSelected: function(data){
        if(data.selectedData.value == "other"){
          $(".tool_specialty.hidden").removeClass("hidden");
          marker = $('<span />').insertBefore('#tool_specialty');
          $('#tool_specialty').detach().attr('type', 'text').insertAfter(marker).removeClass("hidden").css({"width": "205px", "margin-top": "5px"}).focus();
          marker.remove();
        	$("input#tool_specialty").val("Please specify");
        	$("input#tool_specialty").select();
        } else {
        	$("input#tool_specialty").val(data.selectedData.value);
        }
      }
    });
    
    //resource display
    $(".resource_link").live("click", function(e){
    	var id = $(this).data("resource_id");
    	var resource = $(this).data("resource_type");
    	$(".single_resource_display").show();
    	$(".multiple_resource_display").hide();
    	loadingIcon(".single_resource_display");
    	$.post("/administration/resource-display", {id: id, resource: resource}, function(){
    		clearInterval(loadAction);
    		$(".single_resource_display").removeClass("symbols");
    	});
    	return false;
    });
    
    //save memo
    $(".saveMemoLink").live("click", function(e){
    	var rid = $(this).data("resource_id");
    	var rtype = $(this).data("resource_type");
    	var that = $(this);
    	$.post("/administration/save-memo", {id: rid, resource: rtype}, function(){
    	 $(that).html("saved");
      });
    	return false;
    });
  }
//remove announcement
  $(".hideAnnouncementLink").click(function(e){
  	var aid = $(this).data("announcement_id");
  	$.post("/administration/remove-announcement", {id: aid}, function(){$(".current_announcement").html("<h3>No Current Announcements</h3>");});
  	return false;
  });
//display announcement
  $(".displayAnnouncementLink").click(function(e){
  	var aid = $(this).data("announcement_id");
  	$.post("/administration/display-announcement", {id: aid}, function(){});
  	return false;
  });
//calendar more link
  if(onPage("pages-calendar") || onPage("administration-calendar")){
    $(".events > div > div").each(function(){
      var events_height = $(this)[0].scrollHeight;
      if(events_height > 140){
        var events_count = (events_height-140)/30;
        $(this).parent().append("<a href='#' class='more more_events' data-event_count='"+events_count+"'>"+events_count+" more &raquo;</a>");
      }
    });
    $(".more_events").live("click", function(){
      var events_count = $(this).data("event_count");
      $(this).prev("div").css({height: "+="+(events_count*30)+"px", zIndex: "9"});
      $(this).css({bottom: "-="+(events_count*30)+"px", zIndex: "9"}).html("less &raquo").addClass("less_events").removeClass("more_events");
      $(this).closest("td").css("border-bottom", "0");
      return false;
    });
    $(".less_events").live("click", function(){
      var events_count = $(this).data("event_count");
      $(this).prev("div").css({height: "-="+(events_count*30)+"px", zIndex: "auto"});
      $(this).css({bottom: "+="+(events_count*30)+"px", zIndex: "auto"}).html(events_count+" more &raquo").addClass("more_events").removeClass("less_events");
      $(this).closest("td").css("border-bottom", "1px solid #ddd");
      return false;
    });
//event info popup
    $(".day_event_container > a").click(function(e){
    	var event_id = $(this).data("event_id");
    	var top_offset = $(this).offset().top;
    	var scroll_offset = $("#realBody").scrollTop();
    	var left_offset= $(this).offset().left;
    	var width = $(this).width();
    	$(".day_event_details").hide();
    	$("#event_info_"+event_id).css({top: (top_offset-10+scroll_offset), left: (left_offset+width+10), zIndex: "9"}).show();
    	return false;
    });
    $(".day_event_details").click(function(e){
    	e.stopPropagation();
    });
    $("#realBody").click(function(e){
    	$(".day_event_details").hide();
    });
    
//change month
    $(".previousMonthLink").click(function(e){
    	window.location = $(".previous-month").attr("href");
    	return false;
    });
    $(".nextMonthLink").click(function(e){
    	window.location = $(".next-month").attr("href");
    	return false;
    });
    var curMonth = $("#calendar > .panel > h2").html().replace(/<a\b[^>]*>(.*?)<\/a>/ig,"");
    $(".current_month").html("<h2>"+curMonth+"</h2>")
//adding events
    $(".adding_events a").click(function(e){
    	$(this).closest(".dropdown_panel").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
    	var toggle = $(this).data("toggle");
    	$("."+toggle).toggle();
    	return false;
    });
    $(".add_event_form .heading h2").click(function(e){
     	$(this).closest(".add_event_form").hide();
     	$(this).closest(".adding_events").find(".dropdown_panel").toggleClass("dropdown_panel-right").toggleClass("dropdown_panel-down");
    });
    $(".adding_events_form_type_selection .check").click(function(e){
    	var etype = $(this).data("event-type");
    	console.log(etype);
    	$(this).toggleClass("on");
    	$(this).next().toggleClass("off");
    	$(this).closest("li").siblings().find(".check").removeClass("on");
    	$(this).closest("li").siblings().find(".circle").addClass("off");
    	//$(".adding_events_keys ."+etype+"_circle").parent().toggleClass("off");
    	//$(".adding_events_keys ."+etype+"_circle").closest("li").siblings().find(".circle").addClass("off");
    	$(".add_event_form div[class$=_form]").hide()
    	$("."+etype+"_form").show();
    });
    $(".event_form input[type=submit]").click(function(e){
    	$("#event_eventenddate").val($("#event_eventdate").val());
    });
//calendar event type display
    $(".adding_events_keys .circle a").click(function(e){
    	var event_type = $(this).data("event-type");
    	if(event_type == "event"){$(".event_type_acregoogle").toggle();}
    	$(".event_type_"+event_type).toggle();
    	//$(this).parent().toggleClass("off");
      	$(".events > div > div").each(function(){
          $(this).parent().find(".more_events").remove();
          var events_height = $(this)[0].scrollHeight;
          if(events_height > 140){
            var events_count = (events_height-140)/30;
            $(this).parent().append("<a href='#' class='more more_events' data-event_count='"+events_count+"'>"+events_count+" more &raquo;</a>");
          }
        });
    	return false;
    });
  }
//news pagination
  if(onPage("pages-news") || onPage("administration-news")){
    $(".pagination a").live("click", function(e){
    	loadingIcon(".newses");
    	$.get(this.href, null, null, 'script');
    	return false;
    });
  }
//map modal
  $(".see_map a").live("click", function(e){
  	$("#mapModal").modal();
  	return false;
  });
  $('#mapModal').appendTo($("body"));
//user options dropdown
  $(".user_options > a").click(function(e){
  	$(".user_options_dropdown").toggle();
  	return false;
  });
//tenant bg select
  if(onPage("tenant_backgrounds-new") || onPage("tenant_backgrounds-edit")){
    $("#page").ddslick({
      width: 650,
      onSelected: function(data){
        $("input#tenant_background_page_controller").val("administration");
        $("input#tenant_background_page_action").val(data.selectedData.text.toLowerCase());
        $("input#tenant_background_page_url").val("/administration/"+data.selectedData.text.toLowerCase());
      }
    });
  }
//announcement selects
  if(onPage("administration-cms_index")){
    $("#post_fake").ddslick({
      width: 570,
      onSelected: function(data){
        $("input#announcement_post_id").val(data.selectedData.value);
        $("input#announcement_tenant_id").val("");
      }
    });
    $("#tenant_fake").ddslick({
      width: 570,
      onSelected: function(data){
        $("input#announcement_tenant_id").val(data.selectedData.value);
        $("input#announcement_post_id").val("");
      }
    });
    $(".standaloneAnnouncement").click(function(e){
    	$(".new_announcement_form").show();
    	return false;
    });
  }
//delete images
  $(".delete_image").click(function(){
    var href = $(this).attr("href");
    $.post(href);
    return false;
  });
  $(".saveEventMemo").click(function(){
    var rid = $(this).data("resource_id");
  	var rtype = $(this).data("resource_type");
  	var that = $(this);
  	loadingIcon($(this));
  	$.post("/administration/save-memo", {id: rid, resource: rtype}, function(){
  	 clearInterval(loadAction);
  	 $(that).html("saved");
    });
    return false;
  });
//word limit on resource submissions
  var maxWords = 200;
  $('.add_provider_form textarea, .add_contact_form textarea, .add_news_site_form textarea').keypress(function() {
    var $this, wordcount;
    $this = $(this);
    wordcount = $this.val().split(/\b[\s,\.-:;]*/).length;
    if (wordcount > maxWords) {
        return false;
    }
  });

  
});

$(window).load(function(){
//homepage content
  if(onPage("pages-index")){
    if($(".current_announcement").length == 0){
      var maxHeight = -1;
      $('.main div.col').each(function() {
        maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
      });
      $('.main div.col .panel').eq(0).height(maxHeight-22);
      $('.main div.col .panel').eq(1).height(maxHeight-22);
      $('.main div.col .panel').eq(3).height(maxHeight-22-$(".upcoming").height()-20);
    } else {
    	if($(".current_announcement .panel").height() < ($(".events_and_stuff").height()-32)){
    		$(".current_announcement .panel").height($(".events_and_stuff").height()-32);
    		$(".current_announcement .panel").css({"padding": (($(".events_and_stuff").height()-32-428)/2)+16+"px", "height": ($(".current_announcement .panel").height()-(($(".events_and_stuff").height()-32-428)))+"px"});
    		$(".current_announcement_text").css({"bottom":(38+(($(".events_and_stuff").height()-32-428)/2))+"px", "right":(32+(($(".events_and_stuff").height()-32-428)/2))+"px"});
    	} else {
    		$(".twitter .panel").height($(".current_announcement").height()-32-$(".upcoming").height()-20);
    	}
    }
  }
  $("body.pages-index .main").css("top", ($(window).height()/2-$(".main").height()/2)-33);
//featured news heights
  if(onPage("pages-news")){
    if($('.featured_news .news_feature .panel').eq(0).height() > $('.featured_news .news_feature .panel').eq(1).height()){
    	$('.featured_news .news_feature .panel').eq(1).height($('.featured_news .news_feature .panel').eq(0).height());
    } else {
    	$('.featured_news .news_feature .panel').eq(0).height($('.featured_news .news_feature .panel').eq(1).height());
    }
  }
//about tenant news/twitter boxes
  if(onPage("pages-about_tenant")){
  	if($(".acre_news_and_twitter .acre_news .panel").height() > $(".acre_news_and_twitter .twitter .panel").height()){
  		$(".acre_news_and_twitter .twitter .panel").height($(".acre_news_and_twitter .acre_news .panel").height());
  	} else {
  		$(".acre_news_and_twitter .acre_news .panel").height($(".acre_news_and_twitter .twitter .panel").height());
  	}
  }
//resume prefs
  $("#resume_prefs_select").change(function(){
  	var title = $("#resume_prefs_select option:selected").text();
  	var id = $("#resume_prefs_select option:selected").val();
  	var ar = $("#tenant_resume_prefs").val().split(",");
  	$("#tenant_resume_prefs").val($("#tenant_resume_prefs").val() == 0 ? id : $("#tenant_resume_prefs").val()+","+id);
  });
// resume/tenants
//  $(".submit_resume_form input.disabled").live("click", function(e){return false});
  $(".submit_resume_form input[type=submit]").click(function(e){
  	//e.preventDefault();
  	$(this).addClass("disabled");
  	if($("#resume_specialty").val().length == 0){
  		alert("Please select an area of specialty to proceed");
  		return false;
  	} else {
  	 var tenants = "";
    	$(".submit_resume_form .direct_app input:checked").each(function(){
    		tenants += $(this).val()+",";
    	});
    	$("input#direct").val(tenants);	
  	}
  });
//view jobs
  $(".submit_resume_blurb a").click(function(e){
  	e.preventDefault();
  	$(".job-postings").show();
  });
//job prefill
  if(window.location.href.indexOf("contact?job") != -1){
  	$(".submit_resume").show();
  	$(".submit_resume .dd-selected").html("<label class='dd-selected-text'>"+$("#resume_specialty").val()+"</label>");
  }

});

$(window).resize(function(){
  //homepage content center vertically
  $("body.pages-index .main").css("top", ($(window).height()/2-$(".main").height()/2));
});
