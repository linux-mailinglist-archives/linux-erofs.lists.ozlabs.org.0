Return-Path: <linux-erofs+bounces-1484-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA48CA2A20
	for <lists+linux-erofs@lfdr.de>; Thu, 04 Dec 2025 08:28:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dMR1r4yH0z2xC3;
	Thu, 04 Dec 2025 18:28:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764833296;
	cv=none; b=HqlDcHTBbL/LPJ2tpuZ+6VfDl7bUUPIivL+yolNMO5RUA5JCUfN93gEBayJaDK199JhqJRxg0sK2Sn8ZI55pIiVv6Jccl/6B/gEoZx8BsC3okuUxBOIapniVi3QHaRw7fo+a8sojEMzr+ChsQ5aVZIM6aukn0ZZU1/Oldyq273j5SFaklCjVLyy8EPZII5Yo/KwYiZb1kZmK9N4m/NJA07j5011obLOBtYIvicyTE9w7mCDcIdwrMLbQnRsSLW/qa4+TEelHtzVMuknvvBXkgisUf+3OzFLT0MFVqsRCm1E4Rxui4GLk4uMABnPGi8/CfBiIm4vQnldFHZvcgI1Eww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764833296; c=relaxed/relaxed;
	bh=sL2fGuvY17T95CIsO/+LfxhHdezSnRF5itTzudRhq4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KSU7qtX8t3y9jbrzzGBD2LxL3YjiCkczaUyIokw97bIw8g5WdQPdUppgEpfQCHY3iSzAsENFcV4mR0MH1EFz1ImcwCGmDdWOXuJnc2i8ijnl7GusR83ydxAERBtuROvLRNOaduIyLwn130ge2Af04kxZWAMeF3cvo2+cTSWju59HmyDj2KNR6bAwzB/RrdA1Z66Hy02J2OyX6p4wFjG3GKzegjGLwp3atHQqL+cGOFxmPPG+UP7HDHrdmyzFr+KHN6AmNCLsrm8XB4VmzlRUvQoe3zZF3EUIOH8qjL9nZLM44RzMYd7NBDlk6mJK3NFfA0C4Ih7607WkZRyUEOs+4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=l7PbcEDe; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=l7PbcEDe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dMR1n0MYNz2x99
	for <linux-erofs@lists.ozlabs.org>; Thu, 04 Dec 2025 18:28:11 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sL2fGuvY17T95CIsO/+LfxhHdezSnRF5itTzudRhq4M=;
	b=l7PbcEDeIIUzOMKtHtiIkc33bSd+ZEDtsuLYFWJRZ9ZeF8LweXQjpvZwZPfFe3NSZ8M8xmmHQ
	c8r/eNeFvjphbNWYf3e6S/PD3ucsqAchg7MHDextDSpYYQS7GeQXdJT0dmQeGfQLmPS9+S60mP0
	+0vJ9u4xcI5vKeoVrank3Us=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dMQyb3pxHzcb07;
	Thu,  4 Dec 2025 15:25:27 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 15D261401F2;
	Thu,  4 Dec 2025 15:27:57 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 4 Dec
 2025 15:27:56 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <hsiangkao@linux.alibaba.com>, <jingrui@huawei.com>,
	<wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [BUGFIX] [PATCH] erofs-utils: lib: fix erofs_io_sendfile() once more
Date: Thu, 4 Dec 2025 15:26:57 +0800
Message-ID: <20251204072657.1017332-1-zhaoyifan28@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Misuse of constant parameter `count` leads to an infinite loop in
`erofs_io_sendfile()`. Fix it.

Fixes: 53255c7 ("erofs-utils: lib: fix erofs_io_sendfile() again")
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/io.c b/lib/io.c
index 90d2e54..37a74f6 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -592,7 +592,7 @@ ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
 	}
 #if defined(HAVE_SYS_SENDFILE_H) && defined(HAVE_SENDFILE)
 	else do {
-		written = sendfile(vout->fd, vin->fd, pos, count);
+		written = sendfile(vout->fd, vin->fd, pos, rem);
 		if (written <= 0) {
 			if (written < 0) {
 				written = -errno;
-- 
2.43.0


