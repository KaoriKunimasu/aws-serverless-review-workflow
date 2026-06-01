import { useParams } from "react-router-dom";

export function RequestDetailPage() {
  const { requestId } = useParams();

  return (
    <section className="page">
      <header className="page-header">
        <div>
          <h1>Request Detail</h1>
          <p>View request data and workflow status.</p>
        </div>
      </header>

      <section className="card detail-card">
        <dl className="detail-grid">
          <div>
            <dt>Request ID</dt>
            <dd>{requestId}</dd>
          </div>
          <div>
            <dt>Status</dt>
            <dd>
              <span className="status-badge status-badge--submitted">
                submitted
              </span>
            </dd>
          </div>
          <div>
            <dt>Request Type</dt>
            <dd>term</dd>
          </div>
          <div>
            <dt>Category</dt>
            <dd>security</dd>
          </div>
          <div>
            <dt>Source Language</dt>
            <dd>en</dd>
          </div>
          <div>
            <dt>Target Language</dt>
            <dd>ja</dd>
          </div>
          <div className="detail-grid__full">
            <dt>Source Text</dt>
            <dd>authorizer</dd>
          </div>
          <div className="detail-grid__full">
            <dt>Target Text</dt>
            <dd>authorizer</dd>
          </div>
          <div className="detail-grid__full">
            <dt>Reviewer Note</dt>
            <dd>No review note yet.</dd>
          </div>
        </dl>
      </section>
    </section>
  );
}
