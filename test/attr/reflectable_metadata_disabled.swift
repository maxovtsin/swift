// RUN: %target-swift-frontend -disable-reflection-metadata -typecheck %s -verify

// MARK: - Errors

@reflectable // expected-error {{reflection metadata emission must be enabled for modules with `@reflectable` declarations}}
protocol P {}

@reflectable // expected-error {{reflection metadata emission must be enabled for modules with `@reflectable` declarations}}
enum E {}

@reflectable // expected-error {{reflection metadata emission must be enabled for modules with `@reflectable` declarations}}
class C {}
