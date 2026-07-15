using Microsoft.AspNetCore.Mvc;

namespace OrigamiMaster.API.Controllers;

[ApiController]
[Route("share")]
public class ShareController : ControllerBase
{
    [HttpGet("{token}")]
    public IActionResult RedirectToApp(string token)
    {
        var html = $@"
<!DOCTYPE html>
<html>
<head>
    <meta charset=""utf-8"">
    <meta name=""viewport"" content=""width=device-width, initial-scale=1"">
    <title>Origami Master</title>
    <script>
        window.onload = function() {{
            // Attempt to open the custom scheme
            window.location.href = ""origamimaster://share/{token}"";
            
            // Fallback message if it fails
            setTimeout(function() {{
                document.getElementById('msg').innerHTML = ""If the app didn't open automatically, <a href='origamimaster://share/{token}'>click here</a> to open it."";
            }}, 1500);
        }}
    </script>
</head>
<body style=""text-align: center; padding-top: 50px; font-family: sans-serif;"">
    <h2 id=""msg"">Opening Origami Master...</h2>
</body>
</html>";
        return Content(html, "text/html");
    }
}
