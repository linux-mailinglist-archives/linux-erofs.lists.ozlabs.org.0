Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AEB6B22DF
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 12:26:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXRjB1w7wz3cf2
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 22:26:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXRhz2qlrz3cLs
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 22:26:42 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdTT6X8_1678361197;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdTT6X8_1678361197)
          by smtp.aliyun-inc.com;
          Thu, 09 Mar 2023 19:26:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: improve documentation for upcoming 1.6
Date: Thu,  9 Mar 2023 19:26:29 +0800
Message-Id: <20230309112630.74230-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230309112630.74230-1-hsiangkao@linux.alibaba.com>
References: <20230309112630.74230-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Refine README as well as add docs/INSTALL.md and docs/PERFORMANCE.md.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 README              | 241 ++++++++++++++++----------------------------
 docs/INSTALL.md     |  71 +++++++++++++
 docs/PERFORMANCE.md | 182 +++++++++++++++++++++++++++++++++
 3 files changed, 340 insertions(+), 154 deletions(-)
 create mode 100644 docs/INSTALL.md
 create mode 100644 docs/PERFORMANCE.md

diff --git a/README b/README
index 92b3128..6474ed1 100644
--- a/README
+++ b/README
@@ -1,7 +1,7 @@
 erofs-utils
 ===========
 
-userspace tools for EROFS filesystem, currently including:
+Userspace tools for EROFS filesystem, currently including:
 
   mkfs.erofs    filesystem formatter
   erofsfuse     FUSE daemon alternative
@@ -9,76 +9,60 @@ userspace tools for EROFS filesystem, currently including:
   fsck.erofs    filesystem compatibility & consistency checker as well
                 as extractor
 
-Dependencies & build
---------------------
 
- lz4 1.8.0+ for lz4 enabled [2], lz4 1.9.3+ highly recommended [4][5].
- XZ Utils 5.3.2alpha [6] or later versions for MicroLZMA enabled.
-
- libfuse 2.6+ for erofsfuse enabled as a plus.
-
-How to build with lz4-1.9.0 or above
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-To build, you can run the following commands in order:
-
-::
-
-	$ ./autogen.sh
-	$ ./configure
-	$ make
-
-mkfs.erofs binary will be generated under mkfs folder.
+EROFS filesystem overview
+-------------------------
 
