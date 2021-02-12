<div class="w3-container w3-topbar w3-leftbar w3-rightbar w3-border-white w3-black">
  <div class="w3-xxxlarge" style="display: flex; justify-content: space-between; align-items: center; ">
    <b>
      Taskbook
    </b>
    <label class="darkmode-box">
      <input type="checkbox" id="darkmode-checkbox">
      <span class="darkmode-slider"></span>
    </label>
  </div>
  <span class="w3-right" hidden>
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">zzzSign up</span>
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log In</span>
    <span class="w3-large w3-button w3-margin w3-round-large w3-blue">Log Out</span>
  </span>
</div>

<script>
  $("#darkmode-checkbox").bind("click", () => {
    console.log(event.target.checked);
    $("*").toggleClass("dark")
  });
</script>