package main

import (
    "encoding/json"
    "log"
    "net/http"
    "sync"
    "github.com/gorilla/mux"
)

// Bestellung beschreibt eine Bestellung im System
type Bestellung struct {
    ID     string `json:"id"`
    Name   string `json:"name"`
    Gericht string `json:"gericht"`
    Status string `json:"status"` // z.B. "Bestellt", "In Lieferung", "Zugestellt"
}

// Dummy-Daten als In-Memory-Datenbank
var bestellungen = map[string]*Bestellung{
    "1": {ID: "1", Name: "Max Mustermann", Gericht: "Schnitzel mit Pommes", Status: "Bestellt"},
    "2": {ID: "2", Name: "Lisa Müller", Gericht: "Veggie Bowl", Status: "In Lieferung"},
    "3": {ID: "3", Name: "John Doe", Gericht: "Pizza Margherita", Status: "Zugestellt"},
}
var mu sync.Mutex

func getBestellung(w http.ResponseWriter, r *http.Request) {
    vars := mux.Vars(r)
    id := vars["id"]
    mu.Lock()
    b, ok := bestellungen[id]
    mu.Unlock()
    if !ok {
        http.Error(w, "Bestellung nicht gefunden", http.StatusNotFound)
        return
    }
    json.NewEncoder(w).Encode(b)
}

func updateStatus(w http.ResponseWriter, r *http.Request) {
    vars := mux.Vars(r)
    id := vars["id"]
    mu.Lock()
    b, ok := bestellungen[id]
    mu.Unlock()
    if !ok {
        http.Error(w, "Bestellung nicht gefunden", http.StatusNotFound)
        return
    }

    var body struct {
        Status string `json:"status"`
    }
    err := json.NewDecoder(r.Body).Decode(&body)
    if err != nil || body.Status == "" {
        http.Error(w, "Status im JSON-Body angeben", http.StatusBadRequest)
        return
    }

    mu.Lock()
    b.Status = body.Status
    mu.Unlock()
    json.NewEncoder(w).Encode(b)
}

func main() {
    r := mux.NewRouter()
    r.HandleFunc("/order/{id}", getBestellung).Methods("GET")
    r.HandleFunc("/order/{id}", updateStatus).Methods("PUT")

    log.Println("Mahlzeitexpress API läuft auf :8080")
    log.Fatal(http.ListenAndServe(":8080", r))
}
