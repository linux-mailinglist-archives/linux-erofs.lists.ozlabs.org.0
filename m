Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44DB731510
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 12:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686824275;
	bh=r6H4PCpviefXYI95IaO9dYJiG2+PAvpqzJzz9zHKsrM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=gNCfiRDydg+8PB3RyRJvmUVltBS8IaymIs8V0uMFkRDlc0gHkbSTqy5/UAvwkLCH7
	 J163Ghgi5hkILG5kTGCRO+BnVuF/+KfQF/qwVtLSth7fQHQdxYFEXvYnrSeHFKPBg5
	 9eLTYpulRvzN1q6Ul/1OfWW7IX8mC8NcR9NMRNuTs5448GTYLSGb9ZBhLy01uWJMZf
	 xMB5vtajalp2G5ySSQo4SzU9eDh4HJoIxIewbNwpuHmudJknVZXy2sw0Vfh3TqHNTj
	 VxkgPwPBd8rJ693cFGmj7+Zu56u+A1UAntIvqxETBSN/QaqpPCndxIDI5GP1J0+Myy
	 ySWk09jmRkh5g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhdXM6jGVz3bVP
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jun 2023 20:17:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.46; helo=frasgout13.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhdXC6rqNz30XQ
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 20:17:45 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QhdHt5kG5z9xyNp
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Jun 2023 18:07:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwDXvYc55YpkT63TCA--.7908S2;
	Thu, 15 Jun 2023 10:17:33 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/4] erofs-utils: code-refactoring for erofs compressor 
Date: Thu, 15 Jun 2023 18:17:23 +0800
Message-Id: <20230615101727.946446-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwDXvYc55YpkT63TCA--.7908S2
X-Coremail-Antispam: 1UD129KBjvJXoW3uF4kXw4UCF48CFyxZFy5urg_yoWkZr4kpw
	n8uryfKr48JF92krs7CF47WrWUCr10y345J34xAr1rXw1UAr1xtrnxtrn5Ary7Grya93ZY
	qw10vryjgr9xJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK
	6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUz3kuDUUUU
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

simplify and unify erofs compressor code.