-* For lz4 < 1.9.2, there are some stability issues about
-  LZ4_compress_destSize(). (lz4hc isn't impacted) [3].
+EROFS filesystem stands for Enhanced Read-Only File System.  It aims to
+form a generic read-only filesystem solution for various read-only use
+cases instead of just focusing on storage space saving without
+considering any side effects of runtime performance.
 
-** For lz4 = 1.9.2, there is a noticeable regression about
-   LZ4_decompress_safe_partial() [5], which impacts erofsfuse
-   functionality for legacy images (without 0PADDING).
+Typically EROFS could be considered in the following use scenarios:
+  - Firmwares in performance-sensitive systems, such as system
+    partitions of Android smartphones;
 
-How to build with lz4-1.8.0~1.8.3
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+  - Mountable immutable images such as container images for effective
+    metadata & data access compared with tar, cpio or other local
+    filesystems (e.g. ext4, XFS, btrfs, etc.)
 
-For these old lz4 versions, lz4hc algorithm cannot be supported
-without lz4-static installed due to LZ4_compress_HC_destSize()
-unstable api usage, which means lz4 will only be available if
-lz4-static isn't found.
+  - FSDAX-enabled rootfs for secure containers (Linux 5.15+);
 
-On Fedora, lz4-static can be installed by using:
+  - Live CDs which need a set of files with another high-performance
+    algorithm to optimize startup time; others files for archival
+    purposes only are not needed;
 
-	yum install lz4-static.x86_64
+  - and more.
 
-However, it's still not recommended using those versions directly
-since there are serious bugs in these compressors, see [2] [3] [4]
-as well.
+Note that all EROFS metadata is uncompressed by design, so that you
+could take EROFS as a drop-in read-only replacement of ext4, XFS,
+btrfs, etc. without any compression-based dependencies and EROFS can
+bring more effective filesystem accesses to users with reduced
+metadata.
 
-How to build with liblzma
-~~~~~~~~~~~~~~~~~~~~~~~~~
+For more details of EROFS filesystem itself, please refer to:
+https://www.kernel.org/doc/html/next/filesystems/erofs.html
 
-In order to enable LZMA support, build with the following commands:
-	$ ./configure --enable-lzma
-	$ make
+For more details on how to build erofs-utils, see `docs/INSTALL.md`.
 
-Additionally, you could specify liblzma build paths with:
-	--with-liblzma-incdir and --with-liblzma-libdir
+For more details about filesystem performance, see
+`docs/PERFORMANCE.md`.
 
 
 mkfs.erofs
 ----------
 
-two main kinds of EROFS images can be generated: (un)compressed.
+Two main kinds of EROFS images can be generated: (un)compressed images.
 
- - For uncompressed images, there will be none of compression
-   files in these images. However, it can decide whether the tail
-   block of a file should be inlined or not properly [1].
+ - For uncompressed images, there will be none of compresssed files in
+   these images.  However, it can decide whether the tail block of a
+   file should be inlined or not properly [1].
 
- - For compressed images, it'll try to use specific algorithms
-   first for each regular file and see if storage space can be
-   saved with compression. If not, fallback to an uncompressed
-   file.
+ - For compressed images, it'll try to use the given algorithms first
+   for each regular file and see if storage space can be saved with
+   compression. If not, fallback to an uncompressed file.
 
-How to generate EROFS images (lz4 for Linux 5.3+, lzma for Linux 5.16+)
+How to generate EROFS images (LZ4 for Linux 5.3+, LZMA for Linux 5.16+)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Currently lz4(hc) and lzma are available for compression, e.g.
@@ -113,12 +97,55 @@ Note that large pcluster size can cause bad random performance, so
 please evaluate carefully in advance. Or make your own per-(sub)file
 compression strategies according to file access patterns if needed.
 
+How to generate EROFS images with multiple algorithms (Linux 5.16+)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It's possible to generate an EROFS image with files in different
+algorithms due to various purposes.  For example, LZMA for archival
+purposes and LZ4 for runtime purposes.
+
+In order to use alternative algorithms, just specify two or more
+compressing configurations together separated by ':' like below:
+    -zlzma:lz4hc,12:lzma,9 -C32768
+
+Although mkfs still choose the first one by default, you could try to
+write a compress-hints file like below:
+    4096  1 .*\.so$
+    32768 2 .*\.txt$
+    4096    sbin/.*$
+    16384 0 .*
+
+and specify with `--compress-hints=` so that ".so" files will use
+"lz4hc,12" compression with 4k pclusters, ".txt" files will use
+"lzma,9" compression with 32k pclusters, files  under "/sbin" will use
+the default "lzma" compression with 4k plusters and other files will
+use "lzma" compression with 16k pclusters.
+
+Note that the largest pcluster size should be specified with the "-C"
+option (here 32k pcluster size), otherwise all larger pclusters will be
+limited.
+
+How to generate well-compressed EROFS images
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Even if EROFS is not designed for such purposes in the beginning, it
+could still produce some smaller images (not always) compared to other
+approaches with better performance (see `docs/PERFORMANCE.md`).  In
+order to build well-compressed EROFS images, try the following options:
+ -C1048576                     (5.13+)
+ -Eztailpacking                (5.16+)
+ -Efragments / -Eall-fragments ( 6.1+);
+ -Ededupe                      ( 6.1+).
+
+Also EROFS uses lz4hc level 9 by default, whereas some other approaches
+use lz4hc level 12 by default.  So please explicitly specify
+`-zlz4hc,12 ` for comparison purposes.
+
 How to generate legacy EROFS images (Linux 4.19+)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Decompression inplace and compacted indexes have been introduced in
-Linux upstream v5.3, which are not forward-compatible with older
-kernels.
+Linux v5.3, which are not forward-compatible with older kernels.
 
 In order to generate _legacy_ EROFS images for old kernels,
 consider adding "-E legacy-compress" to the command line, e.g.
@@ -153,21 +180,6 @@ significant I/O overhead, double caching, etc.)
 
 Therefore, NEVER use it if performance is the top concern.
 
-Note that extended attributes and ACLs aren't implemented yet due to
-the current Android use case vs limited time. If you are interested,
-contribution is, as always, welcome.
-
-How to build erofsfuse
-~~~~~~~~~~~~~~~~~~~~~~
-
-It's disabled by default as an experimental feature for now due to
-the extra libfuse dependency, to enable and build it manually:
-
-	$ ./configure --enable-fuse
-	$ make
-
-erofsfuse binary will be generated under fuse folder.
-
 How to mount an EROFS image with erofsfuse
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -190,36 +202,8 @@ dump.erofs and fsck.erofs
 
 dump.erofs and fsck.erofs are used to analyze, check, and extract
 EROFS filesystems. Note that extended attributes and ACLs are still
