export function LoginPage() {
  return (
    <main className="auth-page">
      <section className="auth-card">
        <h1>Sign in</h1>
        <p>
          Authentication will be connected to Amazon Cognito in a later change.
        </p>

        <form className="auth-form">
          <label className="form-field">
            <span>Email</span>
            <input type="email" placeholder="name@example.com" disabled />
          </label>

          <label className="form-field">
            <span>Password</span>
            <input type="password" placeholder="••••••••" disabled />
          </label>

          <button type="button" className="button button--primary" disabled>
            Sign in
          </button>
        </form>
      </section>
    </main>
  );
}
