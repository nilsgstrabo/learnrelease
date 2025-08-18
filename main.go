package main

import (
	"net/http"

	"github.com/nilsgstrabo/mygolib/v2"
	"github.com/rs/zerolog/log"
)

func main() {
	log.Info().Msg(mygolib.FooV1("starting"))
	log.Info().Msg(mygolib.Bar("message"))
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
	w.Write([]byte("root #1¤"))
}

func apiHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	s := mygolib.FooV1("hello universe")
	w.Write([]byte(s))
}

func statusHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("success"))
}

func metricsHandler(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(200)
	w.Write([]byte("metrics!!"))
}
