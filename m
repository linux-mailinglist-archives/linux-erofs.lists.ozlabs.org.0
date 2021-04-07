Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB7356290
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 06:39:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FFWrn6BRfz302p
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Apr 2021 14:39:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b8Js7aP2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=b8Js7aP2; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FFWrl2PhYz2yZ9
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Apr 2021 14:39:35 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F5F461246;
 Wed,  7 Apr 2021 04:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617770372;
 bh=6fBSo2g8LJPRNQVGvyh6Oupj1AwkOv6hAm2GhaCYCLQ=;
 h=From:To:Cc:Subject:Date:From;
 b=b8Js7aP2hCpokqeIFA9nNGI25yltRLB3tSU1jf0fulyBeDhUTq0HuYCSHlDg3R66j
 8sQvBJWYsvfvY78uuDBBKiCthKh45ZrcHJIekMOMdjIuGK7xj7CoXNGb8Mtqz+f14l
 1AU+LkDffri7heWbN6mw8du9QLZoO/qxqIpjoxvyl+5/bfKk1D0W0op1VUKSvuNTRl
 NLP4HjN9v2+qI4QSj5zhtgU/ZRqCzoNr4OWPqLsxd3qSJA6nFS7HGkcWjHV93Ac4HN
 xohjv4h3f4PF0OMViL5xIBjbpBhFwNboCQrx4sU94S3IVUXRrDxT8Awf5cEzk4+OYt
 oO5Y0Uc/+cf3Q==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v3 00/10] erofs: add big pcluster compression support
Date: Wed,  7 Apr 2021 12:39:17 +0800
Message-Id: <20210407043927.10623-1-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Gao Xiang <xiang@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

This is the formal version of EROFS big pcluster support, which means
EROFS can compress data into more than 1 fs block after this patchset.

{l,p}cluster are EROFS-specific concepts, standing for `logical cluster'
and `physical cluster' correspondingly. Logical cluster is the basic unit
of compress indexes in file logical mapping, e.g. it can build compress
indexes in 2 blocks rather than 1 block (currently only 1 block lcluster
is supported). Physical cluster is a container of physical compressed
blocks which contains compressed data, the size of which is the multiple
of lclustersize.

Different from previous thoughts, which had fixed-sized pclusterblks
recorded in the on-disk compress index header, our on-disk design allows
variable-sized pclusterblks now. The main reasons are
 - user data varies in compression ratio locally, so fixed-sized
   clustersize approach is space-wasting and causes extra read
   amplification for high CR cases;

 - inplace decompression needs zero padding to guarantee its safe margin,
   but we don't want to pad more than 1 fs block for big pcluster;

 - end users can now customize the pcluster size according to data type
   since various pclustersize can exist in a file, for example, using
   different pcluster size for executable code and one-shot data. such
   design should be more flexible than many other public compression fses
   (Btw, each file in EROFS can have maximum 2 algorithms at the same time
   by using HEAD1/2, which will be formally added with LZMA support.)

In brief, EROFS can now compress from variable-sized input to
variable-sized pcluster blocks, as illustrated below:

  |<-_lcluster_->|________________________|<-_lcluster_->|
  |____._________|_________ .. ___________|_______.______|
        .                                        .
         .                                     .
          .__________________________________.
          |______________| .. |______________|
          |<-          pcluster            ->|

The next step would be how to record the compressed block count in
lclusters. In compress indexes, there are 2 concepts called HEAD and
NONHEAD lclusters. The difference is that HEAD lcluster starts a new
pcluster in the lcluster, but NONHEAD not. It's easy to understand
that big pclusters at least have 2 pclusters, thus at least 2 lclusters
as well.

Therefore, let the delta0 (distance to its HEAD lcluster) of first NONHEAD
compress index store the compressed block count with a special flag as a
new called CBLKCNT compress index. It's also easy to know its delta0 is
constantly 1, as illustrated below:
  ________________________________________________________
 |_HEAD_|_CBLKCNT_|_NONHEAD_|_..._|_NONHEAD_|_HEAD | HEAD |
    |<------ a pcluster with CBLKCNT --------->|<-- -->|
                                                   ^ a pcluster with 1

