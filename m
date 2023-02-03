Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA6688DA6
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 04:01:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7L6B5yk2z3f65
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 14:01:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7L6621rJz30Bp
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 14:01:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VampZ0J_1675393303;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VampZ0J_1675393303)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:01:44 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 0/9] erofs: support page cache sharing between EROFS images in fscache mode
Date: Fri,  3 Feb 2023 11:01:34 +0800
Message-Id: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

v3:
- the page cache sharing now supports readahead:
    - add patch 1: support readahead in meta routine
    - patch 4: initialize f_ra of anonymous file in prep for readahead
    - patch 5: since now readahead is performed upon the data blob, the
      accuate inode size of data blob needs to be derived
- patch 6: filemap_read() is reused when implementing .read_iter()
- cover letter: ~20% memory usage reduction can be seen when
  distributing tensorflow:2.10.0 and tensorflow:2.10.1 at the same node
  (see "Effect" section of the cover letter)


RFC: https://lore.kernel.org/all/20230106125330.55529-1-jefflexu@linux.alibaba.com/
v2: https://lore.kernel.org/all/20230111083158.23462-1-jefflexu@linux.alibaba.com/


changes since RFC:
- patch 2: allocate an anonymous file (realfile) when file is opened,
  rather than allocate a single anonymous file for each blob at mount
  time
- patch 7: add 'sharecache' mount option to control if page cache
  sharing shall be enabled



[Background]
=============
Erofs already supports chunk deduplication across different images to
minimize disk usage since v6.1.  Furthermore, we can make inodes among
different images share page cache for these deduplicated chunks to
reduce the memory usage.  This shall be much usable in container
scenarios as deduplication is requisite for container images.


[Implementation]
================
This is achieved by managing page cache of deduplicated chunks in
blob's address space.  In this way, all inodes sharing the deduplicated
chunk will refer to and share the page cache in the blob's address
space.


[Restriction]
==============
The page cache sharing feature also supports .mmap().  The reverse
mapping requires that one vma can not be shared among inodes and can
be linked to only one inode.  As the vma will be finally linked to the
blob's address space when page cache sharing enabled, the restriction of
the reverse mapping actually requires that the mapped file area can not
be mapped to multiple blobs.  Thus page cache sharing can only be
enabled for those files mapped to one blob.

The chunk based data layout guarantees that a chunk will not cross the
device (blob) boundary.  Thus in chunk based data layout, those files
smaller than the chunk size shall be guaranteed to be mapped to one
blob.  As chunk size is tunable at a per-file basis, this restriction
can be relaxed at image building phase.  As long as we ensure that the
file can not be deduplicated, the file's chunk size can be set to a
reasonable value larger than the file size, so that the file contains
only one chunk, in which case page cache sharing feature can be enabled
on this file later.


[Effect]
========
The final optimization result of this feature depends on the following
factors:

1. The number of deduplicated (shared) chunks.  Images sharing most of
the layers (e.g. a base image and v1 image based on the base image) will
achieve better optimization.

2. As the restriction mentioned above, the number of files for which
page cache sharing can ben enabled among the files accessed.


I test the workload of starting up Tensorflow, which will access quite
many (~5K) files among the startup phase.  I get the base image of
Tensorflow from [1] and build a new image (e.g. v1 image) on top of this
base image.

Since the image got from [1] is in OCI format, I have to convert it to
erofs format with buildkit[2], with default chunk size of 1MB.

I run containers from these two images with containerd (base image first,
v2 image secondly).  The (page cache) memory usage of the rootfs
(container image) is shown as below:

			| page cache sharing	| page cache sharing
			| disabled		| enabled
------------------------|-----------------------|-------------------
First container image   |      			|
page cache usage (MB) 	| 150      		| 150
------------------------+-----------------------|-------------------
Second container image  |      			|
page cache usage (MB) 	| 150			| 7

It can be seen that most (~95%, 143MB/150MB) memory usage reduced under
this workload (when starting following containers sharing container image
layers).

The remained 7MB memory usage is consumed by directories, since page
cache sharing is enabled only for regular files in this RFC
implementation.


I also tested the memory usage reduction among minor versions of the
same container image.  I tested with v2.10.0 and v2.10.1 of tensorflow.
It shows ~20% memory usage reduction, as most files accessed in the
workload is .pyc files which are updated during the version bump.

			| page cache sharing
			| enabled
------------------------|-------------------
First container image   |
(tensorflow:2.10.0)	|
page cache usage (MB) 	| 150
------------------------+-------------------
Second container image  |
(tensorflow:2.10.1)	|
page cache usage (MB) 	| 122



[1] docker.io/tensorflow/tensorflow:2.10.0
[2] https://github.com/moby/buildkit


Jingbo Xu (9):
  erofs: support readahead in meta routine
  erofs: remove unused device mapping in the meta routine
  erofs: unify anonymous inodes for blob
  erofs: allocate anonymous file of blob for page cache sharing
  erofs: set accurate anony inode size for page cache sharing
  erofs: implement .read_iter for page cache sharing
  erofs: implement .mmap for page cache sharing
  erofs: add helper checking if page cache sharing shall be enabled
  erofs: introduce 'sharecache' mount option

 Documentation/filesystems/erofs.rst |   2 +
 fs/erofs/fscache.c                  | 271 +++++++++++++++++++++-------
 fs/erofs/inode.c                    |   4 +
 fs/erofs/internal.h                 |  34 +++-
 fs/erofs/super.c                    |  15 ++
 5 files changed, 256 insertions(+), 70 deletions(-)

-- 
2.19.1.6.gb485710b

