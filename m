Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCED9681F2
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725265923;
	bh=64kmKEU0tXhYV2/T9ubIckI1K+ZPFKC6qQYZpIf0Twk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=isB9Q/UxfBqhRlVZEdSyDlHKkaSgJWggdBhnh0zpgjSuG0RBOj4ji4VvLUpO3A/pM
	 +35GBIypUDFdd5nUQz+0JxsbSN53OezpyPS74kYyBD9z130dnApr8q+brodCV3cklI
	 0y+l7mEvq3/Lho+s07BtpOZiY2+bUNNwm9nNvQsw3kdP3wQHSxt/vNBddc9v496eOb
	 l7Z2folN7QL4DV3kw+Lu2G1fA6Tv33cxphtmTo7EGW0zMh2xoDQ6+eSz3+8UXSveZD
	 AX8ylaYwMDPEaAy+s9NGC8l1bizBnHBphMMSQiY7YF3l/Pt/efAc5CwycPzTIxZK/O
	 lnF8eZfDERA8g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy26q2FvRz2yMv
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:32:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725265921;
	cv=none; b=SxLMHKqni/akrTMk/UGHV6ixnV648USTZe2DRHrobe2U2FOyXnCb2bbwb6JYNt5NFoCeye7bFklGffIuhdKWKwolOrbsSOPjH7FROLX40Ql4YyGyewSK9oHZgtxSI1oaLbC2KwZFcQsiaSvVWCy1dlRhYe5+e86H/ylihEp1zcXQW38Hu7a8K3jVk9rR8Or46SH/DKj/YI8gXyRQYsBN9tbABJSc6MLaEyUcl2jHmbZxObQ9ak7vl4tXWLyyWEXnzcrmj3gQCjsXidpbb5Np5iivhR9dLRlpsyER0LBKHKGl1g/kBiK8nf3iVw6f5EryKcQ3xOB8AHBltfUbJH7HXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725265921; c=relaxed/relaxed;
	bh=64kmKEU0tXhYV2/T9ubIckI1K+ZPFKC6qQYZpIf0Twk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version; b=H/jHRZRyAnSN1vA1PzEyzWeAUJeqfjMe8mj41h0TLD+5pT5njyyCUiJZATVTatLHkcj1vVoXpKwdLtCwPOqbOidsNmllc7njrZ1/YTX0r+D0DIdJt5HH6dxggZqXykdEctL3YR1sdBDzdAgFiVQquGTOBlac+H8C8FBu4xjC9YHtMzHwcISy3FYYAUnImXULXIBTwasKfh1jatGkjHF/VX03AzYyadbQsLQGeSJERzXt9ckbnJrbcCQY98oV6Ayv0kpMtzelktF1rRwF90MXTFlqH90q8ZHjNR+WsW+pjTCWiIzuBEFFVY+UmP7zD7LzfR5sBWNpAY/B+YkU6gKHgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=OOZ72e7c; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=OOZ72e7c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy26n23w7z2xWb
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:32:01 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9073B69905;
	Mon,  2 Sep 2024 04:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725265917; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=64kmKEU0tXhYV2/T9ubIckI1K+ZPFKC6qQYZpIf0Twk=;
	b=OOZ72e7cFDgwNfu4uNlpwiwQk4L75e6RvGKd5aCs2xXjaT9NU87UatWDF/mP8ZjeW1pHTx
	uycGp4OYNBlwKPei4zbrqatgDFu2o+hf13Yk3J6s+8s92Gs9r5Hvo9DRec5t27SoUqZVZx
	MSq8HBLFqwSGhD+ZFMf1HqTBGXpEjTh+hZiKFz8+MyKGe4FkmiikSW58fbwS3DsblI2+eO
	l1vpLdBJUame8RmM777lJCgexC9XG/xbQ526iuCBXY7Pvjklm3rqY1Jq8aGLw8GSbrTaFP
	SSTOGVYcx+LjD+BG60M2Q+GZas2xbY9OUT11TjA6DnC2E6/ZaDPBtQQvMWN/3Q==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH V4 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Date: Mon,  2 Sep 2024 16:31:46 +0800
Message-ID: <20240902083147.450558-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902083147.450558-1-toolmanp@tlmp.cc>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Remove open coding in erofs_fill_symlink.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 419432be3223..40d3f4921d81 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -179,7 +179,6 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	unsigned int bsz = i_blocksize(inode);
-	char *lnk;
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
@@ -188,24 +187,19 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 		return 0;
 	}
 
-	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
-	if (!lnk)
-		return -ENOMEM;
-
 	m_pofs += vi->xattr_isize;
 	/* inline symlink data shouldn't cross block boundary */
 	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
+		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
+	
+	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
+	if (!inode->i_link)
+		return -ENOMEM;
 
-	inode->i_link = lnk;
 	inode->i_op = &erofs_fast_symlink_iops;
 	return 0;
 }
-- 
2.46.0

