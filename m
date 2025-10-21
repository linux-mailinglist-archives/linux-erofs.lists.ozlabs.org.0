Return-Path: <linux-erofs+bounces-1272-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10289BF5ED4
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Oct 2025 12:59:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crTp92rdgz2ymg;
	Tue, 21 Oct 2025 21:59:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761044385;
	cv=none; b=f6gerDLAJtwOZGk5oZfRw8WxwRZN2/6bCddaGW5SLmVeGmLiU1BDkXLXJnKrVDDKUXsVa0QHtt6DxK7BcKzcfsP3+TWQdpyr/wyFgJgLIz8inLX12u8QhzyH7tAiD+sMhgMXM9db1T48D/SNwQ+AOJMfxJk9BH3WNzLJfNIzmoWRdMqimTF8KRUJjP/WwAlWlCuDqCfk9lxm0He4NPNZXmnjvK2ohCkJl/1Iw/cUlL5wOxIfal4lrM3tl+GSwgzMsXjPfge0pkLk7PKJNGrg3ZfFsjvlmDYaOui6+hGjRfSUuzSl+/BzqPaNRsPTPHrh9zB1LikVol0IoRGttBILAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761044385; c=relaxed/relaxed;
	bh=l5AL/pR4eqcVNm4X5aqodih3OEqYLsw6aj1Z1TPPIW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GGZ3UdnIYDXOgHFPnoIJBSkw1YOLphUDF5Y1uU7TVo3fHyxgzEXF0Cy09JvXY9j3Dh5I5yhzYJkIsfu+ING2bizpXJJqi0r3M+Rne+SlF61hh369gtuYGvDqqAPU7D190LiakqpHMdX7EtE77X80M14Qq+/tJerMPYOCkEoLouFdrD0w5OU9RMIj1kkIzigwhDdlapDFkI/ji8/Be4TaR84KWJMPR6bB9DRHvPOXGfoyzZMi+WHQmtHP3dLYhEdhrJlZdnUdKBgWTguUQBz4MpJeArWiSadcCiZVU+Tjzr1iMi39P4CazjagbeveAYmRHkP/MCdUZC2rW5GoZXgIvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cABFW3CX; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=cABFW3CX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crTp36ZJ8z2yMh
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 21:59:38 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l5AL/pR4eqcVNm4X5aqodih3OEqYLsw6aj1Z1TPPIW4=;
	b=cABFW3CXBAV01nnSGP8aHyhIMgY47yTnJP91BDTNCZ1cNEwgA5B+WPcyVej2E8k5q1FkQqQRx
	I8a2qQ2Ks4yubt5gae3RjPrvv+PhYCV5ARo2OYvgOQkyaPtNUjbCWZikrSkP610mNLv5JgY7eMX
	gvhWXVQ6Eqpa4PVmKKkEJSo=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4crTmb3vk4zcb1P;
	Tue, 21 Oct 2025 18:58:23 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id EBB7F18007F;
	Tue, 21 Oct 2025 18:59:32 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 18:59:32 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<hongzhen@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC v7 0/7] erofs: inode page cache share feature
Date: Tue, 21 Oct 2025 10:48:08 +0000
Message-ID: <20251021104815.70662-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Enabling page cahe sharing in container scenarios has become increasingly
crucial, as it can significantly reduce memory usage. In previous efforts,
Hongzhen has done substantial work to push this feature into the EROFS
mainline. Due to other commitments, he hasn't been able to continue his
work recently, and I'm very pleased to build upon his work and continue
to refine this implementation.

This is a forward-port of Hongzhen's original erofs shared pagecache
posted a half yeas ago at (the latest):
https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/T/#u

In addition to the forward-port, I have also fixed a couple bugs and
some minor cleanup during the migration.

Notes: Currently, only compilation tests and basic function have been
verified. Validation for the shared page cache feature is pending until
the erofs-utils tool is complete.

