#!/bin/bash

cd "$(dirname "$0")"

DATE=$(date "+%Y-%m-%d %H:%M:%S")
TODAY=$(date "+%Y-%m-%d")

usage() {
  echo "Usage: ./commit.sh <mode> [message]"
  echo ""
  echo "Modes:"
  echo "  timestamp          Log a timestamp"
  echo "  til <message>      Log a Today I Learned entry"
  echo "  quote <message>    Log a quote"
  echo ""
  echo "Examples:"
  echo "  ./commit.sh timestamp"
  echo "  ./commit.sh til 'Learned about git rebase'"
  echo "  ./commit.sh quote 'The best code is no code at all.'"
}

MODE="$1"
shift
MESSAGE="$*"

case "$MODE" in
  timestamp)
    echo "- **${DATE}** — checked in" >> log.md
    COMMIT_MSG="daily check-in: ${TODAY}"
    ;;
  til)
    if [ -z "$MESSAGE" ]; then
      echo "Error: til mode requires a message"
      usage
      exit 1
    fi
    echo "- **${DATE}** — TIL: ${MESSAGE}" >> log.md
    COMMIT_MSG="til: ${MESSAGE}"
    ;;
  quote)
    if [ -z "$MESSAGE" ]; then
      echo "Error: quote mode requires a message"
      usage
      exit 1
    fi
    echo "- **${DATE}** — 💬 *\"${MESSAGE}\"*" >> log.md
    COMMIT_MSG="quote: ${MESSAGE}"
    ;;
  *)
    usage
    exit 1
    ;;
esac

git add log.md
git commit -m "${COMMIT_MSG}"
git push

echo "Done! Committed: ${COMMIT_MSG}"
