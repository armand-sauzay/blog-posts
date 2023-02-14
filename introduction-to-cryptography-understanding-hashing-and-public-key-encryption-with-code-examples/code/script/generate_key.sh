read -r -p "What is your key name? " KEY_NAME 
gpg --full-generate-key

gpg --export -a $KEY_NAME > ${KEY_NAME}.public.key
gpg --export-secret-key -a $KEY_NAME > ${KEY_NAME}.private.key
