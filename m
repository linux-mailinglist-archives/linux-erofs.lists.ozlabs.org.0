Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 249ED79F4C1
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 00:11:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1694643090;
	bh=ByPRKaBPvwfc9u7y5uG2CcxAtw3rQQ+S7nD3I+xB+zg=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SN8ZQUP38ByzU2pTwCXA/S5/fVxc1lLUwhrtVUipirsxpumv/U2TNq5ocNvAVXHuJ
	 tt5jqkKOPT4v42Z4Np8iEg3Z1nYvGGt0s5rS5qX4pwOgXTGhB4g5Rf2qe6JDHcm6kt
	 X+zN0o4QxtpU9oG3gnz779PVprvRhOpX4u0ioB78yjheGUTm5lFwJkOqFbGSfFFUR/
	 fqgt9bd65U18BP/YsD6teoRyS/Ek2x1F/I+ibA6yzvZzfcTElMjPqhFjNRZoVnCNHj
	 DfO/Wa3HL6fwVVt2sui9HqctJXR/PaKLgPlCkkK8sdSaM/dB7ViFDygbsA9tQK/srG
	 /+FL+Jy8i+2YA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RmF6B0LlFz2ytV
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Sep 2023 08:11:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=sBAR0VW8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::1149; helo=mail-yw1-x1149.google.com; envelope-from=3hzmczqckcyyfjcxcngiqqing.eqonkpwz-gtqhunkuvu.qbncdu.qti@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RmF632Hqvz2xdT
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Sep 2023 08:11:23 +1000 (AEST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdb9fe821so4353327b3.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 15:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694643079; x=1695247879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByPRKaBPvwfc9u7y5uG2CcxAtw3rQQ+S7nD3I+xB+zg=;
        b=I+ixRd2ZOx8LQ/UI/dZBKXesw2Gu78rxMGJJONLHKvaSc4GmYDmrtS0ZKZ4+NP65Z5
         KfijZJ0+JYeDQiCNxGVQeprnJsyn68eKCFGIdciyRHeTY7W5TEYZQCaOmNg3eyC72mzq
         k5a/CN5F4dhTakO+WZq1VhE6UnbER6ZeHFLEEss/jVQy6A3kU+66dEEv/fXYTtDmnj+R
         /GVKphe2MdAocpo7FVBDK127j3Ldft7wBgwQWDIT6RC7/o02GNuVKpVf3tlMdB18x9Gy
         B+GKBRUpk1+OY0eS4/+4qID7bFq2LIppg0/vp2PfmBKPdkoSelF4LV4yW6Xbn+cM3Y1D
         QIkw==
X-Gm-Message-State: AOJu0YzGnozU0gijfXiBQaL1Ij320GCMZjbQEhSNcUqVh/zdWDPhUDTU
	LWsLZ0bsbcFQHv/L1XY277dhWCJG8JesLckpaVsFzYs6jFNEB3Mr8VHewL1I7LVLLFiVp1CAVUz
	FSg78HWocdeWCnW6P77lamhfxlw2Fv9mMJoycXUFwfGBnyTJ1Z7u+T1GqH5iCXp9oMwFecVL/
X-Google-Smtp-Source: AGHT+IFWsoGjvuKxjnedNe92FnqHIA1MBdJ4L39SbMfFa2QF9PU9JW/rugLtWskITQ7GORY3GcPXfNf0OFDn
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a05:690c:2c07:b0:59b:ebe0:9fd3 with SMTP
 id eo7-20020a05690c2c0700b0059bebe09fd3mr3220ywb.7.1694643079667; Wed, 13 Sep
 2023 15:11:19 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:10:58 -0700
In-Reply-To: <20230913221104.429825-1-dhavale@google.com>
Mime-Version: 1.0
References: <20230913221104.429825-1-dhavale@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913221104.429825-2-dhavale@google.com>
Subject: [PATCH v1 1/7] erofs-utils: fsck: Fix potential memory leak in error path
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

Free the memory allocated for 'entry' if strdup() fails.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fsck/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsck/main.c b/fsck/main.c
index 7f78513..3f86da4 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -585,8 +585,10 @@ static int erofsfsck_hardlink_insert(erofs_nid_t nid, const char *path)
 
 	entry->nid = nid;
 	entry->path = strdup(path);
-	if (!entry->path)
+	if (!entry->path) {
+		free(entry);
 		return -ENOMEM;
+	}
 
 	list_add_tail(&entry->list,
 		      &erofsfsck_link_hashtable[nid % NR_HARDLINK_HASHTABLE]);
-- 
2.42.0.283.g2d96d420d3-goog

