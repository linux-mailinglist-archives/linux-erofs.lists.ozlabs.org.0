Return-Path: <linux-erofs+bounces-3129-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EIzI3Myy2kbEwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3129-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:33:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA8F3637AB
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 04:33:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flBxV2Ljfz2ybQ;
	Tue, 31 Mar 2026 13:33:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774924398;
	cv=none; b=aw9UZBG2U/M81bA8DI0s5geaYKfZNIUqsxGPWiKAWnGoawPplIEMu4b5BPrjZgXGFCVD3DOLpvupx5D8XV2kcz39vNQLQg505QAi3KfRhBb7wb0T7BChl3uUWaTH1Y4bI824eqKS9JxXS/v76zxlUIrZZclX5PBXRmGS+sB5lN7XvpFhqDlwbR0/4d0GSHbGBroBhjvgidjU57ZI7NUgbcDoZYX41Bjcob7P9BoB/NPG/6mhBizJBKEP0CnL6YJBPPOLPfh7wbyI9bQ0dm9EZ63To7BIu8NQ/JVKzS6KxAYFH75cmnguwHbUiTmjyQc3Stx7VbQUjjdGZ29gmFrsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774924398; c=relaxed/relaxed;
	bh=ndPA1qw6T9cOuopTgHfdnnxjIooO/Cjbe/kcwP1WGog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWL/MY/oTsKbtNsxz005d63hXhdEhqQ/CQR9nlXDSDSp+fsLJ/hiXNiXiV2uTHsMcvhqlC+6aH1z1L3tlNmaT45BvGr3xN0wbgHBin8WFU2UCkDyk0x21yY8imI9iM0cLAMdPuU7gvq1qE4Bmo3v75AGM+gI3kvM48dJliJXmCDXz3PmbqiI1Mt4ZVJu7cDfr9RvpChshYJq34XsvrUs45GKCwWybZpy6XPuBomcyY29QpJSYkS4W7V65LMfpQUvxQs8ZWJCXHvr5Ot/P11xS0RlWh+xNH5ZSrpJwVovT3mCc3y8kaaoqz13/wzyjFJgDxnMTIvQWf7BMrkclSTNvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EVR/S2SA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EVR/S2SA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flBxT1kPSz2xSb
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 13:33:16 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so86533b3a.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 19:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774924394; x=1775529194; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndPA1qw6T9cOuopTgHfdnnxjIooO/Cjbe/kcwP1WGog=;
        b=EVR/S2SANJAwGwLzM9KcWPSyHws82fJAuSEI18MTCrrgEu7JnbmIefmnvZbmb+2Myx
         etCIvTebT2/1lzQSQyHdw9gYgc1YEcAfZuPFwaFk3xY02c7vOWk+tZN+FWKTW+52Q9JZ
         Td+KW8uTdrnCZjenx2iO/yMuF1XKirnDuTR4sbpg0vHGOSt/dBGbLXSfSsIh2s525cX2
         meO5Sig+9DkHQ2x9ON83c1y91dCgIW8Xl68R/DTBexzgny7WrHg8sm19l+i+a/68pcOK
         /HnE1blmAe2sGAsVAxqpLdbnvHIAXh2aoRYouZcvl39Fp/2KLJ2KbpTGILAZ54pgLTLO
         U9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774924394; x=1775529194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndPA1qw6T9cOuopTgHfdnnxjIooO/Cjbe/kcwP1WGog=;
        b=qcAcVjujPFtOWIYoPtm2MTTfraP6B33BltzMatJdPY398DUeD+1/LPQ/GoxqhcIs1n
         jBbtafMo8a5iF8+x8TZDDNMWoQMWbFNeVzZhb9byi3XAIx+epoV0KK4sKLaBYWSt++Q0
         SgiEvDM4emEZ/HrxTaJyEKW4sPiaognFQqpsGpQ/6lQ5cPDW1i1jy09MlRrNoHTB7yE3
         WeQRL0B9CqPKp6Ijx7KlOyZJn2lxAxFazSB7QB6LFuJf+EoERVJDWlu6wtH4BWZO3bWy
         R4gYfVNUCr9p4KNEjcaLaAE1QIYl+CoJjP/217D/vIojyTI+a5pv7ucPAg60WBh9arme
         iMzg==
X-Gm-Message-State: AOJu0YzxJ/JukMU/SaBmwfC4qNLItGAbvePECm9Z8oXud0c+6vU2Set4
	tQTyB94g7vq1UM2xhVTke8psGKNpnbrMEfWRAi2l/M1qLxHKixvCEOR8
X-Gm-Gg: ATEYQzxXhHnVaj0ThagkXsl1cNZBtKHKoYoVD8j/N42cXBArrVdpyq1npW3thHOySiW
	eSqq5ZRDtL6rZ47Wx9VqLiCmIwEvwSIBnbqP8KrSyUo2PcgxYvHEY2ncaUc+LxfQvAOqO1V2SX3
	54Qm/sivOXpVmtUPvRrsj0nT8+EPXoAa8qGdG7k2M+hzF5JqCOXscUGSZmENFBeLOKkqtSJGm8a
	lv9796mrcXplC+/Mb0JODBg0FUrg7iQ3ds6/6Tz7x3/Ctm48uAbO8uu0CmYBO5psS3nPjvtw4IT
	Bja2HpAtDiJS+E/+LBpFP1VKzWRqdtH2xOBeIU3vNego6i9CDxJLyiG95k/OXqeYPIFofkV9T62
	N2alUSrAHO2rzvYDAJrz65lNJYnyyKYO6TTzLUOwFbtffUh08Y5l8+qQVIABM1d8buRTrxTFrBl
	MORZH+tqcKrUsSuR/lNCAOdinp8aiUfrALSLncjwOwWTW1Wqs=
X-Received: by 2002:a05:6a00:299a:b0:829:7fff:eb7b with SMTP id d2e1a72fcca58-82c960841f8mr13807742b3a.51.1774924394018;
        Mon, 30 Mar 2026 19:33:14 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843b818sm10521706b3a.6.2026.03.30.19.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 19:33:13 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <xiang@kernel.org>
Cc: linux-erofs@lists.ozlabs.org (open list:EROFS FILE SYSTEM),
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] erofs: fix missing folio_unlock causing lock imbalance
Date: Tue, 31 Mar 2026 10:33:06 +0800
Message-ID: <20260331023306.18574-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3129-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 5DA8F3637AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

folio_trylock() in erofs_try_to_free_all_cached_folios() may
successfully acquire the folio lock, but the subsequent check
for erofs_folio_is_managed() can skip unlocking when the folio
is not managed by EROFS.

This leads to a lock imbalance and leaves the folio permanently
locked, which may cause reclaim stalls or interfere with memory
management.

Fix this by ensuring folio_unlock() is called before continuing.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/erofs/zdata.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index fe8121df9ef2..9d7ff22f1622 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -605,8 +605,10 @@ static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 			if (!folio_trylock(folio))
 				return -EBUSY;
 
-			if (!erofs_folio_is_managed(sbi, folio))
+			if (!erofs_folio_is_managed(sbi, folio)) {
+				folio_unlock(folio);
 				continue;
+			}
 			pcl->compressed_bvecs[i].page = NULL;
 			folio_detach_private(folio);
 			folio_unlock(folio);
-- 
2.43.0


