Twitter Snowflake ID configuration

A classic Twitter Snowflake ID is a 64‑bit signed integer with this layout (from most significant bit to least):
1 bit – sign bit
Always 0 (keeps IDs positive).
41 bits – timestamp
Milliseconds since a custom epoch (e.g., Twitter used 2010-11-04 UTC).
Gives about 69 years of unique timestamps.

10 bits – node identifier (Twitter’s original split)
5 bits – datacenter ID (0–31)
5 bits – worker/machine ID (0–31)
Total 2¹⁰ = 1024 unique workers (across all datacenters).
12 bits – sequence number
Per-node counter within the same millisecond.
Allows 2¹² = 4096 unique IDs per node per millisecond.
So overall: 1 + 41 + 5 + 5 + 12 = 64 bits, with the sign bit fixed to 0 in practice. -->
