-- ============================================================================
-- LURAMBI CAMPAIGN FIELD PLATFORM - PRODUCTION SEED DATA
-- Kakamega County, Lurambi Constituency (2027 General Election)
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. SYSTEM PSEUDO-USERS
-- ----------------------------------------------------------------------------
INSERT INTO public.system_users (id, name, description)
VALUES 
    ('00000000-0000-0000-0000-000000000001', 'legacy_import', 'Attribution for historical records imported from the Excel legacy workbook')
ON CONFLICT (name) DO NOTHING;

-- ----------------------------------------------------------------------------
-- 2. CANONICAL WARDS (All 6 Official Lurambi Wards)
-- ----------------------------------------------------------------------------
INSERT INTO public.wards (id, constituency_name, county_name, name, code, registered_voters_target)
VALUES 
    ('a0000001-0000-0000-0000-000000000001', 'Lurambi', 'Kakamega', 'Sheywe', 'LUR-01', 26500),
    ('a0000001-0000-0000-0000-000000000002', 'Lurambi', 'Kakamega', 'Shirere', 'LUR-02', 19400),
    ('a0000001-0000-0000-0000-000000000003', 'Lurambi', 'Kakamega', 'Mahiakalo', 'LUR-03', 18200),
    ('a0000001-0000-0000-0000-000000000004', 'Lurambi', 'Kakamega', 'Butsotso East', 'LUR-04', 17800),
    ('a0000001-0000-0000-0000-000000000005', 'Lurambi', 'Kakamega', 'Butsotso South', 'LUR-05', 16900),
    ('a0000001-0000-0000-0000-000000000006', 'Lurambi', 'Kakamega', 'Butsotso Central', 'LUR-06', 18500)
ON CONFLICT (name) DO UPDATE SET 
    registered_voters_target = EXCLUDED.registered_voters_target;

-- ----------------------------------------------------------------------------
-- 3. CANONICAL POLLING CENTRES & STATIONS
-- ----------------------------------------------------------------------------
-- Sheywe Ward
INSERT INTO public.polling_centres (id, ward_id, name, code, total_registered_voters) VALUES
    ('b0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000001', 'Kakamega Primary School', 'PC-SHEY-01', 3450),
    ('b0000001-0000-0000-0000-000000000002', 'a0000001-0000-0000-0000-000000000001', 'Bukhungu Stadium Grounds', 'PC-SHEY-02', 2800),
    ('b0000001-0000-0000-0000-000000000003', 'a0000001-0000-0000-0000-000000000001', 'Muliro Gardens Community Hall', 'PC-SHEY-03', 2100)
ON CONFLICT (ward_id, name) DO NOTHING;

-- Shirere Ward
INSERT INTO public.polling_centres (id, ward_id, name, code, total_registered_voters) VALUES
    ('b0000002-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000002', 'Amalemba Primary School', 'PC-SHIR-01', 2900),
    ('b0000002-0000-0000-0000-000000000002', 'a0000001-0000-0000-0000-000000000002', 'Sigalagala National Polytechnic', 'PC-SHIR-02', 3100)
ON CONFLICT (ward_id, name) DO NOTHING;

-- Mahiakalo Ward
INSERT INTO public.polling_centres (id, ward_id, name, code, total_registered_voters) VALUES
    ('b0000003-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000003', 'Mahiakalo Primary School', 'PC-MAH-01', 2600),
    ('b0000003-0000-0000-0000-000000000002', 'a0000001-0000-0000-0000-000000000003', 'MMUST (Masinde Muliro University)', 'PC-MAH-02', 4200)
ON CONFLICT (ward_id, name) DO NOTHING;

-- Butsotso East
INSERT INTO public.polling_centres (id, ward_id, name, code, total_registered_voters) VALUES
    ('b0000004-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000004', 'Shikoti Girls Secondary', 'PC-BE-01', 2400),
    ('b0000004-0000-0000-0000-000000000002', 'a0000001-0000-0000-0000-000000000004', 'Eshisiru Primary School', 'PC-BE-02', 2150)
ON CONFLICT (ward_id, name) DO NOTHING;

-- Butsotso South
INSERT INTO public.polling_centres (id, ward_id, name, code, total_registered_voters) VALUES
    ('b0000005-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000005', 'Bukura Agricultural College', 'PC-BS-01', 2700),
    ('b0000005-0000-0000-0000-000000000002', 'a0000001-0000-0000-0000-000000000005', 'Emusire High School', 'PC-BS-02', 1950)
