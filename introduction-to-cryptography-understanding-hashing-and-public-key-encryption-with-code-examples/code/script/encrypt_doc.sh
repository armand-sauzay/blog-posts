read -r -p "What is your key name? " KEY_NAME 

gpg --import ${KEY_NAME}.public.key

gpg --encrypt secret_message.txt