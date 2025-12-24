Return-Path: <linux-erofs+bounces-1571-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC0CDB4C9
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 05:22:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbdy01Fh7z2xnl;
	Wed, 24 Dec 2025 15:22:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766550136;
	cv=none; b=Vj3x05GoTKo8LL4dvyHEMPKdbtc3+j3MhH2OloavaLsUvbzJh0KgKYLOjteFTxX9U60xm9AJtUfu6+tEq85XTKRhQTCv2ai1Px7mhvjNXozv1y7JWnNnPmJ7M+zPEs5y+U9gbuuNa/sg+O2tgO5DaBR/YFyc+O49wMOtH1t2vrYXpmQxTISNqwF0nFNi959+13NbdoHWI+saOuRxg/Qpj1RxMx9cjD/GeOmkvc4TnUnuu5oYzDdkH4Vuovy4dKodwhqrSPdiNP9o5Pufe1WaLnpOdK31wGL1eLcyoVKc9baJsD38ce+TFjjasXRUP8JYvD6ua+9pF1TMkvUezTcFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766550136; c=relaxed/relaxed;
	bh=/1QseCxXiYrmA+IapOH5OVlwmY2OzUwoeQy3GElyQqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2W0LjN6gM7uJX9zANZ/YOIM+T8n7uX54R9vg22ZVJi/MnrDT7pxoaAEEOBnaPsT5Il4MWuzsyYLFQ0Mtk6gladChAX/C/d6X7KqzCNIcj1RnX9dPyDQM04HOH7lTr5zn37gRqweMu42GrUr6YgOV2mZXz4C4NLiOawIX8GzRXc8oWEhYAuavmvVzowtavH0jH0ckmLLhhSyFHBtTnmq9lyvvSfnyNutvySncYd8Jhyt8yNubZxUvzTMbWVV2oscg9ON2mwAqo0yVD3sjYAASGb/hLtSIkAA0ml+/2TIqwX9sMEvm9kqJPQqneIeK7kwIdKs9/bVhJjKa+0Lv0Ubrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CGEioeVV; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=CGEioeVV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbdxx3fxBz2xlM
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 15:22:11 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/1QseCxXiYrmA+IapOH5OVlwmY2OzUwoeQy3GElyQqY=;
	b=CGEioeVV1EvKPRI1TNCeWNC1LxZDTFNCLd/K7i8BPCMRrTGjwoqQiKbGHweWACt00OzCJu5Pr
	T5iL1rBP28L42jcbJrwXMeX0Zq+cqa/lsJTQOfP+6PwVTf0bpLzVrpyyqra5k62TPJOi869Woes
	eQazDxYDZFRdXHcpr1fQlis=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dbdtB2Xdjzcb0v;
	Wed, 24 Dec 2025 12:18:58 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 3223E40538;
	Wed, 24 Dec 2025 12:22:04 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Dec
 2025 12:22:03 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <hsiangkao@linux.alibaba.com>, <chao@kernel.org>, <brauner@kernel.org>,
	<djwong@kernel.org>, <amir73il@gmail.com>, <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH v11 00/10] erofs: Introduce page cache sharing feature
Date: Wed, 24 Dec 2025 04:09:22 +0000
Message-ID: <20251224040932.496478-1-lihongbo22@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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

This patch series is based on Hongzhen's original EROFS shared pagecache
implementation which was posted about half a year ago:
https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/T/#u

In addition to the forward-port, I have also fixed several bugs, resolved
some prerequisite dependencies and performed some minor cleanup.

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
`ishare_key_start` indicates the index of the xattr name within the
prefix xattrs:

```
struct erofs_super_block {
	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
-	__u8 reserved[3];
+	__u8 ishare_xattr_prefix_id;	/* indexes the ishare key in prefix xattres */
+	__u8 reserved[2];
};
```

For example, users can specify the first long prefix as the name for the
file fingerprint as follows:

```
mkfs.erofs  --ishare_key=trusted.erofs.fingerprint  erofs.img ./dir
```

In this way, `trusted.erofs.fingerprint` serves as the name of the xattr
for the file fingerprint. The relevant patch for erofs-utils has been posted
in:

