#include "cpuemu.h"
#include "micro_aes.h"
#include "micro_aes.c" // We need to include the C file, because we are only going to the assembly stage and are not linking. 

#define  HEXSTR_LENGTH  114               /* plaintext hex characters */
static const char
    *plainText = "c9f775baafa36c25 cd610d3c75a482ea dda97ca4864cdfe0 6eaf70a0ec0d7191"
                 "d55027cf8f900214 e634412583ff0b47 8EA2B7CA516745BF EA",
    *iVec      = "8EA2B7CA516745BF EAfc49904b496089",
    *cipherKey = "279fb74a7572135e 8f9b8ef6d1eee003 69c4e0d86a7b0430 d8cdb78070b4c55a",
    *secretKey = "0001020304050607 08090A0B0C0D0E0F 1011121314151617 18191A1B1C1D1E1F",
    *secondKey = "0011223344556677 8899AABBCCDDEEFF 0001020304050607 08090A0B0C0D0E0F",
    *ecbcipher = "5d00c273f8b2607d a834632dcbb521f4 697dd4ab20bb0645 32a6545e24e33ae9"
                 "f545176111f93773 dbecd262841cf83b 10d145e71b772cf7 a12889cda84be795";
 

enum buffer_sizes
{
    PTSIZE = HEXSTR_LENGTH / 2,
    PADDED = PTSIZE + 15 & ~15,
    TAGGED = PTSIZE + 16
};

static void hex2bytes(const char* hex, uint8_t* bytes)
{
    unsigned shl = 0;
    for (--bytes; *hex; ++hex)
    {
        if (*hex < '0' || 'f' < *hex)  continue;
        if ((shl ^= 4) != 0)  *++bytes = 0;
        *bytes |= (*hex % 16 + (*hex > '9') * 9) << shl;
    }
}

static void check(const char* method, void* result, const void* expected, size_t size)
{
    int c = memcmp(expected, result, size);

    write(method, strlen(method));

    const char *successMessage = "AES test run successfully!\n";
    const char *failureMessage = "AES test run failed!\n";

    if (!c) {
      write(successMessage, strlen(successMessage));
    } else {
      write(failureMessage, strlen(failureMessage));
    }

    memset(result, 0xcc, TAGGED);
}



int main() {
    uint8_t iv[16], key[64], authKey[32], input[PADDED], test[TAGGED], output[TAGGED],
           *a = authKey + 1, sa = sizeof authKey - 1, sp = PTSIZE;
    hex2bytes(cipherKey, key);
    hex2bytes(secondKey, key + 32);
    hex2bytes(secretKey, authKey);
    hex2bytes(iVec, iv);
    hex2bytes(plainText, input);

    hex2bytes(ecbcipher, test);
    AES_ECB_encrypt(key, input, sp, output);
    check("ECB encryption", output, test, sizeof input);
    AES_ECB_decrypt(key, test, sizeof input, output);
    check("ECB decryption", output, input, sp);
}
