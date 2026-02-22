Return-Path: <linux-erofs+bounces-2345-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ymQLBGi5mmkEhQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2345-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Feb 2026 09:08:08 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D86DB16E9D4
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Feb 2026 09:08:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fJc6p2x43z30Sv;
	Sun, 22 Feb 2026 19:08:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771747682;
	cv=none; b=MxTtCkuk2qY2nck0GSkNZXanQdyC6UNRHVucNPKIiKgD8oOBfc5IVqwrBU+p4WalJlRr83DVu/x5r7BUA1WwqPzH+aSjs5A2p9Pmk/HwKmDKUxyhcKLfj87LcXHqEYM+5N2VMjLjQgnzcvUBqe4Pt4swA7iclYQSarBfhqlD6YLrEmOHaij2S1D755VMZJP9yUF9lveubmq7/owTFgPWbgwg+POnV34yOBPmqF9tHZaZJIhbTcj0hsaG+R1sBGvipURKEwU8GoTdhPkAne8ilMUpjGaeNBF4LiU8LO5vdYGa37wf6T+FSAUqjP6ua++vsLTUU30l4MSlpyBpzFgMww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771747682; c=relaxed/relaxed;
	bh=FKLp7eIqaq1joxbAidJWEPBkEDQl+3+SaFmtqWCYUbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICJo5eyRehnmeOsxegPmodMByxOFSfberrRAQv5osgdTnp3kuY340N+6EA8MDUkeLDbsx6dXdHPR9Qt6xyVhMJrfa8RrScWr8/55Rf8U/X7lBE1Jo2EwA497J5nIXMmhrSqYXchUeie5l0plbgFJ5lhesDmCHXkdwFYq6vGavvT1o1Inra/5INm41VEQHWFzGIZaaZ7bN3OTvcG1K4dmarTW0s8qO8ykm/H60uhIMMxHIboO1lcEj4fDq8M3lMDp0EnU/9+ftDBf92gBXNDgOL3VTD2meCS1bMIQSg0ClXG3zP2r7BlDDSdnyBaLFL/psa8S08wMGqM9cc1jTcpyWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I9l9Y3RL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=nithurshen@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I9l9Y3RL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=nithurshen@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fJc6m5vVFz2xm5
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Feb 2026 19:07:59 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so30270715ad.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 22 Feb 2026 00:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771747676; x=1772352476; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKLp7eIqaq1joxbAidJWEPBkEDQl+3+SaFmtqWCYUbs=;
        b=I9l9Y3RLdS8pEHmikrA2mxEfzzKHLoVtMvQ1TmFyr2TcmWXX9VQIHAbTxw5Kdags9o
         2XsXhenZmPRKWuGBJkwmOFDSLI2sMoMpwIK+ios/5vF32lYlxMYhJY/x7VDQ66lQrB/V
         aK1h9FPduIhPt9gU/aEn+1Hir5o2+Q8VbXBZxfKKmacbCM6khZ10q1a14vUaVLaDKljA
         TUFAfj3LtirziFgEpVJk0jt/kNNJLjAQxY3+EgrEcznQtf2tvX9yJgokuoQQJstOhkV3
         Vd9C6nyz3qOYikRNHBttkj+SUFikUCznj5wjs1gBfHqfnoty0Y9+V5vOXlsbnRua3Vty
         7ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771747676; x=1772352476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKLp7eIqaq1joxbAidJWEPBkEDQl+3+SaFmtqWCYUbs=;
        b=qbjp7Yotxo0qcPkZqZR8AJd4zH14txs+mgOwr0PSMLYrt9RxPxQaZ/6MW3RTQBfQ9V
         f7aivbiYprCfUKDZkv5Q7eFUi2hK0m393VkejweU6x90v+z7KMsGUILu91LExpMKFzvW
         DJuxqPSOYvjvZyK4MJhxY+ctKv+N6eAUg4WwYzN2Db+HU968ny3Y5qmnFzPqqwqJBwgi
         y/UUQDvCcIrMeiIJmrz1IT9uAD+Y2+YTdD5dahVNR/0Crfc63J3Bj/RqnjoHJ1MTQAkX
         x9Vs3rpfeXgfTb4bLto0GUS/GeXeHP4wXefvBILbWxAfp0wXyyB5BqftcF3IKgTfMabJ
         lzgA==
