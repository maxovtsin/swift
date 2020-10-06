// RUN: %target-swift-frontend -enable-opt-in-reflection-metadata -emit-ir %s | %FileCheck %s

// reflection metadata associated type descriptor opt_in_reflection_metadata.Conformance : opt_in_reflection_metadata.RefProtocol in opt_in_reflection_metadata
// CHECK-DAG: @"$s26opt_in_reflection_metadata11ConformanceVAA11RefProtocolAAMA" = internal constant {{.*}} section "{{[^"]*swift5_assocty|.sw5asty\$B}}

// reflection metadata field descriptor opt_in_reflection_metadata.RefProtocol
// CHECK-DAG: @"$s26opt_in_reflection_metadata11RefProtocol_pMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// CHECK-DAG: @"$s26opt_in_reflection_metadata12RefProtocol2_pMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// reflection metadata field descriptor opt_in_reflection_metadata.Conformance
// CHECK-DAG: @"$s26opt_in_reflection_metadata11ConformanceVMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// reflection metadata field descriptor opt_in_reflection_metadata.RefStruct
// CHECK-DAG: @"$s26opt_in_reflection_metadata9RefStructVMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// reflection metadata field descriptor opt_in_reflection_metadata.RefEnum
// CHECK-DAG: @"$s26opt_in_reflection_metadata7RefEnumOMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// reflection metadata field descriptor opt_in_reflection_metadata.RefClass
// CHECK-DAG: @"$s26opt_in_reflection_metadata8RefClassCMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// reflection metadata field descriptor opt_in_reflection_metadata.RefClassChild
// CHECK-DAG: @"$s26opt_in_reflection_metadata13RefClassChildCMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// reflection metadata field descriptor opt_in_reflection_metadata.RefGenericClass
// CHECK-DAG: @"$s26opt_in_reflection_metadata15RefGenericClassCMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// reflection metadata field descriptor opt_in_reflection_metadata.NonRefProtocol
// CHECK-NOT: @"$s26opt_in_reflection_metadata14NonRefProtocol_pMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}
// reflection metadata field descriptor opt_in_reflection_metadata.NonRefStruct
// CHECK-NOT: @"$s26opt_in_reflection_metadata12NonRefStructVMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}
// reflection metadata field descriptor opt_in_reflection_metadata.NonRefGenericStruct
// CHECK-NOT: @"$s26opt_in_reflection_metadata19NonRefGenericStructVMF" = internal constant {{.*}} section "{{[^"]*swift5_fieldmd|.sw5flmd\$B}}

// CHECK-DAG: @__swift_reflection_version = linkonce_odr hidden constant i16 {{[0-9]+}}

// associated type descriptor for opt_in_reflection_metadata.RefProtocol.RefInner
// CHECK-DAG: @"$s8RefInner26opt_in_reflection_metadata0A8ProtocolPTl" =
// associated type descriptor for opt_in_reflection_metadata.NonRefProtocol.NonRefInner
// CHECK-DAG: @"$s11NonRefInner26opt_in_reflection_metadata0aB8ProtocolPTl" =

@reflectable
public protocol RefProtocol {
  associatedtype RefInner
  var inner: RefInner { get }
}

public protocol RefProtocol2: RefProtocol {}

public struct Conformance: RefProtocol {
  public var inner: Int = 0
}

@reflectable
public struct RefStruct {
  let i: Int
  let rc: RefClass
  let re: RefEnum
}

@reflectable
public enum RefEnum {
  case C(RefClass)
  indirect case S(RefStruct)
  indirect case E(RefEnum)
  case I(Int)
}

@reflectable
public class RefClass {
  let i: Int
  
  public init(i: Int) {
    self.i = i
  }
}

public class RefClassChild: RefClass {
  let y: Int
  
  public init(y: Int) {
    self.y = y
    super.init(i: y)
  }
}

public class RefGenericClass<T>: RefProtocol2 {
  public let inner: T

  public init(inner: T) {
    self.inner = inner
  }
}

public protocol NonRefProtocol {
  associatedtype NonRefInner
  var inner: NonRefInner { get }
}

@reflectable
public protocol RefProtocol3 {}

public struct NonRefStruct {
  let i: Int
  let y: RefProtocol3
}

public struct NonRefGenericStruct<T: RefProtocol> {
  let inner: T
  let i: RefProtocol3
}
