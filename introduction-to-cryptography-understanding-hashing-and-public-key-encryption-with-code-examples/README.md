# Introduction to Cryptography: Understanding Hashing and Public-key Encryption with Code Examples

What's cryptography? What does hashing and public-key encryption mean? And which tool can you use to start writing cryptography code?

![Photo of cryptography computer Markus Spiske on Unsplash](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*euSMvlWzW3aKGIC9d1YMYA.jpeg)
<p align=center> Photo by Markus Spiske on <a href="https://unsplash.com/photos/FXFz-sW0uwo">Unsplash</a></p>

You probably heard the name cryptography a lot recently, especially during the cryptocurrency bull market of 2021. But what does it really mean? Is it useful? And how can you start doing a little bit of cryptography yourself?

As always, we'll go through a little bit of theory and the concepts behind before diving into some code to give a concrete example. __As Steve Jobs once said:__
> The doers are the major thinkers. The people that really create the things that change this industry are both the thinker-doer in one person. And if we really go back and we examine, you know, did Leonardo have a guy off to the side that was thinking 5 years out in the future what he would paint or the technology he would use to paint it. Of course not. Leonardo was the artist, but he also mixed all his own paint. He also was a fairly good chemist, knew about pigments, knew about human anatomy. And combining all of those skills together, the art and the science, the thinking and the doing, was what resulted in the exceptional results.

--- 
So let's think a bit and then get our hands on coding. We'll cover:
1. Cryptography 
    - 1.1. Real world use cases 
    - 1.2.  Web2 vs Web3
    - 1.3. Symmetric vs asymmetric cryptography
2. Hashing
    - 2.1. Core concept behind hashing
    - 2.2. Slight difference in inputs can lead to completely different outputs
    - 2.3. Why is this useful?
3. Public key cryptography (and ssh)
    - 3.1. Public key vs Private key and their respective use
    - 3.2. Digital Signature
    - 3.3. Bonus: how does ssh work?
4. Using gpg to create a key pair and encrypting/decrypting documents
    - 4.1. Having a secret message/document
    - 4.2. Generating a key pair
    - 4.3. Encrypting your message with the public key
    - 4.4. Decrypting your message with your private key

---

## 1. Cryptography

