return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.add_snippets("cmake", {
      s("findpkg", {
        t("find_package("), i(1, "PackageName"), t(" REQUIRED)"), t({"", ""}),
        t("target_link_libraries("), i(2, "target"), t(" ${"), i(3, "PackageName"), t("_LIBRARIES})")
      }),
      
      s("findpkgcomp", {
        t("find_package("), i(1, "PackageName"), t(" REQUIRED COMPONENTS "), i(2, "component"), t(")"), t({"", ""}),
        t("target_link_libraries("), i(3, "target"), t(" ${"), i(4, "PackageName"), t("_LIBRARIES})")
      }),

      s("opencv", {
        t({"find_package(OpenCV REQUIRED)", ""}),
        t("target_link_libraries("), i(1, "target"), t(" ${OpenCV_LIBS})")
      }),

      s("boost", {
        t({"find_package(Boost REQUIRED COMPONENTS "}), i(1, "system filesystem"), t({")",""}),
        t("target_link_libraries("), i(2, "target"), t(" ${Boost_LIBRARIES})")
      }),

      s("qt5", {
        t({"find_package(Qt5 REQUIRED COMPONENTS "}), i(1, "Core Widgets"), t({")",""}),
        t("target_link_libraries("), i(2, "target"), t(" Qt5::Core Qt5::Widgets)")
      }),

      s("pthread", {
        t({"find_package(Threads REQUIRED)", ""}),
        t("target_link_libraries("), i(1, "target"), t(" Threads::Threads)")
      }),

      s("pkgconfig", {
        t({"find_package(PkgConfig REQUIRED)", ""}),
        t("pkg_check_modules("), i(1, "VAR"), t(" REQUIRED "), i(2, "package"), t(")"), t({"", ""}),
        t("target_link_libraries("), i(3, "target"), t(" ${"), i(4, "VAR"), t("_LIBRARIES})")
      }),

      s("feature", {
        t("option("), i(1, "FEATURE_NAME"), t(" \""), i(2, "Description"), t("\" "), i(3, "OFF"), t(")"), t({"", ""}),
        t({"if(${"}), i(4, "FEATURE_NAME"), t({"})",""}),
        t("    "), i(5, "# Feature code here"), t({"", ""}),
        t("endif()")
      }),

      s("addexe", {
        t("add_executable("), i(1, "target"), t(" "), i(2, "main.cpp"), t(")"), t({"", ""}),
        t("target_link_libraries("), i(3, "target"), t(" "), i(4, "libraries"), t(")")
      }),

      s("addlib", {
        t("add_library("), i(1, "libname"), t(" "), i(2, "STATIC"), t(" "), i(3, "source.cpp"), t(")"), t({"", ""}),
        t("target_include_directories("), i(4, "libname"), t(" PUBLIC "), i(5, "include/"), t(")")
      }),
    })

    ls.add_snippets("c", {
      -- === PREPROCESSOR DIRECTIVES (COMPLETE) ===
      -- File inclusion
      s("#include", { t("#include <"), i(1, "stdio.h"), t(">") }),
      s("#inc", { t("#include <"), i(1, "stdio.h"), t(">") }),
      s("#incl", { t("#include \""), i(1, "header.h"), t("\"") }),
      
      -- Macro definition
      s("#define", { t("#define "), i(1, "NAME"), t(" "), i(2, "value") }),
      s("#def", { t("#define "), i(1, "NAME"), t(" "), i(2, "value") }),
      s("#undef", { t("#undef "), i(1, "NAME") }),
      
      -- Conditional compilation
      s("#if", { t("#if "), i(1, "condition"), t({"", ""}), i(2), t({"", "#endif"}) }),
      s("#ifdef", { t("#ifdef "), i(1, "MACRO"), t({"", ""}), i(2), t({"", "#endif"}) }),
      s("#ifndef", { t("#ifndef "), i(1, "MACRO"), t({"", ""}), i(2), t({"", "#endif"}) }),
      s("#else", { t("#else") }),
      s("#elif", { t("#elif "), i(1, "condition") }),
      s("#endif", { t("#endif") }),
      s("#elifdef", { t("#elifdef "), i(1, "MACRO") }),
      s("#elifndef", { t("#elifndef "), i(1, "MACRO") }),
      
      -- Diagnostics
      s("#error", { t("#error \""), i(1, "Error message"), t("\"") }),
      s("#warning", { t("#warning \""), i(1, "Warning message"), t("\"") }),
      
      -- Line control
      s("#line", { t("#line "), i(1, "100"), t(" \""), i(2, "filename.c"), t("\"") }),
      
      -- Pragma directives
      s("#pragma", { t("#pragma "), i(1, "once") }),
      s("#pragma once", { t("#pragma once") }),
      s("#pragmaonce", { t("#pragma once") }),
      s("#pragma message", { t("#pragma message(\""), i(1, "message"), t("\")") }),
      s("#pragma warning", { t("#pragma warning("), i(1, "disable"), t(": "), i(2, "4996"), t(")") }),
      s("#pragma pack", { t("#pragma pack("), i(1, "push, 1"), t(")") }),
      s("#pragma region", { t("#pragma region "), i(1, "RegionName") }),
      s("#pragma endregion", { t("#pragma endregion") }),
      
      -- Null directive
      s("#", { t("#") }),
      
      -- === COMMON PATTERNS ===
      -- Header guard (complete)
      s("guard", { t("#ifndef "), i(1, "HEADER_H"), t({"", "#define "}), i(2, "HEADER_H"), t({"", "", ""}), i(3), t({"", "", "#endif /* "}), i(4, "HEADER_H"), t(" */") }),
      s("headerguard", { t("#ifndef "), i(1, "HEADER_H"), t({"", "#define "}), i(2, "HEADER_H"), t({"", "", ""}), i(3), t({"", "", "#endif /* "}), i(4, "HEADER_H"), t(" */") }),
      
      -- Pragma once header
      s("onceguard", { t({"#pragma once", "", ""}), i(1) }),
      
      -- Debug macro
      s("#debug", { t({"#ifdef DEBUG", ""}), i(1, "printf(\"Debug: %s\\n\", msg);"), t({"", "#endif"}) }),
      
      -- Platform detection
      s("#ifwin", { t({"#ifdef _WIN32", ""}), i(1), t({"", "#endif"}) }),
      s("#iflinux", { t({"#ifdef __linux__", ""}), i(1), t({"", "#endif"}) }),
      s("#ifmacos", { t({"#ifdef __APPLE__", ""}), i(1), t({"", "#endif"}) }),
      s("#ifunix", { t({"#if defined(__unix__) || defined(__APPLE__)", ""}), i(1), t({"", "#endif"}) }),
      
      -- Extern C for C++
      s("#externc", { t({"#ifdef __cplusplus", "extern \"C\" {", "#endif", "", ""}), i(1), t({"", "", "#ifdef __cplusplus", "}", "#endif"}) }),
      
      -- Function-like macro
      s("#defmacro", { t("#define "), i(1, "MACRO"), t("("), i(2, "x"), t(") "), i(3, "((x) * 2)") }),
      
      -- Multi-line macro
      s("#defmulti", { t("#define "), i(1, "MACRO"), t("("), i(2, "x"), t({") \\", "\tdo { \\", "\t\t"}), i(3), t({" \\", "\t} while(0)"}) }),
      
      -- Stringify and concatenate
      s("#stringify", { t("#define STRINGIFY(x) #x") }),
      s("#concat", { t("#define CONCAT(a, b) a##b") }),
      
      -- === CODE SNIPPETS ===
      s("inc", { t("#include <"), i(1, "stdio.h"), t(">") }),
      s("incl", { t("#include \""), i(1, "header.h"), t("\"") }),
      s("main", { t({"int main(int argc, char *argv[])", "{", "\t"}), i(1, "return 0;"), t({"", "}"}) }),
      s("mainsimple", { t({"int main(void)", "{", "\t"}), i(1, "return 0;"), t({"", "}"}) }),
      s("for", { t("for ("), i(1, "int i = 0"), t("; "), i(2, "i < n"), t("; "), i(3, "i++"), t(") {"), t({"", "\t"}), i(4), t({"", "}"}) }),
      s("if", { t("if ("), i(1, "condition"), t(") {"), t({"", "\t"}), i(2), t({"", "}"}) }),
      s("ife", { t("if ("), i(1, "condition"), t(") {"), t({"", "\t"}), i(2), t({"", "} else {", "\t"}), i(3), t({"", "}"}) }),
      s("struct", { t("struct "), i(1, "name"), t(" {"), t({"", "\t"}), i(2), t({"", "};"}) }),
      s("typedef", { t("typedef "), i(1, "int"), t(" "), i(2, "MyType"), t(";") }),
      s("typedefstruct", { t("typedef struct "), i(1, "name"), t(" {"), t({"", "\t"}), i(2), t({"", "} "}), i(3, "Name"), t(";") }),
      s("enum", { t("enum "), i(1, "name"), t(" {"), t({"", "\t"}), i(2, "VALUE1,"), t({"", "};"}) }),
      s("union", { t("union "), i(1, "name"), t(" {"), t({"", "\t"}), i(2), t({"", "};"}) }),
      s("while", { t("while ("), i(1, "condition"), t(") {"), t({"", "\t"}), i(2), t({"", "}"}) }),
      s("dowhile", { t({"do {", "\t"}), i(1), t({"", "} while ("}), i(2, "condition"), t(");") }),
      s("switch", { t("switch ("), i(1, "var"), t(") {"), t({"", "case "}), i(2, "val"), t(":"), t({"", "\t"}), i(3), t({"", "\tbreak;", "default:", "\t"}), i(4), t({"", "}"}) }),
      s("func", { i(1, "void"), t(" "), i(2, "name"), t("("), i(3), t(") {"), t({"", "\t"}), i(4), t({"", "}"}) }),
      s("printf", { t("printf(\""), i(1, "%s\\n"), t("\", "), i(2, "var"), t(");") }),
      s("fprintf", { t("fprintf("), i(1, "stderr"), t(", \""), i(2, "%s\\n"), t("\", "), i(3, "var"), t(");") }),
      s("scanf", { t("scanf(\""), i(1, "%d"), t("\", &"), i(2, "var"), t(");") }),
      s("malloc", { t("("), i(1, "type"), t(" *)malloc("), i(2, "n"), t(" * sizeof("), i(3, "type"), t("));") }),
      s("calloc", { t("("), i(1, "type"), t(" *)calloc("), i(2, "n"), t(", sizeof("), i(3, "type"), t("));") }),
      s("realloc", { t("("), i(1, "type"), t(" *)realloc("), i(2, "ptr"), t(", "), i(3, "n"), t(" * sizeof("), i(4, "type"), t("));") }),
      s("free", { t("free("), i(1, "ptr"), t(");") }),
      s("sizeof", { t("sizeof("), i(1, "type"), t(")") }),
      s("nullptr", { t("NULL") }),
    })

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
