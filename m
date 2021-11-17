Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B4250453E0A
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 02:58:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hv5gk4pL9z2yPm
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Nov 2021 12:58:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jTGZUpjQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jTGZUpjQ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hv5gg5TB3z2xY5
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Nov 2021 12:58:39 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AE7D63212;
 Wed, 17 Nov 2021 01:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637114317;
 bh=WnGiz+fllOvZa0T5RtRtimg/rkvU0t+IPGf3oOixmpQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jTGZUpjQ5BYIimi6hLXS/K0Q5OeQR3Dzdei4itP7+dEIxDmocgIcn9HMDNcHmsRN5
 n3SzzeNg0eqo9zMccseFitpe2rV1fzwac6GRw8tWaYFoe9egC20vA9Eb5zdx68PZg/
 w0Tuo/feoqA6jyhULHGGnbLAgSrnc7yBsR2dZvsbNaIc+6r/76/CSTLY2/bqTPO5N+
 XaFQUSGzR1OFnVTat5NTj/3ZJs6Y6uG/iESTe67nthpdviugs+NZEZUpWbLMMmM2w4
 k+kgBIdjKoUgj6MGN0kdCaHl2LyrmWnhEJsAHRJHfHIZlfZfGDSYjujoguVybjlGG8
 iKnipn7WGMirA==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: manpage: document `noinline_data' extended
 option
Date: Wed, 17 Nov 2021 09:57:57 +0800
Message-Id: <20211117015757.3323-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211117015757.3323-1-xiang@kernel.org>
References: <20211117015757.3323-1-xiang@kernel.org>
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Add documentation for `noinline_data' as well.

Fixes: 60549d52c3b6 ("erofs-utils: add "noinline_data" extended option")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 man/mkfs.erofs.1 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index f2e7d690c215..9c7788efbfec 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -52,6 +52,9 @@ Forcely generate compact inodes (32-byte inodes) to output.
 .BI force-inode-extended
 Forcely generate extended inodes (64-byte inodes) to output.
 .TP
+.BI noinline_data
+Don't inline regular files for FSDAX support (Linux v5.15+).
+.TP
 .BI force-inode-blockmap
 Forcely generate inode chunk format in 4-byte block address array.
 .TP
-- 
2.20.1

