% include("header.tpl")
<div class="w3-container w3-border-white w3-black">
  <div class="w3-xxxlarge w3-left s12 l6"><a id="tasks_button" href="/non_user_Tasks">
      Taskbook 🗒</a>
  </div>
  <div class="w3-right s12 l6" id="banner-buttons">
    <a id="login_button" href="/login"><span class="w3-small w3-button w3-margin w3-round-small w3-yellow w3-hover-pale-yellow">Log In</span></a>
    <a id="darkmode-button"><span class="w3-small w3-button w3-margin w3-round-small w3-white w3-hover-black w3-text-black w3-hover-text-white w3-border-white w3-border">Darkmode</span></a>
  </div>
</div>

<div class = "container">
 <div class="column is-4 is-offset-4">
  <br>
  <h1 class="text-center"><b>SIGN-UP</b></h1>
  <br>
  <form method="POST" action="/register">
   <div class="form-group">
     <label for="firstName">First Name</label>
     <input type="name" class="form-control" id="firstName" name="firstName" placeholder="First Name">
   </div>

   <div class="form-group">
     <label for="lastName">Last Name</label>
     <input type="name" class="form-control" id="lastName" name="lastName" placeholder="Last Name">
   </div>

   <div class="form-group">
     <label for="email">Email address</label>
     <input type="email" class="form-control" id="email" name="email" placeholder="Email">
   </div>

   <div class="form-group">
     <label for="password">Password</label>
     <input type="password" class="form-control" id="password" name="password" placeholder="Password">
   </div>

   <div class="form-group">
     <label for="password2">Confirm Password</label>
     <input type="password" class="form-control" id="password2" name="password2" placeholder="Confirm Password">
   </div>
  
   <br><br>
   <button type="submit" class="btn btn-primary">Register</button>
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