ON CONFLICT (ward_id, name) DO NOTHING;

-- Butsotso Central
INSERT INTO public.polling_centres (id, ward_id, name, code, total_registered_voters) VALUES
    ('b0000006-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000006', 'Lurambi Primary School', 'PC-BC-01', 2850),
    ('b0000006-0000-0000-0000-000000000002', 'a0000001-0000-0000-0000-000000000006', 'Elukhambi Primary School', 'PC-BC-02', 2200)
ON CONFLICT (ward_id, name) DO NOTHING;

-- Polling Stations (Samples per centre)
INSERT INTO public.polling_stations (polling_centre_id, ward_id, station_name, station_number, registered_voters_est) VALUES
    ('b0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000001', 'Kakamega Primary School - Stream 1', 1, 690),
    ('b0000001-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000001', 'Kakamega Primary School - Stream 2', 2, 690),
    ('b0000002-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000002', 'Amalemba Primary - Stream 1', 1, 700),
    ('b0000003-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000003', 'Mahiakalo Primary - Stream 1', 1, 650),
    ('b0000004-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000004', 'Shikoti Girls - Stream 1', 1, 600),
    ('b0000005-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000005', 'Bukura College - Stream 1', 1, 680),
    ('b0000006-0000-0000-0000-000000000001', 'a0000001-0000-0000-0000-000000000006', 'Lurambi Primary - Stream 1', 1, 710)
ON CONFLICT (polling_centre_id, station_name) DO NOTHING;

-- ----------------------------------------------------------------------------
-- 4. PLACE ALIASES & NORMALISATION MAPPINGS
-- Handles common spelling errors, mixed casing, and legacy Excel junk values
-- ----------------------------------------------------------------------------
INSERT INTO public.place_aliases (raw_alias, canonical_type, target_ward_id, target_polling_centre_id, confidence, notes) VALUES
    -- Ward spelling variations from legacy workbook
    ('Shieywe', 'ward', 'a0000001-0000-0000-0000-000000000001', NULL, 0.99, 'Common legacy typo in raw data'),
    ('sheywe', 'ward', 'a0000001-0000-0000-0000-000000000001', NULL, 1.00, 'Lowercase variant'),
    ('Mahialako', 'ward', 'a0000001-0000-0000-0000-000000000003', NULL, 0.98, 'Typo transposition in legacy workbook'),
    ('mahiakalo', 'ward', 'a0000001-0000-0000-0000-000000000003', NULL, 1.00, 'Lowercase variant'),
    ('Butsotso south', 'ward', 'a0000001-0000-0000-0000-000000000005', NULL, 1.00, 'Sentence case variant'),
    ('butsotso east', 'ward', 'a0000001-0000-0000-0000-000000000004', NULL, 1.00, 'Lowercase variant'),
    ('Shirere ', 'ward', 'a0000001-0000-0000-0000-000000000002', NULL, 1.00, 'Trailing space variant'),

    -- Polling centre aliases and junk value mappings
    ('Kakamega Pri', 'polling_centre', 'a0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000001', 0.95, 'Abbreviation'),
    ('Amalemba Pri', 'polling_centre', 'a0000001-0000-0000-0000-000000000002', 'b0000002-0000-0000-0000-000000000001', 0.95, 'Abbreviation'),
    ('chillpark', 'polling_centre', 'a0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000003', 0.85, 'Local nickname mapping to Muliro Gardens area'),
    ('Chillpark', 'polling_centre', 'a0000001-0000-0000-0000-000000000001', 'b0000001-0000-0000-0000-000000000003', 0.85, 'Capitalized nickname variant'),
    ('Iyala ', 'polling_centre', 'a0000001-0000-0000-0000-000000000004', 'b0000004-0000-0000-0000-000000000002', 0.80, 'Sub-location landmark routed to nearest centre'),
    ('iyala', 'polling_centre', 'a0000001-0000-0000-0000-000000000004', 'b0000004-0000-0000-0000-000000000002', 0.80, 'Lowercase variant'),
    ('Daisy', 'polling_centre', NULL, NULL, 0.00, 'Junk value - personal name in place column, route to Needs Mapping'),
    ('uncle devi', 'polling_centre', NULL, NULL, 0.00, 'Junk value - personal alias, route to Needs Mapping'),
    ('Chief Mutsembi', 'polling_centre', NULL, NULL, 0.00, 'Junk value - local chief reference, route to Needs Mapping'),
    ('Approved', 'polling_centre', NULL, NULL, 0.00, 'Junk value - status string misplaced in place column')
