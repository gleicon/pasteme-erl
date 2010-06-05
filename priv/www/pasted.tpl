<%? {Euid, Code, Date} = Data %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"> 
<html lang="en"> 
 
<head> 
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
        <title>pasteme</title> 
    <link rel="stylesheet" href="/static/css/main.css" type="text/css" media="screen" charset="utf-8"> 
        
</head> 
 
<body onload=''> 
<div id='topbar'> 
    <h1 style="float: left">PasteME</h1> 
</div> 

<div id='content'> 
<p>Paste your stuff</p> 
 
<p>Paste your text and share it. </p>
<form action='/paste' method='POST'>
<textarea name='code' rows="15" cols="40"><% Code %></textarea> 
<br>
<p> Last changed: <% Date %> </p>
<input type='hidden' name='<% Euid %>' value=<% Euid %>>
<input type='submit' name='Paste me'> | | <input type='reset'>
</form>
</div> 
<p><a href='/'>Paste again</a></p>

</body> 
</html> 
