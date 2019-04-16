// RUN: %target-typecheck-verify-swift

@functionBuilder // expected-error {{'@functionBuilder' attribute cannot be applied to this declaration}}
var globalBuilder: Int

@functionBuilder // expected-error {{'@functionBuilder' attribute cannot be applied to this declaration}}
func globalBuilderFunction() -> Int { return 0 }

@functionBuilder
struct Maker {}

@functionBuilder
class Inventor {}

@Maker // expected-error {{function builder attribute 'Maker' can only be applied to a parameter}}
var global: Int

@Maker // expected-error {{function builder attribute 'Maker' can only be applied to a parameter}}
func globalFunction() {}

@Maker // expected-error {{function builder attribute 'Maker' can only be applied to a parameter}}
func globalFunctionWithFunctionParam(fn: () -> ()) {}

func makerParam(@Maker
                fn: () -> ()) {}

// FIXME: these diagnostics are reversed?
func makerParamRedundant(@Maker // expected-error {{only one function builder attribute can be attached to a parameter}}
                         @Maker // expected-note {{previous function builder specified here}}
                         fn: () -> ()) {}

func makerParamConflict(@Maker // expected-error {{only one function builder attribute can be attached to a parameter}}
                        @Inventor // expected-note {{previous function builder specified here}}
                        fn: () -> ()) {}

func makerParamExtra(@Maker(5) // expected-error {{function builder attributes cannot have arguments}}
                     fn: () -> ()) {}

