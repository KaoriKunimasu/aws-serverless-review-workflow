export function NewRequestPage() {
  return (
    <section className="page">
      <header className="page-header">
        <div>
          <h1>New Request</h1>
          <p>Create a new review request.</p>
        </div>
      </header>

      <section className="card form-card">
        <form className="form-grid">
          <label className="form-field">
            <span>Title</span>
            <input className="input" type="text" placeholder="Enter a title" />
          </label>

          <label className="form-field">
            <span>Request Type</span>
            <select className="input" defaultValue="term">
              <option value="term">Term</option>
              <option value="document">Document</option>
              <option value="change">Change</option>
            </select>
          </label>

          <label className="form-field">
            <span>Source Language</span>
            <input className="input" type="text" defaultValue="en" />
          </label>

          <label className="form-field">
            <span>Target Language</span>
            <input className="input" type="text" defaultValue="ja" />
          </label>

          <label className="form-field form-field--full">
            <span>Source Text</span>
            <textarea
              className="input input--textarea"
              placeholder="Enter source text"
              rows={4}
            />
          </label>

          <label className="form-field form-field--full">
            <span>Target Text</span>
            <textarea
              className="input input--textarea"
              placeholder="Enter target text"
              rows={4}
            />
          </label>

          <label className="form-field">
            <span>Category</span>
            <input className="input" type="text" placeholder="security" />
          </label>

          <div className="form-actions form-field--full">
            <button type="button" className="button button--secondary">
              Save Draft
            </button>
            <button type="button" className="button button--primary">
              Submit
            </button>
          </div>
        </form>
      </section>
    </section>
  );
}
