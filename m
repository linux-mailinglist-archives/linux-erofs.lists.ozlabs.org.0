Return-Path: <linux-erofs+bounces-1068-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D0B940AE
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 04:46:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW49y1yxlz3cYR;
	Tue, 23 Sep 2025 12:46:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758595590;
	cv=none; b=a9V2CTrtq5qIQD8CRLTXPGKJVuARDm36HPVH3+TfUqC7+FsPHgRmog245WmRAlPbgWsVP4o7z98e1wiMZWKaoXOaltmbj+alK3xYApV8Nrs1hP2u2X4Sg8otLpG5ZpJX8U2q/MtSqhzQ7CjzUEmTZFsK/7jho+edf9SnL4OIO9ltxwoxWE79/TnZaSeT5cDy7O163y2REyF7O9es9eYjJCCLFBEiyHZk4jas1qJSVYD024rSFdrUBS7AHpA8tdZlB5XAOLlludFsXbjRil02MTHoG/582PxMFrbKZHhBCS3BcOPuefJtIIFJxHMgZEyjE3KlE3r/j+aIMUbncxWO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758595590; c=relaxed/relaxed;
	bh=++fiM0d6QAEWnkOieII6dlTnRPGKmx9xWxfgMURWdkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvK8SK7MbMrN99dyouVZaRQKL39ABfvsb7pDqQ8hOSuA9pX9TGvuOdobYvdspxo8CdrmA2PhCZF5Ryq81YK78OvP2elVMU+aUvyl3J8J7/6jVRX1s1TqFJNLmEt4WW13hpQXSd5v/DTo5UoXfT38Qr9Lf07AGCETBNjluNSntIy2ObBMXVIn6qB3WKZaZhb2nUp3Fm8gTJNLdlFyNss8DIdbkOhzilVCwBviC3Sg2ONW28vJsdVTNUYrYSgaOeKVC7T6MOjafpjFwBJZ9pG8FkIl8hgV4h3nUw3HUaXpZAqLNoUrefNmMTfVWlsHG3frC5UqTuMOjDR52GiyiC3QUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW49x2BLrz3cYP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 12:46:27 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cW46C2KxLz1R93B;
	Tue, 23 Sep 2025 10:43:15 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C3A0140298;
	Tue, 23 Sep 2025 10:46:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp500007.china.huawei.com
 (7.202.195.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 10:46:23 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>
Subject: [v2 PATCH 2/3] erofs-utils: lib: avoid using lseek in diskbuf
Date: Tue, 23 Sep 2025 10:46:07 +0800
Message-ID: <20250923024607.90686-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <53801295-8085-4237-85f7-c97181ed1954@linux.alibaba.com>
References: <53801295-8085-4237-85f7-c97181ed1954@linux.alibaba.com>
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
update since v1:
- missing `off += nread;` in v1, add it.

 lib/diskbuf.c | 7 +------
 lib/tar.c     | 3 ++-
 2 files changed, 3 insertions(+), 7 deletions(-)

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
index 8d068cb..b778081 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -675,11 +675,12 @@ static int tarerofs_write_file_data(struct erofs_inode *inode,
 		nread = erofs_iostream_read(&tar->ios, &buf, j);
 		if (nread < 0)
 			break;
-		if (write(fd, buf, nread) != nread) {
+		if (pwrite(fd, buf, nread, off) != nread) {
 			nread = -EIO;
 			break;
 		}
 		j -= nread;
+		off += nread;
 	}
 	erofs_diskbuf_commit(inode->i_diskbuf, inode->i_size);
 	inode->datasource = EROFS_INODE_DATA_SOURCE_DISKBUF;
-- 
2.46.0


