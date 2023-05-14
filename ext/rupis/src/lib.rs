mod entry;
mod error;
mod internal;

use magnus::{define_module, function, prelude::*};

fn start(server: magnus::Value) -> Result<(), Box<dyn std::error::Error>> {
    let rt = tokio::runtime::Runtime::new()?;
    let server = internal::InternalServer::new(server);
    rt.block_on(entry::main(server));
    Ok(())
}

#[magnus::init]
fn init() -> Result<(), magnus::Error> {
    let module = define_module("Rupis")?;
    module.define_singleton_method(
        "_start",
        function!(|server: magnus::Value| { start(server).is_ok() }, 1),
    )?;
    Ok(())
}
