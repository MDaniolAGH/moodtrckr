from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_version_returns_service_and_version():
    response = client.get("/version")

    assert response.status_code == 200
    assert response.json() == {"service": "Mood Tracker API", "version": "1.0.0"}


def test_health_check_still_ok():
    response = client.get("/")

    assert response.status_code == 200
    assert response.json()["status"] == "ok"
