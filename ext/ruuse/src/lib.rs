mod entry;
mod error;

use magnus::Error;
use magnus::{define_module, function, prelude::*};

fn main() -> Result<(), Error> {
    entry::main();
    Ok(())
}

#[magnus::init]
fn init() -> Result<(), Error> {
    let module = define_module("Ruuse")?;
    module.define_singleton_method("start", function!(main, 0))?;
    Ok(())
}
