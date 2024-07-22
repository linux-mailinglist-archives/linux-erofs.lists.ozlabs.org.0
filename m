Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFB938931
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 08:54:17 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LUJ4X4zJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WS9xJ6Nbmz3cTw
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2024 16:54:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LUJ4X4zJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WS9xB1pl1z30VY
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jul 2024 16:54:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721631239; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=xD94dOxY+nku6Q6W3voJyiFwb4COK0rvj1QCMB+mCzs=;
	b=LUJ4X4zJjvAer+6OjlcNqvdGpE3/atBgU5rFusdKaJEJZgnyb9AImkkaftGQF6NqDTlmwDkra/GZ/ADf91aHuU/QhqNqUHYi0PmaOxT0zfLBaSmHPwFJyND/0XnTp/SFB+52L0hncp3w31qeIP9c89vf0KhB42w6HwEdeiGGgho=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WB-Gf3C_1721631237;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WB-Gf3C_1721631237)
          by smtp.aliyun-inc.com;
          Mon, 22 Jul 2024 14:53:58 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC 0/4] erofs: introduce page cache share feature
Date: Mon, 22 Jul 2024 14:53:50 +0800
Message-ID: <20240722065355.1396365-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[Background]
================
Currently, reading files with different paths (or names) but the same
content will consume multiple copies of the page cache, even if the
content of these page caches is the same. For example, reading identical
files (e.g., *.so files) from two different minor versions of container
images will cost multiple copies of the same page cache, since different
containers have different mount points. Therefore, sharing the page cache
for files with the same content can save memory.

[Implementation]
================
During the mkfs phase, file content is hashed and the hash value is 
stored in the `user.fingerprint` extended attribute. Inodes of files
with the same `user.fingerprint` are mapped to an anonymous inode, whose
page cache stores the actual contents. In this way, a single copy of the
anonymous inode's page cache can serve read requests from several files
mapped to it. The following describes the relationship between the anonymous
inode and inodes with the same content:

                        page cache                            
                   ┌────┬────┬────┬──────┐                    
             ┌────►│    │    │ ...│      │                    
             │     └────┴────┴────┴──────┘                    
             │                                                
             │                                                
             │      i_private                                 
          ┌──┴────────┬───┐                                   
       ┌─►│ ano_inode │   │                                   
       │  └───────────┴─┬─┘                                   
       │                │                                     
       │       ┌────────┘                                     
mapped │       ▼                                              
  to   │  ┌──────────┬───┬─────┐                              
       │  │erofs_pcs │cur│ list│                              
       │  └──────────┴─┬─┴───┬─┘                              
       │               │     │                                
       │     ┌─────────┘     │                                
       │     │               │                                
       │     │    ┌──────────┘                                
       │     │    │                                           
       │     ▼    ▼                                           
       │  ┌────────┐       ┌────────┐               ┌────────┐
       └──┤        │ ────► │        │ ───►      ──► │        │
          │        │       │        │      ...      │        │
          └────────┘ ◄──── └────────┘ ◄───      ◄── └────────┘
                                                              
            inode_1          inode_2                  inode_n 

In the above diagram, the `i_private` (protected by `i_lock`) field of the
anonymous inode points to the `struct erofs_pcs` structure:

struct erofs_pcs {
	struct erofs_inode *cur;
	struct rw_semaphore rw_sem;
	struct mutex list_mutex;
	struct list_head list;
};

where the `list` field points to a list of inodes that are mapped to the
anonymous inode and has the same `user.fingerprint` field. The `cur` field
points to the first inode in the inode list, which is used for I/O
mapping (iomap) related operations. 

When an inode is created, it is added to the inode list pointed to by the
`erofs_pcs` structure corresponding to the anonymous inode; similarly, when
the inode is destroyed, it is removed from the inode list. Note that if the
inode is the one pointed to by `cur`, then it is necessary to acquire the
read-write semaphore `rw_sem` to maintain synchronization, in case the inode
is being used for iomap operations elsewhere. 

[Effect]
================
I conducted experiments on two aspects across two different minor versions of
container images:

1. reading all files in two different minor versions of container images 

2. run workloads or use the default entrypoint within the containers^[1]

Below is the memory usage for reading all files in two different minor
versions of container images:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     241     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     872     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |     630     |      28%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     2771    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     926     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     390     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     924     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |     474     |      49%      |
+-------------------+------------------+-------------+---------------+

Additionally, the table below shows the runtime memory usage of the
container:

+-------------------+------------------+-------------+---------------+
|       Image       | Page Cache Share | Memory (MB) |    Memory     |
|                   |                  |             | Reduction (%) |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     34.9    |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     33.6    |       4%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |    149.1    |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |    1027.9   |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |    934.3    |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |    155.0    |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |    139.1    |      11%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     25.4    |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |     18.8    |      26%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      99     |      47%      |
+-------------------+------------------+-------------+---------------+

It can be observed that when reading all the files in the image, the reduced
memory usage varies from 16% to 49%, depending on the specific image.
Additionally, the container's runtime memory usage reduction ranges from 4%
to 47%.

[1] Below are the workload for these images:
      - redis: redis-benchmark
      - postgres: sysbench
      - tensorflow: app.py of tensorflow.python.platform
      - mysql: sysbench
      - nginx: wrk
      - tomcat: default entrypoint

Hongzhen Luo (4):
  erofs: move `struct erofs_anon_fs_type` to super.c
  erofs: expose erofs_iomap_{begin, end}
  erofs: introduce page cache share feature
  erofs: apply the page cache share feature

 fs/erofs/Kconfig           |  10 ++
 fs/erofs/Makefile          |   1 +
 fs/erofs/data.c            |   9 +-
 fs/erofs/fscache.c         |  13 +-
 fs/erofs/inode.c           |  17 ++
 fs/erofs/internal.h        |   8 +
 fs/erofs/pagecache_share.c | 318 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  23 +++
 fs/erofs/super.c           |  40 +++++
 9 files changed, 425 insertions(+), 14 deletions(-)
 create mode 100644 fs/erofs/pagecache_share.c
 create mode 100644 fs/erofs/pagecache_share.h

-- 
2.43.5

