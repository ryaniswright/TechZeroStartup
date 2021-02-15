% include("header.tpl")
% include("banner.tpl")

<!-- uses bootstrap for css -->

<div class = "container">
 <div class="column is-4 is-offset-4">
  <br>
  <h1 class="text-center"><b>LOGIN</b></h1>
  <br>
  <form>
   <div class="form-group">
     <label for="Email">Email Address</label>
     <input type="email" class="form-control" id="Email" placeholder="Email">
     <!-- <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> -->
   </div>

   <div class="form-group">
     <label for="Password">Password</label>
     <input type="password" class="form-control" id="Password" placeholder="Password">
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
% include("footer.tpl")
