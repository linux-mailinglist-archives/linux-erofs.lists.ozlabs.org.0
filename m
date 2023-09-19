Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11F7A6CA1
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 23:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1695157358;
	bh=iqEKmqwQQSLuQ9mTun1fBZyv5AJ/EaIrxxHF+R/5boQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Ch2Xfv8WVGvWWEwLl53j3br8tHhA3woarowPYGbEz9yItiro9HoHaB9gnbzx/gpxR
	 JcUNwrLwi6BrBBt9lCJ+GylKGsVg58kR2bhDDnWkcUv8wPH0PZfRm2ZqS13DSuy4OZ
	 G+HJ9k3EjxEgNeNUUyj2PxzN/xCNYIXURQ2JAxnvm26tLY431lu8ZnMUGfXk/iCMfI
	 G99y4b1bfXZswUPIDg/hI/ihIrRKsyaFLB2jlEa/vo5sgPytkMRo/NnAeSLmYmAUdm
	 Psx9LpDypQzYY0E9S/ysS1SCUxrlX3SQZzgWZ9WGtom9wLrVBdZrfjWxLukOB9Y9QF
	 /FwJiKXcHOHug==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RqvHy1xDxz3cTJ
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 07:02:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=0qOxbker;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3ygwkzqckc9e04xix813bb381.zb985ahk-1eb2f85fgf.bm8xyf.be3@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RqvHs3QyMz30dt
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 07:02:31 +1000 (AEST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c7bb27977so5505474a12.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 Sep 2023 14:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695157347; x=1695762147;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqEKmqwQQSLuQ9mTun1fBZyv5AJ/EaIrxxHF+R/5boQ=;
        b=ergXwtzIgKBoPEovqym5/Hvu6Q2OCSrTFHsBRvKdWlG5TvRqima1D6tViw60Icx3OS
         dWQ+0orzm2FN/YC++Ak0vj49WXt5mXBok/q1+bO8E1ls+vL/t3xV1YBDrWOeQiU+qUaR
         10w2PhGpuuVT630ByG995THu5ZhAM2JwewbVtc/EqRittog9PIw8bLFvsKwIDULdV6eQ
         wHNpqlVvRWULwLY+UbN43eBRce6+VFEt2OPBRrTfeblhwMkA6ogH55CVIS4LDmw2VJyn
         amLmEVJD9gvecybKXatUup3uFzsyxAHrMUPm6isjZAdDqsgB1wuzmxy66z04Pcop9ju3
         iY+g==
X-Gm-Message-State: AOJu0Yzvgk98IjzDJZGjmrGugZUzQEnsI1peDhpyi/2n8cE4fX5w/9RZ
	UtCA28xPbnkdrIy9rGLJou0t7lfnju5k/dQ8tjNY5xV3q6vzr50C61cgtOuk5Xlf9BymWQSObGu
	AU+4Xw6SzmHERe6HABh8GhdiycQYMovYbcwGGyZEcACldM5YGfT6ZtWuAqRE14eDr1SdIqBDU
X-Google-Smtp-Source: AGHT+IEessaAiDccbUQQIc4ZycoXelVHcjc623jRRK5KK373Kd1OnfU4s+VruGEtLpEbaU1uxTKEQadlnbJl
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a63:3d07:0:b0:578:af4d:6658 with SMTP id
 k7-20020a633d07000000b00578af4d6658mr4611pga.4.1695157346773; Tue, 19 Sep
 2023 14:02:26 -0700 (PDT)
Date: Tue, 19 Sep 2023 14:02:20 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919210220.3657736-1-dhavale@google.com>
Subject: [PATCH v1] erofs-utils: lib: Restore memory address before free()
To: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

We move `idx` pointer as we iterate through for loop based on `count`. If
we error out from the loop, restore the pointer to allocated memory
before calling free().

Fixes: 39147b48b76d ("erofs-utils: lib: add erofs_rebuild_load_tree() helper")
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/rebuild.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 27a1df4..8739c53 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -188,6 +188,7 @@ static int erofs_rebuild_fixup_inode_index(struct erofs_inode *inode)
 	inode->u.chunkformat |= chunkbits - sbi.blkszbits;
 	return 0;
 err:
+	idx = inode->chunkindexes;
 	free(idx);
 	inode->chunkindexes = NULL;
 	return ret;
-- 
2.42.0.459.ge4e396fd5e-goog

