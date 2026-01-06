Return-Path: <linux-erofs+bounces-1683-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A24CF68C1
	for <lists+linux-erofs@lfdr.de>; Tue, 06 Jan 2026 04:02:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dlbZ23HZ2z2xqr;
	Tue, 06 Jan 2026 14:02:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767668554;
	cv=none; b=gYHx4KZKcIFcjmi9S+umvvLNla7t8fcH6CdMtJlCB8kuYNfP2qriNRbLYEajnr8GbQBhNL/sLMw4qL4x0p0unFqTSTZwKuymTkvAEyoq6uxwGj2eEuZpyveuznCWUsbyO84mn8a0UZ5ljopQAaQS0CtVBA6K3Gw2ktDvEMj/q+nSGbo7z6W5VYkEhx0s1ELTPJ1cb3YwJTlxK3FYvRDpJmsxuEZ3hLakKmZbENNJ6+amu9MVnK7T9nlRjflr4zfFEx8SnPdsiQB5UkI9aaZS6nVGQ7t4OvscujHGyd+N5VjiF/KB+gRSqqf0xYS3YzhvoACwpJURqJ9zMHaFhE5fLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767668554; c=relaxed/relaxed;
	bh=20nfw3Plmnsmkkkz6LG9IBFsg+zccJwfHvu7Z9UX6fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3wWdGAsSb8b6oKFV9cgT1AZ0++iJ7sQIESGqGCXCkFPfHRBOBgLrdiw10EJgS+cti5UnrtOe19J1yTgPjBVEvibd16ieJ+qW69PjfyBByDjrYS1RdmO0c+ML/xgofRD4s/TxEGk3pLmlmM9wtDQE4Zu6H10omiimKJ5noMt3mHYFW8Hh5sugTC4vbsd+Yn/+IfNEJRdXzXJsS3AowFFZ13Waf59r76Em30ua1vdstGud7i7tvvF5f/DtDBBSfg+mT6tciEEv87BOCRKoqqhCemz+v0TIipOAPcAwiDnnE4QVvt09Mjst2m85F6WPKZDvFLpN+VucHFUS4ibulRXng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HbuXaH2X; dkim-atps=neutral; spf=pass (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=liubaolin12138@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HbuXaH2X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.4; helo=m16.mail.163.com; envelope-from=liubaolin12138@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 251 seconds by postgrey-1.37 at boromir; Tue, 06 Jan 2026 14:02:31 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dlbYz0GcDz2xRv
	for <linux-erofs@lists.ozlabs.org>; Tue, 06 Jan 2026 14:02:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=20
	nfw3Plmnsmkkkz6LG9IBFsg+zccJwfHvu7Z9UX6fs=; b=HbuXaH2Xp0d0DMmk7i
	TGK17vqglg/HjWQIjSl0Ip/S7XJgjmJHjiUqMTNRIZiHpcmnCl92URQFxCa+SlnU
	aeKojGlK38BrbItFy+h4I7PACJkR7o5SG6WsON+yRnIy/jC6N6/bxnNANn7HgbQq
	VSvsvswWc6llYC+rlceKuCcz8=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXX4+OeVxpsvBmKQ--.146S2;
	Tue, 06 Jan 2026 10:55:15 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: xiang@kernel.org,
	chao@kernel.org
Cc: zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	lihongbo22@huawei.com,
	guochunhai@vivo.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] erofs: Fix state inconsistency when updating fsid/domain_id
Date: Tue,  6 Jan 2026 10:55:02 +0800
Message-Id: <20260106025502.133470-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
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
X-CM-TRANSID:QCgvCgDXX4+OeVxpsvBmKQ--.146S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1DCr4fJFWfKFWfKw4kWFg_yoW8GF4rpF
	93K3WFy3y7Aw1UXF92gF48Xr98C340ya48Kws5Kws7X345JF4vgrWSqF1jkryfZrZ3Jw40
	qFnFqw48uryUAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbZ2-UUUUU=
X-Originating-IP: [223.70.160.239]
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6RPzvmlceZOuDQAA3L
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Baolin Liu <liubaolin@kylinos.cn>

When updating fsid or domain_id, the code frees the old pointer before
allocating a new one. If allocation fails, the pointer becomes NULL
while the old value is already freed, causing state inconsistency.

Fix by allocating the new value first, and only freeing the old value
on success.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/erofs/super.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..6e083d7e634c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -509,16 +509,22 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		break;
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	case Opt_fsid:
-		kfree(sbi->fsid);
-		sbi->fsid = kstrdup(param->string, GFP_KERNEL);
-		if (!sbi->fsid)
+		char *new_fsid;
+
+		new_fsid = kstrdup(param->string, GFP_KERNEL);
+		if (!new_fsid)
 			return -ENOMEM;
+		kfree(sbi->fsid);
+		sbi->fsid = new_fsid;
 		break;
 	case Opt_domain_id:
-		kfree(sbi->domain_id);
-		sbi->domain_id = kstrdup(param->string, GFP_KERNEL);
-		if (!sbi->domain_id)
+		char *new_domain_id;
+
+		new_domain_id = kstrdup(param->string, GFP_KERNEL);
+		if (!new_domain_id)
 			return -ENOMEM;
+		kfree(sbi->domain_id);
+		sbi->domain_id = new_domain_id;
 		break;
 #else
 	case Opt_fsid:
-- 
2.39.2