-unsupported when extracting images with fsck.erofs.
-
-Container images
-----------------
-
-EROFS filesystem is well-suitably used for container images with
-advanced features like chunk-based files, multi-devices (blobs)
-and new fscache backend for lazy pulling and cache management, etc.
-
-For example, CNCF Dragonfly Nydus image service [7] introduces an
-(EROFS-compatible) RAFS v6 image format to overcome flaws of the
-current OCIv1 tgz images so that:
-
- - Images can be downloaded on demand in chunks aka lazy pulling with
-   new fscache backend (5.19+) or userspace block devices (5.16+);
-
- - Finer chunk-based content-addressable data deduplication to minimize
-   storage, transmission and memory footprints;
-
- - Merged filesystem tree to remove all metadata of intermediate layers
-   as an option;
-
- - (e)stargz, zstd::chunked and other formats can be converted and run
-   on the fly;
-
- - and more.
-
-Apart from Dragonfly Nydus, a native user daemon is planned to be added
-to erofs-utils to parse EROFS, (e)stargz and zstd::chunked images from
-network too as a real part of EROFS filesystem project.
+unsupported when extracting images with fsck.erofs.  If you are
+interested, contribution is, as always, welcome.
 
 
 Contribution
@@ -233,58 +217,7 @@ patches or feedback to:
 Comments
 --------
 
