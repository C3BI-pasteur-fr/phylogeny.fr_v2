MODULE_PACKAGES="/packages"
MODULE_FILES="/usr/share/modules/modulefiles/"
while IFS="	" read -r name version image remainder
do
    mkdir -p $MODULE_PACKAGES/$name/$version
    singularity pull --name tmp.img $image
    mv tmp.img $MODULE_PACKAGES/$name/$version/$name
    mkdir -p $MODULE_FILES/$name/
    cat > $MODULE_FILES/$name/$version <<EOF
#%Module1.0
proc ModulesHelp { } {
global dotversion
 
puts stderr "\t$name $version"
}
 
module-whatis "$name $version"
prepend-path PATH $MODULE_PACKAGES/$name/$version/
EOF

done < "package_list.txt"