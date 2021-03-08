% include("header.tpl") 
<div class="w3-container w3-border-white w3-black">
  <div class="w3-xxxlarge w3-left s12 l6"><a id="tasks_button" href="/">
      Taskbook 🗒</a>
  </div>
  <div class="w3-right s12 l6" id="banner-buttons">
    <a id="login_button" href="/login"><span class="w3-small w3-button w3-margin w3-round-small w3-yellow w3-hover-pale-yellow">Log In</span></a>
    <a id="register_button" href="/register"><span class="w3-small w3-button w3-margin w3-round-small w3-yellow w3-hover-pale-yellow">Sign up</span></a>
    <a id="darkmode-button"><span class="w3-small w3-button w3-margin w3-round-small w3-white w3-hover-black w3-text-black w3-hover-text-white w3-border-white w3-border">Darkmode</span></a>
  </div>
</div>

<link rel="stylesheet" type="text/css" href="/static/styles.css"/>

<br><br>
<h1 class="text-center" style="color: red;"><b>Login or Sign Up to use Tech Zero Taskbook!</b></h1>

<br><br>
<div class="w3-row">
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>Today</i></h1>
        </div>
        <table id="task-list-today" class="w3-table">
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>Tomorrow</i></h1>
        </div>
        <table id="task-list-tomorrow" class="w3-table">
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>The Next Day</i></h1>
        </div>
        <table id="task-list-the-next-day" class="w3-table">
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>The Day After That</i></h1>
        </div>
        <table id="task-list-the-day-after-that" class="w3-table">
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
</div>
<input id="current_input" hidden value="" />
<script>
/* API CALLS */

function api_get_tasks(success_function) {
    $.ajax({
        url: "api/tasks",
        type: "GET",
        success: success_function
    });
}


/* EVENT HANDLERS */

days = ["today","tomorrow","the-next-day","the-day-after-that"]

function display_task(x) {
    found = false;
    arrows = [];
    lists = [];
    const vw = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0)
    i = 3
    for (let day of days) {
        if (day == x.list) {
            found = true;
            continue;
        }
        if (!found) {
            arrows.push(vw > 600 ? "arrow_back_ios" : "keyboard_arrow_up")
        } else {
            arrows.push(vw > 600 ? "arrow_forward_ios" : "keyboard_arrow_down")
        }
        lists.push(day);
        --i;
    }
    completed = x.completed ? " completed" : "";
    ls = window.localStorage;
    darkened = ls.getItem('darkmode') == 'true' ? " dark": "";
    if ((x.id == "today") | (x.id == "tomorrow") | (x.id == "the-next-day") | (x.id == "the-day-after-that")) {
        t = `<tr id="task-${x.id}" class="task">
                <td colspan="3" style="width:54px"></td>
                <td>
                </td>
            </tr>`;
    } else {
        t = `<tr id="task-${x.id}" class="task">`
        for (i = 0; i < 3; ++i) {
            t+= `<td style="width:18px; padding: 0px;">
                </td>`
        }
        t+=     `<td><span id="description-${x.id}" class="description${completed}${darkened}" style="background-color: ${x.color == '#ffffff' ? 'none' : x.color};">${x.description }</span>
                    <span id="editor-${x.id}" hidden>
                        <input id="input-${x.id}" style="height:22px" class="w3-input${darkened}" type="text" autofocus/>
                    </span>
                </td>
            </tr>`;
    }
    $("#task-list-" + x.list).append(t);
    $("#current_input").val("")
}

function get_current_tasks() {
    
        // display the tasks
    api_get_tasks(function(result) {
        // remove the old tasks
        $(".task").remove();
        // display the new task editor
        display_task({
            id: "today",
            list: "today"
        })
        display_task({
            id: "tomorrow",
            list: "tomorrow"
        })
        display_task({
            id: "the-next-day",
            list: "the-next-day"
        })
        display_task({
            id: "the-day-after-that",
            list: "the-day-after-that"
        })
        for (const task of result.tasks) {
            display_task(task);
        }
        // wire the response events 
    });
}

$(document).ready(function() {
    get_current_tasks()
});
  ls = window.localStorage;
  if (ls.getItem('darkmode') == null) {
    ls.setItem('darkmode', 'false');
  }
  $("#darkmode-button").bind("click", () => {
    $("*").toggleClass("dark")
    ls.setItem('darkmode', ls.getItem('darkmode') == 'false' ? 'true' : 'false')
    console.log(ls.getItem('darkmode'));
  });
  $(document).ready(() => {
    if (ls.getItem('darkmode') == 'true') {
      $("*").toggleClass("dark");
    }
  });
</script>


% include("footer.tpl")
