Return-Path: <linux-erofs+bounces-1044-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C35B857AD
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Sep 2025 17:13:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSJzj55xNz2yGM;
	Fri, 19 Sep 2025 01:13:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758208385;
	cv=none; b=kxXqTaC68kmKEZszYUL/hKWl6rbSDd2XTrH13hgdq8/aF6rUPCCIybjFWqtu3cl9JLOEKPp5CdTib7aZ20C2yX9XJEQ76rdno+ZzV+X3ENJDJbMlPPsC7QMusyQcB0Jl+uQadXIifNUVnz3b63CA3tnyEc3RKZ+Nymg+mxDQbCO2cz3g7QOCn4zO6log9b+F5WjjrBs3hcNy8bW2wjpz1y6TLG0nDMtWhuS2dsqY1xBdVHLlV5I7GW2BM82v7ojFuuXZZZjuamgNou8+blT8l6g37ufjB71093GZAAyW5RhhMTBR3iwqmHdhBspZ61soMXwYccpIYAaGPW1irgkS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758208385; c=relaxed/relaxed;
	bh=QSDEjBbTqJlL+C0FGGnIykVzfl3JgMaqLW6gjJJpfX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0QK5J3YgRpAZJdias5RMP7sMXUns03qcTrC3BiP4vLsg4LIlsGbD59LKJKnZ6FNEFDeESZkkIsxujmFdWs8EY1ODSlL1Oqyf9EIfLTa91eVjV9lmUOKsl5u6WH6+Nxp8UKMUf1Un+G61iaumBHnTiwls8WjssmYUNef+E63kERrlOIF4Jt9h+oP+tPXcYvTTwcoLzfLuSrgsgGKe8dkz2vVLWYSc9cLYKR1hslQrs5HekdLgYMemtIRybBQ4Qtap6cLkU2Xp0rE3JaJ0Wx/4SJXrVulYZe8KNk314jWHj/xlR8oTgixPSy+cbID9ReOaMZbRImdfJsXJc5wYwwjrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSJzh4Qb8z2xgX
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Sep 2025 01:13:03 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cSJvz4xbzz1R8nM
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Sep 2025 23:09:51 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id EC39C1A016C
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Sep 2025 23:12:57 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp500007.china.huawei.com
 (7.202.195.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Sep
 2025 23:12:57 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <lihongbo22@huawei.com>, <jingrui@huawei.com>, <wayne.ma@huawei.com>
Subject: [PATCH 2/3] erofs-utils: lib: avoid using lseek in diskbuf
Date: Thu, 18 Sep 2025 23:12:44 +0800
Message-ID: <20250918151245.58786-3-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250918151245.58786-1-zhaoyifan28@huawei.com>
References: <20250918151245.58786-1-zhaoyifan28@huawei.com>
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

The current `diskbuf` implementation uses `lseek` to operate file offset,
preventing multiple streams from writing to the same file. Let's replace
`write` + `lseek` with `pwrite` to enable this use pattern.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/diskbuf.c | 7 +------
 lib/tar.c     | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/diskbuf.c b/lib/diskbuf.c
index 3789654..0bf42da 100644
--- a/lib/diskbuf.c
+++ b/lib/diskbuf.c
@@ -36,9 +36,6 @@ int erofs_diskbuf_reserve(struct erofs_diskbuf *db, int sid, u64 *off)
 
 	if (strm->tailoffset & (strm->alignsize - 1)) {
 		strm->tailoffset = round_up(strm->tailoffset, strm->alignsize);
-		if (lseek(strm->fd, strm->tailoffset + strm->devpos,
-			  SEEK_SET) != strm->tailoffset + strm->devpos)
-			return -EIO;
 	}
 	db->offset = strm->tailoffset;
 	if (off)
@@ -108,9 +105,6 @@ int erofs_diskbuf_init(unsigned int nstrms)
 			strm->devpos = 1ULL << 40;
 			if (!ftruncate(g_sbi.bdev.fd, strm->devpos << 1)) {
 				strm->fd = dup(g_sbi.bdev.fd);
-				if (lseek(strm->fd, strm->devpos,
-					  SEEK_SET) != strm->devpos)
-					return -EIO;
 				goto setupone;
 			}
 		}
@@ -141,4 +135,5 @@ void erofs_diskbuf_exit(void)
 		close(strm->fd);
 		strm->fd = -1;
 	}
+	free(dbufstrm);
 }
diff --git a/lib/tar.c b/lib/tar.c
index 8d068cb..44714e0 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -675,7 +675,7 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 		nread = erofs_iostream_read(&tar->ios, &buf, j);
 		if (nread < 0)
 			break;
-		if (write(fd, buf, nread) != nread) {
+		if (pwrite(fd, buf, nread, off) != nread) {
 			nread = -EIO;
 			break;
 		}
-- 
2.46.0


