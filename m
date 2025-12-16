Return-Path: <linux-erofs+bounces-1495-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC6FCC13D6
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Dec 2025 08:07:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dVp0F4tXkz2yFQ;
	Tue, 16 Dec 2025 18:07:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765868845;
	cv=none; b=Ml+ehlZwWzroa9BWH1I4ihGm6eAI/maKWneli/u+xZvV045ruptElyS6rjGd3RKy1QwuI7NlCxBgGHOOleISIVqVNYXur2NF4HCj/V2uTU+D2+um/3yYMRBMSocY6rNI+YvJc/PjJyiUtoQ39Rioprmsu72KE53RmD5zaBHefCVXzFvbRckc4dcDrcjH5Lf7psBmopiJFKGE5tgcncR8zjw/1s8UrC+ulDRY1CGkGQ1vpBfZ9k6/flp7Hg0C6N1ggj5Lqx5yUGuchGqmUAGXXJI4+F1AV2a+8fez5dFX0YfO9B3HjPnc1tN/zdXE2HLGOzJTCpHT3Yj5Zd/4BQCpZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765868845; c=relaxed/relaxed;
	bh=YkcRmDtxWcx5UDKRAlE42q3vZ5wZwgNeJCJq0n9NCXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S8C+tgG08Y+Be7qzf8ZJPrrMBbtNtMcK+GdhZB208TBNJ5UOFhz+vMlzCCLovygSQq0y7AIn1MjTru6LBA4xeCGcpOEKn+YcudB54AzlEFI0SM113QXnCRh+MtP05N8haWz+YKHS4+89nTvM4wttE7kcz2s3fsfeWVpW6duUzFsTpnlxUQffoLXe9qr2+oU9CLlXJui0D68SpBfCQdd8VQVDmO4Eapw5vlUBmwkQ3FwXbVrwYaNazCmBPQkXwtmPbZ+T81yMvQVemQXyOr/Nl5Y9d0LN4dB7IKomk8nGSGnIJ/5F537fo4MEDBQSg0rrWPABosTzb3HUbjJScRj+HA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0n9cnHvO; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0n9cnHvO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dVp0C395nz2yDk
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Dec 2025 18:07:23 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YkcRmDtxWcx5UDKRAlE42q3vZ5wZwgNeJCJq0n9NCXk=;
	b=0n9cnHvOQGFI4xzwAcrSDYqpreMn5XXTxGY4D7sKlmYZhNmnOPAYMYHNfr9YFR/gnleSc6mJ3
	NjbyavOCqSWDpjbdzpHuRFZ8RGAB8DB4f+joyqb9szLCyRV/3SS7u85I2ZWHZ2eQwPPLY9ujVEV
	V5uzwbe2tWK9hHf71Myos+A=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dVnxh4TZFz1cySV;
	Tue, 16 Dec 2025 15:05:12 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id EE8601A0174;
	Tue, 16 Dec 2025 15:07:12 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 16 Dec
 2025 15:07:12 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <hudson@cyzhu.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 1/2] erofs-utils: mount: gracefully exit when `erofsmount_nbd()` encounts an error
Date: Tue, 16 Dec 2025 15:05:56 +0800
Message-ID: <20251216070557.743122-1-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

If the main process of `erofsmount_nbd()` encounters an error after the
nbd device has been successfully set up, it fails to disconnect it
before exiting, resulting in the subprocess not being cleaned up and
blocked on `ioctl(nbdfd, NBD_DO_IT, 0)`.

This patch resolves the issue by invoking `erofs_nbd_disconnect()`
before exiting on error.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/liberofs_nbd.h | 2 +-
 mount/main.c       | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/liberofs_nbd.h b/lib/liberofs_nbd.h
index 260605a..93daa24 100644
--- a/lib/liberofs_nbd.h
+++ b/lib/liberofs_nbd.h
@@ -28,7 +28,7 @@ struct erofs_nbd_request {
 		char   handle[8];	/* older spelling of cookie */
 	};
 	u64 from;
-        u32 len;
+	u32 len;
 } __packed;
 
 /* 30-day timeout for NBD recovery */
diff --git a/mount/main.c b/mount/main.c
index 758e8f8..a093167 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -1206,6 +1206,14 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 				free(id);
 		}
 	}
+
+	if (err < 0) {
+		nbdfd = open(nbdpath, O_RDWR);
+		if (nbdfd > 0) {
+			erofs_nbd_disconnect(nbdfd);
+			close(nbdfd);
+		}
+	}
 	return err;
 }
 
-- 
2.43.0


