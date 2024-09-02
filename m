Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C199682A2
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 11:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725267904;
	bh=TQsmNWJpgMKQcVX8UDqSzsB4Bs+ipIytVMnLzc8Cjjc=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=mv29YzSojQVrYyh0c/EVUleV6i48N8BtO/uxLGsmTqPqc67WxKPGXwp7XPvSdEO/W
	 UsrVvBW+aZO7SAr4fMpX/iuOrxPYNAhRPfFqJCPn1q3TQrS6P6i1UCgViBJUqGpaxK
	 yOXFZr+5KRFFQtEK6gZOfr4sKdmAQ7Xjc7bAmQXGlnJTVKYl1Z5ZY2xMILC6sliwPz
	 6f/JCWzXZkyGZfteLseCdTZQhbEUckt+1Vfb7uk0+pa6cyQXFE4l2beruz6Im7QWX6
	 Q03ch37Qb+XNFRiMdc8K0IPDapKnaKzU7ZutINPdIdE4Jccnd/1uWdjGLr/WdYM3mB
	 lgOU5pODSujsA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy2rw0xvZz2yNJ
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 19:05:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725267901;
	cv=none; b=J7JCDlCUqBahf+zJowZdUkDBx4njrc+N5UMeBH5X3y9ascOIgDg8hDXA9MKuNKeY+BfO+RjzJxhK2dzIkufdyK2ICaOnDs95XuJb86Y6zyRxinjvS2Gxx++STx5/wgQpoGQnAihS42hnti3K93BPJ/v6w2UlJ+UzMEIrwtGFyT5EruYknCOVUvxA82Kl33torHoaqEKzqeBG+53mdnMANTlhmB9IpROnUYyZNxQ7TAMiGgTwBbzDIEKfhozGl+FdDPV6JoaIr300XQ92x9hN8E/tfFX7h3tF/CrVXh2i1eLaEZbODeFfPZofVWPna9NOPs4mVFatq0rHvTQ0uxssbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725267901; c=relaxed/relaxed;
	bh=TQsmNWJpgMKQcVX8UDqSzsB4Bs+ipIytVMnLzc8Cjjc=;
	h=Received:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JElBk0h17+GP36gTxdXebrmTsIOQA4QWnAIJAxKJllIBVcKMOaN+r7izLl/iV/pKamp01buage6uVlXQBUPQwVo8XvUSTchjTTOpUaQJ7ASFDV8h68sT1bHGfHOTnoSxE1sgupQuMr2RMHoaWQqW9Q8UzMQDbWlZezxARtIlp0kSi3cOfDl2J5Kcvm2KfmZ7wGxE4lj2jDJg20pg/5wCK6wjnG5MytOijs53TbNkNL58XDPsaZQ73+hNdDKOBQvXkgDHy7Ox3zqMyIUQcYAK3yNEY8sh/xZqm8UVZLccCWx5xRGslNlldtTy6/pXb0nEtzenqSOIK5Jhi8FbKtsHWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u8d5KG78; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u8d5KG78;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy2rs35TJz2xZY
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 19:05:01 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7985F5C57AA;
	Mon,  2 Sep 2024 09:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279AEC4CEC2;
	Mon,  2 Sep 2024 09:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725267898;
	bh=KvXscvN78Ao8anzOavQBBAUcQkSkV1wlEFUurKNjQcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8d5KG78lYck5XcL0P3mmh+NRARmGaESQjh9dEqoJFtQSmJmFGi2ONSEXaSd/8UAc
	 Ohn1V/qBdVe8KglC3hTHWkDxt4qu2q6TzNjbQftleV89sp+jsd9ncFQ/Q3XVId+DCl
	 1WSjqfUVRMVDNGgUhCFz4E7lusZ2GAiScXPSFOCgBAM1g7yTGcsuKXPrl9S8YyS3CE
	 JGa3YuN0v63ntQyPRG9xpNSs2hrW0NXptv7PWUgqkCdttmMJCHLmM89fO0Z8zr3uDS
	 BQlrC2/mHY77oISmAO35JTL6PIgDLNubBV/GTd6pVpUiQmirXDZsGbVhN5oFdIA+On
	 hE6rSWUithovQ==
Date: Mon, 2 Sep 2024 17:04:50 +0800
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH V4 1/2] erofs: use kmemdup_nul in erofs_fill_symlink
Message-ID: <ZtV/speqypBt99sE@debian>
Mail-Followup-To: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
References: <20240902083147.450558-1-toolmanp@tlmp.cc>
 <20240902083147.450558-2-toolmanp@tlmp.cc>
 <5783ccbd-34cb-4f1b-8376-d795df2db4e3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5783ccbd-34cb-4f1b-8376-d795df2db4e3@linux.alibaba.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Sep 02, 2024 at 04:52:30PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/9/2 16:31, Yiyang Wu wrote:
> > Remove open coding in erofs_fill_symlink.
> > 
> > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
> > Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
> 
> If a patch is unchanged, you have two ways to handle:
>  - resend the patch with new received "Reviewed-by";
>  - just send the updated [PATCH 2/2] with new version
>    and `--in-reply-to=<old message id>`.
> 
> I will apply this patch first.

I applied this patch as

From b3c5375ceb2944a7e4d34a6fb106ecd4614260d7 Mon Sep 17 00:00:00 2001
From: Yiyang Wu <toolmanp@tlmp.cc>
Date: Mon, 2 Sep 2024 16:31:46 +0800
Subject: erofs: use kmemdup_nul in erofs_fill_symlink

Remove open coding in erofs_fill_symlink.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
Link: https://lore.kernel.org/r/20240902083147.450558-2-toolmanp@tlmp.cc
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 82259553d9f641..68ea67e0caf33a 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -179,7 +179,6 @@ static int erofs_fill_symlink(struct inode *inode,
void *kaddr,
 {
 	struct erofs_inode *vi = EROFS_I(inode);
 	unsigned int bsz = i_blocksize(inode);
-	char *lnk;
 
 	/* if it cannot be handled with fast symlink scheme */
 	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
@@ -188,24 +187,18 @@ static int erofs_fill_symlink(struct inode *inode,
void *kaddr,
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
+		erofs_err(inode->i_sb, "inline data cross block boundary
@ nid %llu",
 			  vi->nid);
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
 	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
 
-	inode->i_link = lnk;
+	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size,
GFP_KERNEL);
+	if (!inode->i_link)
+		return -ENOMEM;
 	inode->i_op = &erofs_fast_symlink_iops;
 	return 0;
 }


To fix a redundant tab and a blank line.

Thanks,
Gao Xiang
