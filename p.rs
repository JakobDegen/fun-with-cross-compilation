#![crate_type = "proc-macro"]

extern crate proc_macro;

#[proc_macro]
pub fn identity(x: proc_macro::TokenStream) -> proc_macro::TokenStream {
    x
}
