#clean the working file:
echo "" > result.txt

cat host1.txt | tr " " "\n" > host1_list.txt
cat host2.txt | tr " " "\n" > host2_list.txt

#loop the list of flags from node 2 against list of flags of node1 and display only the commone ones:
while read p; do
  grep -E "(^| )$p( |$)" host1_list.txt >> result.txt
done < host2_list.txt

#format the flags to be used in a proxmox custom cpus file, see: https://pve.proxmox.com/pve-docs/cpu-models.conf.5.html
# sed ':a;N;$!ba;s/\n/;+/g' : substitutes the carriage returns with ;+
# sed 's/;//' : removes the first occurrence of ; from the line
flags=$(cat result.txt | sed ':a;N;$!ba;s/\n/;+/g' | sed 's/;//')

#echo the configurations to write to: /etc/pve/virtual-guest/cpu-models.conf
echo "##############################################"
echo "cpu-model: test"
echo "    flags $flags"
echo "    phys-bits host"
echo "    hidden 0"
echo "    hv-vendor-id proxmox"
echo "    reported-model kvm64"
echo "##############################################"

#remove workfiles not needed anymore:
rm host1_list.txt host2_list.txt result.txt
