# Enabled history in erl-shell

Since OTP 22 - this has become very easy:

```
export ERL_AFLAGS="-kernel shell_history enabled"
```

Add that to your .bashrc/.profile.