ON CONFLICT (raw_alias, canonical_type) DO UPDATE SET 
    confidence = EXCLUDED.confidence,
    notes = EXCLUDED.notes;

-- ----------------------------------------------------------------------------
-- 5. DEFAULT SETTINGS & COMPLIANCE PARAMETERS
-- ----------------------------------------------------------------------------
INSERT INTO public.settings (key, value, description) VALUES
    ('campaign_info', '{"candidate_name": "Hon. Candidate Lurambi 2027", "constituency": "Lurambi", "county": "Kakamega", "election_year": 2027}'::jsonb, 'General campaign metadata'),
    ('consent_policy', '{"version": "v1.2-2027", "mandatory": true, "notice_url": "/privacy", "dpa_2019_registered": true}'::jsonb, 'Kenya Data Protection Act 2019 consent configuration'),
    ('verification_providers', '{"register_import_enabled": true, "manual_enabled": true, "external_link_enabled": false, "external_rate_limit_per_min": 5}'::jsonb, 'Verification provider flags and rate limits'),
    ('projection_model', '{"verified_voter_turnout": 0.82, "unverified_voter_turnout": 0.58, "strong_supporter_conv": 0.90, "leaning_conv": 0.65, "undecided_conv": 0.35}'::jsonb, 'Transparent victory projection model coefficients'),
    ('chp_compliance_note', '{"visible": true, "exclude_default": true, "text": "CHPs are community health workers linked to public health programmes. Ensure political activities respect public service neutrality regulations."}'::jsonb, 'Legal notice for Community Health Promoters')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;

-- ----------------------------------------------------------------------------
-- 6. NETWORK INFLUENCERS (Pastors & Community Health Promoters / CHPs)
-- ----------------------------------------------------------------------------
-- Pastors (Faith Leaders)
INSERT INTO public.network_contacts (type, name, phone_e164, denomination, ward_id, reach_status, notes) VALUES
    ('pastor', 'Rev. Timothy Wangila', '+254710111222', 'PEFA Kakamega Central', 'a0000001-0000-0000-0000-000000000001', 'meeting_held', 'Met at Sheywe leadership breakfast. Warm support.'),
    ('pastor', 'Pastor Mary Makokha', '+254721333444', 'Friends Church (Quakers) Shirere', 'a0000001-0000-0000-0000-000000000002', 'contacted', 'Follow-up requested next month on youth empowerment.'),
    ('pastor', 'Bishop Geoffrey Shikuku', '+254733555666', 'NCCK Regional Fellowship', 'a0000001-0000-0000-0000-000000000003', 'meeting_held', 'Influential inter-denominational council convener.'),
    ('pastor', 'Fr. Aloysius Omondi', '+254701777888', 'Catholic Diocese of Kakamega', 'a0000001-0000-0000-0000-000000000001', 'contacted', 'Community peace advocacy discussion.'),
    ('pastor', 'Pastor Nathan Barasa', '+254712999000', 'ACK St. Luke Butsotso East', 'a0000001-0000-0000-0000-000000000004', 'not_contacted', 'Scheduled for ward prayer round.')
ON CONFLICT DO NOTHING;

-- CHPs (Community Health Promoters) - linked to Community Units (CUs)
INSERT INTO public.network_contacts (type, name, phone_e164, community_unit, sub_county, ward_id, reach_status, notes, exclude_from_campaign_exports) VALUES
    ('chp', 'Grace Nafuna Simiyu', '+254711223344', 'Amalemba Community Unit', 'Lurambi', 'a0000001-0000-0000-0000-000000000002', 'contacted', 'Active in household health surveys. Neutral engagement required.', true),
    ('chp', 'Beatrice Imbuhila', '+254722334455', 'Bukura Community Unit', 'Lurambi', 'a0000001-0000-0000-0000-000000000005', 'not_contacted', 'Community unit coordinator for Bukura South.', true),
    ('chp', 'Silvanus Mukolwe', '+254733445566', 'Elukhambi Community Unit', 'Lurambi', 'a0000001-0000-0000-0000-000000000006', 'contacted', 'Expressed interest in rural road dispensary access.', true),
    ('chp', 'Roseline Khalayi', '+254705556677', 'Emukaya Community Unit', 'Lurambi', 'a0000001-0000-0000-0000-000000000004', 'meeting_held', 'Maternal health advocate; emphasized maternity transit issues.', true)
ON CONFLICT DO NOTHING;
