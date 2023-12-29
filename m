Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB4082003C
	for <lists+linux-erofs@lfdr.de>; Fri, 29 Dec 2023 16:29:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1703863745;
	bh=IWLItomP6GEXQZbCwu1A31BjXLnz2T16xYfN+yaLlRY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PZtx5IYBwMr1OZDaDWbuNe77mtZU5zYE0GF5bIaPfB+9mOilZ7/M5/rP9ovaNJEV6
	 tIBrWG2vWWau1cSaMFfnR9l7ruKAomm7q9qwyKYCWwk7y9cq0lM/W7pxkvlR6mi4Hq
	 VwnPhntUSSIPCf0GXEC9UuCdnSSSEuEdoQ8bh0iojJZAPhGZvszRu9jNiZ4PEJB/0b
	 IPjYXpmNqisR1glFseWlLodx0fyqwa3gQZZmwQj80mmCLd0zsiA8RF/fvDPdlxtaWv
	 +d9PodedEWE9S47tuDEWvZu6bbkO6mmnUXcxcXIVxlkWtBuNkK+pBOhT+jriHtrg3N
	 XggMXOqLHFcPA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T1q6T1XRQz3c4R
	for <lists+linux-erofs@lfdr.de>; Sat, 30 Dec 2023 02:29:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=TIt+2a5N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.245; helo=out203-205-221-245.mail.qq.com; envelope-from=eadavis@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 14500 seconds by postgrey-1.37 at boromir; Sat, 30 Dec 2023 02:28:56 AEDT
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T1q6J6dHCz3Wtt
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 Dec 2023 02:28:52 +1100 (AEDT)
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 266AE21D; Fri, 29 Dec 2023 19:09:38 +0800
X-QQ-mid: xmsmtpt1703848178tler3y48n
Message-ID: <tencent_8D66B23C9D36BA971637084BA27411767F09@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH39IW5HizR2sWu+zJcP3A71yxExmFmhU/mUvv0aGo++xNpfn7PSz
	 H0JdlsXhnCdg4V1KzL6pRBg7xd7kL7/AxPr1KYTqzA65gJjwcp+tczR3xCtMYStXSX3M6BJ2UELk
	 ynGqHqPXvkUTwWRwVRvGCphwYqBF8vS7dxaXTFrWJfBPS1DQleBFYVI4W4d8A5qH0mPpjKWbeLdr
	 KSc0J/wSRsNEsrTvJWwz9gjGf1OaSUdv0EQabUK/7QhqKtelMwrvcMdFAzeap9f+jcAb9aVem2Xg
	 WhpCpM/wV0wqhnbTOvInTkUOTJhMCCriMCiCji08CIYg/NCEGMZsRG+B2U7VmaydfSJJqbMubUFB
	 XabmIqXi9BDpce7JuVMoWLdxY6PXkI2IzM5zRAAYusI5oXBWsFtCSzoSiOe6AHJ9SbKI4IgBwjWw
	 F1ZlT8HEoHgmW4HqKeJvUVl9daW1wtoi9A8f9clR16R/cmJWPri1Uca+sVVNBU984s/WO8eB8Gib
	 BLyOgKANBQYIbdIAZmxstFzHe6tzUk2hLFjFqVMLqn7A8/3vIlURrul+l5OWrtISAopif4YJywDP
	 sLUiVXxo9SmyzNe2xjAZjUq5HgVBuXotNdWD9Wqp5MgERLGNzoiFz/bONnKhRDyKbH5vchdqaRev
	 vSxDA2LOvEeyg60sHMUb8CLw2ppZz24JvqRA9lmqNn0au+F1jww4WqFVaNp+z64U/l0Hqir6f/W7
	 vzM875o4UWzFBa0TvL1EA9G8vjSXW5E1pxw8kL7Gv69VtZ676B21KzFvs+TSmwHHMLTj9JUkpVkN
	 2Xm6EW/hC0usa1YPs5bnJomcYOmm1CD5VU49SkphNlysdKDlYTA7IVr3jKylTFHO/5DEHVVK2ZlR
	 SM1w98xfLlAmrpSaR3gBHsOb/WG5wbE+R6vRMqqXntmII7wXQuxErQTqIft4eaAg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
To: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
Subject: [PATCH] erofs: fix uninit-value in z_erofs_lz4_decompress
Date: Fri, 29 Dec 2023 19:09:39 +0800
X-OQ-MSGID: <20231229110938.1157837-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000321c24060d7cfa1c@google.com>
References: <000000000000321c24060d7cfa1c@google.com>
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
From: Edward Adam Davis via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Edward Adam Davis <eadavis@qq.com>
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When LZ4 decompression fails, the number of bytes read from out should be 
inputsize plus the returned overflow value ret.

Reported-and-tested-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/erofs/decompressor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..8ac3f96676c4 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, (ret < 0 && rq->inputsize > 0) ? 
+			       (ret + rq->inputsize) : rq->outputsize, true);
 
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);
-- 
2.43.0

