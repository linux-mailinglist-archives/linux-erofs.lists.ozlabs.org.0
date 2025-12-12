Return-Path: <linux-erofs+bounces-1492-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C9CB89B8
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Dec 2025 11:19:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dSQR92TQWz2xqD;
	Fri, 12 Dec 2025 21:19:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765534741;
	cv=none; b=mQOyiiBvptLrLgkIWQtoVByu7Hi606KQotp8CARbk2i87IgmJ9e3nl1uCfHsILdEPshcgyvuiNFDEu2FhJJZJaSox/oFJ59Gw/6AVR09BKm7iGkE8COf4cFsLhnqN/Lon+7bjlJlDIGtcqGB0Th7ORguID/pDYdWLRMwwMdCmXhYdFspHWsQxN6FQaYqs4XNjazpgcLSleVY6SFzfzVIt7hqPtJzDJL4k348J99Hi9RAUHLoSS8WQ2BtLhkg2+kGSntBz8+KtlkaKg+X0MLBtqoMqad3rMKMadPvyG22J9XZEOfwjhI5s97eDqkH26lDLm12RX5WadmwBZAIAtCFfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765534741; c=relaxed/relaxed;
	bh=BryqT1BVKlr/MICMYJA5KmwE22QR5Cb44fTTv2bCidA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VWU23+EoUlZJy9QoujhupG3MBlwVDzXDpvA56Mi1AkL5jnKx71bKiLjELXLVmdzxuLwED6wwNim7VDRmAQi/7LGJpuzapTuGc7dko7CpwcuvQG1SZKj6KdH+mQpt1fQCYD0JtQTsqoSkq/ZrvdaiRfIWd6IYyqDb9brVY70GFTMOMU/7rSFwFgQrHPsLSmL24EftJyEMOJ1+0sf7WzSg3j7rkGkxAXoQroTDvlNU/PTN+gc5U7UT6HFHp4CVbTplP6iQFVKFeLf5Qqu8uvzvRGMJMlYzyOB83Nul4m67aO7jc4UL789fcN1/xxKwxBtj5QZ5QeF1upHMtOir2g0B6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dSQR72nHCz2xNk
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Dec 2025 21:18:56 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BryqT1BVKlr/MICMYJA5KmwE22QR5Cb44fTTv2bCidA=;
	b=ShVctinupd+CPTtI9S2xADgHIBisVkwZx8S2Ifmq7d2nmjNTeh4ipDGFGh6AJHqslbm+dpasB
	5ZSz+vy1uYaNCFtjZLmYO0bGngqtlnxV1F9epcQCDw+AgS1sUJ02vNZJB+77UwspZK7WmAg4zIc
	ZBVFITVOpB2L7CHYZC4f7K8=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dSQNY5KDRz1cyPb;
	Fri, 12 Dec 2025 18:16:45 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id B8B831401E9;
	Fri, 12 Dec 2025 18:18:43 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 12 Dec
 2025 18:18:43 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudson@cyzhu.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 1/2] erofs-utils: mount: Check the status of subprocess to avoid infinite loop
Date: Fri, 12 Dec 2025 18:17:32 +0800
Message-ID: <20251212101733.590089-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
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
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In `erofsmount_nbd()`, if the child process forked therein exits
erroneously within `erofsmount_startnbd()`, the NBD device will never
become operational. Since the parent process does not check the child's
status, it will stuck in an infinite loop polling the NBD device state.

This patch ensures the parent process correctly detects this failure and
returns an error accordingly.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 mount/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mount/main.c b/mount/main.c
index b28b8ba..758e8f8 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -8,6 +8,7 @@
 #include <signal.h>
 #include <sys/mount.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 #include <pthread.h>
 #include <unistd.h>
 #include "erofs/config.h"
@@ -1173,6 +1174,14 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 	while (1) {
 		err = erofs_nbd_in_service(num);
 		if (err == -ENOENT || err == -ENOTCONN) {
+			int status;
+
+			err = waitpid(pid, &status, WNOHANG);
+			if (err < 0)
+				return -errno;
+			else if (err > 0)
+				return status ? -EIO : 0;
+
 			usleep(50000);
 			continue;
 		}
-- 
2.43.0


