Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF64D2CA
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Jun 2019 18:08:57 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45V6FL71d0zDr5V
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 02:08:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45V6Dn4qpmzDqDd
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2019 02:08:25 +1000 (AEST)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id B325C9B162EE99F7F5CB;
 Fri, 21 Jun 2019 00:08:18 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 00:08:06 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/8] staging: erofs: decompression inplace approach
Date: Fri, 21 Jun 2019 00:07:11 +0800
Message-ID: <20190620160719.240682-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
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
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is patch v2 of erofs decompression inplace approach, no major
issues observed after v1 preliminarily applied to our products, and
changes from v1 are minor, so I drop "RFC" tag from this version.

See the bottom lines which are taken from RFC PATCH v1 and describe
the principle of these technologies.

The series is based on the latest staging-next since all dependencies
have already been merged.

changelog from v1:
 - keep Z_EROFS_NR_INLINE_PAGEVECS in unzip_vle.h after switching to
   new decompression backend;
 - add some DBG_BUGONs in new decompression backend to observe
   potential issues;
 - minor code cleanup.

8<--------

Hi,

After working on for more than half a year, the detail of erofs decompression
inplace is almost determined and ready for linux-next.

Currently, inplace IO is used if the whole compressed data is used
in order to reduce compressed pages extra memory overhead and an extra
memcpy (the only one memcpy) will be used for each inplace IO since
temporary buffer is needed to keep decompressing safe for inplace IO.

However, most of lz-based decompression algorithms support decompression
inplace by their algorithm designs, such as LZ4, LZO, etc.

If iend - oend margin is large enough, decompression inplace can be done
in the same buffer safely, as illustrated below:

         start of compressed logical extent
           |                          end of this logical extent
           |                           |
     ______v___________________________v________
... |  page 6  |  page 7  |  page 8  |  page 9  | ...
    |__________|__________|__________|__________|
           .                         ^ .        ^
           .                         |compressed|
           .                         |   data   |
           .                           .        .
           |<          dstsize        >|<margin>|
                                       oend     iend
           op                        ip

Fixed-size output compression can make the full use of this feature
to reduce memory overhead and avoid extra memcpy compared with fixed-size
input compression since iend is strictly not less than oend for fixed-size
output compression with inplace IO to last pages.

In addition, erofs compression indexes have been improved as well by
introducing compacted compression indexes.

These two techniques all benefit sequential read (on x86_64, 710.8MiB/s ->
755.4MiB/s; on Kirin980, 725MiB/s -> 812MiB/s) therefore erofs could have
similar sequential read performance against ext4 in a larger CR range
on high-spend SSD / NVMe devices as well.

However, note that it is _cpu vs storage device_ tradeoff, there is no
absolute performance conclusion for all on-market combinations.

Test images:
 name                       size                 CR
 enwik9                     1000000000           1.00
 enwik9_4k.squashfs.img      621211648           1.61
 enwik9_4k.erofs.img         558133248           1.79
 enwik9_8k.squashfs.img      556191744           1.80
 enwik9_16k.squashfs.img     502661120           1.99
 enwik9_128k.squashfs.img    398204928           2.51

Test Environment:
CPU: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz (4 cores, 8 threads)
DDR: 8G
SSD: INTEL SSDPEKKF360G7H
Kernel: Linux 5.2-rc3+ (with lz4-1.8.3 algorithm)

Test configuration:
squashfs:
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
erofs:
CONFIG_EROFS_FS_USE_VM_MAP_RAM=y
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR=y

with intel_pstate=disable,
     8 cpus on at 1801000 scaling_{min,max}_freq,
     userspace scaling_governor

Sequential read results (MiB/s):
                           1      2      3      4      5      avg
 enwik9_4k.ext4.img        767    770    738    726    724    745
 enwik9_4k.erofs.img       756    745    770    746    760    755.4
 enwik9_4k.squashfs.img    90.3   83.0   94.3   90.7   92.6   90.18
 enwik9_8k.squashfs.img    111    108    110    108    110    109.4
 enwik9_16k.squashfs.img   158    163    146    165    174    161.2
 enwik9_128k.squashfs.img  324    314    262    262    296    291.6


Thanks,
Gao Xiang

Gao Xiang (8):
  staging: erofs: add compacted ondisk compression indexes
  staging: erofs: add compacted compression indexes support
  staging: erofs: move per-CPU buffers implementation to utils.c
  staging: erofs: move stagingpage operations to compress.h
  staging: erofs: introduce generic decompression backend
  staging: erofs: introduce LZ4 decompression inplace
  staging: erofs: switch to new decompression backend
  staging: erofs: integrate decompression inplace

 drivers/staging/erofs/Makefile        |   2 +-
 drivers/staging/erofs/compress.h      |  62 ++++
 drivers/staging/erofs/data.c          |   4 +-
 drivers/staging/erofs/decompressor.c  | 322 ++++++++++++++++++
 drivers/staging/erofs/erofs_fs.h      |  60 +++-
 drivers/staging/erofs/inode.c         |  12 +-
 drivers/staging/erofs/internal.h      |  52 ++-
 drivers/staging/erofs/unzip_vle.c     | 368 ++------------------
 drivers/staging/erofs/unzip_vle.h     |  38 +--
 drivers/staging/erofs/unzip_vle_lz4.c | 229 -------------
 drivers/staging/erofs/utils.c         |  12 +
 drivers/staging/erofs/zmap.c          | 463 ++++++++++++++++++++++++++
 12 files changed, 993 insertions(+), 631 deletions(-)
 create mode 100644 drivers/staging/erofs/compress.h
 create mode 100644 drivers/staging/erofs/decompressor.c
 delete mode 100644 drivers/staging/erofs/unzip_vle_lz4.c
 create mode 100644 drivers/staging/erofs/zmap.c

-- 
2.17.1

