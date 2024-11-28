from http.server import SimpleHTTPRequestHandler, HTTPServer

class HealthCheckHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.send_header("Content-type", "text/plain")
            self.end_headers()
            self.wfile.write(b"Bot is running and healthy!")
        else:
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b"Not Found")

def start_http_server():
    port = 8080
    server = HTTPServer(("0.0.0.0", port), HealthCheckHandler)
    print(f"🌐 HTTP server running on http://0.0.0.0:{port}")
    server.serve_forever()

if __name__ == "__main__":
    start_http_server()
