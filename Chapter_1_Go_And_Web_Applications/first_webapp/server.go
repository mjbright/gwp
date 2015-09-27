package main

import (
    "fmt"
    "net/http/httputil"
    "net/http"
)

func handler(writer http.ResponseWriter, request *http.Request) {
    // Determine protocol:
    proto := "unknown"
    if (request.Proto == "HTTP/1.1") {
        proto="http"
    }
     
    // Log the request on the server stdout:
    fmt.Printf("-------- Received %s request on: %s://%s%s\n", request.Method, proto, request.Host, request.RequestURI)
    if ((request.Method == "POST") && (request.ContentLength > 0)) {
        //fmt.Printf("Content: '%s'\n", request.Body)
        bytes, err := httputil.DumpRequest(request, true)
    
        if err != nil {
            fmt.Printf("ERROR<%s>\n", err)
            return
        }

        fmt.Printf("%s\n", bytes)
    }

    if (request.Method == "HEAD") {
        // How to treat a HEAD request - client blocks?!
        return
    }

    // Server response on writer:
    //
    // Send extra information to the client:
    fmt.Fprintf(writer, "-------- Received %s request from: %s --------\n", request.Method, request.RemoteAddr)
    fmt.Fprintf(writer, "Full info: %+v\n", request)
    fmt.Fprintf(writer, "Received request on: %s://%s%s\n", proto, request.Host, request.RequestURI)

    // Send the response:
    fmt.Fprintf(writer, "Hello World, %s\n", request.URL.Path[1:])
}

func main() {
    http.HandleFunc("/", handler)
    port := "8080"
    fmt.Printf("Listening on port %s\n", port)
    // http.ListenAndServe(":80", nil)
    http.ListenAndServe(":" + port, nil)
    fmt.Print(http.ListenAndServe(":" + port, nil))
    fmt.Printf("Finished listening on port %s\n", port)
}
