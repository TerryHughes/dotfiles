syntax keyword cOperator _PreventExecution InvalidCodePath InvalidDefaultCase Assert _StaticAssert3 _StaticAssert2 _StaticAssert1 StaticAssert NotImplemented NotSupported InvalidOperation DoNothing
syntax keyword cOperator nameof

syntax keyword cType u8 u16 u32 u64
syntax keyword cType s8 s16 s32 s64
syntax keyword cType        f32 f64
syntax keyword cType b8
syntax keyword cType memory_index offsetof
syntax keyword cType buffer

syntax keyword cType u8_ u16_ u32_ u64_ u24_
syntax keyword cType u8x u16x u32x u64x
syntax keyword cType s8_ s16_ s32_ s64_
syntax keyword cType s8x s16x s32x s64x
syntax keyword cType          f32x f64x
syntax keyword cType b1x
syntax keyword cType e8_
syntax keyword cType e8x
syntax keyword cType c8x
syntax keyword cType string
syntax keyword cType color
syntax keyword cType umm
syntax keyword cType v2 v3 v4
syntax keyword cType m4x4

syntax keyword cStorageClass internal global local

syntax keyword cConstant U8Minimum U16Minimum U32Minimum U64Minimum
syntax keyword cConstant U8Maximum U16Maximum U32Maximum U64Maximum
syntax keyword cConstant S8Minimum S16Minimum S32Minimum S64Minimum
syntax keyword cConstant S8Maximum S16Maximum S32Maximum S64Maximum
syntax keyword cConstant                      F32Minimum F64Minimum
syntax keyword cConstant                      F32Maximum F64Maximum

syntax keyword cNumber null nullptr
syntax match cNumber display "\<0b[01]\('\=[01]\+\)*\(u\=l\{0,2}\|ll\=u\)\>"
syntax match cNumber display "\<[1-9]\('\=\d\+\)*\(u\=l\{0,2}\|ll\=u\)\>" contains=cFloat
syntax match cNumber display "\<0x\x\('\=\x\+\)*\(u\=l\{0,2}\|ll\=u\)\>"

syntax match cInclude display "^\s*\zs\(%:\|#\)\s*include\>\s*preprocessor.\+" contains=cIncluded

syntax keyword Ignore UNUSED_PARAMETER UNUSED_RETURN_VALUE
