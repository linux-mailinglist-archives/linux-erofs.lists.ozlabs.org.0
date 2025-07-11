Return-Path: <linux-erofs+bounces-596-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E78B027B3
	for <lists+linux-erofs@lfdr.de>; Sat, 12 Jul 2025 01:36:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bf7Pr2lpHz30Vq;
	Sat, 12 Jul 2025 09:36:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::104a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752276960;
	cv=none; b=iykN+EeBNcEgJEIsaAiDw04onYUlLmin1sCnSMAF3lemeZDDv/0mitHdTJ0r4LxAMxbrzRqVJoYXk9sBMo1y1X8H58HfN0WUTozWzw+xPsIULQUmMgn8Qp04LrrvoRzzMKuqL8/TpcU/AX48MgFKlvNuZpxSq9D1TE4dG0ILIhFiRqp1r4ocumR+uopeZ6lIvUskzdd0V4sbydI45UqOxEoOhybz95DWG/kwgxIoMhly/UTTQFidg4j8Kveow06+v9E/75+McRKITIiYPU9fDaNEM56wxBI1bdWQ7k1D0dDT66toG1fVHLlW0OSPYeTEdlST2dfCuoYRuC323VbfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752276960; c=relaxed/relaxed;
	bh=27bB/NzeVinAvSfuf0Iq1YLO371cD+yjxyU79kflYJQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nnNZFF4BKa7WHhzjSMHhPfeGy/8hmRBw5OzWtOKAvO2HwWDww/LY9JShHlenXlox1pHwUH4KWnIXKIJ2KDGVKFupPqguLP95HZb8hHC3ERD4vcsz2YKg6fXzLLvGG+Vs8oo4+BsRLb3ca0dR5+g1m6WiynveRV2fv8kuQEMHBiFZVnYuxfRXFHHLHVNWxLis26lUgrw6sATiCwq7Gs8tS0/t1IDtcLsi6TR2+gkoTZllusKFoL3v/VWy2tineRTXtWa17b6hNax6vypf9Mv/YoSgZqrkTfRw7XMZGg2aUTjQbIKMoXo0d9BuYTgbi+qckyHR1fWswly3d+etHHdk4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=BTj2ErIB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3259xaackcywlpiditmowwotm.kwutqvcf-mzwnatqaba.whtija.wzo@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=BTj2ErIB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3259xaackcywlpiditmowwotm.kwutqvcf-mzwnatqaba.whtija.wzo@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bf7Pp67fKz2yrj
	for <linux-erofs@lists.ozlabs.org>; Sat, 12 Jul 2025 09:35:58 +1000 (AEST)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so2506120a91.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 11 Jul 2025 16:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752276955; x=1752881755; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=27bB/NzeVinAvSfuf0Iq1YLO371cD+yjxyU79kflYJQ=;
        b=BTj2ErIBmXnkgQRBMijgGzeY8hMrjcZom+JS1+UjvpfGNg4fOaHqEWQnsNO8MdkRch
         SUmwk5qaZ4q/gtd9wvVHgn63Elm/G74kDBF/YJW/8zEx1zPusoR5wn3r5XJs6BarLhaO
         xhFBK+oP41mAE/FL1+KnhRIOErGZwBLZ+EQ2G/7d1I3bsDvMZYxeN9N9qnp1cDTAPzyU
         5bb1B3UNn4IoeLiQy/VkLnrF8gRHEKqN6DrC2R00Iil2FhDPlbRud27CPE/xRre72pRR
         K4u+Bhl2L8YuO+pnT9Izb5wx7ajxp3CSAB7MwlQ0oOQ6TBNsrL+zKLUZ3kXYoFtIKr/g
         jVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752276955; x=1752881755;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27bB/NzeVinAvSfuf0Iq1YLO371cD+yjxyU79kflYJQ=;
        b=TGeD1VwHI7atGTg2UTJb64l8pyQDvAvScS9GcVX5g5YUkCU1xiJdMpqCAJLTGA8Ofo
         0Gkf75VHa5Ou4ye8Xq4fI/6Smekpq4GNHtK7rEvJuYVGePs7oYY5byLttk3RhsWwtWLB
         rmmbqD2/Yf6g/oPBWHo4X3BXzdjAgVSlpu5BBxpwNrP/ej/WCyvO9nj0ROhKIhhynRE7
         FOAamPCiw+MQus3h7B43QHwqahbc3dnF4Tma1y5mN7J/YFYGn96+q+0FYvlhYW02goPF
         /G7AvuV1ueyMWgCMm7BKBIJu8ehNTRScbFyoIPdGLn7NkSI2mmw1k456spg0fbrJ2TS+
         lmag==
X-Gm-Message-State: AOJu0YyOUP/5JqYN3jgWf3KmXem2lZn21PamHXWYpBJF6Cd4zmTDw6d4
	qCrBF6KFN3ckr8xA9pmxv4dLQgsqWMxeNMTvxwkMo5NGGuOYt6CaZQqP1vJQMo0eQJUIMqFP5M3
	u1MldxDOKX7Gp849WuCExK7JHV9RmJlGK568ksvA00rDCUkm3k85xoRvxS33eB9xINLzn7BRXxl
	YK0DfL+214UOiTbHnS0Rr/oinyW61dmAOao+YM6ZgJ2X2r0LlfeA==
X-Google-Smtp-Source: AGHT+IFQIXBf8lMpMXzJ2WnIIVL8ZV+wSc5AAF2TzTMDuKvvtfiHPRfCwUPOfpjMAVbSiv03tgD1/oNXdYQV
X-Received: from pjbsq7.prod.google.com ([2002:a17:90b:5307:b0:311:ea2a:3919])
 (user=dhavale job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3844:b0:311:af8c:51cd
 with SMTP id 98e67ed59e1d1-31c4f53f6ffmr7269092a91.18.1752276955086; Fri, 11
 Jul 2025 16:35:55 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:35:48 -0700
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711233548.195561-1-dhavale@google.com>
Subject: [PATCH] erofs-utils: lib: fix memory leak in xattr handling
From: Sandeep Dhavale <dhavale@google.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, hsiangkao@linux.alibaba.com, kernel-team@android.com, 
	Sandeep Dhavale <dhavale@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In android the LeakSanitizer reported memory leaks originating
from functions like erofs_get_selabel_xattr.

The root cause is that the 'kvbuf' buffer, which is allocated to
store xattr data, was not being freed when its owning
'xattr_item' struct was deallocated. The functions put_xattritem()
and erofs_cleanxattrs() were freeing the xattr_item struct but
neglected to free the kvbuf pointer within it.

This patch fixes the leak by adding the necessary free() calls for
kvbuf in both functions.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 lib/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/xattr.c b/lib/xattr.c
index 091c88c..6711dcc 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -194,6 +194,7 @@ static unsigned int put_xattritem(struct xattr_item *item)
 	if (item->count > 1)
 		return --item->count;
 	hash_del(&item->node);
+	free((void *)item->kvbuf);
 	free(item);
 	return 0;
 }
@@ -775,6 +776,7 @@ static void erofs_cleanxattrs(bool sharedxattrs)
 			continue;
 
 		hash_del(&item->node);
+		free((void *)item->kvbuf);
 		free(item);
 	}
 
-- 
2.50.0.727.gbf7dc18ff4-goog


