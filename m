Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BCC9625D7
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 13:20:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv2586mhRz2ykt
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 21:20:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724844010;
	cv=none; b=ZCh54N5sazHUsFew4jLpngwQmBauNqNoLBoEqNwLMLw7Cclaq1KOyWJ2XHC7kB6jSOmaJNHTpeDbEpnyB5lHRUBHKW0c4QSkXWH5kbAjKetxDMO0AIkekgU23fZBsEM64eYyeVslYh5q5LkQ3v8g+2rRPlL0QExt2M2mUFc8z/Rq8o9iI/QOls+dFQbQHOrUK7CRShy7x+Gvu7Rh1/IxtWQSkOfa4fQE8yyzTZv57y44GJxTMJZuHjU6KKcFrSEHlL1ZsYgsuZxdDge+6cU1MqkjnuBQU1uOpi523TWropcVjsbkH0paCJ2DhsTMA7UbarYM/TGBo+FVUU4GTxYdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724844010; c=relaxed/relaxed;
	bh=ZGTJq2rAfxLvSQxM0K96ocXGs6cX+lZzDArmhphRc3k=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=I92PW1X+5uWLI61bj0/ywl9aLWTPhVKDP5L4acBbG68WuCxSxpk+L4YbyC5wRf4U/r6Wxo6ChRe0H6NI9h+OkpISWT1CKTg5ATEtUTX+mbwXuvvdNucL+KUrhIvjA3tMM4vHqT6ByfQAJolsG3B8E2YSwJ5hMt6C/a5+ZByFk5cPifJQ1j0CubF6g0u1xgbruVT8lBTer4lRlJAm151a5QQCJJ5xkrx9nfN+G0QSclZk1Da0xaLBwEPW/SCdLw/gqbJ9DfN5n9GJKAGMK5vH40eVbpyvAyzvTfq2O/tT7EbtMV4+7TqVLhw0FTniTt+jWru/wi781NDI6UIm46xWfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JXkhD/Vd; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JXkhD/Vd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv2550Vpgz2xdT
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 21:20:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724844003; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZGTJq2rAfxLvSQxM0K96ocXGs6cX+lZzDArmhphRc3k=;
	b=JXkhD/VduQapYzpkYQwYAdb4cUKMMvfVrS4C0PlC09dWEV38u/UcHOLzpuqiv8Tu2OLeieNdsXsZTCMKxx5ciFcYYgmzhVCVe34HJb3Vrg2aQQTkmbYchejRP2DHdygEjEPTIJEWHPeOfUj6u+AsFUmPp3MjyQ/41M2YdIwm1Aw=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WDpi5rU_1724844000)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 19:20:01 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	lihongbo22@huawei.com
Subject: [PATCH RFC v3 0/3] erofs: introduce page cache share feature
Date: Wed, 28 Aug 2024 19:19:56 +0800
Message-ID: <20240828111959.3677011-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

v3:
Changes since v2:
  - The implementation of page cache share has been redesigned to overcome read
    dependencies during device unmounting, where an inode cannot be freed when
    it is currently being used to perform a read elsewhere.
  - Added support for compressed files.
  - The relevant experiments were repeated, in accordance with the latest implementations.

v2: https://lore.kernel.org/all/20240731080704.678259-1-hongzhen@linux.alibaba.com/

v1: https://lore.kernel.org/all/20240722065355.1396365-1-hongzhen@linux.alibaba.com/


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
This introduces the page cache share feature in erofs. During the mkfs
phase, the file content is hashed and the hash value is stored in the
`trusted.erofs.fingerprint` extended attribute. Inodes of files with the
same `trusted.erofs.fingerprint` are mapped to the same anonymous inode
(indicated by the `ano_inode` field). When a read request occurs, the
anonymous inode serves as a "container" whose page cache is shared. The
actual operations involving the iomap are carried out by the original
inode which is mapped to the anonymous inode.

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
|                   |        No        |      35     |       -       |
|       redis       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     149     |       -       |
|      postgres     +------------------+-------------+---------------+
|    16.1 & 16.2    |        Yes       |      95     |      37%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     1028    |       -       |
|     tensorflow    +------------------+-------------+---------------+
|  1.11.0 & 2.11.1  |        Yes       |     930     |      10%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |     155     |       -       |
|       mysql       +------------------+-------------+---------------+
|  8.0.11 & 8.0.12  |        Yes       |     132     |      15%      |
+-------------------+------------------+-------------+---------------+
|                   |        No        |      25     |       -       |
|       nginx       +------------------+-------------+---------------+
|   7.2.4 & 7.2.5   |        Yes       |      20     |      20%      |
+-------------------+------------------+-------------+---------------+
|       tomcat      |        No        |     186     |       -       |
| 10.1.25 & 10.1.26 +------------------+-------------+---------------+
|                   |        Yes       |      98     |      48%      |
+-------------------+------------------+-------------+---------------+

It can be observed that when reading all the files in the image, the reduced
memory usage varies from 16% to 49%, depending on the specific image.
Additionally, the container's runtime memory usage reduction ranges from 10%
to 48%.

[1] Below are the workload for these images:
	- redis: redis-benchmark
	- postgres: sysbench
	- tensorflow: app.py of tensorflow.python.platform
	- mysql: sysbench
	- nginx: wrk
	- tomcat: default entrypoint

Hongzhen Luo (3):
  erofs: move `struct erofs_anon_fs_type` to super.c
  erofs: introduce page cache share feature
  erofs: apply the page cache share feature

 fs/erofs/Kconfig           |  10 +++
 fs/erofs/Makefile          |   1 +
 fs/erofs/data.c            |  34 +++++++-
 fs/erofs/fscache.c         |  13 ---
 fs/erofs/inode.c           |  12 +++
 fs/erofs/internal.h        |   6 ++
 fs/erofs/pagecache_share.c | 171 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  20 +++++
 fs/erofs/super.c           |  50 +++++++++++
 fs/erofs/zdata.c           |  32 +++++++
 10 files changed, 335 insertions(+), 14 deletions(-)
 create mode 100644 fs/erofs/pagecache_share.c
 create mode 100644 fs/erofs/pagecache_share.h

-- 
2.43.5

