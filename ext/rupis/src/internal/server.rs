use crate::internal::ast::Node;

#[derive(Debug)]
pub struct InternalServer {
    pub value: magnus::Value,
}

impl InternalServer {
    pub fn new(value: magnus::Value) -> Self {
        Self { value }
    }

    pub fn parse(&self, text: &str) -> Result<Node, InternalServerError> {
        let parsed: String =
            self.value
                .funcall("parse", (text,))
                .map_err(|e| InternalServerError {
                    message: format!("Failed to call parse function: {}", e),
                })?;
        let node: Node = serde_json::from_str(&parsed).map_err(|e| InternalServerError {
            message: format!("Failed to parse JSON: {}", e),
        })?;
        Ok(node)
    }
}

#[derive(Debug)]
pub struct InternalServerError {
    pub message: String,
}
