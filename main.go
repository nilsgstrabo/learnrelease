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
	mux.HandleFunc("/metrics", metricsHandler)
	return mux
}

func rootHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("root #13"))
}

func apiHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("hello universe"))
}

func statusHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("success"))
}

func metricsHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("metrics!"))
}
