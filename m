Return-Path: <linux-erofs+bounces-2864-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA3WN7h0vGmZywIAu9opvQ
	(envelope-from <linux-erofs+bounces-2864-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 23:12:08 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516522D2E60
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 23:12:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcKg71mSWz2xm3;
	Fri, 20 Mar 2026 09:12:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773958323;
	cv=none; b=MFJcnslLKjzbFDYIi3J1vjNdOFXqY+3ffa1D9we6DUDDiYiGkSf37Lhdnlcj3yeSy+deqE6fmXJ8WyUQxngK5YlAexM1sZr4yZ5ata/BI8ywTa/Heh477ytzBm8mSNmfZboNzbxUaRWGuE6K+rFXttQlhrDW1Tkbtj6+wFQOdkFt0Q+MRWo9S5w+E6mWLwSQ3bnJXoeAwBfQyvEhNvxRI7j/bdgfLVtsGxmOUNX1nev2EdyVcqCo4GXsFPCpgmNuSyk0R5UeAuQkaJEZP5MWNSptLspC2r7BujH2m8gdKAaUHbiBKtdEVwJrfpNagikor59C14bptyDJ4AZlAqp4lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773958323; c=relaxed/relaxed;
	bh=A5MGKLGstHNoKs/LoydwKD+YghSwmy3lzQ24vpZtsN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HVVCbzIqcsFTHazonjnMEXjxuLJvpupP8VyxXCTrN2xlp8mADYaUje/vqtGsUN7PDaCUiGDgoLV9xzsbEOtwQUXJr/LS2/c4r2eprZRbDBX7SYCi5RlOiIgPxDJjK3mwJdsMSFobKC8M9sEOOCnz3sSK9FPSIjm7ZRDm+IrJpWGVeU3cgeqvNmQinFWASLwJx115J5UeaIw+RKNh9hUiePTYvpJJcAvSAjWEIEOdUFisppyX7Y+AG1KsbObpvkG1Il5Voqunzm5ZqBt2f0QRTmtvhuFcNRwl0dRu48hy0xiSZhmjqRU7+C8y6HOi9nsDCjGcECrSsYfZ5KtHSBWo3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VBeu4rfJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=smsharma3121@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VBeu4rfJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=smsharma3121@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcKg541BGz2xly
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 09:12:00 +1100 (AEDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c632ca0c317so40676a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773958318; x=1774563118; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A5MGKLGstHNoKs/LoydwKD+YghSwmy3lzQ24vpZtsN4=;
        b=VBeu4rfJRWzFel1T26mJNAGio1b5MJtv4YZoKN2p+ejtt13QnHK2GTSw1N1IDbjYpo
         dvq5+ll5hVapWn2KtFsyUmmAFSMM4Kvc2+IuxsRN+XAHJWe1SmYD28IIutRopg99Awy0
         bGkVIVCs9Rjck2gaEDlgsx3cE3vO40r34dHvS8q+XjJWs8EGlBum/hE7QRPcBjwZbtFn
         Ln7o3XZnLtGf1ahCOgvUKePY12JfvEUuDvJXlrhu4uT1nKa/cQcg2g+HEKdV7RiYetHm
         KEuDBp13QzNwZPOE8NJPmzOGNooUiE4k910Q6mqYVW48ZnWCwlFFY0ehrWdkVPe+sYzy
         s4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773958318; x=1774563118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5MGKLGstHNoKs/LoydwKD+YghSwmy3lzQ24vpZtsN4=;
        b=Me1szRNaiUih62+HUQmofygr3KxlFSMsuGDSeUwohAV2yFBIWu9pfvDW9XPbuLtSKQ
         tEgNQaaxXIf2P2zDdJ1O9TkRTlVoa3LhLSZiBh98bJx2v15oV8B+jm09B9Yf1N8P377h
         a03xBc4gnQa42zAMHFBkx0xnu8fZjxaLqR4YmOdi3u3kyUG6S0qk+KT+LP2r+cjvpLt6
         mXYR2nd8A9Vi42YFhgtJpn1Jlbo+GzFFwGKxoHmg+hx8k2mvBHqtX6jHGCVLvjQHtw6/
         p0l2W+j9qQFzRHottkHajlVf5iZ6XBF9IkB+sD5GHSXDf+qQBvODSoyotpFCPW7bKBRT
         rkgA==
X-Gm-Message-State: AOJu0YwruXM+CzjHC4CuwG3/2n8CIu5KfN+GEExE9HAmtxmrzy6JQOtk
	8F/+ZGIpdBmVHxYiQkp7QXVqExegSS1szd9x6MFU3XHKY+gIz3c4bjaT/hWxdevI
X-Gm-Gg: ATEYQzwki5j5ldRK+7JmS6cqIwbsyqNmIxzhrr159t6DL40g0jVTNkS5JjQ3HZDLV0M
	1ud+7f4QHWKPMuN/pk5RrxiLmFtplHANGt6vUlw6zBkAo2BA7NixBbK+UA15QJUGq1fYTqi/Btj
	8SaZ/jdfiR729KPeKVwXOzGEntga81TariuVPGN0g66C3PqlgLcUx659zc8oK3loN98K13eY1EU
	LkZe7iNEBDhbv4jNaVBJsOo4ib9Gq/682xXBtRZa7xAj7VqCpdyjxhZ7OkSoUSG6OrZBgA+VgCm
	VwUd6znYDg1l0mYtasD59/YczfBoGZ86FmBZA9vldDqPYJ07KiIbV8mx1FW5c3QSxQvxCdvfDJu
	97MAcmcIKXYRwCuYCP2i8lSmvdmOsgxZBKfku/0mjgxiPvANLLHc8Euh/M0Hl5TPpkMNN90+pzd
	6hvAx5D1CUJPldlz48gxGj9b6Dqsvmb/0CJPs/ZjkmNw12ZATRYaxfByaAaTHVpRQD/g==
X-Received: by 2002:a05:6a20:cd90:b0:398:f074:ad07 with SMTP id adf61e73a8af0-39bced4e82amr549840637.7.1773958317587;
        Thu, 19 Mar 2026 15:11:57 -0700 (PDT)
Received: from localhost.localdomain ([103.115.155.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a818114sm303757a12.12.2026.03.19.15.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:11:57 -0700 (PDT)
From: Vi-shub <smsharma3121@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	yifan@pku.edu.cn,
	Vi-shub <smsharma3121@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix QPL job leak on early error paths in z_erofs_decompress_qpl() After z_erofs_qpl_get_job() succeeds, two early-return error paths bypass z_erofs_qpl_put_job(), leaking the QPL job handle:  - Line 200: return -EFSCORRUPTED (when inputmargin >= inputsize)  - Line 205: return -ENOMEM (when malloc fails for decodedskip buffer) Fix by replacing the bare returns with goto out_inflate_end, which already handles both z_erofs_qpl_put_job() and free(buff).
Date: Fri, 20 Mar 2026 03:41:36 +0530
Message-Id: <20260319221136.2126-1-smsharma3121@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
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
X-Spamd-Result: default: False [2.30 / 15.00];
	LONG_SUBJ(3.00)[479];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,pku.edu.cn,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2864-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[smsharma3121@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.961];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 516522D2E60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Vi-shub <smsharma3121@gmail.com>
---
 lib/decompress.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index e7ec83e..eb696d3 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -196,13 +196,17 @@ static int z_erofs_decompress_qpl(struct z_erofs_decompress_req *rq)
 		return PTR_ERR(job);
 
 	inputmargin = z_erofs_fixup_insize(src, rq->inputsize);
-	if (inputmargin >= rq->inputsize)
-		return -EFSCORRUPTED;
+	if (inputmargin >= rq->inputsize) {
+		ret = -EFSCORRUPTED;
+		goto out_inflate_end;
+	}
 
 	if (rq->decodedskip) {
 		buff = malloc(rq->decodedlength);
-		if (!buff)
-			return -ENOMEM;
+		if (!buff) {
+			ret = -ENOMEM;
+			goto out_inflate_end;
+		}
 		dest = buff;
 	}
 
-- 
2.39.1.windows.1


