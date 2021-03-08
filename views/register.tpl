% include("header.tpl")
% include("banner.tpl")

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

   <span class="form-check">
     <input type="checkbox" class="form-check-input" id="tosCheck1">
     <label class="tosCheck1" for="exampleCheck1">I have read & accept the <a href="#">Terms & Conditions</a>.</label>
   </span>
   
   <br><br>
   <button type="submit" class="btn btn-primary">Register</button>
  </form>
 </div>
</div>

% include("footer.tpl")
