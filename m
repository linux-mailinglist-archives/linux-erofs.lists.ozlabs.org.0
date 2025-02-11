Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE11A30D59
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 14:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739282067;
	bh=gSx+1m3nKy1qm8su7TU/pzumhy9IJvTf32kHKeih6ow=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Xg30dX3czybA3yepsCjtoV/aAJuWmfTZF2q/XK8fwG17Jn3IQLIREYZHqWr1Geqyy
	 nG0GATpuYFa7e0QFwbQx0KQ4ca+wAFBOUiGp9n2jljk5ixer6UbsaNlRXQ4PG6HmW/
	 7zx3EV2Y4cHn/UEV2nqv6Ug/QlN8s1dkLenFEtRIC4uO1UHnqb9a2EOvMR1ffjGFzl
	 PTocSRDvC0z4sy8PZbO1eiqYxKCX8HrfcFoGpAG6wxCMzdWErmNz/jsAA9mhHuzyGq
	 nKlezYdmz2EEbWzET9fP7m9OpCyFwf0fIHxqyN7CiB10clbTkBDIQ5Ke1AoAI0psTd
	 pPP6LwHy/HJPA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ysjc34tvSz3c3n
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 00:54:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739282064;
	cv=none; b=izxmU57IsYJWebmlF/yns3U7oe2gUzDNIWnyT2/AbdkGtdBLed6yUQPftKOJ5yxJqIVV6lyxQ5NJrM56wjdi/EAXWvE7EfOwUXsES9sEdEz9dlRZZtU4D93lYmQ+MsOaef9UdwGN09EdxLIf7JrMLoH9+cOLJHNBbQvHeTRnmwOVt9zydOQ6dDw0K4f0m6wRDM27483uvVXoLoh9Cl/5LoSxQM8OM+WCXFum8L8w6MfQmdphR9AeG7aitcTBdez3AD3RzT3msCbkrfvnNTSWh+cNibPvmecI2xjiGTVsG+SlOJ44exdZNZhOzXHHVYNeSqFn975aBZ4gl3o16WpsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739282064; c=relaxed/relaxed;
	bh=gSx+1m3nKy1qm8su7TU/pzumhy9IJvTf32kHKeih6ow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jca1jU0jUfa2UjZRv166Yv3LGIaQeHyw25prE7l3oFxzdIvd2ciQ/hN5z3v1vC1akizSgmUD0hz1XkNW2izrP/MmKhexcaJ5BnfLXDUmfl7NFR7bUcDw0N08cZaUTWzodtaLeMKDHJqjpCidDDc47A6utKrvh71lGLytkgeAGRP/y+wELg1rx/G3rqn5x+0FQmitx+Sih8Gm4OhyVKt5/ubfPyUWDFiQhinLI6vzK1H0nlXDqJVdMdz8xmeX976Nh50/1Qbs+QpIlX7y/TIbClm4eKOozMx9jMfCTTY03V/7t/q2QLCssioKc+qP4lat0Zbm435uHM6SgZIybE2ppg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ysjbz0gjtz3064
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 00:54:22 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YsjZF4QWTz1JJm2;
	Tue, 11 Feb 2025 21:52:53 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id BD3FF14010D;
	Tue, 11 Feb 2025 21:54:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Feb
 2025 21:54:15 +0800
To: <xiang@kernel.org>, <chao@kernel.org>
Subject: [PATCH v2 4/4] erofs: file-backed mount supports direct io
Date: Tue, 11 Feb 2025 21:53:31 +0800
Message-ID: <20250211135331.933681-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211135331.933681-1-lihongbo22@huawei.com>
References: <20250211135331.933681-1-lihongbo22@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After .direct_IO is hooked, so it is easy to handle direct io in fileio
mount case.

We conduct the basic test on direct io and normal io, the fio is used in
the test, the results show it can decrease the memory overhead. It slower
than normal io in seq read due to erofs page cache and readahead, uut in
rand read direct io is similar than buffer io. The results are reasonable.

```
- buffer io
           total      used        free      shared  buff/cache   available
Mem:        54Gi     2.4Gi        52Gi        11Mi       254Mi        51Gi
Swap:      4.0Gi        0B       4.0Gi

after read

             total    used        free      shared  buff/cache   available
Mem:        54Gi     2.5Gi        50Gi        11Mi       2.3Gi        51Gi
Swap:      4.0Gi        0B       4.0Gi

cost 2GB memory (the test file is 1GB)

- direct io

           total      used        free      shared  buff/cache   available
Mem:        54Gi     2.4Gi        52Gi        11Mi       280Mi        51Gi
Swap:      4.0Gi        0B       4.0Gi

after read

           total      used        free      shared  buff/cache   available
Mem:        54Gi     2.6Gi        51Gi        11Mi       1.2Gi        51Gi
Swap:      4.0Gi        0B       4.0Gi

only cost 1GB memory (the test file is 1GB)

buffer io: 96.6k (seq read), 4245 (rand read)
direct io: 21.6k (seq read), 4187 (rand read)
```

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/erofs/data.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0cd6b5c4df98..d58496225381 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -395,9 +395,13 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (IS_DAX(inode))
 		return dax_iomap_rw(iocb, to, &erofs_iomap_ops);
 #endif
-	if ((iocb->ki_flags & IOCB_DIRECT) && inode->i_sb->s_bdev)
-		return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
-				    NULL, 0, NULL, 0);
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		if (inode->i_sb->s_bdev)
+			return iomap_dio_rw(iocb, to, &erofs_iomap_ops,
+					    NULL, 0, NULL, 0);
+		if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
+			return generic_file_read_iter(iocb, to);
+	}
 	return filemap_read(iocb, to, 0);
 }
 
-- 
2.34.1

