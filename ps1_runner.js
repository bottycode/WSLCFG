// Usage: wscript.exe ps1_runner.js script.ps1 [arguments...]

var argv = WScript.Arguments;
var arguments = "";
var fs = new ActiveXObject("Scripting.FileSystemObject");
var shell = new ActiveXObject("WScript.Shell");

if (argv.length >= 1 && argv(0).match(/\.ps1$/i) && fs.FileExists(argv(0))) {
	for (var i = 0; i < argv.length; i++) {
		// TODO: if argv(i) contains '"'...
		arguments = arguments + ' "' + argv(i) + '"';
	}

	shell.Run('powershell.exe -File' + arguments, 0, true);
}