If another HEAD follows a HEAD lcluster, there is no room to record
CBLKCNT, but it's easy to know the size of pcluster will be 1.

More implementation details about this and compact indexes are in the
commit message.

On the runtime performance side, the current EROFS test results are:
 ________________________________________________________________
|  file system  |   size    | seq read | rand read | rand9m read |
|_______________|___________|_ MiB/s __|__ MiB/s __|___ MiB/s ___|
|___erofs_4k____|_556879872_|_ 781.4 __|__ 55.3 ___|___ 25.3  ___|
|___erofs_16k___|_452509696_|_ 864.8 __|_ 123.2 ___|___ 20.8  ___|
|___erofs_32k___|_415223808_|_ 899.8 __|_ 105.8 _*_|___ 16.8 ____|
|___erofs_64k___|_393814016_|_ 906.6 __|__ 66.6 _*_|___ 11.8 ____|
|__squashfs_8k__|_556191744_|_  64.9 __|__ 19.3 ___|____ 9.1 ____|
|__squashfs_16k_|_502661120_|_  98.9 __|__ 38.0 ___|____ 9.8 ____|
|__squashfs_32k_|_458784768_|_ 115.4 __|__ 71.6 _*_|___ 10.0 ____|
|_squashfs_128k_|_398204928_|_ 257.2 __|_ 253.8 _*_|___ 10.9 ____|
|____ext4_4k____|____()_____|_ 786.6 __|__ 28.6 ___|___ 27.8 ____|


* Squashfs grabs more page cache to keep all decompressed data with
  grab_cache_page_nowait() than the normal requested readahead (see
  squashfs_copy_cache and squashfs_readpage_block).
  In principle, EROFS can also cache such all decompressed data
  if necessary, yet it's low priority for now and has little use
  (rand9m is actually a better rand read workload, since the amount
   of I/O is 9m rather than full-sized 1000m).

More details are in
https://lore.kernel.org/r/20210329053654.GA3281654@xiangao.remote.csb

Also it's easy to know EROFS is not a fixed pcluster design, so users
can make several optimized strategy according to data type when mkfs.
And there is still room to optimize runtime performance for big pcluster
even further.

Finally, it passes ro_fsstress and can also successfully boot buildroot
& Android system with android-mainline repo.

current mkfs repo for big pcluster:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b experimental-bigpcluster-compact

Thanks for your time on reading this!

Thanks,
Gao Xiang

changes since v2:
 - introduce a new erofs_vm_ram_map() helper to reduce duplicated logic
   and fix uninitialized variable pointed out by Colin & Joe;
 - add a new EXPERIMENTAL warning for new big pcluster feature to end
   users.

changes since v1:
 - add a missing vunmap in erofs_pcpubuf_exit();
 - refine comments and commit messages.

Gao Xiang (10):
  erofs: reserve physical_clusterbits[]
  erofs: introduce multipage per-CPU buffers
  erofs: introduce physical cluster slab pools
  erofs: fix up inplace I/O pointer for big pcluster
  erofs: add big physical cluster definition
  erofs: adjust per-CPU buffers according to max_pclusterblks
  erofs: support parsing big pcluster compress indexes
  erofs: support parsing big pcluster compact indexes
  erofs: support decompress big pcluster for lz4 backend
  erofs: enable big pcluster feature

 fs/erofs/Kconfig        |  14 ---
 fs/erofs/Makefile       |   2 +-
 fs/erofs/decompressor.c | 235 ++++++++++++++++++++++++----------------
 fs/erofs/erofs_fs.h     |  31 ++++--
 fs/erofs/internal.h     |  44 ++++----
 fs/erofs/pcpubuf.c      | 134 +++++++++++++++++++++++
 fs/erofs/super.c        |   1 +
 fs/erofs/utils.c        |  12 --
 fs/erofs/zdata.c        | 193 +++++++++++++++++++++------------
 fs/erofs/zdata.h        |  14 +--
 fs/erofs/zmap.c         | 162 ++++++++++++++++++++++-----
 11 files changed, 587 insertions(+), 255 deletions(-)
 create mode 100644 fs/erofs/pcpubuf.c

-- 
2.20.1