-[1] According to the EROFS on-disk format, the tail block of files
-    could be inlined aggressively with its metadata in order to reduce
-    the I/O overhead and save the storage space (called tail-packing).
-
-[2] There was a bug until lz4-1.8.3, which can crash erofs-utils
-    randomly. Fortunately bugfix by our colleague Qiuyang Sun was
-    merged in lz4-1.9.0.
-
-    For more details, please refer to
-    https://github.com/lz4/lz4/commit/660d21272e4c8a0f49db5fc1e6853f08713dff82
-
-[3] There were many bugfixes merged into lz4-1.9.2 for
-    LZ4_compress_destSize(), and I once ran into some crashs due to
-    those issues. * Again lz4hc is not affected. *
-
-    [LZ4_compress_destSize] Allow 2 more bytes of match length
-    https://github.com/lz4/lz4/commit/690009e2c2f9e5dcb0d40e7c0c40610ce6006eda
-
-    [LZ4_compress_destSize] Fix rare data corruption bug
-    https://github.com/lz4/lz4/commit/6bc6f836a18d1f8fd05c8fc2b42f1d800bc25de1
-
-    [LZ4_compress_destSize] Fix overflow condition
-    https://github.com/lz4/lz4/commit/13a2d9e34ffc4170720ce417c73e396d0ac1471a
-
-    [LZ4_compress_destSize] Fix off-by-one error in fix
-    https://github.com/lz4/lz4/commit/7c32101c655d93b61fc212dcd512b87119dd7333
-
-    [LZ4_compress_destSize] Fix off-by-one error
-    https://github.com/lz4/lz4/commit/d7cad81093cd805110291f84d64d385557d0ffba
-
-    since upstream lz4 doesn't have stable branch for old versions, it's
-    preferred to use latest upstream lz4 library (although some regressions
-    could happen since new features are also introduced to latest upstream
-    version as well) or backport all stable bugfixes to old stable versions,
-    e.g. our unofficial lz4 fork: https://github.com/erofs/lz4
-
-[4] LZ4HC didn't compress long zeroed buffer properly with
-    LZ4_compress_HC_destSize()
-    https://github.com/lz4/lz4/issues/784
-
-    which has been resolved in
-    https://github.com/lz4/lz4/commit/e7fe105ac6ed02019d34731d2ba3aceb11b51bb1
-
-    and already included in lz4-1.9.3, see:
-    https://github.com/lz4/lz4/releases/tag/v1.9.3
-
-[5] LZ4_decompress_safe_partial is broken in 1.9.2
-    https://github.com/lz4/lz4/issues/783
-
-    which is also resolved in lz4-1.9.3.
-
-[6] https://tukaani.org/xz/xz-5.3.2alpha.tar.xz
-
-[7] https://nydus.dev
-    https://github.com/dragonflyoss/image-service
+[1] According to the EROFS on-disk format, the tail blocks of files
+    could be inlined aggressively with their metadata (called
+    tail-packing) in order to minimize the extra I/Os and the storage
+    space.
diff --git a/docs/INSTALL.md b/docs/INSTALL.md
new file mode 100644
index 0000000..2e818da
--- /dev/null
+++ b/docs/INSTALL.md
@@ -0,0 +1,71 @@
+This document describes how to configure and build erofs-utils from
+source.
+
+See the [README](../README) file in the top level directory about
+the brief overview of erofs-utils.
+
+## Dependencies & build
+
+LZ4 1.9.3+ for LZ4(HC) enabled [^1].
+
+[XZ Utils 5.3.2alpha+](https://tukaani.org/xz/xz-5.3.2alpha.tar.gz) for
+LZMA enabled, [XZ Utils 5.4+](https://tukaani.org/xz/xz-5.4.1.tar.gz)
+highly recommended.
+
+libfuse 2.6+ for erofsfuse enabled.
+
+[^1]: It's not recommended to use LZ4 versions under 1.9.3 since
+unexpected crashes could make trouble to end users due to broken
+LZ4_compress_destSize() (fixed in v1.9.2),
+[LZ4_compress_HC_destSize()](https://github.com/lz4/lz4/commit/660d21272e4c8a0f49db5fc1e6853f08713dff82) or
+[LZ4_decompress_safe_partial()](https://github.com/lz4/lz4/issues/783).
+
+## How to build with LZ4
+
+To build, the following commands can be used in order:
+
+``` sh
+$ ./autogen.sh
+$ ./configure
+$ make
+```
+
+`mkfs.erofs`, `dump.erofs` and `fsck.erofs` binaries will be
+generated under the corresponding folders.
+
+## How to build with liblzma
+
+In order to enable LZMA support, build with the following commands:
+
+``` sh
+$ ./configure --enable-lzma
+$ make
+```
+
+Additionally, you could specify liblzma target paths with
+`--with-liblzma-incdir` and `--with-liblzma-libdir` manually.
+
+## How to build erofsfuse
+
+It's disabled by default as an experimental feature for now due
+to the extra libfuse dependency, to enable and build it manually:
+
+``` sh
+$ ./configure --enable-fuse
+$ make
+```
+
+`erofsfuse` binary will be generated under `fuse` folder.
+
+## How to install erofs-utils manually
+
+Use the following command to install erofs-utils binaries:
+
+``` sh
+# make install
+```
+
+By default, `make install` will install all the files in
+`/usr/local/bin`, `/usr/local/lib` etc.  You can specify an
+installation prefix other than `/usr/local` using `--prefix`,
+for instance `--prefix=$HOME`.
diff --git a/docs/PERFORMANCE.md b/docs/PERFORMANCE.md
new file mode 100644
index 0000000..202f2fe
--- /dev/null
+++ b/docs/PERFORMANCE.md
@@ -0,0 +1,182 @@
+# Test setup
+
+Processor: x86_64, Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz * 2 vcores
+
+Storage: Cloud disk, 3000 IOPS upper limit
+
+OS Kernel: Linux 6.2
+
+Softwares: LZ4 1.9.3, erofs-utils 1.6, squashes-tools 4.5.1
+
+Disclaimer: Test results could be varied from different hardware and/or data patterns. Therefore, the following results are ONLY for reference.
+
+# Benchmark on multiple files
+
+[rootfs of Debian docker image](https://github.com/debuerreotype/docker-debian-artifacts/blob/dist-amd64/bullseye/rootfs.tar.xz?raw=true) is used as the dataset, which contains 7000+ files and directories.
+Note that that dataset can be replaced regularly, and the SHA1 of the snapshot "rootfs.tar.xz" used here is "aee9b01a530078dbef8f08521bfcabe65b244955".
+
+## Image size
+
+|   Size    | Filesystem | Cluster size | Build options                                             |
+|-----------|------------|--------------|-----------------------------------------------------------|
+| 124669952 | erofs      | uncompressed | -T0 [^1]                                                  |
+| 124522496 | squashfs   | uncompressed | -noD -noI -noX -noF -no-xattrs -all-time 0 -no-duplicates |
+|  73601024 | squashfs   | 4096         | -b 4096 -comp lz4 -Xhc -no-xattrs -all-time 0             |
+|  73121792 | erofs      | 4096         | -zlz4hc,12 [^2] -C4096 -Efragments -T0                    |
+|  67162112 | squashfs   | 16384        | -b 16384 -comp lz4 -Xhc -no-xattrs -all-time 0            |
+|  65478656 | erofs      | 16384        | -zlz4hc,12 -C16384 -Efragments -T0                        |
+|  61456384 | squashfs   | 65536        | -b 65536 -comp lz4 -Xhc -no-xattrs -all-time 0            |
+|  59834368 | erofs      | 65536        | -zlz4hc,12 -C65536 -Efragments -T0                        |
+|  59150336 | squashfs   | 131072       | -b 131072 -comp lz4 -Xhc -no-xattrs -all-time 0           |
+|  58515456 | erofs      | 131072       | -zlz4hc,12 -C131072 -Efragments -T0                       |
+
+[^1]: Forcely reset all timestamps to match squashfs on-disk basic inodes for now.
+[^2]: Because squashfs uses level 12 for LZ4HC by default.
+
+## Sequential data access
+
+hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "tar cf - . | cat > /dev/null"
+
+| Filesystem | Cluster size | Time                            |
+|------------|--------------|---------------------------------|
+| squashfs   | 4096         | 10.257 s ±  0.031 s             |
+| erofs      | uncompressed |  1.111 s ±  0.022 s             |
+| squashfs   | uncompressed |  1.034 s ±  0.020 s             |
+| squashfs   | 131072       | 941.3 ms ±   7.5 ms             |
+| erofs      | 4096         | 848.1 ms ±  17.8 ms             |
+| erofs      | 131072       | 724.2 ms ±  11.0 ms             |
+
+## Sequential metadata access
+
+hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "tar cf /dev/null ."
+
+| Filesystem | Cluster size | Time                            |
+|------------|--------------|---------------------------------|
+| erofs      | uncompressed | 419.6 ms ±   8.2 ms             |
+| squashfs   | 4096         | 142.5 ms ±   5.4 ms             |
+| squashfs   | uncompressed | 129.2 ms ±   3.9 ms             |
+| squashfs   | 131072       | 125.4 ms ±   4.0 ms             |
+| erofs      | 4096         |  75.5 ms ±   3.5 ms             |
+| erofs      | 131072       |  65.8 ms ±   3.6 ms             |
+
+[ Note that erofs-utils currently doesn't perform quite well for such cases due to metadata arrangement when building.  It will be fixed in the later versions. ]
+
+## Small random data access (~7%)
+
+find mnt -type f -printf "%p\n" | sort -R | head -n 500 > list.txt
+hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs cat > /dev/null"
+
+| Filesystem | Cluster size | Time                            |
+|------------|--------------|---------------------------------|
+| squashfs   | 4096         |  1.386 s ±  0.032 s             |
+| squashfs   | uncompressed |  1.083 s ±  0.044 s             |
+| squashfs   | 131072       |  1.067 s ±  0.046 s             |
+| erofs      | 4096         | 249.6 ms ±   6.5 ms             |
+| erofs      | uncompressed | 237.8 ms ±   6.3 ms             |
+| erofs      | 131072       | 189.6 ms ±   7.8 ms             |
+
+
+## Small random metadata access (~7%)
+
+find mnt -type f -printf "%p\n" | sort -R | head -n 500 > list.txt
+hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs stat"
+
+| Filesystem | Cluster size | Time                            |
+|------------|--------------|---------------------------------|
+| squashfs   | 4096         | 817.0 ms ±  34.5 ms             |
+| squashfs   | 131072       | 801.0 ms ±  40.1 ms             |
+| squashfs   | uncompressed | 741.3 ms ±  18.2 ms             |
+| erofs      | uncompressed | 197.8 ms ±   4.1 ms             |
+| erofs      | 4096         |  63.1 ms ±   2.0 ms             |
+| erofs      | 131072       |  60.7 ms ±   3.6 ms             |
+
+## Full random data access (~100%)
+
+find mnt -type f -printf "%p\n" | sort -R > list.txt
+hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs cat > /dev/null"
+
+| Filesystem | Cluster size | Time                            |
+|------------|--------------|---------------------------------|
+| squashfs   | 4096         | 20.668 s ±  0.040 s             |
+| squashfs   | uncompressed | 12.543 s ±  0.041 s             |
+| squashfs   | 131072       | 11.753 s ±  0.412 s             |
+| erofs      | uncompressed |  1.493 s ±  0.023 s             |
+| erofs      | 4096         |  1.223 s ±  0.013 s             |
+| erofs      | 131072       | 598.2 ms ±   6.6 ms             |
+
+## Full random metadata access (~100%)
+
+find mnt -type f -printf "%p\n" | sort -R > list.txt
+hyperfine -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1" "cat list.txt | xargs stat"
+
+| Filesystem | Cluster size | Time                            |
+|------------|--------------|---------------------------------|
+| squashfs   | 131072       |  9.212 s ±  0.467 s             |
+| squashfs   | 4096         |  8.905 s ±  0.147 s             |
+| squashfs   | uncompressed |  7.961 s ±  0.045 s             |
+| erofs      | 4096         | 661.2 ms ±  14.9 ms             |
+| erofs      | uncompressed | 125.8 ms ±   6.6 ms             |
+| erofs      | 131072       | 119.6 ms ±   5.5 ms             |
+
+
+# FIO benchmark on a single large file
+
+`silesia.tar` (203M) is used to benchmark, which could be generated from unzipping [silesia.zip](http://mattmahoney.net/dc/silesia.zip) and tar.
+
+## Image size
+
+|   Size    | Filesystem | Cluster size | Build options                                             |
+|-----------|------------|--------------|-----------------------------------------------------------|
+| 114339840 | squashfs   | 4096         | -b 4096 -comp lz4 -Xhc -no-xattrs                         |
+| 104972288 | erofs      | 4096         | -zlz4hc,12 -C4096                                         |
+|  98033664 | squashfs   | 16384        | -b 4096 -comp lz4 -Xhc -no-xattrs                         |
+|  89571328 | erofs      | 16384        | -zlz4hc,12 -C16384                                        |
+|  85143552 | squashfs   | 65536        | -b 65536 -comp lz4 -Xhc -no-xattrs                        |
+|  81211392 | squashfs   | 131072       | -b 131072 -comp lz4 -Xhc -no-xattrs                       |
+|  80519168 | erofs      | 65536        | -zlz4hc,12 -C65536                                        |
+|  78888960 | erofs      | 131072       | -zlz4hc,12 -C131072                                       |
+
+## Sequential I/Os
+
+fio -filename=silesia.tar -bs=4k -rw=read -name=job1
+
+| Filesystem | Cluster size | Bandwidth |
+|------------|--------------|-----------|
+| erofs      | 65536        | 624 MiB/s |
+| erofs      | 16384        | 600 MiB/s |
+| erofs      | 4096         | 569 MiB/s |
+| erofs      | 131072       | 535 MiB/s |
+| squashfs   | 131072       | 236 MiB/s |
+| squashfs   | 65536        | 157 MiB/s |
+| squashfs   | 16384        | 55.2MiB/s |
+| squashfs   | 4096         | 12.5MiB/s |
+
+## Full Random I/Os
+
+fio -filename=silesia.tar -bs=4k -rw=randread -name=job1
+
+| Filesystem | Cluster size | Bandwidth |
+|------------|--------------|-----------|
+| erofs      | 131072       | 242 MiB/s |
+| squashfs   | 131072       | 232 MiB/s |
+| erofs      | 65536        | 198 MiB/s |
+| squashfs   | 65536        | 150 MiB/s |
+| erofs      | 16384        | 96.4MiB/s |
+| squashfs   | 16384        | 49.5MiB/s |
+| erofs      | 4096         | 33.7MiB/s |
+| squashfs   | 4096         | 6817KiB/s |
+
+## Small Random I/Os (5%)
+
+fio -filename=mnt/silesia.tar -bs=4k -rw=randread --io_size=10m -name=job1
+
+| Filesystem | Cluster size | Bandwidth |
+|------------|--------------|-----------|
+| erofs      | 131072       | 19.2MiB/s |
+| erofs      | 65536        | 16.9MiB/s |
+| squashfs   | 131072       | 15.1MiB/s |
+| erofs      | 16384        | 14.7MiB/s |
+| squashfs   | 65536        | 13.8MiB/s |
+| erofs      | 4096         | 13.0MiB/s |
+| squashfs   | 16384        | 11.7MiB/s |
+| squashfs   | 4096         | 4376KiB/s |
-- 
2.24.4

