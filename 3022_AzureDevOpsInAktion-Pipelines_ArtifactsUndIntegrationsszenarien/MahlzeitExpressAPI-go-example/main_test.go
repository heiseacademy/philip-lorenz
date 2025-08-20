package main

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/gorilla/mux"
)

// Hilfsfunktion, um einen neuen Router für die Tests zu erstellen
func setupRouter() *mux.Router {
	r := mux.NewRouter()
	r.HandleFunc("/order/{id}", getBestellung).Methods("GET")
	r.HandleFunc("/order/{id}", updateStatus).Methods("PUT")
	return r
}

func TestGetBestellung(t *testing.T) {
	router := setupRouter()

	// Test: Bestellung existiert
	req, _ := http.NewRequest("GET", "/order/1", nil)
	rr := httptest.NewRecorder()
	router.ServeHTTP(rr, req)

	if rr.Code != http.StatusOK {
		t.Fatalf("Erwarteter Status 200, aber %d erhalten", rr.Code)
	}

	var b Bestellung
	if err := json.NewDecoder(rr.Body).Decode(&b); err != nil {
		t.Fatal("Konnte Antwort nicht decodieren:", err)
	}
	if b.ID != "1" || b.Status != "Bestellt" {
		t.Errorf("Erwartete Bestellung mit ID=1 und Status='Bestellt', erhalten: %+v", b)
	}

	// Test: Bestellung existiert NICHT
	req, _ = http.NewRequest("GET", "/order/999", nil)
	rr = httptest.NewRecorder()
	router.ServeHTTP(rr, req)

	if rr.Code != http.StatusNotFound {
		t.Errorf("Erwarteter Status 404, aber %d erhalten", rr.Code)
	}
}

func TestUpdateStatus(t *testing.T) {
	router := setupRouter()

	// Test: Status korrekt updaten
	body := []byte(`{"status":"Zugestellt"}`)
	req, _ := http.NewRequest("PUT", "/order/2", bytes.NewReader(body))
	req.Header.Set("Content-Type", "application/json")
	rr := httptest.NewRecorder()
	router.ServeHTTP(rr, req)

	if rr.Code != http.StatusOK {
		t.Fatalf("Erwarteter Status 200, aber %d erhalten", rr.Code)
	}

	var b Bestellung
	if err := json.NewDecoder(rr.Body).Decode(&b); err != nil {
		t.Fatal("Konnte Antwort nicht decodieren:", err)
	}
	if b.Status != "Zugestellt" {
		t.Errorf("Erwarteter Status='Zugestellt', erhalten: %s", b.Status)
	}

	// Test: Fehlerhafter Body
	req, _ = http.NewRequest("PUT", "/order/2", bytes.NewReader([]byte(`{}`)))
	req.Header.Set("Content-Type", "application/json")
	rr = httptest.NewRecorder()
	router.ServeHTTP(rr, req)

	if rr.Code != http.StatusBadRequest {
		t.Errorf("Erwarteter Status 400, aber %d erhalten", rr.Code)
	}

	// Test: Bestellung existiert NICHT
	req, _ = http.NewRequest("PUT", "/order/999", bytes.NewReader(body))
	req.Header.Set("Content-Type", "application/json")
	rr = httptest.NewRecorder()
	router.ServeHTTP(rr, req)

	if rr.Code != http.StatusNotFound {
		t.Errorf("Erwarteter Status 404, aber %d erhalten", rr.Code)
	}
}
