use serde::Deserialize;

#[derive(Debug)]
pub struct Location {
    pub start_line: usize,
    pub start_column: usize,
    pub end_line: usize,
    pub end_column: usize,
}

impl<'de> Deserialize<'de> for Location {
    fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
    where
        D: serde::Deserializer<'de>,
    {
        let location: (usize, usize, usize, usize) = serde::Deserialize::deserialize(deserializer)?;
        Ok(Self {
            start_line: location.0,
            start_column: location.1,
            end_line: location.2,
            end_column: location.3,
        })
    }
}

#[derive(Debug, Deserialize)]
#[serde(tag = "type")]
pub enum Node {
    #[serde(rename = "program")]
    Program(Program),
    #[serde(rename = "statements")]
    Statements(Statements),
    #[serde(rename = "comment")]
    Comment(Comment),
    #[serde(rename = "command")]
    Command(Command),
    #[serde(rename = "arguments")]
    Arguments(Arguments),
    #[serde(rename = "ident")]
    Ident(Ident),
    #[serde(rename = "void_stmt")]
    VoidStmt(VoidStmt),
    #[serde(rename = "string_literal")]
    StringLiteral(StringLiteral),
}

#[derive(Debug, Deserialize)]
pub struct Program {
    pub location: Location,
    pub statements: Statements,
}
#[derive(Debug, Deserialize)]
pub struct Statements {
    pub location: Location,
    pub body: Vec<Node>,
}

#[derive(Debug, Deserialize)]
pub struct Comment {
    pub location: Location,
    pub value: String,
}

#[derive(Debug, Deserialize)]
pub struct Command {
    pub location: Location,
    pub message: Box<Node>,
    pub arguments: Arguments,
}

#[derive(Debug, Deserialize)]
pub struct Arguments {
    pub location: Location,
    pub parts: Vec<Node>,
}

#[derive(Debug, Deserialize)]
pub struct Ident {
    pub location: Location,
    pub value: String,
}

#[derive(Debug, Deserialize)]
pub struct VoidStmt {
    pub location: Location,
}

#[derive(Debug, Deserialize)]
pub struct StringLiteral {
    pub location: Location,
    pub parts: Vec<StringLiteralPart>,
}

#[derive(Debug, Deserialize)]
#[serde(tag = "type")]
pub enum StringLiteralPart {
    #[serde(rename = "tstring_content")]
    TStringContent(TStringContent),
    #[serde(rename = "string_embexpr")]
    StringEmbExpr(StringEmbExpr),
}

#[derive(Debug, Deserialize)]
pub struct TStringContent {
    pub location: Location,
    pub value: String,
}

#[derive(Debug, Deserialize)]
pub struct StringEmbExpr {
    pub location: Location,
    pub statements: Statements,
}


