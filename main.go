package main

import (
	"net/http"

	"github.com/rs/zerolog/log"
)

func main() {
	log.Info().Msg("starting")
	err := http.ListenAndServe(":8080", initHandler())
	log.Info().Err(err).Msg("stopping")

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
	w.Write([]byte("root #1"))
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
