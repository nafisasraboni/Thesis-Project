-- Scan history table for persisting malware prediction results
CREATE TABLE IF NOT EXISTS scan_history (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  file_name TEXT NOT NULL,
  extension TEXT NOT NULL,
  size_in_bytes INTEGER NOT NULL DEFAULT 0,
  sha256 TEXT NOT NULL,
  prediction TEXT NOT NULL,
  confidence REAL NOT NULL,
  processing_time TEXT NOT NULL DEFAULT '0.00 sec',
  threat_level TEXT NOT NULL DEFAULT 'Low',
  probabilities JSONB NOT NULL DEFAULT '{}',
  asset_type TEXT NOT NULL DEFAULT 'file',
  scan_date TIMESTAMPTZ NOT NULL DEFAULT now(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Index for fast querying by user and date
CREATE INDEX IF NOT EXISTS idx_scan_history_user_date ON scan_history(user_id, scan_date DESC);
CREATE INDEX IF NOT EXISTS idx_scan_history_prediction ON scan_history(prediction);

-- App settings table (one row per user)
CREATE TABLE IF NOT EXISTS app_settings (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id UUID UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
  use_mock_prediction BOOLEAN NOT NULL DEFAULT true,
  prediction_base_url TEXT NOT NULL DEFAULT 'https://bi-lstmcnn-production.up.railway.app',
  request_timeout_seconds INTEGER NOT NULL DEFAULT 30,
  save_scan_history BOOLEAN NOT NULL DEFAULT true,
  analytics_window_days INTEGER NOT NULL DEFAULT 7,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE scan_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_settings ENABLE ROW LEVEL SECURITY;

-- RLS Policies: users can only see their own data
CREATE POLICY "Users can view own scan history" ON scan_history
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own scan history" ON scan_history
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own scan history" ON scan_history
  FOR DELETE USING (auth.uid() = user_id);

CREATE POLICY "Users can view own settings" ON app_settings
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can upsert own settings" ON app_settings
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own settings" ON app_settings
  FOR UPDATE USING (auth.uid() = user_id);

-- Function to auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_app_settings_updated_at
  BEFORE UPDATE ON app_settings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();