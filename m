Return-Path: <linux-erofs+bounces-385-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B22ACBF00
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:57:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBH3C4VnWz2yGM;
	Tue,  3 Jun 2025 13:57:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748923031;
	cv=none; b=H+V3LCW9Po1Uu8d+n08+GQ4FFFmdmkP75rjgtPK8e9QrbKEIIQNtsCCMtP60zjqxcR6Dbztm1k69qpSDCYY0GFKmMjb93LHjkiaq8ISLCX0VbRtUVyjz7ggRFZusEG8NdJ48ef+YgQIJMiEEe5iQzEP7PDxrg/R5ZFCzQDf6iLVzUQkOVZZusZuyptYVRm+CLKdVGcpMrrw25qxdWbUje9/BA/JDeBPEcmDDwj9yF59fMRc3MFNZumRn3Td6ojDCUTmAl+mSBYtMkibV3KLTs/JlLEuIi+Ak4gx1OSI4mGBLoi60JGdZIsK6P2T0AKNx+cODL3CFnUoOMnlZlUhdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748923031; c=relaxed/relaxed;
	bh=P9r+QEqRE9kJEIsXPiILyrBDIApYEKFI2NzBEGkpEcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HX+19PoRCDgoviUXRi5/ItFtEbxAlbrHnJrRZwiFGu0h3PKjBcBunFxIGAbOVavlPbwqU/+M2HP1IfuhIVSNrXjDnaJOGghdyI7RIZdHhmgzgfvfVjCry+3aeKjrgUsHUH/In69gk2IKvpTSlJ591jQ4sjqi358SkBe8D9bHNlh+oBiXXQHEMHzRsIU25KFRqWwFnfC96dnt43WtoH/TwDAIhPRD2HoI9z7rJTkO3o+ufDS2UR3Vne+EN7ueGPT/9az2NaNAHjzCwyA6jUFvJ5pSG/Nr3Vo1BFKmVAsR9z4rF4hsx8+ZHdgdfCzvV3GNdasIMvssH9Cy5+VH7DreYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FuHZksQ4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=FuHZksQ4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBH3B3C22z2xDD
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:57:09 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748923026; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P9r+QEqRE9kJEIsXPiILyrBDIApYEKFI2NzBEGkpEcY=;
	b=FuHZksQ4oCFksix5VrZCj4KbTl8KI0G3gkAdudWd26SF2wd7VGUvPiubU3IcYPqvHeIYd2GMJdF9yrBmTNaZCFtPwe2rETl0kBZULL77EwYpQ0/TIUQ2LDfUkQWKkVQAYmJ27HZEiOXYnm6+BcCEoYG0tDEq3LV2KqAcQfy91ds=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WchYNJm_1748923025 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 11:57:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/5] erofs-utils: change EROFS_TOF_HASHLEN to 64
Date: Tue,  3 Jun 2025 11:56:57 +0800
Message-ID: <20250603035657.2092012-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603035657.2092012-1-hsiangkao@linux.alibaba.com>
References: <20250603035657.2092012-1-hsiangkao@linux.alibaba.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The image build time of `-Efragments` will be greatly reduced.

Processors:   Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz (96 cores)
Memory:       384 GiB
Mkfs options: -zlzma,6 -Efragments -C1048576
 __________________________________________________________________________________
|______ Testset _____|________|_______ Vanilla _________|_________ After __________|
|  CoreOS            |  Size  |__ 660484096 (630 MiB) __|___ 660475904 (630 MiB) __|
|____________________|_ Time _|_______ 4m12.249s _______|_______ 1m49.828s ________|
|  Fedora KIWI       |  Size  |_ 2554892288 (2437 MiB) _|__ 2554793984 (2436 MiB) _|
|____________________|_ Time _|_______ 19m8.141s _______|_______ 6m22.378s ________|

It is now preferred to use `-Efragments` over `-Eall-fragments`, since
placing all data in the packed inode (`-Eall-fragments`) could introduce
some performance penalty.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fragments.c b/lib/fragments.c
index ce079af..1f24f70 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -31,7 +31,7 @@ struct erofs_fragmentitem {
 };
 
 #define EROFS_FRAGMENT_INMEM_SZ_MAX	(256 * 1024)
-#define EROFS_TOF_HASHLEN		16
+#define EROFS_TOF_HASHLEN		64
 
 #define FRAGMENT_HASHSIZE		65536
 #define FRAGMENT_HASH(c)		((c) & (FRAGMENT_HASHSIZE - 1))
-- 
2.43.5


