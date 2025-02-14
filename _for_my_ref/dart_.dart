void main() {
  print('REVERSED: ${reversedString('REVERSED')}');
  print('REVERSED2: ${reversedString_2('REVERSED2')}');
  print('MADAM: ${isPalindrome('MADAM', 1)}');
  print('MADAM: ${isPalindrome('MADAM', 2)}');
  print('is prime -> 23: ${isPrime(23)} -- 33: ${isPrime(33)}');
  print('getFibonacci recursive 5 : ${getFibonacci(5, 1)}');
  print('getFibonacci 5 : ${getFibonacci(5, 2)}');

  var list = [44, 323, 121, 2234235, 343, 33, 2, 545546, -232];
  print('Largest for $list is ${findLargestNumberInList([44, 323, 121, 2234235, 343, 33, 2, 545546, -232], 1)}');
  print('Largest for $list is ${findLargestNumberInList([44, 323, 121, 2234235, 343, 33, 2, 545546, -232], 2)}');


  print('factorial recursive 5 : ${factorial(5, 1)}');
  print('factorial 5 : ${factorial(5, 2)}');

  print('First non repeating char \'flutter\': ${firsNonRepeatingCharacter('flutter')} ');

  print('swap numbers (10,3):-> ${swapNumbers(10, 3)} -- (10,-3):-> ${swapNumbers(10, -3)} -- (-10,3):-> ${swapNumbers(-10, 3)}');
  
  print('is anagram (silent, listen): ${isAnagram('silent', 'listen')}');
  print('is anagram (mad, rockers): ${isAnagram('mad', 'rockers')}');
}

String reversedString(String text) {
  return text.split('').reversed.join('');
}

String reversedString_2(String text) {
  String reversed = '';
  for (int i = text.length - 1; i >= 0; i--) {
    reversed = reversed + text[i];
  }
  return reversed;
}

isPalindrome(String text, int method) {
  if (method == 1) {
    return text == reversedString(text);
  } else {
    return text == reversedString_2(text);
  }
}

isPrime(int n) {
  if (n < 2) {
    return false;
  } else {
    for (int i = 2; i < n ~/ 2; i++) {
      if (n % i == 0) {
        return false;
      }
    }
  }
  return true;
}

fibonacciRecursive(int n) {
  if (n <= 1) {
    return n;
  } else {
    return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2);
  }
}

getFibonacci(int n, int method) {
  if (method == 1) {
    String fib = '';
    for (int i = 0; i < n; i++) {
      //print(fibonacciRecursive(i));
      fib = fib + '${fibonacciRecursive(i)} ';
    }
    //print(fib);
    return fib;
  } else {
    String fib = '';

    int a = 0;
    int b = 1;

    //print(a);
    //print(b);
    fib = '$a $b ';
    for (int i = 0; i < n - 2; i++) {
      int c = a + b;
      a = b;
      b = c;
      //print(c);
      fib = fib + '$c ';
    }
    //print(fib);
    return fib;
  }
}

findLargestNumberInList(List<int> list, int method) {
  if (method == 1) {
    return list.reduce((value, element) => element > value ? element : value);
  } else {
    int max = -0x800000000000000;
    for (int n in list) {
      if (n > max) {
        max = n;
      }
    }
    return max;
  }
}

factorialRecursive(int n) {
  if(n <= 1) {
    return 1;
  } else {
    return n * factorialRecursive(n - 1);
  }
}

factorial(int n, int method) {
  if(method == 1) {
    return factorialRecursive(n);
  } else {
    int factorial = 1;
    for(int i =1; i<= n; i++) {
      factorial *= i;
    }
    return factorial;
  }
}

firsNonRepeatingCharacter(String text) {
  Map<String, int> map = {};
  for(var char in text.split('')) {
    map[char] = (map[char] ?? 0) + 1;
  }

  for(var char in text.split('')) {
    if(map[char] == 1) {
      return char;
    }
  }
  return '';

}

swapNumbers(int a, int b) {
  a=a+b;
  b=a-b;
  a=a-b;
  return 'a: $a  b: $b';
}

isAnagram(String s1, String s2) {
  List<String> l1 = s1.split('')..sort();
  List<String> l2 = s2.split('')..sort();
  
  return l1.join('') == l2.join('');
}

void main2() {
  //// fibonacci
  int fibFor = 10;
  int a = 0, b = 1;

  print('Fibonacci for $fibFor');
  print(a);
  print(b);
  for (int i = 0; i < fibFor - 2; i++) {
    int c = a + b;
    a = b;
    b = c;

    print(c);
  }

  //// factorial

  int factFor = 5, factorial = 1;

  for (int i = 1; i <= factFor; i++) {
    factorial *= i;
  }

  print('\nFactorial for $factFor');

  print(factorial);

  //// pallindrome number
  //// armstrong number
  //// reverse number
  int palFor = 153;
  int originalPal = palFor, remP = 0, revP = 0;
  int armS = 0;

  while (palFor > 0) {
    remP = palFor % 10;
    revP = revP * 10 + remP;

    palFor = palFor ~/ 10;

    armS = armS + (remP * remP * remP);
  }

  print('\nReversed Number: $revP');
  print(originalPal == revP ? '$originalPal is Palindrome' : '$originalPal is not palindrome');

  print(originalPal == armS ? '$armS is Armstrong number' : '$armS is not Armstrong number');

  //// pallindrome text
  //// reverse text

  String palText = 'madam';
  String revPText = '';

  for (int i = palText.length - 1; i >= 0; i--) {
    revPText = revPText + palText[i];
  }

  print('\nReversed Text: $revPText');
  print(palText == revPText ? '$palText is Palindrome' : '$palText is not palindrome');

  //// perfect number

  int number = 13;
  int perfectSum = 0;
  for (int i = 1; i <= number ~/ 2; i++) {
    if (number % i == 0) {
      perfectSum += i;
    }
  }

  print('');
  print(number == perfectSum ? '$number is perfect number' : '$number is not perfect number');

  //// prime number

  bool isPrime = true;

  for (int i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) {
      isPrime = false;
    }
  }

  print('');
  print(isPrime ? '$number is prime number' : '$number is not prime number');
}
