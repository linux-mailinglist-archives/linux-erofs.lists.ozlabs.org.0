Return-Path: <linux-erofs+bounces-1045-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DDDB857AC
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Sep 2025 17:13:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSJzj5fHsz2yMw;
	Fri, 19 Sep 2025 01:13:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758208385;
	cv=none; b=T9uw6KkGTlzpXHdU9dJq3kFsOgTVa6HAsq4gMAz+mxC+rHP7qmV/PDLkeL3Fcg1STnFpmYi5lhM+KDzo5Rcu6d30427Gl6q/ptnHyUhKwzFGLjJksKB/7xg8aGG7JznB5tSPFrZoLj7+6dLeYnP01QlFczjHUODBkcgz651Na/kPTV6O4F7kKI1dCYLrZC6R9U6FMxTw94H2lCwDose/3ALpn3CU2vvNZPbEa+ME2ZebxUWI2ii6Bj2/DUP0dL+nKjbRLxXopsALV/q6XArH1QxOSGofwjv8/CHeaP9ryS7zxPRaO511CRHZAMTK/3pkfRe4mGsIKIG+6Lc0B2cvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758208385; c=relaxed/relaxed;
	bh=DiHLrkzL0WCe55daXadOavoKAuElv7sPypXQjm6NrI4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e3j45pZvRGr+vE6sKXHGYalK6vti6yB3N14QkVCZuG+LAi91Vt1U3rFuRECy9OscsnylIB9Hs9Vb5dkpKvckq4KCTV8uAYp03xJHxQTarkk+25Wt42VmY+sQDE9SFQLUzy1QgOOw3wAYaoMgforfrdWpAzSvEkAypvYNKz+C1e7Remmidqf/mZiebnpmJFUvWarpvBCs5AmYfFznVCczNpWgEh0sl3HL7gPiqsh1gRl8aXkFMkmItqEN3RluuNm4G1kFuCfloquPibq9SkRB2yQfA7jfZZKm2Ooy4/srm7HVx8IQ8S4iq+P5kPg7y+NnvRqh393l29u9qWC4S5kpxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSJzh4xMcz2xlR
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Sep 2025 01:13:03 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cSJzD1LD0z14MSg
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Sep 2025 23:12:40 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 26BDD1402E9
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Sep 2025 23:12:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp500007.china.huawei.com
 (7.202.195.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Sep
 2025 23:12:56 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <lihongbo22@huawei.com>, <jingrui@huawei.com>, <wayne.ma@huawei.com>
Subject: [PATCH 0/3] erofs-utils: mkfs: s3: switch to libcurl multiplexing api
Date: Thu, 18 Sep 2025 23:12:42 +0800
Message-ID: <20250918151245.58786-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

This patchset use curl_multi* API in s3erofs to improve performance while
interacting with a large number of files.

E2E mkfs.erofs image building time comparison:
- Workload A: Building from 3000 empty files
- Workload B: Building from 3000 files with size in 2~5 Bytes

+------------+------------+------------+
|            | Baseline   | Optimized  |
+------------+------------+------------+
| Workload A | 72.24s     | 5.08s      |
+------------+------------+------------+
| Workload B | 34.31s     | 0.61s      |
+------------+------------+------------+

zhaoyifan (3):
  erofs-utils: add mount/mount.erofs to .gitignore
  erofs-utils: lib: avoid using lseek in diskbuf
  erofs-utils: mkfs: use libcurl multiplexing api to optimize S3
    interaction

 .gitignore       |   1 +
 lib/diskbuf.c    |   7 +-
 lib/remotes/s3.c | 400 +++++++++++++++++++++++++++++++++--------------
 lib/tar.c        |   2 +-
 4 files changed, 284 insertions(+), 126 deletions(-)

-- 
2.46.0


