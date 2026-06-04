import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";

import { useAuth } from "../app/providers/AuthProvider";
import { ApiError } from "../lib/api/client";
import { getRequestDetail, type RequestDetail } from "../lib/api/requests";

function formatDateTime(value: string): string {
  const date = new Date(value);

  if (Number.isNaN(date.getTime())) {
    return value;
  }

  return new Intl.DateTimeFormat("en-AU", {
    dateStyle: "medium",
    timeStyle: "short",
  }).format(date);
}

export function RequestDetailPage() {
  const { requestId } = useParams();
  const { session } = useAuth();

  const accessToken = session?.accessToken ?? "";

  const [request, setRequest] = useState<RequestDetail | null>(null);
  const [loading, setLoading] = useState(true);
  const [errorMessage, setErrorMessage] = useState("");
  const [notFound, setNotFound] = useState(false);

  useEffect(() => {
    async function loadRequestDetail() {
      if (!requestId) {
        setErrorMessage("Request ID is missing.");
        setLoading(false);
        return;
      }

      if (!accessToken) {
        setErrorMessage("Access token is missing. Please sign in again.");
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        setErrorMessage("");
        setNotFound(false);

        const item = await getRequestDetail(accessToken, requestId);
        setRequest(item);
      } catch (error) {
        if (error instanceof ApiError && error.status === 404) {
          setNotFound(true);
        } else if (error instanceof ApiError) {
          setErrorMessage(error.message);
        } else if (error instanceof Error) {
          setErrorMessage(error.message);
        } else {
          setErrorMessage("Failed to load request detail.");
        }
      } finally {
        setLoading(false);
      }
    }

    void loadRequestDetail();
  }, [accessToken, requestId]);

  if (loading) {
    return (
      <section className="page">
        <header className="page-header">
          <div>
            <h1>Request Detail</h1>
            <p>Loading request detail...</p>
          </div>
        </header>
      </section>
    );
  }

  if (notFound) {
    return (
      <section className="page">
        <header className="page-header">
          <div>
            <h1>Request Detail</h1>
            <p>The requested workflow item was not found.</p>
          </div>
        </header>

        <section className="card">
          <Link to="/requests">Back to requests</Link>
        </section>
      </section>
    );
  }

  if (errorMessage) {
    return (
      <section className="page">
        <header className="page-header">
          <div>
            <h1>Request Detail</h1>
            <p>Unable to load the workflow item.</p>
          </div>
        </header>

        <section className="card">
          <div style={{ color: "#b00020", marginBottom: "1rem" }}>{errorMessage}</div>
          <Link to="/requests">Back to requests</Link>
        </section>
      </section>
    );
  }

  if (!request) {
    return null;
  }

  return (
    <section className="page">
      <header className="page-header">
        <div>
          <h1>{request.title}</h1>
          <p>Review the submitted workflow request details.</p>
        </div>
        <div>
          <Link to="/requests">Back to requests</Link>
        </div>
      </header>

      <section className="card form-card">
        <div
          style={{
            display: "grid",
            gap: "1rem",
            gridTemplateColumns: "repeat(auto-fit, minmax(220px, 1fr))",
            marginBottom: "1.5rem",
          }}
        >
          <div>
            <strong>Request ID</strong>
            <div>{request.requestId}</div>
          </div>

          <div>
            <strong>Status</strong>
            <div>{request.status}</div>
          </div>

          <div>
            <strong>Request Type</strong>
            <div>{request.requestType}</div>
          </div>

          <div>
            <strong>Category</strong>
            <div>{request.category || "-"}</div>
          </div>

          <div>
            <strong>Source Language</strong>
            <div>{request.sourceLanguage}</div>
          </div>

          <div>
            <strong>Target Language</strong>
            <div>{request.targetLanguage}</div>
          </div>

          <div>
            <strong>Created By</strong>
            <div>{request.createdBy || "-"}</div>
          </div>

          <div>
            <strong>Created At</strong>
            <div>{formatDateTime(request.createdAt)}</div>
          </div>

          <div>
            <strong>Updated At</strong>
            <div>{formatDateTime(request.updatedAt)}</div>
          </div>
        </div>

        <div className="form-grid">
          <div className="form-field form-field--full">
            <span>Source Text</span>
            <div className="input input--textarea" style={{ whiteSpace: "pre-wrap" }}>
              {request.sourceText || "-"}
            </div>
          </div>

          <div className="form-field form-field--full">
            <span>Target Text</span>
            <div className="input input--textarea" style={{ whiteSpace: "pre-wrap" }}>
              {request.targetText || "-"}
            </div>
          </div>

          <div className="form-field form-field--full">
            <span>Reviewer Note</span>
            <div className="input input--textarea" style={{ whiteSpace: "pre-wrap" }}>
              {request.reviewerNote || "-"}
            </div>
          </div>
        </div>
      </section>
    </section>
  );
}