v2: https://lore.kernel.org/all/20251118015849.228939-1-lihongbo22@huawei.com/

At the same time, we introduce a new mount option which is inode_share to
enable the feature. For security reasons, we allow sharing page cache only
within the same domain by adding "-o domain_id=xxxx" during the mounting
process:

```
mount -t erofs -o inode_share,domain_id=trusted.erofs.fingerprint erofs.img /mnt
```

If no domain ID is specified, it will share page cache in default none domain.

2. Implementation
==================

2.1. file open & close
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

2.2. file reading
-----------------
Assuming the deduplication inode's page cache is PGCache_dedup, there
are two possible scenarios when reading a file:
1) the content being read is already present in PGCache_dedup;
2) the content being read is not present in PGCache_dedup.

In the second scenario, it involves the iomap operation to read from the
disk.

2.2.1. reading existing data in PGCache_dedup
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

2.2.2 reading non-existent content in PGCache_dedup
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
described in 2.1, the deduplicated inode itself is not bound to a
specific device. The deduplicated inode will select an erofs inode from
the backing list (by default, the first one) to complete the
corresponding iomap operation.

2.3. release page cache
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

Changes from v10:
    - add reviewed-by and acked-by.
    - do some cleanup on typo, useless code and some helpers' name.
    - use fingerprint struct and introduce inode_share mount option as
      suggested by Xiang.

Changes from v9:
    - make shared page cache as a compatiable feature.
    - refine code style as suggested by Xiang.
    - init ishare mnt during the module init as suggested by Xiang.
    - rebase the latest mainline and fix the comments in cover letter.

Changes from v8:
    - add review-by in patch 1 and patch 10.
    - do some clean up in patch 2 and patch 4,6,9 as suggested by Xiang.
    - add new patch 3 to export alloc_empty_backing_file.
    - patch 5 only use xattr prefix id to record the ishare info, changed
      config to EROFS_FS_PAGE_CACHE_SHARE and make it compatible.
    - patch 7 use backing file helpers to alloc file when ishare file is
      opened as suggested by Xiang.
    - patch 8 remove erofs_read_{begin,end} as suggested by Xiang.

v10: https://lore.kernel.org/all/20251223015618.485626-1-lihongbo22@huawei.com/
v9: https://lore.kernel.org/all/20251117132537.227116-1-lihongbo22@huawei.com/
v8: https://lore.kernel.org/all/20251114095516.207555-1-lihongbo22@huawei.com/
v7: https://lore.kernel.org/all/20251021104815.70662-1-lihongbo22@huawei.com/
v6: https://lore.kernel.org/all/20250301145002.2420830-1-hongzhen@linux.alibaba.com/T/#u
v5: https://lore.kernel.org/all/20250105151208.3797385-1-hongzhen@linux.alibaba.com/
v4: https://lore.kernel.org/all/20240902110620.2202586-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240828111959.3677011-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240731080704.678259-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240722065355.1396365-1-hongzhen@linux.alibaba.com/

Diffstat:
 Documentation/filesystems/erofs.rst |   4 +
 fs/erofs/Kconfig                    |   9 ++
 fs/erofs/Makefile                   |   1 +
 fs/erofs/data.c                     |  91 ++++++++----
 fs/erofs/erofs_fs.h                 |   5 +-
 fs/erofs/fscache.c                  |  13 --
 fs/erofs/inode.c                    |   4 +
 fs/erofs/internal.h                 |  37 +++++
 fs/erofs/ishare.c                   | 210 ++++++++++++++++++++++++++++
 fs/erofs/super.c                    |  70 +++++++++-
 fs/erofs/xattr.c                    |  53 ++++++-
 fs/erofs/xattr.h                    |  12 +-
 fs/erofs/zdata.c                    |  30 ++--
 fs/file_table.c                     |   1 +
 fs/fuse/file.c                      |   4 +-
 fs/iomap/buffered-io.c              |   6 +-
 include/linux/iomap.h               |   8 +-
 17 files changed, 492 insertions(+), 66 deletions(-)
 create mode 100644 fs/erofs/ishare.c

-- 
2.22.0


