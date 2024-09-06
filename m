Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72C96EE47
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 10:37:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0V2s4SP8z306S
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 18:37:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725611827;
	cv=none; b=DtH/UwW2V+3C13BlFxo4F+qx/b5f8eZMlzJpzR2ni6onmTK6mqkOYIBAdRsGcazIdDC33kV4p2CtMsCQaTtT7I/iWDVriVoux8MO6RHNvmjXM571/pt4ET0maY8BM08PfPTKQEC7qWCLoBV8KOWqcr5nDZMIfZLZe2CMCPp0IPNYl7dK/SjlhWJbvsWmRoQha8NhDM8laE/kr36etQ/U7cZE5Ff55ing0vd3W7vCYNr23I9qcub16mGcp08Wx91a5x4YzBJjon5PgzCTT0tG0AoktII693det45+bD27YPgiFI47mMNZklLHcChH9DZJGKQ2XmmGuf6InwRrYuBwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725611827; c=relaxed/relaxed;
	bh=4BMe9JHlscQ7Xp/fUvM4a4M+DdjHZ2kRh7uYMDFEkXU=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=b2mus5OPsOcU3iRNwaNk0SNZz+A2ZXQZG6ak7ZRX8iSjLVqmhR598etTh3+q+n4DgpXEuogeKOwTnmJ9RQbbZA0+6KipvyHul75430vMCPb6x7Exi6t5bbLUj8Q4zvMxNCEqLijDd9f8MiGTL4lSmddCNqTC2ETP4lxbne6e61mpJlEtq3WHcK8n6ncNs1I98oQIKeidVUtfLvc7N/XVhOuuPcyTs4+eiF8sTyH3bOmxjjUiqwJZGewYiotGfhl1diSlj0xmaVxmizohl13RxS+QKar8SPypSA+lJ1R8XjXXZ/hD6MrpdH5hwsL7xSRqRhfrdmk1SwOLZ7TMj5RWAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G1a/YNCb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G1a/YNCb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0V2n5Zklz301n
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 18:37:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725611819; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4BMe9JHlscQ7Xp/fUvM4a4M+DdjHZ2kRh7uYMDFEkXU=;
	b=G1a/YNCbOvVSx8BRNxRSsq3yINY5IOZ7ZkGAozeqJ8yDbXNoiDjV8UFaDkslqMy8GOHtbLLy5MZoUeaF8AbXbqo5aOuzh3DNdvP2t7ftvD0wqryQjFPM3bY4j8+BAU4D/kXzWi091yKMalXCQAnBijhoel7OpDommXCjj6IjSwE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEOvkJa_1725611812)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 16:36:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix an undefined behavior of memcpy
Date: Fri,  6 Sep 2024 16:36:51 +0800
Message-ID: <20240906083651.341555-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Call trace:
 - erofs_mkfs_build_tree
  - erofs_mkfs_go(sbi, ~0, NULL, 0);

inode.c:1395:20: runtime error: null pointer passed as argument 2, which is declared to never be null
/usr/include/string.h:44:28: note: nonnull attribute specified here
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior inode.c:1395:20 in

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index 128c051..d464bc6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1392,7 +1392,8 @@ static int erofs_mkfs_go(struct erofs_sb_info *sbi,
 
 	item = q->queue + q->tail;
 	item->type = type;
-	memcpy(&item->u, elem, size);
+	if (size)
+		memcpy(&item->u, elem, size);
 	q->tail = (q->tail + 1) & (q->entries - 1);
 	q->idle = false;
 
-- 
2.43.5

