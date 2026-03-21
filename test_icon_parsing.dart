void main() {
  // Test hex string parsing
  String hexString = "0xe8b5";
  if (hexString.toLowerCase().startsWith('0x')) {
    int? result = int.tryParse(hexString.substring(2), radix: 16);
    print("Input: $hexString");
    print("Parsed: $result");
    print("Hex representation: 0x${result?.toRadixString(16)}");
  }

  // Test another one
  String hexString2 = "0xe14f";
  if (hexString2.toLowerCase().startsWith('0x')) {
    int? result2 = int.tryParse(hexString2.substring(2), radix: 16);
    print("\nInput: $hexString2");
    print("Parsed: $result2");
    print("Hex representation: 0x${result2?.toRadixString(16)}");
  }

  // Expected: 0xe8b5 = 59573
  print("\n0xe8b5 should be: ${0xe8b5}");
  print("0xe14f should be: ${0xe14f}");
}
