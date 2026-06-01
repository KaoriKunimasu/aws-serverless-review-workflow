const mockRequests = [
  {
    requestId: "req-001",
    title: "Review API Gateway terminology",
    status: "submitted",
    requestType: "term",
  },
  {
    requestId: "req-002",
    title: "Update authentication wording",
    status: "in_review",
    requestType: "change",
  },
];

export function RequestsPage() {
  return (
    <section className="page">
      <header className="page-header">
        <div>
          <h1>Requests</h1>
          <p>Review and track submitted workflow items.</p>
        </div>
      </header>

      <section className="card">
        <div className="table-toolbar">
          <input
            className="input"
            type="text"
            placeholder="Search requests"
            disabled
          />

          <select className="input" disabled defaultValue="">
            <option value="">All statuses</option>
            <option value="draft">Draft</option>
            <option value="submitted">Submitted</option>
            <option value="in_review">In Review</option>
            <option value="approved">Approved</option>
            <option value="rejected">Rejected</option>
          </select>
        </div>

        <div className="table-wrapper">
          <table className="table">
            <thead>
              <tr>
                <th>Request ID</th>
                <th>Title</th>
                <th>Type</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              {mockRequests.map((request) => (
                <tr key={request.requestId}>
                  <td>{request.requestId}</td>
                  <td>{request.title}</td>
                  <td>{request.requestType}</td>
                  <td>
                    <span className={`status-badge status-badge--${request.status}`}>
                      {request.status}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
    </section>
  );
}
