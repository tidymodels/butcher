# Generate expected UI messages

    Code
      assess_object(big, small)
    Message
      v Memory released: <redacted>
    Code
      assess_object(small, small)
    Message
      x No memory released. Do not butcher.
    Code
      assess_object(small, big)
    Message
      x The butchered object is <redacted> larger than the original. Do not butcher.

