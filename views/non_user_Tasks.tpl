% include("header.tpl") 
<div class="w3-container w3-border-white w3-black">
  <div class="w3-xxxlarge w3-left s12 l6">
      Taskbook 🗒
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
            <ul>
                <li>Get Homework Done</li><br>
                <li>Walk The Dog</li><br>
                <li>Take out Trash</li>
            </ul>
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>Tomorrow</i></h1>
        </div>
        <table id="task-list-tomorrow" class="w3-table">
            <ul>
                <li>Do Something Fun</li><br>
                <li>Phone a Friend</li>
            </ul>
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>The Next Day</i></h1>
        </div>
        <table id="task-list-the-next-day" class="w3-table">
            <ul>
                <li>Do Something Amazing</li><br>
                <li>Exercise</li>
            </ul>
        </table>
        <div class="w3-row w3-bottombar w3-border-black w3-margin-bottom w3-margin-top"></div>
    </div>
    <div class="w3-col l3 s12 w3-container">
        <div class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">
            <h1><i>The Day After That</i></h1>
        </div>
        <table id="task-list-the-day-after-that" class="w3-table">
            <ul>
                <li>Take a Break</li><br>
                <li>Take a Hike</li><br>
                <li>Finish Coding</li>
            </ul>
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