X-Gm-Message-State: AOJu0YyhBwthG3VL5vjq+Mk9IELxa3vY4xCHfi0m3Uu9va6oFtIPY2Jl
	Vx30CExMa11MajbFH2Az8Sm8+VVuPS8kYtQxt0g0TW1P32KvFNwOQMm3zbhHpQ6y
X-Gm-Gg: AZuq6aIAbqUlFFXD3Kf8aqzAERUCbH3At0qprpcGeE6mIQrLrND6Rhur/RHmHNmwjMJ
	+1PQQeoOMFoDngDYPA4NuHD940N2g4FXv5UOoHKmAArd3Jy1G3OIYlBHtRdsjlWrv9u9VPiR0EF
	Ye5e5UVrmsMyyfFyKP4IHIval1NEbD1NvaS+A6IYm80rJbnHPedwbovWIhrQ741bIblMq9lIO4m
	UQVJPcPjX6XMM1d6oxXKTOQaR4nZrjUGZjTUiIW8+s0T3tt0E2IhLoveJWzdVfRkkTBXFD6v39Y
	pJjNpzYDxAt0IIjA0gJcEemvYnXP1kcPSWWz3sa3Hvke4ojhfsWv3QPvaPRFsndPdTVmrXZiXtD
	odzG+LFxeWqefDIm2lhHK0V954R6sqen6PnlGaHjg2vfUrp08m2eBnq24qtYXDqSylBDu4hPjTW
	1jFhP7tz+Zlo8tKXAGj2i6O986SKlahfgCxjDZwubjz3QY0GXV/7KeWzBtPiFlRkVBGz3f1EUOh
	NcHJVcO+Jka1TV/
X-Received: by 2002:a17:902:c94b:b0:2ab:2311:e4fc with SMTP id d9443c01a7336-2ad7456f9abmr48165895ad.56.1771747675778;
        Sun, 22 Feb 2026 00:07:55 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e34fe7sm38961375ad.2.2026.02.22.00.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:07:55 -0800 (PST)
From: Nithurshen <nithurshen@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: yifan.yfzhao@foxmail.com,
	Nithurshen <nithurshen@gmail.com>
Subject: [PATCH v2] erofs-utils: lib: fix undefined behavior in zstd dict_size bit shift
Date: Sun, 22 Feb 2026 13:36:59 +0530
Message-ID: <20260222080659.11722-1-nithurshen@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <tencent_1678AFFD6EC67E757579937EE239D055A205@qq.com>
References: <tencent_1678AFFD6EC67E757579937EE239D055A205@qq.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2345-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foxmail.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshen@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D86DB16E9D4
X-Rspamd-Action: no action

cppcheck static analysis flags that shifting the signed 32-bit literal
`1` by `ilog2(dict_size)` can lead to undefined behavior if the shift
amount reaches or exceeds 31.

This patch casts the literal to `1U` to ensure the shift operates
safely on an unsigned 32-bit integer, preventing potential overflows
on different architectures.

Signed-off-by: Nithurshen <nithurshen@gmail.com>
---
 lib/compressor_libzstd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index c475077..6330f44 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -123,10 +123,10 @@ static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
 		} else {
 			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
 					  pclustersize_max << 3);
-			dict_size = 1 << ilog2(dict_size);
+			dict_size = 1U << ilog2(dict_size);
 		}
 	}
-	if (dict_size != 1 << ilog2(dict_size) ||
+	if (dict_size != 1U << ilog2(dict_size) ||
 	    dict_size > Z_EROFS_ZSTD_MAX_DICT_SIZE) {
 		erofs_err("invalid dictionary size %u", dict_size);
 		return -EINVAL;
-- 
2.51.0


