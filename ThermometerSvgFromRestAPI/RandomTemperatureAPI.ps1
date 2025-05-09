# Start a simple REST API server on localhost:8088
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:8088/temperature/")
$listener.Start()
Write-Host "Listening on http://localhost:8088/temperature/"

while ($listener.IsListening) {
    $context = $listener.GetContext()
    $response = $context.Response
    $request = $context.Request

    # Add CORS headers
    $response.Headers.Add("Access-Control-Allow-Origin", "*")
    $response.Headers.Add("Access-Control-Allow-Methods", "GET, OPTIONS")
    $response.Headers.Add("Access-Control-Allow-Headers", "Content-Type")

    # Handle OPTIONS preflight request
    if ($request.HttpMethod -eq "OPTIONS") {
        $response.StatusCode = 204
        $response.Close()
        continue
    }

    if ($request.HttpMethod -eq "GET") {
        # Generate a random temperature between -10 and 30
        $temperature = Get-Random -Minimum -10 -Maximum 31

        # Create JSON response
        $responseString = @{ temperature = $temperature } | ConvertTo-Json

        $buffer = [System.Text.Encoding]::UTF8.GetBytes($responseString)
        $response.ContentType = "application/json"
        $response.ContentLength64 = $buffer.Length
        $response.OutputStream.Write($buffer, 0, $buffer.Length)
    } else {
        $response.StatusCode = 405  # Method Not Allowed
    }

    $response.OutputStream.Close()
}
