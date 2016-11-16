import Base.Libdl: dlopen, dlsym
libtest = dlopen("libtest1.so")

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

info("Setting C values using a Foo Julia object through pointers")
jobj = Foo(3, 3.14)
unsafe_store!(convert(Ptr{Foo}, voidfooptr), jobj)

info("Printing values from C")
ccall(dlsym(libtest, "print_foo"), Void, (Ptr{Void},), voidfooptr)

info("Julia object passed to C")
f = Foo(1, 3.0)
ccall(dlsym(libtest, "sum"), Float32, (Foo,), f)
