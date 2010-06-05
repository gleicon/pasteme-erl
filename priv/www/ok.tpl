<%? {Euid, Code, Date} = Data %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"> 
<html lang="en"> 
 
<head> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 
    <title>pasteme</title> 
    <link rel="stylesheet" href="/static/css/main.css" type="text/css" media="screen" charset="utf-8"> 
	<script language="javascript" type="text/javascript" src="/static/edit_area/edit_area_full.js"></script>
	<script language="javascript" type="text/javascript">
	editAreaLoader.init({
		id : "code"		// textarea id
		,syntax: "css"			// syntax to be uses for highgliting
		,start_highlight: true		// to display with highlight mode on start-up
	    ,is_editable: false
	    ,allow_toggle: false
	});
	</script>  
</head> 
 
<body> 
<div id='topbar'> 
    <h1 style="float: left">PasteME</h1> 
</div> 

<div id='content'> 
<p>Paste your stuff | <a href='/'>Paste again</a></p> 
 
<p>>> <a href='/p/<% Euid %>'>Snippet URL</a>. </p>
<textarea id="code" name='code' rows="30" cols="100"><% Code %></textarea>
</div> 

</body> 
</html> 
