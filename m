Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD628B0777
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 12:38:13 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hQL7PsFQ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VPb6q2fHhz3dCV
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Apr 2024 20:38:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hQL7PsFQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VPb6f55B9z3cFw
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Apr 2024 20:38:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7EE11CE140C;
	Wed, 24 Apr 2024 10:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F297AC113CE;
	Wed, 24 Apr 2024 10:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713955078;
	bh=DpJg2cHrz08AXmNf/xWkLpE+4eBBr+TUNVOWo5vuWQI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=hQL7PsFQvtIWcL0MF4rCLjmbZbEUNCOUkyU2kkgh6XD/DURp/q+VV9UqPGO2AkvuE
	 BiUM0F1YDzJpF6Yidw22B41cVKoVzXuSR+HzfWNipkRtSbgRiwASRF+ZX+2lee4K6K
	 df/ZuQHiSCCk1vjPYpDAaaT/FpYzqrQZfNuKRvomdjAWv4Kp8/CAaXlxmkbedODfTH
	 nfpQySViRhdoUrfv1TkdUEghn2CjwRaZeHT23H8ClOkViD9OnNa38NgQp2x7lCRnxr
	 i7DNfDMW8hici63+gGTOpdZMoRkHveJ26SiMmvt8+Gn1GAggb2t5JZfRmOJleo9vx8
	 tae3ygehVIhcQ==
Date: Wed, 24 Apr 2024 18:37:55 +0800
From: Gao Xiang <xiang@kernel.org>
To: Noboru Asai <asai@sijam.com>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH v2] erofs-utils: add missing block counting
Message-ID: <ZijhA4IJFSO7FYUy@debian>
Mail-Followup-To: Noboru Asai <asai@sijam.com>,
	linux-erofs@lists.ozlabs.org
References: <20240424055923.107209-1-asai@sijam.com>
 <288873a1-f594-4f5b-b3a1-881ad7ced1cf@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <288873a1-f594-4f5b-b3a1-881ad7ced1cf@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Apr 24, 2024 at 02:15:58PM +0800, Gao Xiang wrote:
> 
> 
> On 2024/4/24 13:59, Noboru Asai wrote:
> > Add missing block counting when the data to be inlined is not inlined.
> > 
> > ---
> > v2:
> > - move from erofs_write_tail_end() to erofs_prepare_tail_block()
> > 
> > Signed-off-by: Noboru Asai <asai@sijam.com>
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang

I applied the following version since v2 caused CI failure:
https://github.com/erofs/erofsnightly/actions/runs/8812585654


From 89e76dda5fd4956709bbb88b76063ef165fa3882 Mon Sep 17 00:00:00 2001
From: Noboru Asai <asai@sijam.com>
Date: Wed, 24 Apr 2024 14:59:23 +0900
Subject: [PATCH] erofs-utils: add missing block counting

Add missing block counting when the data to be inlined is not inlined.

Signed-off-by: Noboru Asai <asai@sijam.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/inode.c b/lib/inode.c
index 7508c74..896a257 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -664,6 +664,8 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	} else {
 		inode->lazy_tailblock = true;
 	}
+	if (is_inode_layout_compression(inode))
+		inode->u.i_blocks += 1;
 	return 0;
 }
 
-- 
2.30.2

