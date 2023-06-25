use std::io::Write;

fn main() {
  let data = std::io::read_to_string(std::io::stdin())
    .expect("failed to read from stdin");
  let (json, key) = keyvalues_serde::from_str_with_key::<
    serde_json::Map<String, serde_json::Value>,
  >(&data)
  .expect("failed to deserialize VDF");
  let json = serde_json::json!({ key: json });
  let json = serde_json::to_string(&json).expect("failed to serialize to JSON");

  std::io::stdout()
    .write_all(json.as_bytes())
    .expect("failed to write JSON to stdout");
}
