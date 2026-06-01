import { createBrowserRouter, Navigate } from "react-router-dom";
import { AppLayout } from "../components/layout/AppLayout";
import { DashboardPage } from "../pages/DashboardPage";
import { LoginPage } from "../pages/LoginPage";
import { NewRequestPage } from "../pages/NewRequestPage";
import { RequestDetailPage } from "../pages/RequestDetailPage";
import { RequestsPage } from "../pages/RequestsPage";

export const router = createBrowserRouter([
  {
    path: "/login",
    element: <LoginPage />,
  },
  {
    path: "/",
    element: <AppLayout />,
    children: [
      {
        index: true,
        element: <Navigate to="/dashboard" replace />,
      },
      {
        path: "dashboard",
        element: <DashboardPage />,
      },
      {
        path: "requests",
        element: <RequestsPage />,
      },
      {
        path: "requests/new",
        element: <NewRequestPage />,
      },
      {
        path: "requests/:requestId",
        element: <RequestDetailPage />,
      },
    ],
  },
]);
