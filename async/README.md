# Asynchronous Programming
In Julia, the concept of coroutines is coined in a different term/keyword: `Task`.
It is just a difference in naming, the concept being referred to is the same as in
Python, Javascript, etc.

There are at least two differences btw a `Task` and a function call.

1. _"switching tasks does not use any space, so any number of task switches can occur without consuming the call stack."_ -- Julia community
2. _"switching among tasks can occur in any order, unlike function calls, where the called function must finish executing before control returns to the calling function."_ -- Julia community


## Basic Usage of `Task`
The following creates a coroutine (without having it run yet).
```julia
julia> t = @task begin; sleep(5); println("done"); end
Task (runnable) @0x00007f13a40c0eb0
```

**N.B.**
- `@task x` is equivalent to `Task(()->x)`.<br>
  In other words, the above is equiv. to
  ```julia
  julia> t = Task(()->begin; sleep(5); println("done"); end)
  Task (runnable) @0x00007f6259051cd0
  ```
- It seems that `Task` only accepts a 0-argument function like
  ```julia
  julia> a() = sum(i for i in 1:1000)
  a (generic function with 1 method)
  
  julia> b = Task(a)
  Task (runnable) @0x00007f625aad6e10
  
  julia> a1(n) = sum(i for i in 1:n)
  a1 (generic function with 1 method)
  
  julia> b1 = Task(a1)
  Task (runnable) @0x00007f625aad7260
  
  julia> b.result
  
  julia> b.code
  a (generic function with 1 method)
  
  julia> b._state
  0x00
  
  julia> schedule(b)
  Task (done) @0x00007f625aad6e10
  
  julia> b.result
  500500
  
  julia> b.code
  a (generic function with 1 method)
  
  julia> b._state
  0x01
  
  julia> schedule(b1)
  Task (failed) @0x00007f625aad7260
  MethodError: no method matching a1()
  Closest candidates are:
    a1(::Any) at REPL[55]:1
  
  julia>
  ```
  - It is true that a `Task` accepts only 0-arg function as its input, but Julia also provides a workaround for this, e.g. using anonymous functions
    ```julia
    julia> a1(n) = sum(i for i in 1:n)
    a1 (generic function with 1 method)
    
    julia> b1 = Task(() -> a1(10))
    Task (runnable) @0x00007f625a100740
    
    julia> schedule(b1)
    Task (done) @0x00007f625a100740
    
    julia> b1.result
    55
    ```

To have a coroutine run in Julia, use the `schedule` function.
Using the same coroutine `t` above, if we run `schedule(t)`, we
will see
```julia
julia> schedule(t)
Task (runnable) @0x00007f13a40c0eb0
```
and Julia gives the control back to the prompt, i.e. you, immediately, and,
five seconds later, stdout prints `"done"`. Having obtain the control,
you can ask Julia to do sth else while waiting for `t` to complete.

**N.B.** If you want the coroutine `t` to run again, you cannot do it by simply
running `schedule(t)` again. Indeed,
```julia
julia> schedule(t)
ERROR: schedule: Task not runnable
Stacktrace:
 [1] error(s::String)
   @ Base ./error.jl:33
 [2] enq_work(t::Task)
   @ Base ./task.jl:628
 [3] schedule(t::Task)
   @ Base ./task.jl:663
 [4] top-level scope
   @ REPL[28]:1

```

This is because a coroutine can only be run once. Put in another way,
each coroutine has a state,

- when the state is `done`, we cannot `schedule` it
- when the state is `runnable`, we can `schedule` it

I think this is why a coroutine is also known, among many other names, as a  _one-shot continuation_.
```julia
julia> t
Task (done) @0x00007f6259052290

julia> schedule(t)
ERROR: schedule: Task not runnable
Stacktrace:
 [1] error(s::String)
   @ Base ./error.jl:33
 [2] enq_work(t::Task)
   @ Base ./task.jl:628
 [3] schedule(t::Task)
   @ Base ./task.jl:663
 [4] top-level scope
   @ REPL[28]:1

julia> t = Task(()->begin; sleep(5); println("done"); end)
Task (runnable) @0x00007f62590529c0

julia> t
Task (runnable) @0x00007f62590529c0

julia> istaskstarted(t)
false

julia> istaskdone(t)
false

julia> schedule(t)
Task (runnable) @0x00007f62590529c0

julia> istaskstarted(t)
true

julia> istaskdone(t)
false

julia> done
julia> istaskstarted(t)
true

julia> istaskdone(t)
true
```

We can also ask Julia to **block** until a coroutine completes by
using the `wait` function.
```julia
julia> t = @task begin; sleep(5); println("done"); end
Task (runnable) @0x00007f13a40c0eb0

julia> schedule(t); wait(t)
pwd()
done

julia> pwd()
"/home/phunc20"

julia>
```
As you can see, this time, despite the fact that we have asked Julia for `pwd()`,
it waits until after `t` prints `done` to execute `pwd()`.

Since it is some common that one schedules a task right after creating it, Julia
provides a convenient macro which does just that -- `@async x` is equiv. to `schedule(@task x)`
```julia
julia> @async begin; sleep(5); println("done"); end
Task (runnable) @0x00007f625aab3c70

julia> pwd()
"/home/phunc20"

julia> done
```
