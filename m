Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE269685AF
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 13:06:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy5YB0LPcz2yG9
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 21:06:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725275195;
	cv=none; b=aA2TsBHZG1HjZSGZnJPeM+zMQSchYSc0EyoS2PhL99Bk9ZcWYtmoCeqvjP2lS4FtmE0ntOl1xP5NA3o1mSnTtqqVLczaddG+IbbOeD3CpuO9BHHux/MVr8nf5FVCTeIEM+Rvg6VYYTHtiAu28hUsmY62NgG3QEHjjIGsnDNu1LZL3OsT5nTaRIDUt8U7Ay0+I6mOVbfrx/gFSrqkNygyBXUQS8idwGn9UbzxItJcfAREwGW9hNxHg9f01RXPnoTGXLwb2DQbvOFpAZO4/d/RPr6EVYR4iumHTg6peKQmEpJo7Y4jR9gOaID7anBKRZGrA9nvFALSdBmzfGjMk+yA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725275195; c=relaxed/relaxed;
	bh=54uiycrpKCuIzqYqG1SzcrlXmsXcCqDK/gsnbUk+/kc=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=mzt7q4iFIH+8pMZgmMo5/GIVg51AWhOIYYNhov3gEn5joW2/4jY8gAp0WdW+XHJo9lFmeqamgP2rUHUlshTdeiYPQlRvQSn+E5gS5tinjKiIUY87RfH8DC7w4U1DmxeIakBNbaEeYFmzqnbnmQoQWljnA+q3JimKSzMHJSzRc+3GNqXdx+dp70VCYGH1yTCKVZkHJTn1ZZvW2BOYx52pvOfjeF4ye2SMmpAn9H+uNg7CfohFVdfNbdF0zgFNGlNhUkGAzdrcpaU6r31TOVguuAhRA3JjUZM3CEIOm4dA6wpEoHQP6pkP1ShcalAUEGt9ZKthrnplzVTi2nasvvDLRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yHG9wCVt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yHG9wCVt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy5Y604Slz2xPZ
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 21:06:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725275188; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=54uiycrpKCuIzqYqG1SzcrlXmsXcCqDK/gsnbUk+/kc=;
	b=yHG9wCVtVwH4AKs41CVfKGoXeZiz0cEATSzT1xpa3mjX7DnZk3XDHcQw8SufPpuy5f6WcpYLIAE4IdmwD+Rsq1eeIJe0G2OA1uLDGGHtHLFwfVjFvw4DKAI71H1n/R4SwkhbnJzlyty1riKZehrzxvePawJXc5XVYelGTCFZxXo=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WE7YYnS_1725275186)
          by smtp.aliyun-inc.com;
          Mon, 02 Sep 2024 19:06:27 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH RFC v4 0/4] erofs: introduce page cache share feature
Date: Mon,  2 Sep 2024 19:06:16 +0800
Message-ID: <20240902110620.2202586-1-hongzhen@linux.alibaba.com>
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

v4:
Changes since v3:
	- Implemented .fadvise
v3: https://lore.kernel.org/all/20240828111959.3677011-1-hongzhen@linux.alibaba.com/
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

Hongzhen Luo (4):
  erofs: move `struct erofs_anon_fs_type` to super.c
  erofs: introduce page cache share feature
  erofs: apply the page cache share feature
  erofs: introduce .fadvise for page cache share

 fs/erofs/Kconfig           |  10 ++
 fs/erofs/Makefile          |   1 +
 fs/erofs/data.c            |  68 ++++++++++-
 fs/erofs/fscache.c         |  13 --
 fs/erofs/inode.c           |  12 ++
 fs/erofs/internal.h        |  11 ++
 fs/erofs/pagecache_share.c | 239 +++++++++++++++++++++++++++++++++++++
 fs/erofs/pagecache_share.h |  21 ++++
 fs/erofs/super.c           |  59 +++++++++
 fs/erofs/zdata.c           |  32 +++++
 10 files changed, 452 insertions(+), 14 deletions(-)
 create mode 100644 fs/erofs/pagecache_share.c
 create mode 100644 fs/erofs/pagecache_share.h

-- 
2.43.5

