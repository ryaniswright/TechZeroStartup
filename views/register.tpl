% include("header.tpl")
% include("banner.tpl")


<div class = "container">
 <div class="column is-4 is-offset-4">
  <br>
  <h1 class="text-center"><b>LOGIN</b></h1>
  <br>
  <form>
   <div class="form-group">
     <label for="FirstName">First Name</label>
     <input type="name" class="form-control" id="firstname" placeholder="First Name">
   </div>

   <div class="form-group">
     <label for="LastName">Last Name</label>
     <input type="name" class="form-control" id="lastname" placeholder="Last Name">
   </div>

   <div class="form-group">
     <label for="Email">Email address</label>
     <input type="email" class="form-control" id="Email" placeholder="Email">
   </div>

   <div class="form-group">
     <label for="exampleInputPassword1">Password</label>
     <input type="password" class="form-control" id="Password1" placeholder="Password">
   </div>

   <div class="form-group">
     <label for="exampleInputEmail1">Confirm Password</label>
     <input type="password" class="form-control" id="Password2" placeholder="Confirm Password">
   </div>

   <span class="form-check">
     <input type="checkbox" class="form-check-input" id="exampleCheck1">
     <label class="form-check-label" for="exampleCheck1">I have read & accept the <a href="#">Terms & Conditions</a>.</label>
   </span>
   
   <br><br>
   <button type="submit" class="btn btn-primary">Register</button>
  </form>
 </div>
</div>

% include("footer.tpl")
