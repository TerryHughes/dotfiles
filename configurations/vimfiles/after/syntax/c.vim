syntax keyword cOperator _PreventExecution InvalidCodePath InvalidDefaultCase Assert _StaticAssert3 _StaticAssert2 _StaticAssert1 StaticAssert NotImplemented NotSupported InvalidOperation DoNothing

syntax keyword cType u8_ u16_ u32_ u64_
syntax keyword cType u8x u16x u32x u64x
syntax keyword cType s8_ s16_ s32_ s64_
syntax keyword cType s8x s16x s32x s64x
syntax keyword cType          f32x f64x
syntax keyword cType b1x
syntax keyword cType e8_
syntax keyword cType e8x

syntax keyword cStorageClass internal global local

syntax keyword cConstant U8Minimum U16Minimum U32Minimum U64Minimum
syntax keyword cConstant U8Maximum U16Maximum U32Maximum U64Maximum
syntax keyword cConstant S8Minimum S16Minimum S32Minimum S64Minimum
syntax keyword cConstant S8Maximum S16Maximum S32Maximum S64Maximum
syntax keyword cConstant                      F32Minimum F64Minimum
syntax keyword cConstant                      F32Maximum F64Maximum


syntax match cNumber display "\<0b[01]\('\=[01]\+\)*\(u\=l\{0,2}\|ll\=u\)\>"
syntax match cNumber display "\<[1-9]\('\=\d\+\)*\(u\=l\{0,2}\|ll\=u\)\>" contains=cFloat
syntax match cNumber display "\<0x\x\('\=\x\+\)*\(u\=l\{0,2}\|ll\=u\)\>"

syntax match cInclude display "^\s*\zs\(%:\|#\)\s*include\>\s*preprocessor.\+" contains=cIncluded
