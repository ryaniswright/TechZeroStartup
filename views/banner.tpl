<div class="w3-container w3-border-white w3-black">
  <div class="w3-xxxlarge" style="display: flex; justify-content: space-between; align-items: center; ">
    <b>
      Taskbook
    </b>
    <label class="darkmode-box">
      <input type="checkbox" id="darkmode-checkbox">
      <span class="darkmode-slider"></span>
    </label>

    <span class="w3-right">
      <a href="/tasks"><span class="w3-small w3-button w3-margin w3-round-small w3-white">Tasks</span></a>
      <a href="/register"><span class="w3-small w3-button w3-margin w3-round-small w3-yellow">Sign up</span></a>
      <a href="/login"><span class="w3-small w3-button w3-margin w3-round-small w3-yellow">Log In</span></a>
      <span class="w3-small w3-button w3-margin w3-round-small w3-red">Log Out</span>
    </span>
  </div>
</div>

<script>
  $("#darkmode-checkbox").bind("click", () => {
    console.log(event.target.checked);
    $("*").toggleClass("dark")
  });
</script>