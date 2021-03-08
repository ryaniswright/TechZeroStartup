<div class="w3-container w3-border-white w3-black">
  <div class="w3-xxxlarge w3-left s12 l6"><a id="tasks_button" href="/">
      Taskbook 🗒</a>
  </div>
  <div class="w3-right s12 l6" id="banner-buttons">
    <a id="tasks_button" href="/tasks"><span class="w3-small w3-button w3-margin w3-round-small w3-white w3-hover-light-grey">Tasks</span></a>
    <a id="logout_button" href='/logout'><span class="w3-small w3-button w3-margin w3-round-small w3-red w3-hover-pale-red">Log Out</span></a>
    <a id="darkmode-button"><span class="w3-small w3-button w3-margin w3-round-small w3-white w3-hover-black w3-text-black w3-hover-text-white w3-border-white w3-border">Darkmode</span></a>
  </div>
</div>

<script>
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
