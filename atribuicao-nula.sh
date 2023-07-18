#!/usr/bin/env bash

var=https://debxp.org/cbpb
: ${var#*//}
dom=${_%/*}
echo $dom
