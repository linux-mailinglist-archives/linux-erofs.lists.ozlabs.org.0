Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0948974E5A8
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 06:03:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1689048182;
	bh=vuiccM128u3F7GrBFHXqGD2WL83xY5vpUaiVW9iyq3M=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=BIy2oiylnEy3ktGx/M1Ktnfkpi/60AJBrFYqL8+89k64WGGIFbHrDcuMNIoNO0ZEX
	 28SE3dQAYEcMJayVDeJFdYsv+fwNEXWMw5EENhyaA04pdCh/TMSuSZgLpPhyopQn+m
	 efpDVWmZubvr3cmTiAISaGQ9S9buwZCErL+R39lG/ImJT8TeN+/ExJYdggycuUFE4O
	 iYQU4jf5+ijdoZp39OH3uLpGRqrILPvLFuQWqklWuqyPSpXX07u8NCOI9FykNJYpEK
	 WU5uo7sXceR05pb/lv3Fg8pLRzgM0MdsuNalWc9/MFfyR5dZ4XCoSGwLN4HryyoawF
	 JdTUm3CCm/25w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R0Rzp0W8Hz3bWy
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Jul 2023 14:03:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=PjKllEEK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com; envelope-from=yinxin.x@bytedance.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R0Rzh3KY2z30fB
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Jul 2023 14:02:55 +1000 (AEST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b708b97418so4690294a34.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 21:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048170; x=1691640170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuiccM128u3F7GrBFHXqGD2WL83xY5vpUaiVW9iyq3M=;
        b=b4hUUf403/zjwyyHwDOpiEtRIA1jdvc07eWHPR2MGshyKKQ4SVUv35gj3JyDOmrPw8
         KQR+OKVLMyEY6lDgkNBN3VoPaku25Q+4Yj3YBrMCsEgRA4w/o8UULFtWW1SRymb+37PS
         xwQKNHKRTuyU7F0Wmf/DudqqZGd2ohGTifBrutEIEgGTDIoOguZ1hraK8YYQsAcDkVRv
         BYn+c7arLGLOpZYNXrXJZSIfBgNTkcZYAjeOUkJArPlqK8fvjQcLPhWL+M70IVsMbfw/
         pAydnFx4zV+si+1MtI5BZOqmhyJgmmp8Rpl3oHEVjOOr0e4LlqlSLhjFRY0BvUti6lnK
         q7aQ==
X-Gm-Message-State: ABy/qLbSBHzGQaM4WOh7ExeJeZ0W6brYvx5Pj0qMjGoD4FMgF/x9YhAh
	yjcywLsQo9oZ7diIrSLdQzap3A==
X-Google-Smtp-Source: APBJJlFmsxXmKrIXfjtVssxNfDzzn6shb3RQn/di+ezfmGGNZjbyWDDMUEfMw1AbGPDyYMsN49iITg==
X-Received: by 2002:a9d:480b:0:b0:6b7:4aa6:77b4 with SMTP id c11-20020a9d480b000000b006b74aa677b4mr14496139otf.4.1689048170194;
        Mon, 10 Jul 2023 21:02:50 -0700 (PDT)
Received: from yinxin.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902c2c800b001b23eb0b4bbsm684680pla.147.2023.07.10.21.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 21:02:49 -0700 (PDT)
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	huyue2@coolpad.com
Subject: [PATCH] erofs: enable dax for chunk based regular file
Date: Tue, 11 Jul 2023 12:02:39 +0800
Message-Id: <20230711040239.7410-1-yinxin.x@bytedance.com>
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