(A recap of Hongzhen's original cover letter is below, edited slightly
for this serise:)

Background
==============
Currently, reading files with different paths (or names) but the same
content can consume multiple copies of the page cache, even if the
content of these caches is identical. For example, reading identical
files (e.g., *.so files) from two different minor versions of container
images can result in multiple copies of the same page cache, since
different containers have different mount points. Therefore, sharing
the page cache for files with the same content can save memory.

Proposal
==============

1. determining file identity
----------------------------
First, a way needs to be found to check whether the content of two files
is the same. Here, the xattr values associated with the file
fingerprints are assessed for consistency. When creating the EROFS
image, users can specify the name of the xattr for file fingerprints,
and the corresponding name will be stored in the packfile. The on-disk
`ishare_key_start` indicates the offset of the xattr's name within the
packfile:

```
struct erofs_super_block {
	__le32 build_time;      /* seconds added to epoch for mkfs time */
	__le64 rootnid_8b;      /* (48BIT on) nid of root directory */
-	__le64 reserved2;
+	__le32 ishare_key_start;        /* start of ishare key */
+	__le32 reserved2;
	__le64 metabox_nid;     /* (METABOX on) nid of the metabox inode */
	__le64 reserved3;       /* [align to extslot 1] */
};
```

For example, users can specify the first long prefix as the name for the
file fingerprint as follows:

```
mkfs.erofs  --ishare_key=trusted.erofs.fingerprint  erofs.img ./dir
```

In this way, `trusted.erofs.fingerprint` serves as the name of the xattr
for the file fingerprint. The relevant patches for erofs-utils will be
released later.

At the same time, for security reasons, this patch series only shares
files within the same domain, which is achieved by adding
"-o domain_id=xxxx" during the mounting process:

```
mount -t erofs -o domain_id=xxx erofs.img /mnt
```

If no domain ID is specified, it will fall back to the non-page cache
sharing mode.

2. whose page cache is shared?
------------------------------

2.1. share the page cache of inode_A or inode_B
-----------------------------------------------
For example, we can share the page cache of inode_A, referred to as
PGCache_A. When reading file B, we read the contents from PGCache_A to
achieve memory savings. Furthermore, if we need to read another file C
with the same content, we will still read from PGCache_A. In this way,
we fulfill multiple read requests with just a single page cache.

2.2. share the de-duplicated inode's page cache
-----------------------------------------------
Unlike in 2.1, we allocate an internal deduplicated inode and use its
page cache as shared. Reads for files with identical content will
ultimately be routed to the page cache of the deduplicated inode. In
this way, a single page cache satisfies multiple read requests for
different files with the same contents.

2.3. discussion of the two solutions
-----------------------------------------------
Although the solution in 2.1 allows for page cache sharing, it has
inherent drawbacks. The creation and destruction of inode nodes in the
file system mean that when inode_A is destroyed, PGCache_A is also
released. Consequently, if we need to read the file content afterward,
we must retrieve the data from the disk again. This conflicts with the
design philosophy of page cache (caching contents from the disk).

Therefore, I choose to implement the solution in 2.2, which is to
allocate an internal deduplicated inode and use its page cache as
shared.

3. Implementation
==================

3.1. file open & close
----------------------
When the file is opened, the ->private_data field of file A or file B is
set to point to an internal deduplicated file. When the actual read
occurs, the page cache of this deduplicated file will be accessed.

When the file is opened, if the corresponding erofs inode is newly
created, then perform the following actions:
1. add the erofs inode to the backing list of the deduplicated inode;
2. increase the reference count of the deduplicated inode.

The purpose of step 1 above is to ensure that when a real I/O operation
occurs, the deduplicated inode can locate one of the disk devices
(as the deduplicated inode itself is not bound to a specific device).
Step 2 is for managing the lifecycle of the deduplicated inode.

When the erofs inode is destroyed, the opposite actions mentioned above
will be taken.

