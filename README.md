# Bug Demonstration

I've found a bug that I can't figure out.
This repo is a minimal example to reproduce it.
There is a test that repeats the same thing 1000 times and sometimes
`Regex.split` does not properly split the string.
I tried to strip the project as much as I can but if I tried to remove anything more,
it magically started to work normally.

## To reproduce

To test I recommend using bash loop like `while mix test; do done`.
For me it fails every 4-5 runs.

On a failed test, you can see output like this:

```
STR: "10.00 EUR"
LST: ["10.00", "EUR"]
VALUE: "10.00"
STR: "10.00 EUR"
LST: ["10.00", "EUR"]
VALUE: "10.00"
STR: "10.00 EUR"
LST: ["10.00 EUR"]
VALUE: ""
```

Last line indicates that at this particular moment Regex.split did not split the string.

## Elixir versions

I specified Elixir 1.10.4 and Erlang OTP 23. But it works the same on Elirix 1.11.4
Looks like it disappears in version 1.12.0
