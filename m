Return-Path: <linux-erofs+bounces-2696-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBPdDFRftmnWAwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2696-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 08:27:16 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 738AE2902A0
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 08:27:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYVD063zTz2yZ3;
	Sun, 15 Mar 2026 18:27:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773559632;
	cv=none; b=ip6mcRYcXxEXaloXpFIkSFDV54sJHqNF6g4YcP810sOcPZtUTfjZtHR3dpNXt2f4UrLHErflClyQiv+DxXnxm9FXzEDxpZsdxUU/1QB7D6iIEdPVbRgvaBAp1IFAatwB/sPwl9M5gHZI32KAjD9NrQcIZX1pfOeMrNBJ2mm8bHjY06gRT3vYFLbcxqwpyPKo9nLy5AAP2hO5sAfDb+4yjJv/UEtXdOKP6SSanPCqU9PocDj98pGF64o0GWoSKBcKEocg1aHsBy0H3qzc4uuAT6tpIUOnYqPqhYxyqcFNpgPuOwmKTD5JdVs8k1rCj+L5ZEOlRW6duJmsb2w1d/NNuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773559632; c=relaxed/relaxed;
	bh=z2ubEZu08kNYvTY5shpQNqpb3ZkDkRqA4suelzjzeyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGd37o45feeKNYNE+5gLuchcf4lsc7DiceyLPiemuDhwxW9buVHgJKeNJB18NGd4KOXLZC6x1wgnWJyFH+5wlyqAUeYUP8X5QZvm6ZiotGizzHqyi+JCfc03ya3Z5aFSmGZcG1S+5pZOJjGMdWZB4BKfTS5O3Aot/zYa2YCd1WxuwFNEKwS+PO8bNrfGjf4OnFTiaCrslpU8YVRN5/CLU3u0BKCXsRFwmXSJfgoWx7s9Fwtw0nlip2FhCED5enfEaOM03FJ59/85YNp4lWRnSo1i1T6VCp5i8BJGKgxICkGG8OlGOxwziInRhSMeuUFZx55PgmSW6OCyr9SbQmo+/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O4fiPSx1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O4fiPSx1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYVD0042Qz2xVT
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 18:27:11 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8297fd53bdaso386541b3a.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773559630; x=1774164430; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2ubEZu08kNYvTY5shpQNqpb3ZkDkRqA4suelzjzeyU=;
        b=O4fiPSx1XWrYY/ikLIvz/5QJj9E5KvTtjJ+gOdXO1XMYu8qi+rmXsnuUbMrDfJ1MjS
         mphs+yiO2EQ1YbU72NNrI9QIqsZOQXnTd338TiO73ARVd59gRdhRWblB+BBp8HPK6ymD
         bYYuRgSiCys6bck7FykLCYoymFZm1bn+jdSckfrAeatOAkOuUosF7K3ZoQYow81I8Qcl
         8qSljqu3jK9pl9cuZRsDcqYJQZpTFNvx5SKOcDkzE80fOk5dKOjdpe2yZGo52Ts/me52
         qmYrMGNnjvj1RhaufYBGQ55zCBKloBiIFGjKel4lvW7IxhSTEftyKGpBee6OCaz+O/NZ
         oIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773559630; x=1774164430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2ubEZu08kNYvTY5shpQNqpb3ZkDkRqA4suelzjzeyU=;
        b=gay4dQiHVwnpL8gs4fKj1Sj9cKD8UmcdajWpk6NnpzPZwGm5goD0w+U6F4QlBfiauE
         8G8AZFb1Esq7YbufeSw2D+MWho1zb400fXxBCzPuAMkYQj7n51YQjsBmalLO3zrccYXM
         UhtLXX8uzIWj9WDBWi4SNh3ZxZbciUz2HYzgqYqKQzDSOq+opJwjue0edELlRL/ApZcx
         qZf+wy01YswlM5gzyEXEURr4gi6FOsHQfUtd9qM/210gAnQKOABKUN+r6C1WLtavmokI
         kRMUtFhEKqxhme6JzpqykBnx1b6O+vbjaPtb1S4jj+CyRkiAeuQwCK0vWzNpXvlJ+gb/
         HEwA==
X-Gm-Message-State: AOJu0Ywtek9nRwDFSUQuxiJMAqTzy+fLZ9PRMrTBVcJeLIlyoUKE+7zl
	iTED51rsupARXv4WY5Ap/cxsCzlilgUgk72hKa3AdHjStQjdc1I53LdA
