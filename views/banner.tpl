<div class="w3-container w3-border-white w3-black">
  <div class="w3-xxxlarge" style="display: flex; justify-content: space-between; align-items: center; ">
    <b>
      Taskbook
    </b>

    <span class="w3-right" id="banner-buttons">
      <a id="tasks_button" href="/tasks"><span class="w3-small w3-button w3-margin w3-round-small w3-white w3-hover-light-grey">Tasks</span></a>
      <a id="register_button" href="/register"><span class="w3-small w3-button w3-margin w3-round-small w3-yellow w3-hover-pale-yellow">Sign up</span></a>
      <a id="login_button" href="/login"><span class="w3-small w3-button w3-margin w3-round-small w3-yellow w3-hover-pale-yellow">Log In</span></a>
      <a id="logout_button"><span class="w3-small w3-button w3-margin w3-round-small w3-red w3-hover-pale-red">Log Out</span></a>
      <a id="darkmode-button"><span class="w3-small w3-button w3-margin w3-round-small w3-white w3-hover-black w3-text-black w3-hover-text-white w3-border-white w3-border">Darkmode</span></a>
    </span>
  </div>
</div>

<script>
  dark = false;
  $("#darkmode-button").bind("click", () => {
    $("*").toggleClass("dark")
    dark = !dark;
  });
</script>