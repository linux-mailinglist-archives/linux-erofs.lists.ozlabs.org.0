Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC66323C5E
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Feb 2021 13:54:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dlwq9200Gz3cJb
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Feb 2021 23:54:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nkgAEiNw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nkgAEiNw; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dlwq76x3Wz30N5
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Feb 2021 23:54:27 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C63C564F8A;
 Wed, 24 Feb 2021 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614171265;
 bh=ZDSGtqQMqznruC3i1uHg8aXjYRDodJFZt8lPSkU8j7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nkgAEiNwQ9F2FAriAhKX0p1/O5aCmio35m9N3dDMCL4ZF3f5y3z/a//9uw/wbsI28
 IMsSCrbjKo2xa/C2C/9QIQ0VzmJwcHdmAitl79Hrb8Yt+vUaLu2d8+ADYIOgsLmrWL
 FVYHUmIqG3TqjH/gU8eZU1j+b8RnGLGQltJMhLno5CNcEZBE3oXIpL9wHQnKSo3BFq
 R+qn4gTVSi7QmHqTeQYuYg0DRfMdwuYXvEJZbSsuBaaH5iWHtYP3JQHVjm9iB6N5hn
 PhD6MMpm6bnEK6ae4fafNL+CeRmMdzbytFAA1mSWOsKZz9TcuWvAyuG9Vwj+4EQnla
 hWGZGUEtljrrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 34/40] erofs: fix shift-out-of-bounds of blkszbits
Date: Wed, 24 Feb 2021 07:53:34 -0500
Message-Id: <20210224125340.483162-34-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224125340.483162-1-sashal@kernel.org>
References: <20210224125340.483162-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>,
 syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

[ Upstream commit bde545295b710bdd13a0fcd4b9fddd2383eeeb3a ]

syzbot generated a crafted bitszbits which can be shifted
out-of-bounds[1]. So directly print unsupported blkszbits
instead of blksize.

[1] https://lore.kernel.org/r/000000000000c72ddd05b9444d2f@google.com

Link: https://lore.kernel.org/r/20210120013016.14071-1-hsiangkao@aol.com
Reported-by: syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0e369494f2f2c..22e059b4f745c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -124,8 +124,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-		erofs_err(sb, "blksize %u isn't supported on this platform",
-			  1 << blkszbits);
+		erofs_err(sb, "blkszbits %u isn't supported on this platform",
+			  blkszbits);
 		goto out;
 	}
 
-- 
2.27.0

