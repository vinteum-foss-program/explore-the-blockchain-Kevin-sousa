# How many new outputs were created by block 123,456?
#!/bin/bash
BLOCK_NUMBER=123456

BLOCK_HASH=$(bitcoin-cli getblockhash $BLOCK_NUMBER)

TXIDS=$(bitcoin-cli getblock $BLOCK_HASH | jq -r '.tx[]')

TOTAL_OUTPUTS=0

for TXID in $TXIDS; do
  OUTPUT_COUNT=$(bitcoin-cli getrawtransaction $TXID true | jq '.vout | length')
  TOTAL_OUTPUTS=$((TOTAL_OUTPUTS + OUTPUT_COUNT))
done

echo $TOTAL_OUTPUTS
