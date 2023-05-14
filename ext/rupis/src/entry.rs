use tower_lsp::jsonrpc::Result as RpcResult;
use tower_lsp::lsp_types::*;
use tower_lsp::{Client, LanguageServer, LspService, Server};

use crate::internal::InternalServer;

#[derive(Debug)]
struct Backend {
    client: Client,
    internal: InternalServer,
}

#[tower_lsp::async_trait]
impl LanguageServer for Backend {
    async fn initialize(&self, _: InitializeParams) -> RpcResult<InitializeResult> {
        Ok(InitializeResult::default())
    }

    async fn initialized(&self, _: InitializedParams) {
        self.client
            .log_message(MessageType::INFO, "server initialized!")
            .await;
    }

    async fn did_open(&self, params: DidOpenTextDocumentParams) {
        self.client
            .log_message(MessageType::INFO, format!("file opened: {:#?}", params))
            .await;
        let text = params.text_document.text;
        let parsed = match self.internal.parse(&text) {
            Ok(node) => node,
            Err(e) => {
                self.client
                    .log_message(MessageType::ERROR, format!("error: {:#?}", e))
                    .await;
                return;
            }
        };
        println!("{:#?}", parsed);
    }

    async fn shutdown(&self) -> RpcResult<()> {
        Ok(())
    }
}

pub async fn main(internal: InternalServer) {
    let stdin = tokio::io::stdin();
    let stdout = tokio::io::stdout();

    let (service, socket) = LspService::new(|client| Backend { client, internal });
    Server::new(stdin, stdout, socket).serve(service).await;
}

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
