apt-get update
wget -O w10x64.img https://bit.ly/akuhnetW10x64

curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
	| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
	&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
	| sudo tee /etc/apt/sources.list.d/ngrok.list \
	&& sudo apt update \
	&& sudo apt install ngrok

ngrok config add-authtoken 2MgX2kMIJcGpO2qQSpDZtoUdzGR_3MJUrRMbDf9TzwhpQopXb
ngrok tcp 3388 &>/dev/null &

qemu-system-x86_64 -hda w10x64.img -m 4G -smp cores=4 -net user,hostfwd=tcp::3388-:3389 -net nic -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -vga vmware -nographic &>/dev/null &