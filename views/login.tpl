% include("header.tpl")
<div class="w3-container w3-border-white w3-black">
  <div class="w3-xxxlarge w3-left s12 l6"><a id="tasks_button" href="/non_user_Tasks">
      Taskbook 🗒</a>
  </div>
  <div class="w3-right s12 l6" id="banner-buttons">
    <a id="register_button" href="/register"><span class="w3-small w3-button w3-margin w3-round-small w3-yellow w3-hover-pale-yellow">Sign up</span></a>
    <a id="darkmode-button"><span class="w3-small w3-button w3-margin w3-round-small w3-white w3-hover-black w3-text-black w3-hover-text-white w3-border-white w3-border">Darkmode</span></a>
  </div>
</div>

<!-- uses bootstrap for css -->

<div class = "container">
 <div class="column is-4 is-offset-4">
  <br>
  <h1 class="text-center"><b>LOGIN</b></h1>
  <br>
  <form method="POST" action="/login">
   <div class="form-group">
     <label for="Email">Email Address</label>
     <input type="email" class="form-control" id="Email" name = "email" placeholder="Email">
     <!-- <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> -->
   </div>

   <div class="form-group">
     <label for="Password">Password</label>
     <input type="password" class="form-control" id="Password" name = "password" placeholder="Password">
   </div>

   <div class="form-check">
     <input type="checkbox" class="form-check-input" id="check">
     <label class="form-check-label" for="check">Remember Me</label>
   </div>
   <br>
   <button type="submit" class="btn btn-primary">Login</button>
  </form>
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
% include("footer.tpl")

