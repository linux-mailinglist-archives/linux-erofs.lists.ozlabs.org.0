Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255A374E720
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 08:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689056506;
	bh=g9vw3wNJaqc0GmkV9rPx5sBjZTmUCUoNHWYqHzXkNyM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Gsj6uUVN/LkavTQbHKME+4hcrYsnxgNbYr0KaSKx2OAm+2anCrPNzMmAdfUScMD/q
	 545Q6ZPKS/1iBDI7DI2YTXG+GwF5/3NHNuesC03D7/4ml3r28rHIIET897ni4j2/xE
	 FtdQiAGoCDjACD4SsknA1Ah5M0MoHA60SqPeghgLIAGFj2ddjPOrUXXYOjDmgXGHv8
	 847ptnd90ImHIyA2PTNA3oLR0NPBi4bxHSCfJAwlIELBqkUjdkmjbOg2FeL6BRMXv/
	 ZWpAkElHESfM1tHZdIqqw854DIGVUhk1mA8dDmqYOH+UIsA9gSy9/c+ak3lQ2qypSQ
	 nzHgmVGCaU5og==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0W3t0Bnjz3bNs
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 16:21:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=I9U+FodQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=yinxin.x@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0W3p4DSpz309D
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 16:21:41 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-66f5faba829so2966932b3a.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 23:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689056498; x=1691648498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9vw3wNJaqc0GmkV9rPx5sBjZTmUCUoNHWYqHzXkNyM=;
        b=bKaB2CFZlarYjT4GorZvn7X9dgT55fuKGUCEAGbHYK6ktzAYlUyyMBt4NWXUv8/Vg7
         c1aRNMLfMh9/7JHPb+cP83xeMIdCcXAOENR57b3xd51ylseo3SUK4PzyhyUWDMVwUy9P
         7biOrv3JavBl3BHAsSg6pIC3R+BLsWFeZH/ShX9GU77PRinqp0UTVJ4lyNFv4g1LW4s7
         P3IZUOg1JyBc6t4YNaU0yL14PL8J780eQB1vwEKkl5JANcD94HnOD2aQFuAJVO7LMae3
         Z7K94sNSH0/8+CvcrYUqQHau/YEnHZ282F0d2jVBpJYl8GLurVdPpWsbtT5/rZUrWqz0
         Hvkg==
X-Gm-Message-State: ABy/qLb8zQ9iSBW+9QmDCz393tiwugaLAX8IoX/Ytzm77E+AVHnRiRQj
	Z647hVyTe7UsXd3HLRcKtniDyg==
X-Google-Smtp-Source: APBJJlHx73zLQPxjJC8AvYUv64ekmUKVlLyPrdUmGa3uBS9V+G1fw9QM1Day53sIS5cpHttM9bJ4WQ==
X-Received: by 2002:a05:6a00:850:b0:675:8f71:28f1 with SMTP id q16-20020a056a00085000b006758f7128f1mr13858646pfk.30.1689056498026;
        Mon, 10 Jul 2023 23:21:38 -0700 (PDT)
Received: from yinxin.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id q17-20020a62e111000000b00682ed27f99dsm864056pfh.46.2023.07.10.23.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 23:21:37 -0700 (PDT)
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	huyue2@coolpad.com
Subject: [PATCH] erofs: fix fsdax unavailability for chunk-based regular files
Date: Tue, 11 Jul 2023 14:21:30 +0800
Message-Id: <20230711062130.7860-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
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
From: Xin Yin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Xin Yin <yinxin.x@bytedance.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

DAX can be used to share page cache between VMs, reducing guest memory
overhead. And chunk based data format is widely used for VM and
container image. So enable dax support for it, make erofs better used
for VM scenarios.

Fixes: c5aa903a59db ("erofs: support reading chunk-based uncompressed files")
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/erofs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d70b12b81507..e12592727a54 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -183,7 +183,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
-	    vi->datalayout == EROFS_INODE_FLAT_PLAIN)
+	    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
+	     vi->datalayout == EROFS_INODE_CHUNK_BASED))
 		inode->i_flags |= S_DAX;
 
 	if (!nblks)
-- 
2.25.1

