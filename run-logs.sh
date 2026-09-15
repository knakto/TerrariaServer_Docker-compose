#! /bin/sh

docker ps -a | awk '{print "-- : ", $NF}'
# CONTAINER="friend_terraria"
read -p "Type Your world to loging: " CONTAINER
DATETIME=$(date +"%Y-%m-%d")
LOG_DIR="logs"
LOG_FILE="${LOG_DIR}/${CONTAINER}_log_${DATETIME}.log"

# cat ./logs/server.log | awk \
docker logs -f --since=0s $CONTAINER 2>&1 | awk \
'{ \
  if ($1 != "Validating" && $1 != "Saving" && $1 != "Backing" && $1 != "Loading" && $1 != "Settling" && $1 != "Resetting") \
  { \
    if ($NF == "joined." || $NF == "connecting...") \
    { \
      $0="\033[32m" $0 "\033[0m"; \
    } \
    else if ($NF == "left.") \
    { \
      $0="\033[31m" $0 "\033[0m"; \
    } \
    else if ($1 ~ /^\xEf\xBB\xBF\xEF\xBB\xBFError$/ || $1 == "Terraria" || $1 == "Type" || $1 == "Listening" || $1 == ":")
    {
      $0="\033[36m" $0 "\033[0m"; \
    }
    else \
    { \
      $1="\033[35m" $1 "\033[0m"; \
    } \
    print strftime("[%Y-%m-%d %H:%M:%S]"), $0; \
    fflush(); \
  } \
}' | tee -a $LOG_FILE
