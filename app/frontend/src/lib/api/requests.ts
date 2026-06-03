import { apiFetch } from "./client";
import type {
  CreateRequestPayload,
  CreateRequestResponse,
  ListRequestsResponse,
  WorkflowRequest,
} from "../../types/request";

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null;
}

function readString(value: unknown, fallback = ""): string {
  return typeof value === "string" ? value : fallback;
}

function readOptionalString(value: unknown): string | undefined {
  return typeof value === "string" && value.length > 0 ? value : undefined;
}

function readBoolean(value: unknown, fallback = false): boolean {
  return typeof value === "boolean" ? value : fallback;
}

function readNumber(value: unknown, fallback: number): number {
  return typeof value === "number" ? value : fallback;
}

function normalizeRequest(value: unknown): WorkflowRequest {
  const source = isRecord(value) ? value : {};

  return {
    requestId: readString(
      source.requestId ?? source.id ?? source.pk ?? source.request_id,
      "unknown-request-id",
    ),
    title: readString(source.title ?? source.requestTitle, "Untitled request"),
    description: readString(
      source.description ?? source.body ?? source.details,
      "",
    ),
    sourceLanguage: readString(
      source.sourceLanguage ?? source.fromLanguage ?? source.source_language,
      "ja",
    ),
    targetLanguage: readString(
      source.targetLanguage ?? source.toLanguage ?? source.target_language,
      "en",
    ),
    status: readOptionalString(source.status),
    createdAt: readString(
      source.createdAt ?? source.created_at,
      new Date(0).toISOString(),
    ),
    createdBy: readOptionalString(
      source.createdBy ?? source.userId ?? source.created_by,
    ),
  };
}

function normalizeListResponse(value: unknown): ListRequestsResponse {
  if (Array.isArray(value)) {
    const items = value.map(normalizeRequest);

    return {
      items,
      count: items.length,
      hasMore: false,
    };
  }

  if (isRecord(value)) {
    const rawItems = Array.isArray(value.items) ? value.items : [];
    const items = rawItems.map(normalizeRequest);

    return {
      items,
      count: readNumber(value.count, items.length),
      hasMore: readBoolean(value.hasMore, false),
    };
  }

  return {
    items: [],
    count: 0,
    hasMore: false,
  };
}

function normalizeCreateResponse(value: unknown): CreateRequestResponse {
  if (isRecord(value) && value.item) {
    return {
      item: normalizeRequest(value.item),
      message: readOptionalString(value.message),
    };
  }

  return {
    item: normalizeRequest(value),
  };
}

export async function listRequests(
  accessToken: string,
): Promise<ListRequestsResponse> {
  const response = await apiFetch<unknown>("/requests", {
    method: "GET",
    accessToken,
  });

  return normalizeListResponse(response);
}

export async function createRequest(
  accessToken: string,
  payload: CreateRequestPayload,
): Promise<CreateRequestResponse> {
  const response = await apiFetch<unknown>("/requests", {
    method: "POST",
    accessToken,
    body: payload,
  });

  return normalizeCreateResponse(response);
}
