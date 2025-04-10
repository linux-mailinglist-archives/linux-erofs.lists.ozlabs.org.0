Return-Path: <linux-erofs+bounces-181-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E50A837CB
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Apr 2025 06:24:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZY6CF0mc1z3bgn;
	Thu, 10 Apr 2025 14:24:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=210.51.61.248
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744259049;
	cv=none; b=nfby1rk3CaXk6BQ+lDD7IdEqHC++anXmxlD7mAQa/hWauoelPMS36vFX99I2b28sGAk4u9+8lmQTEn6kbG1XP5AtkGW6dc/UdOX57eh1v4xwE7CFq/9Gu2K/Lr7xlRvLU7MYTa3XH+riPJEbYwHqFZvcp1EXIPl/D+akwGTuxFy8WrGJpS8MV0hajfeHwfB62jWAwSlfJ8/cJFlvrQzbAz2QifXB8k15rKVW1/NLHyMagIN2yTotKU4KIuodVP05qz+a5tUndDw4wTyyy2vQa28BYZTEWqVKfc44n+xnnQDhnThJHpEmYqFN169PQiXTft6IFuaqrMx9MZme5W0jVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744259049; c=relaxed/relaxed;
	bh=MPf8lUtR8JjSG7X+9BDlJZvd5HRURL6kR2YpH6MOosk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iGc7MCPwljtkXVSAv5ObCM3yyzdRs2A/nj1B0/uOuZq1SDDZ0MDLp6sZ2F+/ZVDMAwhGoedpiP4dsqec5QhIaVu2N+mHTROSB9MFDobUuNU//V0AbKMZSxHFJJZZb5PkDEwJAWuGbmBrHIMK8oHfUffTs/0Bd7qUAzgaH9VN+ysEoQKdLgmQVvvW7JT7lvGgUQjs95yXSW4AgZDMPm4qTOiH+S0bPqfF5A1FaclRiGKFN3zHi9VDMj1G2Rz5W712hK5i6VBjfo12M3zgTiMBk3CFiPRYk36GVfhbrnmLIZulq5D/A7KmilYSUtGjxs4IWqKfJr9+N8Z+7w8Q3c3LVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org) smtp.mailfrom=inspur.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=inspur.com (client-ip=210.51.61.248; helo=ssh248.corpemail.net; envelope-from=liubo03@inspur.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Thu, 10 Apr 2025 14:24:07 AEST
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZY6CC29btz2yf3
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 14:24:07 +1000 (AEST)
Received: from jtjnmail201622.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202504101222467137;
        Thu, 10 Apr 2025 12:22:46 +0800
Received: from localhost.localdomain (10.94.13.146) by
 jtjnmail201622.home.langchao.com (10.100.2.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 12:22:46 +0800
From: Bo Liu <liubo03@inspur.com>
To: <xiang@kernel.org>, <chao@kernel.org>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Bo Liu
	<liubo03@inspur.com>
Subject: [PATCH 0/2] erofs: support deflate decompress by using Intel QAT
Date: Thu, 10 Apr 2025 00:20:46 -0400
Message-ID: <20250410042048.3044-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.94.13.146]
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201622.home.langchao.com (10.100.2.22)
tUid: 2025410122246b0df1532b0f6c621da8f7d37d98b692f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This patch introdueces the use of the Intel QAT to decompress compressed
data in the EROFS filesystem, aiming to improve the decompression speed
of compressed datea.

We created a 285MiB compressed file and then used the following command to
create EROFS images with different cluster size.
     # mkfs.erofs -zdeflate,level=9 -C16384

fio command was used to test random read and small random read(~5%) and
sequential read performance.
     # fio -filename=testfile  -bs=4k -rw=read -name=job1
     # fio -filename=testfile  -bs=4k -rw=randread -name=job1
     # fio -filename=testfile  -bs=4k -rw=randread --io_size=14m -name=job1

Here are some performance numbers for reference:

Processors: Intel(R) Xeon(R) 6766E(144 core)
Memory:     521 GiB

|-----------------------------------------------------------------------------|
|           | Cluster size | sequential read | randread  | small randread(5%) |
|-----------|--------------|-----------------|-----------|--------------------|
| Intel QAT |    4096      |    538  MiB/s   | 112 MiB/s |     20.76 MiB/s    |
| Intel QAT |    16384     |    699  MiB/s   | 158 MiB/s |     21.02 MiB/s    |
| Intel QAT |    65536     |    917  MiB/s   | 278 MiB/s |     20.90 MiB/s    |
| Intel QAT |    131072    |    1056 MiB/s   | 351 MiB/s |     23.36 MiB/s    |
| Intel QAT |    262144    |    1145 MiB/s   | 431 MiB/s |     26.66 MiB/s    |
| deflate   |    4096      |    499  MiB/s   | 108 MiB/s |     21.50 MiB/s    |
| deflate   |    16384     |    422  MiB/s   | 125 MiB/s |     18.94 MiB/s    |
| deflate   |    65536     |    452  MiB/s   | 159 MiB/s |     13.02 MiB/s    |
| deflate   |    65536     |    452  MiB/s   | 177 MiB/s |     11.44 MiB/s    |
| deflate   |    262144    |    466  MiB/s   | 194 MiB/s |     10.60 MiB/s    |

Bo Liu (2):
  erofs: remove duplicate code
  erofs: support deflate decompress by using Intel QAT

 fs/erofs/decompressor_deflate.c | 145 +++++++++++++++++++++++++++++++-
 fs/erofs/internal.h             |   1 +
 fs/erofs/sysfs.c                |  30 +++++++
 fs/erofs/zdata.c                |   1 -
 4 files changed, 175 insertions(+), 2 deletions(-)

-- 
2.31.1


