<?php 
if(isset($_POST['submit'])) {
$names = $_POST["names"];
$ranks = $_POST["ranks"];

$today = date("Y-M-d_H-i-s");
$oldfile = "old/auth.cfg__".$today;
	rename("auth.cfg",$oldfile);
	chmod($oldfile, 0775);

echo "<h1>AuthMan output saving as:</h1>";
$authdata = "// AuthMan ".$today."\n";
$x = 0;
foreach ($names as $value) {
	if(preg_match("/^[a-z]+$/",$names[$x]) && preg_match("/\b[aoms]\b/", $ranks[$x]))
	{
	echo "<b>addlocalop ".$names[$x]." ".$ranks[$x]."</b><br>\n";
	$authdata .= "addlocalop ".$names[$x]." ".$ranks[$x]."\n";
	} else { echo "<i>invalid:".$names[$x].":</i><br>\n"; }
	$x++;
}

$file = 'auth.cfg';
	file_put_contents($file, $authdata, LOCK_EX);
	//echo "<hr />AUTHDATA::".$authdata."::<hr />";
	chmod($file, 0775);
echo "<hr />";
exit();
}

?>

<html>
	<title>Auth Manager</title>
<body>
<style>
	body {
		background-color: white;
		color: #666;
	}
	h1, h2, h3, h4, h5 {
		color: #888;
		font-family: Tahoma, Geneva, sans-serif;
	}
	header, footer {
		color: #888;
		font-family: "Lucida Console", Monaco, monospace;
		text-align: left;
		min-width: 400px;
		max-width: 500px;
	}
	input, button, select {
		color: #666;
		background-color: #FAFAFA;
		padding-left: 5px;
		padding-right: 5px;
		padding-bottom: 0;
		padding-top: 0;
		margin: 0;
		border: solid 1px #666;
	}
	input[type=submit] {
		padding: 5px 10px;
		font-family: Tahoma, Geneva, sans-serif;
		font-size: 1em;
		background-color: #F0FFF0;
	}
	input[type=text] {
		line-height: 1.75em;
	}
	button #btnReset {
		background-color: #FFF4F4;
	}
	#btnAddRow {
		background-color: #F0F0FF;
	}
	.formRow {
		min-width: 500px;
		height: 3em;
	}
	code {
		font-size: 1.25em;
		font-family: "Lucida Console", Monaco, monospace;
		background-color: #DDD;
		border: solid 1px #CDCDCD;
		padding: 2px;
	}
	footer a, footer a:link, footer a:visited, footer a:active {
		text-decoration: none;
		color: #888;
	}
	footer a:hover {
		text-decoration: none;
		color: #222;
	}
	button:hover, input #btnReset, input[type=submit] {
		color: #222;
	}
