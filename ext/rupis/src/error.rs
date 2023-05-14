use magnus::Error;

pub fn new(message: &str) -> Error {
    magnus::Error::new(magnus::exception::runtime_error(), message.to_string())
}

pub fn internal(message: &str) -> Error {
    magnus::Error::new(magnus::exception::runtime_error(), message.to_string())
}
