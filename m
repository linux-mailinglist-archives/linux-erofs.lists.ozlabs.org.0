Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7B16799C4
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Jan 2023 14:42:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P1SnQ5XCXz3c9C
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jan 2023 00:42:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KRaTzgp9;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KRaTzgp9;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P1SnK1xztz2xrD
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jan 2023 00:41:57 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 457D1B811DA;
	Tue, 24 Jan 2023 13:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10256C4339B;
	Tue, 24 Jan 2023 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674567711;
	bh=0+jcL0cpGh18gP3DGO0pTxKbweqX1ksJ6xgS3QQQsZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRaTzgp9xm1yNEZHc/2lOZvfx3tYZvq3w5UzLLK+QvEZqogIfUwzZbhJAuBGoxnSH
	 2Xt7FsJSn0MalBiTl6H9vN1gGS6L9JahPjJKi7kfjfiMgH5n6M3q+KsSwHjP/ZjqAA
	 TXDiYz9Hb8tYI+p47a8S4j/7FnxiKIJuwi4BC+pPTyOfe8YhZFAYnTCfj0NLTOuNpK
	 SJvQeM6ViaBTsPpp4hUtjWRXzQo1U6I6HaY8B8S1uy9RN8XQqGX0egZMDXM8FT9lk/
	 NRCnBsK/ILj7PDHe+81JmlDCmDmls7Q01khsmafGDNlr2hjbhm9SxAJU1zo6XUXJ5h
	 c+nnsQ78fY4wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/35] erofs/zmap.c: Fix incorrect offset calculation
Date: Tue, 24 Jan 2023 08:41:03 -0500
Message-Id: <20230124134131.637036-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124134131.637036-1-sashal@kernel.org>
References: <20230124134131.637036-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Siddh Raman Pant <code@siddh.me>, syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com, Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Siddh Raman Pant <code@siddh.me>

[ Upstream commit 6acd87d50998ef0afafc441613aeaf5a8f5c9eff ]

Effective offset to add to length was being incorrectly calculated,
which resulted in iomap->length being set to 0, triggering a WARN_ON
in iomap_iter_done().

Fix that, and describe it in comments.

This was reported as a crash by syzbot under an issue about a warning
encountered in iomap_iter_done(), but unrelated to erofs.

C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=1037a6b2880000
Kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=e2021a61197ebe02
Dashboard link: https://syzkaller.appspot.com/bug?extid=a8e049cd3abd342936b6

Reported-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20221209102151.311049-1-code@siddh.me
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zmap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e6d5d7a18fb0..39cc014dba40 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -793,12 +793,16 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 		iomap->type = IOMAP_HOLE;
 		iomap->addr = IOMAP_NULL_ADDR;
 		/*
-		 * No strict rule how to describe extents for post EOF, yet
-		 * we need do like below. Otherwise, iomap itself will get
+		 * No strict rule on how to describe extents for post EOF, yet
+		 * we need to do like below. Otherwise, iomap itself will get
 		 * into an endless loop on post EOF.
+		 *
+		 * Calculate the effective offset by subtracting extent start
+		 * (map.m_la) from the requested offset, and add it to length.
+		 * (NB: offset >= map.m_la always)
 		 */
 		if (iomap->offset >= inode->i_size)
-			iomap->length = length + map.m_la - offset;
+			iomap->length = length + offset - map.m_la;
 	}
 	iomap->flags = 0;
 	return 0;
-- 
2.39.0

