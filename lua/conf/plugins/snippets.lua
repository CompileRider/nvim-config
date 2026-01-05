-- Rust snippets
return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.add_snippets("rust", {
      -- Main functions
      s("main", { t({"fn main() {", "    "}), i(1), t({"", "}"}) }),
      s("mainasync", { t({"#[tokio::main]", "async fn main() {", "    "}), i(1), t({"", "}"}) }),
      -- Functions
      s("fn", { t("fn "), i(1, "name"), t("("), i(2), t(") "), i(3, ""), t(" {"), t({"", "    "}), i(4), t({"", "}"}) }),
      s("fnpub", { t("pub fn "), i(1, "name"), t("("), i(2), t(") "), i(3, ""), t(" {"), t({"", "    "}), i(4), t({"", "}"}) }),
      s("fnasync", { t("async fn "), i(1, "name"), t("("), i(2), t(") "), i(3, ""), t(" {"), t({"", "    "}), i(4), t({"", "}"}) }),
      -- Structs
      s("struct", { t("struct "), i(1, "Name"), t(" {"), t({"", "    "}), i(2), t({"", "}"}) }),
      s("structpub", { t("pub struct "), i(1, "Name"), t(" {"), t({"", "    pub "}), i(2), t({"", "}"}) }),
      -- Enums
      s("enum", { t("enum "), i(1, "Name"), t(" {"), t({"", "    "}), i(2), t({"", "}"}) }),
      s("enumpub", { t("pub enum "), i(1, "Name"), t(" {"), t({"", "    "}), i(2), t({"", "}"}) }),
      -- Impl
      s("impl", { t("impl "), i(1, "Type"), t(" {"), t({"", "    "}), i(2), t({"", "}"}) }),
      s("implfor", { t("impl "), i(1, "Trait"), t(" for "), i(2, "Type"), t(" {"), t({"", "    "}), i(3), t({"", "}"}) }),
      -- Traits
      s("trait", { t("trait "), i(1, "Name"), t(" {"), t({"", "    "}), i(2), t({"", "}"}) }),
      -- Derives
      s("derive", { t("#[derive("), i(1, "Debug, Clone"), t(")]") }),
      s("derivefull", { t("#[derive(Debug, Clone, PartialEq, Eq, Hash)]") }),
      s("deriveserde", { t("#[derive(Debug, Clone, Serialize, Deserialize)]") }),
      -- Tests
      s("test", { t({"#[test]", "fn "}), i(1, "test_name"), t({"() {", "    "}), i(2), t({"", "}"}) }),
      s("testmod", { t({"#[cfg(test)]", "mod tests {", "    use super::*;", "", "    #[test]", "    fn "}), i(1, "test_name"), t({"() {", "        "}), i(2), t({"", "    }", "}"}) }),
      -- Macros
      s("println", { t("println!(\""), i(1, "{}"), t("\", "), i(2), t(");") }),
      s("eprintln", { t("eprintln!(\""), i(1, "{}"), t("\", "), i(2), t(");") }),
      s("dbg", { t("dbg!("), i(1), t(");") }),
      s("format", { t("format!(\""), i(1, "{}"), t("\", "), i(2), t(")") }),
      s("vec", { t("vec!["), i(1), t("]") }),
      s("todo", { t("todo!(\""), i(1), t("\")") }),
      s("unimplemented", { t("unimplemented!(\""), i(1), t("\")") }),
      -- Result/Option
      s("ok", { t("Ok("), i(1), t(")") }),
      s("err", { t("Err("), i(1), t(")") }),
      s("some", { t("Some("), i(1), t(")") }),
      s("none", { t("None") }),
      -- Match
      s("match", { t("match "), i(1, "expr"), t(" {"), t({"", "    "}), i(2, "pattern"), t(" => "), i(3), t(","), t({"", "}"}) }),
      s("matchopt", { t("match "), i(1, "opt"), t({" {", "    Some("}), i(2, "val"), t({") => {},", "    None => {},", "}"}) }),
      s("matchres", { t("match "), i(1, "res"), t({" {", "    Ok("}), i(2, "val"), t({") => {},", "    Err(e) => {},", "}"}) }),
      -- Control flow
      s("if", { t("if "), i(1, "cond"), t(" {"), t({"", "    "}), i(2), t({"", "}"}) }),
      s("iflet", { t("if let "), i(1, "Some(x)"), t(" = "), i(2, "expr"), t(" {"), t({"", "    "}), i(3), t({"", "}"}) }),
      s("for", { t("for "), i(1, "item"), t(" in "), i(2, "iter"), t(" {"), t({"", "    "}), i(3), t({"", "}"}) }),
      s("while", { t("while "), i(1, "cond"), t(" {"), t({"", "    "}), i(2), t({"", "}"}) }),
      s("loop", { t({"loop {", "    "}), i(1), t({"", "}"}) }),
      -- Closures
      s("closure", { t("|"), i(1), t("| "), i(2) }),
      s("closuremove", { t("move |"), i(1), t("| "), i(2) }),
      -- Attributes
      s("allow", { t("#[allow("), i(1, "unused"), t(")]") }),
      s("deny", { t("#[deny("), i(1, "warnings"), t(")]") }),
      s("cfg", { t("#[cfg("), i(1, "feature = \"default\""), t(")]") }),
      s("cfgtest", { t("#[cfg(test)]") }),
      -- Use
      s("use", { t("use "), i(1, "std::"), i(2), t(";") }),
      s("usecrate", { t("use crate::"), i(1), t(";") }),
      s("usesuper", { t("use super::"), i(1), t(";") }),
      -- Modules
      s("mod", { t("mod "), i(1, "name"), t(";") }),
      s("modpub", { t("pub mod "), i(1, "name"), t(";") }),
      s("modinline", { t("mod "), i(1, "name"), t(" {"), t({"", "    "}), i(2), t({"", "}"}) }),
    })

    -- Cargo.toml snippets
    ls.add_snippets("toml", {
      s("dep", { i(1, "crate"), t(" = \""), i(2, "1.0"), t("\"") }),
      s("depfeat", { i(1, "crate"), t(" = { version = \""), i(2, "1.0"), t("\", features = [\""), i(3), t("\"] }") }),
      s("tokio", { t("tokio = { version = \"1\", features = [\"full\"] }") }),
      s("serde", { t("serde = { version = \"1\", features = [\"derive\"] }") }),
      s("anyhow", { t("anyhow = \"1\"") }),
      s("thiserror", { t("thiserror = \"1\"") }),
      s("clap", { t("clap = { version = \"4\", features = [\"derive\"] }") }),
      s("tracing", { t("tracing = \"0.1\"") }),
    })

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