3.2. file reading
-----------------
Assuming the deduplication inode's page cache is PGCache_dedup, there
are two possible scenarios when reading a file:
1) the content being read is already present in PGCache_dedup;
2) the content being read is not present in PGCache_dedup.

In the second scenario, it involves the iomap operation to read from the
disk.

3.2.1. reading existing data in PGCache_dedup
-------------------------------------------
In this case, the overall read flowchart is as follows (take ksys_read()
for example):

         ksys_read
             │
             │
             ▼
            ...
             │
             │
             ▼
erofs_ishare_file_read_iter (switch to backing deduplicated file)
             │
             │
             ▼

 read PGCache_dedup & return

At this point, the content in PGCache_dedup will be read directly and
returned.

3.2.2 reading non-existent content in PGCache_dedup
---------------------------------------------------
In this case, disk I/O operations will be involved. Taking the reading
of an uncompressed file as an example, here is the reading process:

         ksys_read
             │
             │
             ▼
            ...
             │
             │
             ▼
erofs_ishare_file_read_iter (switch to backing deduplicated file)
             │
             │
             ▼
            ... (allocate pages)
             │
             │
             ▼
erofs_read_folio/erofs_readahead
             │
             │
             ▼
            ... (iomap)
             │
             │
             ▼
        erofs_iomap_begin
             │
             │
             ▼
            ...

Iomap and the layers below will involve disk I/O operations. As
described in 3.1, the deduplicated inode itself is not bound to a
specific device. The deduplicated inode will select an erofs inode from
the backing list (by default, the first one) to complete the
corresponding iomap operation.

3.2.3 optimized inode selection
-------------------------------
The inode selection method described in 3.2.2 may select an "inactive"
inode. An inactive inode indicates that there may have been no read
operations on the inode's device for a long time, and there is a high
likelihood that the device may be unmounted. In this case, unmounting
the device may experience a slight delay due to other read requests
being routed to that device. Therefore, we need to select some "active"
inodes for the iomap operation.

To achieve optimized inode selection, an additional `processing` list
has been added. At the beginning of erofs_{read_folio,readahead}(), the
corresponding erofs inode will be added to the `processing` list
(because they are active). And it is removed at the end of
erofs_{read_folio,readahead}(). In erofs_iomap_begin(), the selected
erofs inode's count is incremented, and in erofs_iomap_end(), the count
is decremented.

In this way, even after the erofs inode is removed from the `processing`
list, the increment in the reference count can ensure the integrity of
the data reading process. This is somewhat similar to RCU (not exactly
the same, but similar).

3.3. release page cache
-----------------------
Similar to overlayfs, when dropping the page cache via .fadvise, erofs
locates the deduplicated file and applies vfs_fadvise to that specific
file.

Effect
==================
I conducted experiments on two aspects across two different minor
versions of container images:

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
|  2.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
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
|  2.11.0 & 2.11.1  |        Yes       |    934.3    |      10%      |
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

It can be observed that when reading all the files in the image, the
reduced memory usage varies from 16% to 49%, depending on the specific
image. Additionally, the container's runtime memory usage reduction
ranges from 4% to 47%.

[1] Below are the workload for these images:
      - redis: redis-benchmark
      - postgres: sysbench
      - tensorflow: app.py of tensorflow.python.platform
      - mysql: sysbench
      - nginx: wrk
      - tomcat: default entrypoint

The patch in this version has made the following changes compared to
the previous versionv(patch v5):

- support user-defined fingerprint name;
- support domain-specific page cache share;
- adjusted the code style;
- adjustments in code implementation, etc.

v5: https://lore.kernel.org/all/20250105151208.3797385-1-hongzhen@linux.alibaba.com/
v4: https://lore.kernel.org/all/20240902110620.2202586-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240828111959.3677011-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240731080704.678259-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240722065355.1396365-1-hongzhen@linux.alibaba.com/

-- 
2.22.0


