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
      <span class="w3-small w3-button w3-margin w3-round-small w3-white"> <a href = "/tasks"> Tasks </a></span>
      <span class="w3-small w3-button w3-margin w3-round-small w3-yellow"> <a href = "/register"> Sign up </a></span>
      <span id ="tc" class="w3-small w3-button w3-margin w3-round-small w3-yellow"> <a href="/login">Log In</a></span>
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