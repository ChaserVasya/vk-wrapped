enum ErrorCode {
  unspecified,
  invalidParam,
  http,
  jsonParse,
  notImplemented,
  notAllowed,

  // Adding visitors
  addingVisitorAlreadyAdded,
  addingVisitorAlreadyVisited,
  addingVisitorNotAllowed,

  // Authentication
  authContactIsInvalid,
  authCodeRequestTooQuick,
  authCodeToShort,
  authOutgoingEmpty,
  authOutgoingExpired,
}
