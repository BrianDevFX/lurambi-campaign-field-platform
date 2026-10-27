/**
 * National ID Normalisation & Security Utility
 * 
 * Rules:
 * - Valid Kenyan National ID is 7 or 8 digits.
 * - Missing or empty ID: imports as `pending_id` with `MISSING_ID` flag (~14% filled in legacy data).
 * - Invalid length: imports with `INVALID_ID` flag.
 * - ID masking (e.g. 2****789) for UI privacy compliance under Kenya Data Protection Act 2019.
 * - Salted hash generation for duplicate matching without exposing raw plaintext.
 */

export interface NationalIdResult {
  raw: string | number | null | undefined;
  cleanId: string | null;
  maskedId: string | null;
  idHash: string | null;
  isValid: boolean;
  status: 'valid' | 'missing' | 'invalid_length';
  flags: string[];
}

// In-app deterministic salt for matching (configured in production via SUPABASE / server secret)
const CAMPAIGN_SALT = 'LURAMBI_2027_KE_SALT_v1';

/**
 * Basic fast hash implementation for browser client & server duplicate matching
 */
export function generateSaltedHash(value: string): string {
  const str = `${CAMPAIGN_SALT}:${value.trim()}`;
  let hash = 0x811c9dc5;
  for (let i = 0; i < str.length; i++) {
    hash ^= str.charCodeAt(i);
    hash += (hash << 1) + (hash << 4) + (hash << 7) + (hash << 8) + (hash << 24);
  }
  return ('0000000' + (hash >>> 0).toString(16)).slice(-8) + 
         Math.abs(hash).toString(36);
}

export function maskNationalId(id: string): string {
  const clean = id.trim();
  if (clean.length < 4) return '***';
  const first = clean.slice(0, 2);
  const last = clean.slice(-3);
  return `${first}${'*'.repeat(Math.max(2, clean.length - 5))}${last}`;
}

export function normaliseNationalId(input: string | number | null | undefined): NationalIdResult {
  if (input === null || input === undefined || String(input).trim() === '') {
    return {
      raw: input,
      cleanId: null,
      maskedId: null,
      idHash: null,
      isValid: false,
      status: 'missing',
      flags: ['MISSING_ID']
    };
  }

  // Strip non-digit characters
  const cleaned = String(input).trim().replace(/[^0-9]/g, '');

  if (cleaned.length === 0) {
    return {
      raw: input,
      cleanId: null,
      maskedId: null,
      idHash: null,
      isValid: false,
      status: 'missing',
      flags: ['MISSING_ID']
    };
  }

  // Check valid Kenyan National ID length: 7 or 8 digits
  if (cleaned.length === 7 || cleaned.length === 8) {
    return {
      raw: input,
      cleanId: cleaned,
      maskedId: maskNationalId(cleaned),
      idHash: generateSaltedHash(cleaned),
      isValid: true,
      status: 'valid',
      flags: []
    };
  }

  // Invalid length (e.g. 5 digits, 6 digits, or accidental phone number in ID column)
  return {
    raw: input,
    cleanId: cleaned,
    maskedId: maskNationalId(cleaned),
    idHash: generateSaltedHash(cleaned),
    isValid: false,
    status: 'invalid_length',
    flags: ['INVALID_ID']
  };
}