X-Gm-Gg: ATEYQzwrW8jC3knhFrGXWo566MDOBlxeEflQL6iknRziPCAvts+hSAXYIILzQiKQqk0
	D8VqYlqi4KBQP7etbt5Vb7UrUpt2CYs0YF7lJsk0pQdRylM+B8Cx1B7n1YvzdnWIMersAC5wguQ
	/hO4EMMmfVWZj8SuuzicFtwlPSYvU45Sm/g42NbsvfnEFdlSklCHmRHOFGTMwdPHWf8TXnOMDht
	zs0wfZXkeZtJzxYR2I1R/y4t9UJWvmM+C6o/WzUN9YsL5wXq4XS49TMVsvbeRAnyHeht8vBWmz+
	M2xXMCd478P2t6lkz7Jx8cznslkW/4yLhM0ogNvApNCiRm8su65FKV7azylkAnBDsOQ7UXKD0uw
	ZhCPXghIN3y7mci9jBFJ+MYke+GTIT1KncHAGljwjjaSpLo81axjo6EmSQ4uQzd9WETxYq451Hu
	3Wh+XgMtXNvyA417Eqv7XApF2Ln+n9IHtu1FOkwDgmnlujNxy36SkWvb7j1LniBbM29RJVq9RWi
	7i7yN0cG1HPzWGJV5Bh9fJTSee7CzsbvnuI5A==
X-Received: by 2002:a17:90b:3dc5:b0:359:7b9a:2cf2 with SMTP id 98e67ed59e1d1-35a21c9aa2cmr5728419a91.0.1773559629660;
        Sun, 15 Mar 2026 00:27:09 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb649a8sm5744485a12.18.2026.03.15.00.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 00:27:09 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH 2/2] erofs-utils: lib: fix decodedcapacity integer overflow in inflate partial
Date: Sun, 15 Mar 2026 07:27:01 +0000
Message-ID: <20260315072701.17090-2-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315072701.17090-1-singhutkal015@gmail.com>
References: <20260315072701.17090-1-singhutkal015@gmail.com>
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [117.203.246.41 listed in zen.spamhaus.org]
	* -0.0 SPF_PASS SPF: sender matches SPF record
	*  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends in
	*      digit
	*      [singhutkal015(at)gmail.com]
	*  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail provider
	*      [singhutkal015(at)gmail.com]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:42d listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:singhutkal015@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2696-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 738AE2902A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

decodedcapacity is declared as 'unsigned int' (32 bits). Two code
paths can silently overflow it and corrupt the heap:

1. The initial assignment shifts rq->decodedlength left by 4 bits
   when partial_decoding is set. Values exceeding UINT_MAX >> 4
   wrap to a small integer, causing malloc() to allocate an
   undersized buffer; a subsequent write overflows the heap.

2. The doubling loop left-shifts decodedcapacity by 1. Once it
   exceeds UINT_MAX >> 1 the result wraps to 0. On glibc,
   realloc(ptr, 0) returns a valid non-NULL pointer; the next
   write into that buffer is a silent heap overflow.

Fix both sites: change the type to size_t, cast rq->decodedlength
to size_t before the initial shift to force 64-bit arithmetic, and
add a guard before the doubling shift that returns -EFSCORRUPTED
via out_inflate_end when the value would overflow SIZE_MAX.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/decompress.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index f87efd5..ff703ae 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -4,6 +4,7 @@
  * Created by Huang Jianan <huangjianan@oppo.com>
  */
 #include <stdlib.h>
+#include <stdint.h>
 
 #include "erofs/decompress.h"
 #include "erofs/err.h"
@@ -251,13 +252,13 @@ static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 	unsigned int inputmargin;
 	struct libdeflate_decompressor *inf;
 	enum libdeflate_result ret;
-	unsigned int decodedcapacity;
+	size_t decodedcapacity;
 
 	inputmargin = z_erofs_fixup_insize(src, rq->inputsize);
 	if (inputmargin >= rq->inputsize)
 		return -EFSCORRUPTED;
 
-	decodedcapacity = rq->decodedlength << (4 * rq->partial_decoding);
+	decodedcapacity = (size_t)rq->decodedlength << (4 * rq->partial_decoding);
 	if (rq->decodedskip || rq->partial_decoding) {
 		buff = malloc(decodedcapacity);
 		if (!buff)
@@ -287,7 +288,12 @@ static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 			ret = -EFSCORRUPTED;
 			goto out_inflate_end;
 		}
-			decodedcapacity = decodedcapacity << 1;
+			if (decodedcapacity > SIZE_MAX >> 1) {
+				erofs_err("inflate: decompression buffer overflow");
+				ret = -EFSCORRUPTED;
+				goto out_inflate_end;
+			}
+			decodedcapacity <<= 1;
 			dest = realloc(buff, decodedcapacity);
 			if (!dest) {
 				ret = -ENOMEM;
-- 
2.43.0