</style>

	<header>
		<h1>Auth Manager</h1>
		<p>
			Server:&nbsp;&nbsp;<code id="serverName">My Server</code>
		</p><p>
			Address:&nbsp;<code id="serverURL">redeclipse.example.com:28801</code>
		</p> 
	</header>
	<hr />
	<div id="content">
		<form action="index.php" method="POST" id="myform1" autocomplete="off">
			<div class="formOptions">
				<button type="button" id="btnReset" onclick="resetAll()">Reset All</button>
			</div>
			<br>
			<div id="formData">
			<?php
				echo "<!-- Begin form data -->"."\n";
				$lines = file("auth.cfg", FILE_IGNORE_NEW_LINES);
				$users = array();

				foreach($lines as $value) {
					if (strpos($value,'addlocalop') == 0) {
						$value = str_replace("addlocalop ","",$value);
						$temp = explode(" ", $value);
						if (strpos($temp[0],'//') === false) {
							//echo $temp[0] . " => " . $temp[1] . "<br>";
							$users[$temp[0]] = $temp[1];
						}
					} else { echo "::".$value.":: NOT VALID"; }
				}

				function cleanStr($string) {
				   $string = str_replace(' ', '-', $string); // Replaces all spaces with hyphens.
				   $string = preg_replace('/[^A-Za-z0-9\-]/', '', $string); // Removes special chars.
				   return preg_replace('/-+/', '-', $string); // Replaces multiple hyphens with single one.
				}
				$users = cleanStr($users);

				$i=0;
				foreach($users as $key => $value) {
				$priva = $privo = $privm = $privs = "";
				switch($value) {
					case 'a':
						//echo "admin";
						$priva = "selected";
						break;
					case 'o':
						//echo "op";
						$privo = "selected";
						break;
					case 'm':
						//echo "mod";
						$privm = "selected";
						break;
					case 's':
						//echo "supporter";
						$privs = "selected";
						break;
				}

				echo '<div class="formRow" id="'.$key.'">'."\n";
				echo '	<input type="text"  name="names[]" required size="15" value="'.$key.'" pattern="[a-z]+" >'."\n";
				echo '	<select name="ranks[]" required>'."\n";
				echo '		<option value="s" '.$privs.' >Supporter</option>'."\n";
				echo '		<option value="m" '.$privm.' >Moderator</option>'."\n";
				echo '		<option value="o" '.$privo.' >Operator</option>'."\n";
				echo '		<option value="a" '.$priva.' >Administrator</option>'."\n";
				echo '	</select>'."\n";
				echo '	<button type="button" name="deleteuser" value="'.$i.'" onclick="delUser(this)" >X</button>'."\n";
				echo '</div>'."\n";

				$i++;
				}

				echo "<!-- End of auth.cfg generated form data -->\n";
			?>
			</div>
			<button type="button" id="btnAddRow" onclick="addNewRow()">Add Row</button><br>
			<br>
			<input type="submit" name="submit" value="Save Changes">
		</form>
	</div>
	<hr />
	<footer>
		&copy; freezurbern 2015 <a href="https://github.com/freezurbern">&#64; GitHub</a>.
	</footer>

	<script>
		function addNewRow() {
			var destform = document.getElementById("formData"); // the form to add these items to
			var d = document.createElement("div"); // each row is contained in a div
				d.setAttribute("class","formRow");
				d.setAttribute("id",(Math.floor(Math.random() * 10000) + 1));
			destform.appendChild(d);
			var namebox = document.createElement("input"); // username field
				namebox.setAttribute("type","text");
				namebox.setAttribute("name","names[]");
				namebox.setAttribute("required","required");
				namebox.setAttribute("size","15");
				namebox.setAttribute("pattern","[a-z]+");
			d.appendChild(namebox);
			d.innerHTML = d.innerHTML + "\n";
			var ranksel = document.createElement("select"); // select tags
				ranksel.setAttribute("name","ranks[]");
				ranksel.setAttribute("required","required");
			d.appendChild(ranksel);
			var rankoptS = document.createElement("option");
				rankoptS.setAttribute("value","s");
				rankoptS.innerHTML = "Supporter";
			ranksel.appendChild(rankoptS);
			var rankoptM = document.createElement("option");
				rankoptM.setAttribute("value","m");
				rankoptM.innerHTML = "Moderator";
			ranksel.appendChild(rankoptM);
			var rankoptO = document.createElement("option");
				rankoptO.setAttribute("value","o");
				rankoptO.innerHTML = "Operator";
			ranksel.appendChild(rankoptO);
			var rankoptA = document.createElement("option");
				rankoptA.setAttribute("value","a");
				rankoptA.innerHTML = "Administrator";
			ranksel.appendChild(rankoptA);
			d.innerHTML = d.innerHTML + "\n";
			var delBtn = document.createElement("button");
				delBtn.setAttribute("type","button");
				delBtn.setAttribute("name","delete");
				delBtn.setAttribute("value","delete");
				delBtn.setAttribute("onclick","delUser(this)");
				delBtn.innerHTML = "X";
			d.appendChild(delBtn);
		}
		function delUser(srcNode) {
			var targetID = srcNode.parentNode.id;
			var e = document.getElementById(targetID);
				e.parentNode.removeChild(e);
		}
		function resetAll() {
			var x = document.getElementsByTagName("input")
			var i;
			for (i = 0; i < x.length; i++) {
				if (x[i].type == "text") {x[i].value = "";}
			}
		}
	</script>
</body>
</html>