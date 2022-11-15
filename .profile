JEKYLL_VERSION=4
alias jekyll='docker run --rm \
  -p 127.0.0.1:4000:4000 \
  --volume="$PWD:/srv/jekyll:Z" \
  -it jekyll/jekyll:$JEKYLL_VERSION \
  jekyll'
echo "alias for jekyll created."

alias blog_date='date "+%F %T %z"'

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa-coltonenglish
