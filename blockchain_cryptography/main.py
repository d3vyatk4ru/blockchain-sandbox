import cryptos

valid_private_key = False

while not valid_private_key:
    # 16-bit number (hex)
    private_key = cryptos.random_key()
    # transfer to 10-bit number
    decoded_private_key = cryptos.decode_privkey(private_key, 'hex')
    valid_private_key = 0 < decoded_private_key < cryptos.N

# transfer to base 58 format
wif_encoded_private_key = cryptos.encode_privkey(decoded_private_key, 'wif')

print(f'\nPrivate Key (WIF) is: {wif_encoded_private_key}')
print(f'Private Key (16-bit) is: {private_key}')
print(f'Private Key (10-bit) is: {decoded_private_key}')

# CREATE PUBLIC KEY
# PK * G, where G is fix point on elliptic curve
public_key = cryptos.fast_multiply(cryptos.G, decoded_private_key)

print('\nCoordinate on elliptic curve')
print(f'public_key.x is: {public_key[0]}\n'
      f'public_key.y is: {public_key[1]}')

encoded_public_key_hex = cryptos.encode_pubkey(public_key, 'hex')

print(f'\nencoded_public_key is: {encoded_public_key_hex}\n')

# CHECK ENCODED PUBLIC KEY
if not public_key[1] % 2:
    # even
    compressed_prefix = '02'
else:
    # odd
    compressed_prefix = '03'

hex_compressed_public_key = compressed_prefix + cryptos.encode(public_key[0], 16)
print(f'Compressed public key in 16-bit is: {hex_compressed_public_key}')

# calc hash = RIPEMD160(SHA256(x)) -> address = base58check(hash)
address = cryptos.pubkey_to_address(hex_compressed_public_key)

print(f'BTC address from compressed public key in base58check is: {address}')
