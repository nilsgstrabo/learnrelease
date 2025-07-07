package main

import "net/http"

func main() {
	http.ListenAndServe(":8080", initHandler())
}

func initHandler() http.Handler {
	mux := http.NewServeMux()
	mux.HandleFunc("/", rootHandler)
	mux.HandleFunc("/api", apiHandler)
	mux.HandleFunc("/status", statusHandler)
	return mux
}

func rootHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("welcome"))
}

func apiHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("hello world"))
}

func statusHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("success"))
}

func Magic() string {
	return "magic1"
}
