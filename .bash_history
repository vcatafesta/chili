#1726031420
cd ..
#1726031421
dir
#1726031422
cd ..
#1726031429
ff buildiso
#1726031431
ff buildiso*
#1726031434
ff *buildiso*
#1726031436
cd ..
#1726031438
cd build-iso/
#1726031440
ff *buildiso*
#1726031442
ls
#1726031442
dir
#1726031445
ls -la
#1726031446
dir
#1726031451
gpush
#1726031454
cd ..
#1726031455
dir
#1726031460
cd iso-profiles/
#1726031460
dir
#1726031464
tree -a
#1726031470
dir
#1726031491
cdb
#1726031493
cd gitrepo
#1726031508
ff buildiso.sh
#1726031512
ed ./usr/bin/buildiso.sh
#1726031565
buildiso.sh -o chililinux
#1726031599
ed ./usr/bin/buildiso.sh
#1726031646
buildiso.sh -o chililinux
#1726031655
ed ./usr/bin/buildiso.sh
#1726031679
ff gitlib.sh
#1726031684
ed ./usr/share/community/gitrepo/shell/gitlib.sh
#1726031775
cpc ./usr/share/community/gitrepo/shell/gitlib.sh
#1726031780
buildiso.sh -o chililinux
#1726031952
cdb
#1726031958
cd chililinux
#1726031959
dir
#1726031962
cd build-iso
#1726031962
dir
#1726031966
cd .github/
#1726031967
dir
#1726031970
ccd ..
#1726031972
cd ..
#1726031972
dir
#1726031974
cd ..
#1726031974
dir
#1726031975
cd -
#1726031976
dir
#1726031980
ed acion.y
#1726031982
ed acion.yml
#1726031984
dir
#1726031988
ed action.yml
#1726032141
ssh Y2J4Rwyetfe8YeWGTdCYBW393@nyc1.tmate.io
#1726032918
buildiso
#1726032931
sudo pacman -S extra/manjaro-tools-iso-git
#1726032951
buildiso
#1726032970
cd /
#1726032971
buildiso
#1726032993
ed /usr/share/manjaro-tools/iso-profiles/
#1726032999
dir /usr/share/manjaro-tools/iso-profiles/
#1726033004
dir /usr/share/manjaro-tools/iso-profiles/repo_info 
#1726033006
cat /usr/share/manjaro-tools/iso-profiles/repo_info 
#1726033015
cat /usr/share/manjaro-tools/iso-profiles/shared/
#1726033019
dir /usr/share/manjaro-tools/iso-profiles/shared/
#1726033026
dir /usr/share/manjaro-tools/iso-profiles/shared/manjaro/
#1726033029
dir /usr/share/manjaro-tools/iso-profiles/shared/manjaro/live-overlay/
#1726033032
dir /usr/share/manjaro-tools/iso-profiles/shared/manjaro/live-overlay/etc/
#1726033036
cd /
#1726033037
dir
#1726033043
buildiso
#1726033049
man buildiso
#1726033130
git clone https://gitlab.manjaro.org/profiles-and-settings/iso-profiles.git ~/iso-profiles
#1726033137
cd 
#1726033139
cd iso-profiles/
#1726033140
dir
#1726033152
ls -l ~/iso-profiles/manjaro/xfce
#1726033254
buildiso -p xfce
#1726034171
dir
#1726034185
sudo su
#1726035073
cd
#1726035075
cd iso-profiles/
#1726035076
dir
#1726035084
ff user*
#1726035518
dir
#1726035525
ff iso-profiles.conf
#1726035536
cd
#1726035538
cd .configq
#1726035539
dir
#1726035547
cd manjaro-tools/
#1726035548
dir
#1726035551
ed iso-profiles.conf 
#1726035649
dir
#1726035652
ed iso-profiles.conf 
#1726035678
cd
#1726035679
dir
#1726035681
cd iso-profiles/
#1726035682
dir
#1726035687
cd ..
#1726035701
xcopy iso-profiles/ chili-iso-profiles/
#1726035703
cd -
#1726035704
dir
#1726035707
cd
#1726035719
cd .config/manjaro-tools/
#1726035719
dir
#1726035721
ed iso-profiles.conf 
#1726035733
cd
#1726035735
cd chili-iso-profiles/
#1726035736
dir
#1726035755
dir /github/chililinux/iso-profiles/
#1726035780
xcoy /github/chililinux/iso-profiles/community .
#1726035784
xcopy /github/chililinux/iso-profiles/community .
#1726035793
xcopy /github/chililinux/iso-profiles/custom-profiles .
#1726035799
xcopy /github/chililinux/iso-profiles/shared .
#1726035807
buildiso -p xfce
#1726035830
cd /home/vcatafesta/chili-iso-profiles/custom-profiles/xfce
#1726035831
dir
#1726035836
ed Desktop-remove 
#1726035845
ed Root-remove 
#1726035871
dir /home/vcatafesta/iso-profiles/manjaro/
#1726035877
dir /home/vcatafesta/iso-profiles/manjaro/xfce/
#1726035900
xcopy /home/vcatafesta/iso-profiles/manjaro/xfce/desktop-overlay .
#1726035907
xcopy /home/vcatafesta/iso-profiles/manjaro/xfce/live-overlay .
#1726035924
xcopy /home/vcatafesta/iso-profiles/manjaro/xfce/Packages-* .
#1726035926
dir
#1726035945
xcopy /home/vcatafesta/iso-profiles/manjaro/xfce/profile.conf .
#1726035951
buildiso -p xfce
#1726036111
dir
#1726036146
ls
#1726033599
cdb
#1726033607
cd chilinux
#1726033617
cd chililinux
#1726033618
dir
#1726033625
cd build-iso
#1726033626
dir
#1726033634
ffs iso-profiles
#1726033694
cd
#1726033696
cd iso-profiles/
#1726033697
dir
#1726033706
cd manjaro/
#1726033706
di
#1726033708
dir
#1726033714
cd xfce/
#1726033715
dir
#1726033724
ed profile.conf 
#1726033733
cd ..
#1726033735
dir
#1726033740
cat repo_info
#1726033742
dir
#1726033858
type -a xcopy
#1726034375
cd
#1726034377
cd iso-profiles/
#1726034380
ff profile.conf
#1726034392
dir
#1726034394
cd
#1726034395
cd /home
#1726034397
cd iso-profiles/
#1726034397
dir
#1726034402
ff profile.conf
#1726034416
ed./manjaro/xfce/profile.conf
#1726034419
ed ./manjaro/xfce/profile.conf
#1726034423
cdb
#1726034426
cd chililinux/
#1726034427
cd iso-profiles/
#1726034428
dir
#1726034431
ff profile.conf
#1726034441
ed ./community/xfce/profile.conf
#1726034459
clear
#1726034460
dir
#1726034467
ff profile.conf
#1726034545
dir
#1726034547
cd /
#1726034589
du
#1726034593
duf
#1726034786
dir /var/cache/manjaro-tools/iso/
#1726034788
dir /var/cache/manjaro-tools/iso/manjaro/
#1726034790
dir /var/cache/manjaro-tools/iso/manjaro/xfce/
#1726034792
dir /var/cache/manjaro-tools/iso/manjaro/xfce/24.1.0pre1/
#1726034797
cat /var/cache/manjaro-tools/iso/manjaro/xfce/24.1.0pre1/biglinux-xfce-24.1.0pre1-minimal-240911-linux54-pkgs.txt 
#1726034834
sudo rm -r /var/lib/manjaro-tools/buildiso/
#1726034888
cd
#1726034890
cd iso-profiles/
#1726034896
ff profile.conf
#1726034910
ed ./manjaro/xfce/profile.conf
#1726034950
buildiso -p xfce
#1726064364
cd
#1726064369
cd .config/manjaro-tools/
#1726064369
dir
#1726064371
ed iso-profiles.conf 
#1726064885
sci
#1726065748
cdb
#1726065751
cd chililinux
#1726065754
cd build-iso
#1726065754
dir
#1726065756
tree
#1726065759
dir
#1726065764
cd ..
#1726065767
cd iso-profiles/
#1726065767
dir
#1726065770
tree
#1726065771
dir
#1726065774
cd community/
#1726065774
dir
#1726065776
cd xfce
#1726065777
dir
#1726065786
cd ..
#1726065787
dir
#1726065793
cd custom-profiles/
#1726065794
dir
#1726065796
cd xfce/
#1726065796
dir
#1726065895
cd /tmp
#1726065898
git clone https://github.com/talesam/iso-profiles/tree/main/community/xfce
#1726065905
git clone https://github.com/talesam/iso-profiles 
#1726065910
cd iso-profiles/
#1726065911
dir
#1726065916
ddel .git
#1726065917
dir
#1726065919
tree
#1726065921
dir
#1726065927
cd -
#1726065928
cdb
#1726065935
cd chililinux/iso-profiles/
#1726065938
xcopy /tmp/iso-profiles/. .
#1726065940
dir
#1726065943
gpush
#1726065954
git remote -v
#1726065956
dir
#1726065960
gpush
#1726065974
git remote -v
#1726065980
gpush
#1726066047
git push origin main
#1726066050
gpush
#1726066082
git remote add upstream https://github.com/chililinux/iso-profiles
#1726066089
git merge origin/main
#1726066091
gpush
#1726066100
tree
#1726066115
dir /tmp/iso-profiles/
#1726066120
xcopy /tmp/iso-profiles/. .
#1726066122
gpush
#1726066239
cd /github/build-iso
#1726066240
dir
#1726066243
cd ..
#1726066248
cd /github/chililinux/build-iso/
#1726066249
dir
#1726066250
ed action.yml
#1726066253
rm action.yml
#1726066254
ed action.yml
#1726066263
prettier -w action.yml
#1726066265
dir
#1726066280
cd .github/
#1726066281
dir
#1726066283
cd workflows/
#1726066283
dir
#1726066295
rm edition.yml 
#1726066297
ed edition.yml 
#1726066304
prettier -w edition.yml 
#1726066306
dir
#1726066309
ed edition.yml 
#1726066322
gpush
#1726066357
cd ..
#1726066359
dir
#1726066370
git remote -v
#1726066381
git push origin main
#1726066384
gpush
#1726066403
git remote add upstream https://github.com/chililinux/build-iso
#1726066410
git merge origin/main
#1726066415
gpush
#1726066421
dir
#1726066426
tree 
#1726066431
dir
#1726066434
d .github/
#1726066436
dir
#1726066440
cd .github/
#1726066440
dir
#1726066442
cd workflows/
#1726066442
dir
#1726066455
ed edition.yml 
#1726066464
cd ,,
#1726066466
cd ..
#1726066471
dir
#1726066477
ffs iso-profiles.conf
#1726066481
ffs 'iso-profiles.conf'
#1726066509
dir
#1726066513
ed action.yml
#1726066551
ffs 'iso-profiles'
#1726066584
ffs 'iso-profiles.conf'
#1726066588
ffs 'iso-profiles\.conf'
#1726066591
ffs 'iso-profiles.conf'
#1726115514
ssh W6cqM29pf2aGN44xGFvh9p5hp@sfo2.tmate.io
#1726144416
cdb
#1726144422
cd buid-iso
#1726144429
cd chililinux/build-iso/
#1726144430
dir
#1726144437
ed action.yml
#1726144477
prettier -w action.yml
#1726144482
ed action.yml
#1726144628
cp action.yml /lixo
#1726144633
rm action.yml
#1726144636
ed action.yml
#1726144655
prettier -w action.yml
#1726144657
ed action.yml
#1726144900
prettier -w action.yml
#1726144905
gpush
#1726144921
buildiso.sh -o chililinux
#1726145007
ed action.yml
#1726145197
gpush
#1726145210
cd /github/gitrepo
#1726145219
cd =
#1726145220
cd -
#1726145227
buildiso.sh -o chililinux
#1726145306
ed action.yml
#1726145719
cd .github/workflows/
#1726145720
dir
#1726145733
mv edition.yml edition.yml.old
#1726145738
ed edition.yml
#1726145753
prettier -w edition.yml
#1726145773
ed Stable_Testing-Beta_XFCE.yml
#1726145786
prettier -w Stable_Testing-Beta_XFCE.yml
#1726145789
cd ..
#1726145791
gpush
#1726145799
buildiso.sh -o chililinux
#1726147053
cd
#1726147061
mkdir docker-overlay
#1726147064
cd docker-overlay/
#1726147074
ed nano Dockerfile
#1726147107
docker build -t overlay-supported-image .
#1726147115
sudo pacman -S docker
#1726147145
docker build -t overlay-supported-image .
#1726147167
enable docker
#1726147173
start docker
#1726147178
docker build -t overlay-supported-image .
#1726147186
sudo docker build -t overlay-supported-image .
#1726147231
docker run --privileged -it overlay-supported-image
#1726147235
sudo docker run --privileged -it overlay-supported-image
#1726147266
dir
#1726147284
cat nano
#1726147288
rm nano
#1726147289
dir
#1726147299
sudo docker run --privileged -it overlay-supported-image
#1726147404
ed Dockerfile 
#1726147432
sudo docker run --privileged -it overlay-supported-image
#1726147438
ed Dockerfile 
#1726147454
sudo docker run --privileged -v /mnt/data/upper:/upper -v /mnt/data/work:/work -v /mnt/data/lower:/lower -v /mnt/data/merged:/merged -it overlay-supported-image
#1726147468
df -T /var/lib/docker
#1726147509
docker info | grep "Storage Driver"
#1726147513
sudo docker info | grep "Storage Driver"
#1726147565
sudo ed /etc/docker/daemon.json.
#1726147570
sudo ed /etc/docker/daemon.json
#1726147585
sudo nano /etc/docker/daemon.json
#1726147607
dir /etc/docker/daemon.json
#1726147611
dir /etc/docker/
#1726147624
sudo mkdir -p /etc/docker
#1726147627
sudo nano /etc/docker/daemon.json
#1726147645
sudo systemctl restart docker
#1726147654
docker info | grep "Storage Driver"
#1726147656
sudo docker info | grep "Storage Driver"
#1726147664
sudo docker run --privileged -v /tmp/upper:/upper -v /tmp/work:/work -v /tmp/lower:/lower -v /tmp/merged:/merged -it overlay-supported-image
#1726147724
sudo mkdir -p /tmp/upper /tmp/work /tmp/lower /tmp/merged
#1726147724
sudo chmod 755 /tmp/upper /tmp/work /tmp/lower /tmp/merged
#1726147730
sudo docker run --privileged   -v /tmp/upper:/upper   -v /tmp/work:/work   -v /tmp/lower:/lower   -v /tmp/merged:/merged   -it overlay-supported-image
#1726147749
dir
#1726147755
cat Dockerfile 
#1726147841
mv Dockerfile Dockerfile.old
#1726147845
ed Dockerfile
#1726147857
sudo docker build -t arch-overlay-image .
#1726147910
ed Dockerfile
#1726147931
sudo docker build -t arch-overlay-image .
#1726147979
sudo docker run --privileged -it arch-overlay-image
#1726148060
sudo mkdir -p /tmp/upper /tmp/work /tmp/lower /tmp/merged
#1726148063
sudo docker run --privileged -it arch-overlay-image
#1726148075
sudo docker info | grep "Storage Driver"
#1726148085
sudo systemctl restart docker
#1726148108
mv Dockerfile Dockerfile.2
#1726148115
ed Dockerfile
#1726148137
sudo docker build -t simple-test-image .
#1726148156
sudo docker run --privileged -it simple-test-image
#1726148848
dir
#1726148855
mv Dockerfile Dockerfile.3
#1726148858
ed Dockerfile
#1726148870
sudo docker build -t overlayfs-test-image .
#1726148898
sudo docker run --privileged -it overlayfs-test-image
#1726150288
sudo docker commit manjaro my-new-image
#1726150325
sudo docker commit overlayfs-test-image manjaro
#1726150377
sudo docker run --privileged -it overlayfs-test-image
#1726150424
docker run -it --name my-container overlayfs-test-image
#1726150427
sudo docker run -it --name my-container overlayfs-test-image
#1726150461
docker images
#1726150464
sudo docker images
#1726150529
sudo docker rm archlinux
#1726150565
sudo docker rm 88e34eb59b71
#1726150579
docker images
#1726150581
sudo docker images
#1726150607
sudo docker rm 88e34eb59b71
#1726150618
sudo docker rm archlinux
#1726150628
sudo docker --help
#1726150642
sudo docker rm --help
#1726150650
sudo docker rm -v
#1726150683
sudo docker ps
#1726150705
docker rmi overlayfs-test-image
#1726150705
docker rmi simple-test-image
#1726150705
docker rmi arch-overlay-image
#1726150705
docker rmi overlay-supported-image
#1726150705
docker rmi archlinux
#1726150711
sudo docker ps
#1726150719
sudo docker images
#1726150733
sudo docker rmi overlayfs-test-image
#1726150740
sudo docker rmi overlayfs-test-image -f
#1726150743
sudo docker images
#1726150757
sudo docker rmi simple-test-image
#1726150759
sudo docker rmi simple-test-image -f
#1726150762
sudo docker images
#1726150773
sudo docker rmi arch-overlay-image
#1726150775
sudo docker rmi arch-overlay-image -f
#1726150786
sudo docker rmi overlay-supported-image
#1726150788
sudo docker rmi overlay-supported-image -f
#1726150795
sudo docker rmi archlinux
#1726150797
sudo docker rmi archlinux -f
#1726150800
sudo docker images
#1726150805
ed Dockerfile
#1726150846
sudo docker build -t arch-with-overlay .
#1726150879
ed Dockerfile
#1726150900
sudo docker build -t arch-with-overlay .
#1726150927
ed Dockerfile
#1726150936
sudo docker build -t arch-with-overlay .
#1726150965
dr
#1726151054
#sudo docker build -t arch-with-overlay .
#1726151068
sudo docker run --privileged -it arch-with-overlay
#1726151130
sudo docker run -it --name my-container arch-with-overlay
#1726151150
sudo docker run -it --name vilmar arch-with-overlay
#1726151171
sudo docker images
#1726151199
sudo docker run -it vilmar
#1726151212
sudo docker run -it --name vilmar
#1726151389
docker image prune
#1726151394
sudo docker image prune
#1726151404
docker images
#1726151406
sudo docker images
#1726151565
sudo docker run -d -v /lixo:/lixo arch-with-overlay
#1726151579
dir
#1726151583
cd /
#1726151584
dir
#1726151586
cd -
#1726151604
sudo docker images
#1726151628
sudo docker run -d -v /lixo:/lixo -it arch-with-overlay
#1726151641
sudo docker run -it arch-with-overlay
#1726152005
sudo docker images
#1726152034
sudo docker commit 938f83611b8b buildiso
#1726152052
sudo docker commit arch-with-overlay buildiso
#1726152086
sudo docker ps
#1726152103
sudo docker commit 409ff0cacea9 buildiso
#1726152106
sudo docker ps
#1726152111
sudo docker images
#1726152137
sudo docker ps -a
#1726152169
sudo docker run -it buildiso
#1726152252
sudo docker exec
#1726152301
sudo docker run -it buildiso /bin/bash
#1726152320
uname -a
#1726152414
cdb
#1726152420
cd chililinux/build-iso/
#1726152421
dir
#1726152426
cp /lixo/action.yml .
#1726152428
dir /lixo
#1726152438
ff \*.yml
#1726152445
cd ./.github/workflows/
#1726152446
dir
#1726152449
dir edit*
#1726152459
edition.yml
#1726152461
ed edition.yml
#1726152468
cd ..
#1726152468
dir
#1726152470
cd ..
#1726152472
ed action.yml
#1726152510
sudo pacman -S fuse-overlayfs
#1726152514
ed action.yml
#1726152580
gpush
#1726152597
buildiso.sh -o chililinux
#1726152696
ssh r5yfPxsKBDd8fUC7UJZRs7D9U@nyc1.tmate.io
#1726149515
sudo pacman -S manjaro-tools
#1726149524
sudo pacman -S manjaro-tools-iso
#1726149604
ed /etc/pacman.conf 
#1726149682
sudo pacman -Ss manjaro-tools-iso
#1726149696
cat /etc/pacman.d/mirrorlist 
#1726149772
sudo pacman -Ss manjaro-tools-iso
#1726149787
ed /etc/pacman.conf 
#1726149804
kate /etc/pacman.conf 
#1726149851
cat /etc/pacman.d/mirrorcdn 
#1726150159
sudo pacman -Syy
#1726180422
dir
#1726180430
ed action.yml
#1726180447
gpush
#1726181940
ed action.yml
#1726183542
dir
#1726183548
ed action.yml
#1726183647
gpush
#1726183664
buildiso.sh -o chililinux -a
#1726183771
ssh VFPtGvL9U2cWgpzCg44xZPA8P@nyc1.tmate.i
#1726183777
ssh VFPtGvL9U2cWgpzCg44xZPA8P@nyc1.tmate.io
#1726184510
ssh uXuNcuLhcXTE2AweNCWCcYenE@nyc1.tmate.io
#1726197456
sudo rm -r /var/cache/manjaro-tools/
#1726197464
sudo rm -r /var/lib/manjaro-tools/buildiso/
#1726197493
ed action.yml
#1726197631
sudo pacman -Scc --noconfirm
#1726197641
sudo pacman -Scc 
#1726197652
ed action.yml
#1726197658
prettier -w action.yml
#1726197660
gpush
#1726197719
sudo pacman -Scc --noconfirm
#1726197727
buildiso.sh -o chililinux -a
#1726197791
ffs privile
#1726197801
ed ./.github/workflows/edition.yml
#1726197945
ed action.yml
#1726197979
gpush
#1726198273
ed action.yml
#1726198288
gpush
#1726198300
buildiso.sh -o chililinux -a
#1726198422
ed action.yml
#1726198576
prettier -w action.yml
#1726198579
gpush
#1726198586
buildiso.sh -o chililinux -a
#1726198933
ssh FUMPJCSBptRCFmXtbDCWxH3SU@nyc1.tmate.io
#1726200774
ed ./.github/workflows/edition.yml
#1726202295
prettier -w ./.github/workflows/edition.yml
#1726202299
ed action.yml
#1726202347
gpush
#1726202353
buildiso.sh -o chililinux -a
#1726202768
ed ./.github/workflows/edition.yml
#1726202786
prettier -w ./.github/workflows/edition.yml
#1726202788
ed ./.github/workflows/edition.yml
#1726202827
prettier -w ./.github/workflows/edition.yml
#1726202829
ed ./.github/workflows/edition.yml
#1726202847
prettier -w ./.github/workflows/edition.yml
#1726202850
ed ./.github/workflows/edition.yml
#1726202858
prettier -w ./.github/workflows/edition.yml
#1726202866
ed ./.github/workflows/edition.yml
#1726202869
ed action.yml
#1726202879
gpush
#1726202890
buildiso.sh -o chililinux -a
#1726202948
prettier -w action.yml
#1726203049
cdb
#1726203053
cd gitrepo/
#1726203057
ff gitrepo.sh
#1726203063
ed ./usr/bin/
#1726203093
ff \*.sh
#1726203100
ed ./usr/share/community/gitrepo/shell/gitlib.sh
#1726203122
ff gitrepo.sh
#1726203125
ed ./usr/bin/gitrepo.sh
#1726203135
ed ./usr/share/community/gitrepo/shell/gitlib.sh
#1726203144
shfmt -w ./usr/share/community/gitrepo/shell/gitlib.sh
#1726203147
cpc ./usr/share/community/gitrepo/shell/gitlib.sh
#1726203150
ed ./usr/bin/gitrepo.sh
#1726203159
shfmt -w ./usr/bin/gitrepo.sh
#1726203170
cpc ./usr/bin/gitrepo.sh
#1726203174
cpc ./usr/bin/buildiso.sh 
#1726203176
gpush
#1726203183
cd /chililinu
#1726203185
cd /chililinux
#1726203186
cdb
#1726203189
chililinux
#1726203192
cd chililinux
#1726203194
cd build-iso/
#1726203379
ff \*.yml
#1726203383
ed ./.github/workflows/edition.yml
#1726203435
ed action.yml
#1726203691
duf
#1726203702
ed action.yml
#1726203741
gpush
#1726203865
sudo pacman -Sy
#1726203870
sudo pacman -Su
#1726203919
sudo pacman -S qemu-system-nios2
#1726203922
sudo pacman -Ss qemu-system-nios2
#1726203924
sudo pacman -Ss qemu-system-nios
#1726203928
sudo pacman -Ss qemu-system
#1726203943
sudo pacman -Su
#1726178167
cdb
#1726178168
dir
#1726178175
cd chililinux/build-iso/
#1726178175
dir
#1726178181
cd .github/workflows/
#1726178182
dir
#1726178193
mv Stable_Testing-Beta_XFCE.yml Stable_Testing-Beta_XFCE.yml.old
#1726178193
dir
#1726178196
gpush
#1726178274
cd ..
#1726178290
cd build-iso/
#1726178291
ed action.yml
#1726178376
gpush
#1726178387
buildiso.sh -o chililinux
#1726178396
cd gitrepo
#1726178399
cd 
#1726178401
cdb
#1726178403
cd gitrepo/
#1726178409
ff buildiso.sh
#1726178414
ed ./usr/bin/buildiso.sh
#1726178534
cpc ./usr/bin/buildiso.sh
#1726178540
buildiso.sh
#1726178559
ed ./usr/bin/buildiso.sh
#1726178824
shfm -w ./usr/bin/buildiso.sh
#1726178831
shfmt -w ./usr/bin/buildiso.sh
#1726178832
ed ./usr/bin/buildiso.sh
#1726178902
shfmt -w ./usr/bin/buildiso.sh
#1726178903
ed ./usr/bin/buildiso.sh
#1726178907
cpc ./usr/bin/buildiso.sh
#1726178911
buildiso.sh
#1726178916
ed ./usr/bin/buildiso.sh
#1726178929
cpc ./usr/bin/buildiso.sh
#1726178930
buildiso.sh
#1726178934
ed ./usr/bin/buildiso.sh
#1726178953
cpc ./usr/bin/buildiso.sh
#1726178955
buildiso.sh
#1726178962
buildiso.sh --auto
#1726178968
ed ./usr/bin/buildiso.sh
#1726179010
cpc ./usr/bin/buildiso.sh
#1726179011
buildiso.sh --auto
#1726179018
ed ./usr/bin/buildiso.sh
#1726179043
cpc ./usr/bin/buildiso.sh
#1726179044