### 1.1. Real world use case
Cryptography, in short, is a set of techniques to enable secure communication through encoding and decoding messages. More generally, cryptography is about constructing and analyzing protocols that prevent third parties or the public from reading private messages. It is mainly used for: 
- personal information: most web applications use cryptography to encrypt messages, the data they store, and hide the protect services and APIs through encrypted secrets
- it is the base layer of crypto/blockchain. And you don't have to go further than the second page of Satoshi Nakamoto's original paper on bitcoin (read more [here](https://bitcoin.org/bitcoin.pdf)) to understand that cryptography is central in the blockchain/crypto field.

### 1.2. Web2 vs Web3

> So, most of the "tech" we know relies on cryptography: if you're a __Web2__ aficionado, you trust that companies will correctly protect your data through encrypting the "username" and "password" required to access their databases (these are usually not user and password per say but can be access keys). And if you're a __Web3__ aficionado you trust yourself with keeping your "username" and "password" (or public and private keys) secret to yourself.

And how you keep things __secret__ is through cryptography:
- have an input
- Run a function on it to encode it. 
- Potentially run another function to then decode the encoded message.

__<p align = center>roughly, cryptography = encryption + decryption <p>__


### 1.3. Symmetric and asymmetric cryptography
Popular encryption algorithm include the [Caesar cipher](https://medium.com/r/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FCaesar_cipher) (shift all the letters by one or more characters, i.e. a becomes b, b becomes c, etc.), or [Pig Latin](https://en.wikipedia.org/wiki/Pig_Latin) (adding a suffix to each syllab) which you might know. It is also useful to distinguish between symmetric and asymmetric cryptography:

- __Symmetric cryptography__: the same key is used to encrypt and decrypt the message. This is the most common type of cryptography and is used in most applications. The most popular symmetric cryptography algorithm is AES (Advanced Encryption Standard) which is used in most applications. __In symmetric cryptography: encryption = decryption__ 

- __Asymmetric cryptography__: the key used to encrypt the message is different from the key used to decrypt the message. This is the most common type of cryptography used in the blockchain/crypto field. The most popular asymmetric cryptography algorithm is RSA (Rivest–Shamir–Adleman) which is used in most applications. __In asymmetric cryptography: encryption ≠ decryption__


In this article we'll only cover __asymmetric cryptography__ and cover two main ideas that are the foundation of most applications: (1) hashing and (2) public-key cryptography.

## 2. Hashing
### 2.1. Core concept behind hashing
Hashing is the simplest cryptographic process: you take an input (an image, text, any data basically) and you make it go through a hashing process to create an encrypted message. One of the most used algorithm is SHA-256 (which was developed by the NSA): it will create a "random" 64 character long string from any input.

![illustration of hashing (image by author)](https://cdn-images-1.medium.com/max/1600/1*6r7_AuWfh9-VcqetWaJ2vA.png)
<p align=center> illustration of hashing (image by author) </p>

### 2.2. A slight difference in inputs can lead to completely different outputs
Below, you can see how the two strings "hello world" and "Hello world" are hashed with the SHA-256 algorithm. Notice the very slight difference on the first letter being capitalized or not but the huge difference in the encrypted messages… You can try it out for yourself here.
```bash
Hello world → b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9
hello world → 64ec88ca00b268e5ba1a35678a1b5316d212f4f366b2477232534a8aeca37f3c
```

### 2.3. Why is this useful?
> Hashing is a one way function. It is easy to go from message to encrypted message but almost impossible to do the opposite.

Well, good. But why is this useful?

→ Let's say you have a website and you are storing all the passwords of all your users. You wouldn't want to store them plainly in a datafile (assuming you're a little concerned about those passwords getting leaked…), right? So you could probably hash them with a specific algorithm. When someone signs up on your website, you'll hash their password and store the hashed password. And if that same someone tries to log in with their password, you hash the their login password input and compare it to the original hash of their password when they signed up. If the 2 hashes match (the hash from the original password and the hash from the login input) , you let the user in. And if someone stills the database with all the hashed passwords of all the users, you'll be safe because they could not log in with that information!
But sometimes it would be nice to also be able to decode right? Let's say you're sending a hashed love letter to your lover (with SHA-256 once again)
```bash
I love you → c33084feaa65adbbbebd0c9bf292a26ffc6dea97b170d88e501ab4865591aafd
```

Your lover wouldn't really know what to do with `c33084feaa65adbbbebd0c9bf292a26ffc6dea97b170d88e501ab4865591aafd` would they?

This is where public-key cryptography can be useful.

## 3. Public-key cryptography
In public-key cryptography, there is a set of keys consisting of two keys: a public key and a private key. Both of these keys are one-way functions meaning that they are not interchangeable: the public key is used to encrypt and the private key is used to decrypt. And the security of the process is guaranteed as long as the private key is kept secret.

![illustration of public-key encryption (image by author)](https://cdn-images-1.medium.com/max/1600/1*ggsr_Z3I_ngtwcroEDpVAg.png)
<p align=center> illustration of public-key encryption (image by author) </p>

This is a powerful concept: only those with the private key would be able to decrypt messages encoded with the public key. This opens up the door for many possible applications. I can create a key pair, send the public key to everyone and keep the private key to myself. People could encrypt the messages they want to send me with the public key and publish it somewhere (in a journal, on social media, whatever). And I will be the only one to be able to decrypt the encoded message.

Another very central concept in cryptography is __digital signature__, which is basically proving that you own the private key associated with a public key without sharing the private key. For example, let's say that you have shared a public key (with which anyone can can encrypt a message with). Someone encrypts a message with your public key and sends the encrypted message to you. If you can decrypt the encrypted message they sent, you have proved that you own the private key associated with the public one. This is how digital signature work. You now know the base layer of Bitcoin for instance since showing that you own the private key associated associated with your public Bitcoin address is a process very similar to what we just described.

### Bonus: ssh

SSH (Secure Shell) keys are a way to authenticate a user's access to a remote server. They allow users to log in to a remote server without the need to enter a password.

SSH keys consist of a public key and a private key. The public key is used to encrypt data that is sent from the client to the server, and the private key is used to decrypt the data.
To use an SSH key for authentication, the user generates a key pair on their local machine and then adds the public key to the authorized_keys file on the remote server. When the user attempts to log in to the server, the server sends a challenge message to the client, which the client encrypts using the private key and sends back to the server. If the server can decrypt the message using the public key, the user is authenticated and granted access to the server.

SSH keys are a secure and convenient way to authenticate access to a remote server, as they do not rely on the user remembering a password and they can be revoked or replaced easily if necessary.

The concept is nice, right? _But how can you apply the theory and start using it in code?_ 

## 4. Using gpg to create a key pair and encrypting/decrypting documents

One of the nice tools around for playing around with public and private keys is gnupg with the gpg CLI (you can read more [here](https://gnupg.org/)).

The goal is not to give an extensive overview of gpg but let's see a simple example to realize typical steps (key pair creation and encrypting/decrypting).

As always you can check out the associated code on GitHub and follow along if you want. This basically consists in three steps:
- creating a key pair.
- encoding the document with the public key.
- decrypting the encoded document with the private key.

### 4.1. Having a secret message/document
Let's say you have a private message in a document like:
```txt
#secret_message.txt
The Navy UFO videos weren't supposed to be released.
```

### 4.2. Generating a key pair
You could begin by generating a key pair and storing the public and private key as follows:
```bash
read -r -p "What is your key name? " KEY_NAME 
gpg --full-generate-key #then follow the prompts
gpg --export -a $KEY_NAME > ${KEY_NAME}.public.key
gpg --export-secret-key -a $KEY_NAME > ${KEY_NAME}.private.key
```

### 4.3. Encrypting your message with the public key
Then, using gpg --encrypt you could encrypt your message using the following commands:
```bash
read -r -p "What is your key name? " KEY_NAME
gpg --import ${KEY_NAME}.public.key
gpg --encrypt secret_message.txt
```

### 4.4. Decrypting your message with your private key
Finally, using gpg --decrypt you can use the private key to decrypt the message that you just encoded to verify that the encryption/decryption worked well.
```bash
gpg --decrypt secret_message.txt.gpg
```

---

Tadaa! You've created a key pair, encrypted and then decrypted your message. You're now a crypto expert!

---

I hope you liked this article! Feel free to contact me on LinkedIn, GitHub or Twitter if you have any questions or suggestions or just want to chat, or checkout other articles I wrote on medium and leave feedback. Happy learning!

## About me
Hey! 👋 I'm Armand Sauzay ([armandsauzay](https://twitter.com/armandsauzay)). You can find, follow or contact me on: 

- [Github](https://github.com/armand-sauzay) 
- [Twitter](https://twitter.com/armandsauzay)
- [LinkedIn](https://www.linkedin.com/in/armand-sauzay-80a70b160/)
- [Medium](https://medium.com/@armand-sauzay)
- [Dev.to](https://dev.to/armandsauzay)