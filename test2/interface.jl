import Base.Libdl: dlopen, dlsym
libtest = dlopen("libtest2.so")

voidfooptr = ccall(
    dlsym(libtest, "create_foo"),
    Ptr{Void}, (Int32, Float32), 1, 2.0
)

immutable Foo
    bar::Int32
    car::Float32
end

info("Loading from void ptr into Julia obj")
@show juliafoo = unsafe_load(convert(Ptr{Foo}, voidfooptr), 1)

info("Setting C values using a Foo Julia object")
jobj = Foo(3, 3.14)
unsafe_store!(convert(Ptr{Foo}, voidfooptr), jobj)

info("Printing values from C")
ccall(dlsym(libtest, "print_foo"), Void, (Ptr{Void},), voidfooptr)