Test by following script:
```shell
#!/bin/bash

FSCK=`which fsck.erofs`
MKFS=`which mkfs.erofs`
DPFS=`which dump.erofs`
SRC_DIR=./src
IMGDIR=./image/

mkdir -p ${IMGDIR}
create_erofsimg()
{
	local img=$1
	echo "MKFS [mkfs.erofs $@]"
	$MKFS $@ ${SRC_DIR}
}

#test mkfs.erofs
create_erofsimg  ${IMGDIR}/erofs-raw32.img -E force-inode-compact || exit -11
create_erofsimg  ${IMGDIR}/erofs-raw64.img -E force-inode-extended || exit -12
create_erofsimg  ${IMGDIR}/erofs-lzma-4k.img -zlzma,9 || exit -13
create_erofsimg  ${IMGDIR}/erofs-lzma-bigpcluster-8k.img -zlzma,9 -C 8192 || exit -14
create_erofsimg  ${IMGDIR}/erofs-lzma-rand-bigpcluster-1M.img -zlzma,9 -C 1048576 --random-pclusterblks || exit -15
create_erofsimg  ${IMGDIR}/erofs-lz4-4k.img -zlz4hc,9 || exit -16
create_erofsimg  ${IMGDIR}/erofs-lz4-rand-bigpcluster-1M.img -zlz4hc,9 -C 1048576 --random-pclusterblks || exit -17
create_erofsimg  ${IMGDIR}/erofs-rand-alg-1M.img -zlz4:lzma,9:lz4hc,9 -C 1048576 --random-pclusterblks --random-algorithms || exit -18
create_erofsimg  ${IMGDIR}/erofs-rand-frag-1M.img -zlz4:lzma,9:lz4hc,9 -C 8192 -Efragments,8192 --random-pclusterblks --random-algorithms || exit -19
create_erofsimg  ${IMGDIR}/erofs-rand-frag-dedupe-1M.img -zlz4:lzma,9:lz4hc,9 -C 1048576 -Efragments,1048576 -Ededupe --random-algorithms || exit -20

#test {dump,fsck}.erofs
for img in `ls ${IMGDIR}/*.img`
do
	echo "FSCK_DUMP==================$img====================="
	mkdir -p ${img}_dir && $FSCK $img && $FSCK --extract=${img}_dir $img
	$DPFS $img
done
ls -F ${IMGDIR}/
```

Output:
--------------------------------------------
MKFS [mkfs.erofs ./image//erofs-raw32.img -E force-inode-compact]
mkfs.erofs 1.6-g566da452-dirty
Build completed.
MKFS [mkfs.erofs ./image//erofs-raw64.img -E force-inode-extended]
mkfs.erofs 1.6-g566da452-dirty
Build completed.
MKFS [mkfs.erofs ./image//erofs-lzma-4k.img -zlzma,9]
mkfs.erofs 1.6-g566da452-dirty
<W> erofs: z_erofs_compress_init() Line[1105] EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
<W> erofs: z_erofs_compress_init() Line[1106] Note that it may take more time since the compressor is still single-threaded for now.
Build completed.
MKFS [mkfs.erofs ./image//erofs-lzma-bigpcluster-8k.img -zlzma,9 -C 8192]
mkfs.erofs 1.6-g566da452-dirty
<W> erofs: z_erofs_compress_init() Line[1105] EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
<W> erofs: z_erofs_compress_init() Line[1106] Note that it may take more time since the compressor is still single-threaded for now.
Build completed.
MKFS [mkfs.erofs ./image//erofs-lzma-rand-bigpcluster-1M.img -zlzma,9 -C 1048576 --random-pclusterblks]
mkfs.erofs 1.6-g566da452-dirty
<W> erofs: z_erofs_compress_init() Line[1105] EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
<W> erofs: z_erofs_compress_init() Line[1106] Note that it may take more time since the compressor is still single-threaded for now.
Build completed.
MKFS [mkfs.erofs ./image//erofs-lz4-4k.img -zlz4hc,9]
mkfs.erofs 1.6-g566da452-dirty
Build completed.
MKFS [mkfs.erofs ./image//erofs-lz4-rand-bigpcluster-1M.img -zlz4hc,9 -C 1048576 --random-pclusterblks]
mkfs.erofs 1.6-g566da452-dirty
Build completed.
MKFS [mkfs.erofs ./image//erofs-rand-alg-1M.img -zlz4:lzma,9:lz4hc,9 -C 1048576 --random-pclusterblks --random-algorithms]
mkfs.erofs 1.6-g566da452-dirty
<W> erofs: z_erofs_compress_init() Line[1105] EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
<W> erofs: z_erofs_compress_init() Line[1106] Note that it may take more time since the compressor is still single-threaded for now.
Build completed.
MKFS [mkfs.erofs ./image//erofs-rand-frag-1M.img -zlz4:lzma,9:lz4hc,9 -C 8192 -Efragments,8192 --random-pclusterblks --random-algorithms]
mkfs.erofs 1.6-g566da452-dirty
<W> erofs: main() Line[790] EXPERIMENTAL compressed fragments feature in use. Use at your own risk!
<W> erofs: z_erofs_compress_init() Line[1105] EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
<W> erofs: z_erofs_compress_init() Line[1106] Note that it may take more time since the compressor is still single-threaded for now.
Build completed.
MKFS [mkfs.erofs ./image//erofs-rand-frag-dedupe-1M.img -zlz4:lzma,9:lz4hc,9 -C 1048576 -Efragments,1048576 -Ededupe --random-algorithms]
mkfs.erofs 1.6-g566da452-dirty
<W> erofs: main() Line[790] EXPERIMENTAL compressed fragments feature in use. Use at your own risk!
<W> erofs: main() Line[793] EXPERIMENTAL data deduplication feature in use. Use at your own risk!
<W> erofs: z_erofs_compress_init() Line[1105] EXPERIMENTAL MicroLZMA feature in use. Use at your own risk!
<W> erofs: z_erofs_compress_init() Line[1106] Note that it may take more time since the compressor is still single-threaded for now.
Build completed.
FSCK_DUMP==================./image//erofs-lz4-4k.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            6
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          36
Filesystem lz4_max_distance:                  65535
Filesystem sb_extslots:                       0
Filesystem inode count:                       7
Filesystem created:                           Thu Jun 15 18:11:51 2023
Filesystem features:                          sb_csum mtime 0padding 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-lz4-rand-bigpcluster-1M.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            6
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem compr_algs:                        lz4, lz4hc
Filesystem sb_extslots:                       0
Filesystem inode count:                       7
Filesystem created:                           Thu Jun 15 18:11:51 2023
Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-lzma-4k.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            6
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem compr_algs:                        lzma
Filesystem sb_extslots:                       0
Filesystem inode count:                       7
Filesystem created:                           Thu Jun 15 18:11:50 2023
Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-lzma-bigpcluster-8k.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            6
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem compr_algs:                        lzma
Filesystem sb_extslots:                       0
Filesystem inode count:                       7
Filesystem created:                           Thu Jun 15 18:11:50 2023
Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-lzma-rand-bigpcluster-1M.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            6
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem compr_algs:                        lzma
Filesystem sb_extslots:                       0
Filesystem inode count:                       7
Filesystem created:                           Thu Jun 15 18:11:50 2023
Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-rand-alg-1M.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            6
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem compr_algs:                        lz4, lz4hc, lzma
Filesystem sb_extslots:                       0
Filesystem inode count:                       7
Filesystem created:                           Thu Jun 15 18:11:51 2023
Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-rand-frag-1M.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            2
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem packed nid:                        71
Filesystem compr_algs:                        lz4, lz4hc, lzma
Filesystem sb_extslots:                       0
Filesystem inode count:                       8
Filesystem created:                           Thu Jun 15 18:11:51 2023
Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster fragments dedupe 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-rand-frag-dedupe-1M.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            2
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          37
Filesystem packed nid:                        71
Filesystem compr_algs:                        lz4, lz4hc, lzma
Filesystem sb_extslots:                       0
Filesystem inode count:                       8
Filesystem created:                           Thu Jun 15 18:11:51 2023
Filesystem features:                          sb_csum mtime 0padding compr_cfgs big_pcluster fragments dedupe 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-raw32.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            17
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          36
Filesystem lz4_max_distance:                  65535
Filesystem sb_extslots:                       0
Filesystem inode count:                       7
Filesystem created:                           Thu Jun 15 18:11:50 2023
Filesystem features:                          sb_csum mtime 
Filesystem UUID:                              not available
FSCK_DUMP==================./image//erofs-raw64.img=====================
Filesystem magic number:                      0xE0F5E1E2
Filesystem blocks:                            17
Filesystem inode metadata start block:        0
Filesystem shared xattr metadata start block: 0
Filesystem root nid:                          36
Filesystem lz4_max_distance:                  65535
Filesystem sb_extslots:                       0
Filesystem inode count:                       7
Filesystem created:                           Thu Jun 15 18:11:50 2023
Filesystem features:                          sb_csum mtime 
Filesystem UUID:                              not available
erofs-lz4-4k.img			erofs-lzma-4k.img_dir/			 erofs-rand-alg-1M.img		erofs-rand-frag-dedupe-1M.img_dir/
erofs-lz4-4k.img_dir/			erofs-lzma-bigpcluster-8k.img		 erofs-rand-alg-1M.img_dir/	erofs-raw32.img
erofs-lz4-rand-bigpcluster-1M.img	erofs-lzma-bigpcluster-8k.img_dir/	 erofs-rand-frag-1M.img		erofs-raw32.img_dir/
erofs-lz4-rand-bigpcluster-1M.img_dir/	erofs-lzma-rand-bigpcluster-1M.img	 erofs-rand-frag-1M.img_dir/	erofs-raw64.img
erofs-lzma-4k.img			erofs-lzma-rand-bigpcluster-1M.img_dir/  erofs-rand-frag-dedupe-1M.img	erofs-raw64.img_dir/

Guo Xuenan (4):
  erofs-utils: lib: refactor erofs compressors init
  erofs-utils: lib: unify all identical compressor print function
  erofs-utils: simplify erofs compressor init and exit
  erofs-utils: dump: add some superblock fields

 dump/main.c              |  13 +++
 fsck/main.c              |  17 +---
 include/erofs/compress.h |   7 +-
 include/erofs/internal.h |   1 +
 lib/compress.c           |  87 ++++++++------------
 lib/compressor.c         | 173 ++++++++++++++++++++++++++++-----------
 lib/compressor.h         |  23 ++++--
 lib/compressor_liblzma.c |   4 -
 lib/compressor_lz4.c     |   2 -
 lib/compressor_lz4hc.c   |   3 -
 lib/super.c              |   5 ++
 mkfs/main.c              |  18 +---
 12 files changed, 207 insertions(+), 146 deletions(-)

-- 
2.31.1