#1726179082
buildiso.sh -o chililinux --auto
#1726179096
ed ./usr/bin/buildiso.sh
#1726179206
cpc ./usr/bin/buildiso.sh
#1726179210
cd chililinux/
#1726179215
cd build-iso/
#1726179218
buildiso.sh -o chililinux --auto
#1726179239
ed /usr/share/community/gitrepo/shell/gitlib.sh:
#1726179245
ed /usr/share/community/gitrepo/shell/gitlib.sh
#1726179263
cdb
#1726179265
cd gitrepo
#1726179270
ed ./usr/bin/buildiso.sh
#1726179292
cpc ./usr/bin/buildiso.sh
#1726179295
buildiso.sh -o chililinux --auto
#1726179306
ed ./usr/bin/buildiso.sh
#1726179339
shfmt -w ./usr/bin/buildiso.sh
#1726179341
buildiso.sh -o chililinux --auto
#1726179345
ed ./usr/bin/buildiso.sh
#1726179394
cpc ./usr/bin/buildiso.sh
#1726179395
buildiso.sh -o chililinux --auto
#1726179401
ed ./usr/bin/buildiso.sh
#1726179409
cpc ./usr/bin/buildiso.sh
#1726179410
buildiso.sh -o chililinux --auto
#1726179458
ed action.y
#1726179461
cdb
#1726179464
cd chililinux/
#1726179464
di
#1726179471
cd build-iso/
#1726179472
dir
#1726179474
ed action.yml
#1726179494
ff \*.yml
#1726179497
ed ./.github/workflows/edition.yml
#1726179506
gpush
#1726179633
ssh fuQB4sggDgWq964G3RxVhzcCN@nyc1.tmate.io
#1726182206
cd
#1726182209
cd iso-profiles/
#1726182210
cd ..
#1726182215
ddel iso-profiles/
#1726182236
git clone https://github.com/chililinux/iso-profiles 
#1726182241
cd .config
#1726182243
cd manjaro
#1726182244
dir
#1726182248
cd ..
#1726182253
cd manjaro-tools/
#1726182254
dir
#1726182256
ed iso-profiles.conf 
#1726182266
gitbuild
#1726182271
builiso
#1726182278
buildiso
#1726182448
cd ..
#1726182449
dir
#1726182454
cd 
#1726182456
cd iso-profiles/
#1726182457
dir
#1726182460
cat repo_info 
#1726182461
dir
#1726182467
cd custom-profiles/
#1726182468
dir
#1726182470
cd ..
#1726182471
dir
#1726182472
cd community/
#1726182473
dir
#1726182475
cd ..
#1726182548
pathd
#1726182551
cd iso-profiles/
#1726182554
pdw
#1726182587
dir /etc/manjaro-tools/
#1726182596
ed /etc/manjaro-tools/manjaro-tools.conf 
#1726182635
cd /etc/manjaro-tools/
#1726182635
dir
#1726182639
tree
#1726182643
dir
#1726182681
sudo nano buildiso.conf
#1726182704
dir /home/vcatafesta/iso-profiles/
#1726182706
dir /home/vcatafesta/iso-profiles/community/
#1726182711
sudo nano buildiso.conf
#1726182723
buildiso -p xfce
#1726182757
buildiso -p xfce -d /home/vcatafesta/iso-profiles/community/
#1726182770
buildiso -h
#1726182855
buildiso -p xfce -i /home/vcatafesta/iso-profiles/community/
#1726182869
sudo buildiso -p xfce -i /home/vcatafesta/iso-profiles/community/
#1726182897
sudo buildiso -p xfce -i https://github.com/chililinux/iso-profiles
#1726182948
sudo buildiso -p xfce -i https://github.com/talesam/iso-profiles
#1726182959
sudo buildiso -p xfce -i https://github.com/chililinux/iso-profiles/main
#1726183040
sudo rm -rf /usr/share/manjaro-tools/iso-profiles
#1726183115
sudo ln -s /home/vcatafesta/iso-profiles /usr/share/manjaro-tools/iso-profiles
#1726183128
buildiso -p xfce
#1726183137
sudo buildiso -p xfce
#1726183155
sudo rm /var/lib/manjaro-tools/buildiso/xfce/x86_64/rootfs
#1726183162
sudo rm -rf /var/lib/manjaro-tools/buildiso/xfce/x86_64/rootfs
#1726183164
sudo buildiso -p xfce
#1726183289
sudo buildiso -p community/xfce
#1726183314
dir /usr/share/manjaro-tools/
#1726183321
cd iso-profiles/d
#1726183324
cd iso-profiles/
#1726183325
dir
#1726183331
cd community/
#1726183332
dir
#1726183336
cd xfce
#1726183337
dir
#1726183340
cd /
#1726183363
buildiso -p /home/vcatafesta/iso-profiles/community/xfce
#1726183377
buildiso -p community/xfce
#1726183454
sudo buildiso -i
#1726183470
ping 8.8.8.8
#1726183494
sudo buildiso -p /usr/share/manjaro-tools/iso-profiles/community/xfce
#1726183526
sudo buildiso -p community/xfce
#1726184037
cdb
#1726184045
cd chililinux/build-iso/
#1726184046
dir
#1726184047
ed action.yml
#1726184129
gpush
#1726184137
ed action.yml
#1726184213
gpush
#1726184248
buildiso.sh -o chililinux -a
#1726184319
ed /usr/bin/buildiso.sh
#1726184359
ed/usr/share/community/gitrepo/shell
#1726184361
ed /usr/share/community/gitrepo/shell
#1726184366
ed /usr/share/community/gitrepo/shell/gitlib.sh 
#1726184381
cd /gitrepo
#1726184384
cdb
#1726184390
cd gitrepo/
#1726184391
dir
#1726184395
ff gitrepo.sh
#1726184399
ed ./usr/bin/gitrepo.sh
#1726184431
ff \*.sh
#1726184439
ed ./usr/share/community/gitrepo/shell/gitlib.sh
#1726184444
ed ./usr/bin/gitrepo.sh
#1726184451
ed ./usr/share/community/gitrepo/shell/gitlib.sh
#1726184474
cpc ./usr/share/community/gitrepo/shell/gitlib.sh
#1726184475
ed ./usr/bin/gitrepo.sh
#1726184483
cpc ./usr/bin/gitrepo.sh
#1726184492
cpc ./usr/bin/buildiso.sh 
#1726184548
cd
#1726184550
cd iso-profiles/
#1726184550
dir
#1726184552
ff xfce
#1726184557
cd custom-profiles/
#1726184557
dir
#1726184559
cd ..
#1726184559
dir
#1726184562
cd community/
#1726184563
dir
#1726184565
cd ..
#1726184565
dir
#1726184568
cd custom-profiles/
#1726184569
dir
#1726184570
cd ..
#1726184675
cdb
#1726184679
cd build-iso
#1726184680
dir
#1726184686
cd chililinux/build-iso/
#1726184687
dir
#1726184692
ed action.yml
#1726184736
gpush
#1726184879
cd /var/lib/manjaro-tools/
#1726184879
dir
#1726184881
cd buildiso/
#1726184882
dir
#1726184884
tree
#1726184889
cd xfce/
#1726184890
dir
#1726184892
cd xfce/
#1726184893
dir
#1726184943
cd
#1726184947
cd .config/manjaro-tools/
#1726184948
dir
#1726184969
ed /etc/manjaro-tools/manjaro-tools.conf 
#1726185047
dir
#1726185052
cp /etc/manjaro-tools/manjaro-tools.conf .
#1726185053
dir
#1726185055
cd ..
#1726185056
dir
#1726185058
cd iso-profiles/
#1726185059
dir
#1726185061
ddel custom-profiles/
#1726185062
dir
#1726185064
cd community/
#1726185065
dir
#1726185068
cd xfce/
#1726185068
dir
#1726185073
ed profile.conf 
#1726185087
ed /etc/manjaro-tools/manjaro-tools.conf 
#1726185092
ed profile.conf 
#1726185108
ed user-repos.conf 
#1726185167
dir
#1726185194
cd /var/lib/manjaro-tools/
#1726185195
dir
#1726185197
cd buildiso/
#1726185198
dir
#1726185204
cd /var/lib/pacman
#1726185205
dir
#1726185207
cd local
#1726185234
cd manjaro-tools-base-git-r3038.3ecba91-1/
#1726185235
dir
#1726185237
ed files
#1726185250
cd /usr/lib/manjaro-tools/
#1726185250
dir
#1726185255
grep overlayfs *
#1726185269
ed util-iso.sh 
#1726185282
ed util-iso-mount.sh.sh 
#1726185285
ed util-iso-mount.sh
#1726185943
cdb
#1726185960
cd chililinux/build-iso/
#1726185961
dir
#1726185962
ed action.yml
#1726186027
gpush
#1726186045
buildiso.sh -o chililinux --auto
#1726186078
ed action.yml
#1726186098
gpush
#1726186134
ssh uXuNcuLhcXTE2AweNCWCcYenE@nyc1.tmate.io
#1726186211
ed action.yml
#1726186291
gpush
#1726186312
buildiso.sh -o chililinux --auto
#1726186341
prettier -w action.yml
#1726186344
dir
#1726186674
ed action.yml
#1726186858
sudo buildiso -i https://github.com/chililinux/iso-profiles /usr/share/manjaro-tools/
#1726186883
cd ttps://github.com/chililinux/iso-profiles 
#1726186909
cd /usr/share/manjaro-tools/
#1726186913
ls -la
#1726186926
sudo buildiso -i https://github.com/chililinux/iso-profiles
#1726186945
git clone https://github.com/chililinux/iso-profiles
#1726186948
sudo git clone https://github.com/chililinux/iso-profiles
#1726186954
sudo buildiso -i https://github.com/chililinux/iso-profiles
#1726186960
dir
#1726186974
sudo git clone https://github.com/chililinux/iso-profiles
#1726186978
dir
#1726186982
cd iso-
#1726186984
cd iso-profiles/
#1726186985
dir
#1726186989
sudo git clone https://github.com/chililinux/iso-profiles
#1726186994
dir
#1726186998
ddel iso-profiles/
#1726187005
sudo rm -rf iso-profiles/
#1726187011
sudo buildiso -i https://github.com/chililinux/iso-profiles
#1726187029
cd ..
#1726187029
dir
#1726187038
sudo buildiso -i https://github.com/chililinux/iso-profiles
#1726187064
sudo git clone https://github.com/chililinux/iso-profiles
#1726187069
dir
#1726187081
sudo buildiso -i https://github.com/chililinux/iso-profiles
#1726187087
dir
#1726187096
sudo git clone https://github.com/chililinux/iso-profiles
#1726187100
cd iso-
#1726187105
cd iso-profiles/
#1726187105
dir
#1726187114
git remote -v
#1726187126
git config --global --add safe.directory /usr/share/manjaro-tools/iso-profiles
#1726187128
git remote -v
#1726187134
sudo git clone https://github.com/chililinux/iso-profiles
#1726187146
dir
#1726187149
cd ..
#1726187150
dir
#1726187157
sudo buildiso -i https://github.com/chililinux/iso-profiles
#1726187164
dir
#1726187170
sudo git clone https://github.com/chililinux/iso-profiles
#1726187178
git config --global --add safe.directory /usr/share/manjaro-tools/iso-profiles
#1726187185
sudo buildiso -i https://github.com/chililinux/iso-profiles
#1726187190
dir
#1726190350
ed action.
#1726190356
cdb
#1726190359
cd chililinux/build-iso/
#1726190363
ed action.yml
#1726191272
cdls
#1726191274
cdb
#1726191276
cd gitrepo/
#1726191277
gpush
#1726192569
cdb
#1726192580
cd chilinux
#1726192584
cd chililinux
#1726192586
cd build-
#1726192588
cd build-iso
#1726192588
dir
#1726192590
ed action.yml
#1726192628
gpush
#1726192650
buildiso.sh -o chililinux
#1726193450
ed action.yml
#1726193619
gpush
#1726193624
buildiso.sh -o chililinux
#1726193730
ed action.yml
#1726193810
gpush
#1726193815
buildiso.sh -o chililinux
#1726193839
cd gitrepo
#1726193841
cdb
#1726193842
cd gitrepo
#1726193846
ff buildiso.sh
#1726193849
ed ./usr/bin/buildiso.sh
#1726193867
cpc./usr/bin/buildiso.sh
#1726193871
cpc ./usr/bin/buildiso.sh
#1726193873
cd -
#1726193877
cd chililinux
#1726193882
cd build-iso
#1726193882
dir
#1726193887
buildiso.sh -o chililinux
#1726193892
buildiso.sh -o chililinux -a
#1726193971
ed action.yml
#1726194131
prettier -w action.yml
#1726194133
gpush
#1726194165
ed action.yml
#1726194345
gpush
#1726194353
buildiso.sh -o chililinux -a
#1726194388
ed action.yml
#1726194484
gpush
#1726194488
buildiso.sh -o chililinux -a
#1726194631
ed action.yml
#1726194721
prettier -w action.yml
#1726194723
gpush
#1726194727
buildiso.sh -o chililinux -a
#1726194772
buildiso.sh -o chililinux
#1726195008
ed action.yml
#1726195140
gpush
#1726195145
buildiso.sh -o chililinux
#1726195151
buildiso.sh -o chililinux -a
#1726195223
ed action.yml
#1726195264
prettier -w action.yml
#1726195267
buildiso.sh -o chililinux -a
#1726195320
gpush
#1726195324
buildiso.sh -o chililinux -a
#1726195609
ed action.yml
#1726195642
gpush
#1726195650
buildiso.sh -o chililinux -a
#1726195692
ed action.yml
#1726195708
ff \*.yml
#1726195712
ed ./.github/workflows/edition.yml
#1726195738
cdb
#1726195743
cd gitrepo/
#1726195745
ff gitrepo.sh
#1726195749
ed ./usr/bin/gitrepo.sh
#1726195755
dir
#1726195763
ff \*.yml
#1726195780
cdb
#1726195803
cd chililinux/build-iso/
#1726195804
ls -la
#1726195911
buildiso.sh -o chililinux
#1726195947
cdb
#1726195949
cd gitrepo
#1726195950
dir
#1726195955
ff gitrepo.sh
#1726195963
ff buildiso.sh
#1726195966
ed ./usr/bin/buildiso.sh
#1726195993
cd -
#1726196019
cd chililinux/build-iso/
#1726196020
dir
#1726196025
ed action.yml
#1726196138
buildiso.sh -o chililinux
#1726196157
ed action.yml
#1726196412
cdb
#1726196413
cd gitrepo
#1726196418
ff buildiso.sh
#1726196425
ed ./usr/bin/buildiso.sh
#1726196435
gpush
#1726196440
cpc ./usr/bin/buildiso.sh
#1726196444
cd -
#1726196445
clear
#1726196458
cd chililinux
#1726196460
cd build-iso
#1726196460
dir
#1726196514
ed action.yml
#1726196547
sudo pacman -S overlayfs-tools
#1726196555
sudo pacman -Syu overlayfs-tools
#1726196578
yay -S overlayfs-tools
#1726196587
yay -Ss overlayfs
#1726196665
mhwd-kernel -li  # Listar kernels instalados
#1726196687
sudo mount -t overlay overlay -o lowerdir=/lower,upperdir=/upper,workdir=/work /mnt
#1726196814
ssh D4SwmxWxn6FnZjTVgaHEw383c@nyc1.tmate.io
#1726199108
ed action.yml
#1726199179
prettier -w action.yml
#1726199181
gpush
#1726199201
ed action.yml
#1726199217
prettier -w action.yml
#1726199224
gpush
#1726199731
ed action.yml
#1726199745
ff  \*.yml
#1726199751
ed ./.github/workflows/edition.yml
#1726199912
prettier -w ./.github/workflows/edition.yml
#1726199915
ed ./.github/workflows/edition.yml
#1726199929
gpush
#1726199961
buildiso.sh -o chililinux -a
#1726200006
ed ./.github/workflows/edition.yml
#1726200094
prettier -w ./.github/workflows/edition.yml
#1726200096
ed ./.github/workflows/edition.yml
#1726200111
prettier -w ./.github/workflows/edition.yml
#1726200115
gpush
#1726200120
prettier -w ./.github/workflows/edition.yml
#1726200125
buildiso.sh -o chililinux -a
#1726200202
ed ./.github/workflows/edition.yml
#1726200453
ssh AjgLWhkgDKeJ9G2n5khtSz3fu@nyc1.tmate.io
