#!/bin/bash
# shellcheck disable=1090,1091

# Ping Google to check for internet connectivity
if ! ping -c 1 google.com >/dev/null 2>&1; then
	return 1
fi

# Initialize
source "$HOME/.ik_var"
source "$HOME/.ik_secrets"

# Set a default active value if not set
source "$ACTIVE_VAR_FILE"
if [ -z "$CURRENT_IP" ]; then
	echo "CURRENT_IP=" >>"$ACTIVE_VAR_FILE"
fi

function sendTelegramChat() {
	curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
		-d "chat_id=${TELEGRAM_CHAT_ID}" \
		-d "text=$1"
}

function cloudflare() {
	curl -sSL \
		-H "Accept: application/json" \
		-H "Content-Type: application/json" \
		-H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
		"$@"
}

# Get public IP from AWS
PUBLIC_IP=$(curl -s https://checkip.amazonaws.com)

if [ "$CURRENT_IP" != "$PUBLIC_IP" ]; then
	# Update Cloudflare
	for ((i = 0; i < ${#CLOUDFLARE_DOMAINS[@]}; i++)); do
		cloudflare -X PUT \
			"https://api.cloudflare.com/client/v4/zones/${CLOUDFLARE_ZONE_ID}/dns_records/${CLOUDFLARE_DOMAIN_IDS[$i]}" \
			--data "{\"type\":\"A\",\"name\":\"${CLOUDFLARE_DOMAINS[$i]}\",\"content\":\"${PUBLIC_IP}\",\"ttl\":1,\"proxied\":${CLOUDFLARE_PROXIES[$i]}}"
	done

	# Update local
	sed -s -i "s/CURRENT_IP=$CURRENT_IP/CURRENT_IP=$PUBLIC_IP/" "$ACTIVE_VAR_FILE"

	# Send Telegram notification
	sendTelegramChat "Public IP updated from ${CURRENT_IP} to ${PUBLIC_IP}"
fi
