Return-Path: <linux-erofs+bounces-2691-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CraGNvitWlt6QAAu9opvQ
	(envelope-from <linux-erofs+bounces-2691-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2026 23:36:11 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EB628F560
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2026 23:36:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYGR96RBYz3bnL;
	Sun, 15 Mar 2026 09:36:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773527765;
	cv=none; b=AUkcYAYFDDC7UBW7SkG7ofjsDKN1QoK7U6pm816eYtb+qCVaaoNBklKgUuFzTSY99YgoCUDQanzeTf7B/tW66Ak/8eV5SjL0pu3/7a9pRuQPTVgtZpTfj4LjYgd9hPkqSZ/GXaYF/fXhyzrG/PJwsRt4NKZgdseuKpCLD6L6lm1caYy8v6MsrkvLZ8ijVteQBYFIsOCq2Iks1/TW0WHlEgmQqO5CZxeHjP4876+sig7vIbSCWYpWYoRXQ+om7cj96KTvlG9Cq+g6KyI2CrmV2uoSPANvsSBHDlp/E3250t3krXlbkL7ySzBnbfJLCBNccA290lM0WHACsA8kGLbCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773527765; c=relaxed/relaxed;
	bh=fTpO+85/GnZ5rgpOwhJaW7UCAP+4jsoUV8gsBgHdu54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiWnI0SNwps2usPlIsue/hyBgCIAuUNw8hnpAGMA2Bgtkw2M/MhEfW1wXVzIUQYY7LHssN99mlALshQmrEv+oeR4W5Eexq8R+Q8Kg/sKqlqiBe6Iql2tjtmllGx8rVfLHVGmqQ91q50CO36lgMLFUlsAnImOYJU4zVzhQ4ToElaYf4lTpvDzR9oPaLxdTA+Vb9Rw1h6D+pVmg6YP5vimLH9gofJA41Iqt8nesT3TlLsgfyWLK3N0pYHNgWKV0Nf/R238mgXHx2ce+3cN7SDumuu3aPPrvzZoi1OsyH2lHcb/v1ZT1R56OtGtS8J3mlpk9hdL7v91Hdw8Ge6RKYUzmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f1Q71Pak; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f1Q71Pak;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYGR85dxFz3bnD
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 09:36:03 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35b92c8a9dfso77319a91.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 14 Mar 2026 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773527762; x=1774132562; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTpO+85/GnZ5rgpOwhJaW7UCAP+4jsoUV8gsBgHdu54=;
        b=f1Q71PakFdQ8aSG2DhkqxyM8XOFnL2GbYnBlnFyBmIVV53A74Uo0ZesYf5vMglswvw
         WVbjArEzGJWlc4Fn2Fk2rjWeA0/ApLoAXmFJTtZkrgueBZXYuYhArEFp7gvFXt6rsOxa
         /+7AEue2a2TMIl6jHvUWDo+5uF+sYUTH4ieuZxV6pTpiqUalY+HoDaAY15GvoF8PLZHS
         Yjf/tHjNiVAtWTY7wwjkFhgKP8k6150ELJ+3BpbICqhAN9JmlsEECfaT6MdtbyWA9Rt2
         vgMKlXqOMZaNWOzM2MjzdhvpghkGWdMpP0hTjkQh12LURd9WaG476Dz42hrk0jV1LPEk
         z9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773527762; x=1774132562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTpO+85/GnZ5rgpOwhJaW7UCAP+4jsoUV8gsBgHdu54=;
        b=Dr9vw9de+kSOKlNc6ilCvcJeGurlGrcB2aMKBjMJLK27NtTIFEF7uBMd3k1dNfHFn/
         +ObyhWZOayyDAnP3cfZs5lTw3nJrV7dwKO+kYxMhqLclEVhSIu72xTRzu6uJCSuQ2Rs3
         6QMhTP2ThOD4/t2WnKOlVuwIFIdxnXOcH36a1zPMGTs1AEHShMmEhHZ3W5H3WxUVdZ8Y
         sGw8Je5V6L688N9aZNOlyTDibBXkf9tlTXsGiljqMzlcsnIJqA2X32iUrsi0lDJsExAT
         MjSC9cuqP8x01TT5I2tRf5U9QTviGIiZbpvqByDgqgQ4u4+h7zjqhpA0our+xj2k61wC
         EIQw==
X-Gm-Message-State: AOJu0Yy0fuUxHUatUhDRC2koSFP75Q9kBo8pc+8/BkC70vM4rdyKcW8w
	nmSXceFHqfCA6gCrtCPrXhAMkofY7nG3MwLYAXJnnMvBN+K1Z6rF3ZUVNFBosTdU
X-Gm-Gg: ATEYQzzmAsCVxD5W6fdgoe4sDJJuNXYx7blgS6PIayDeIaFrH4T0OD0U2/qPJt6bTnG
	dCmGp/WI0WnBZqxcVs1GKezj9J9xaMbtk/zNd9fP8LPmpOP6L/KvlLjaYYhvtZZJHlvedajFgg4
	qU16ZeZ5q8VI/Azkj35DmoeQRunvFOZ13cUELdujlmeljC2sfAuY2EMUYvYxXvV9sMDtXDywUmP
	4pqcKgVn/5P0iULoxROg1zVyaIXiqp0djopJcZ7FO/xKZO/7GstQ+DJSQXv54lJhU7rlBTEr0Af
	tNH36X2nMz2yxQwqxTeRSvaD3ZX0j0g3Qpyedb7qkLc5joO6MdUUJV81StxSnHfP4626w1pK4KB
	A20szZRgPxumu09uuDMjghE7usZYfeu2eV+7Qz1DN8Vt68OOwuHroL5bG5CzVrSRCkSidlqGjDF
	IyZQLkh05b2nTzY3zES2uVkna1IlA43XSMQoRoWMnDtfOg27YTKsKtQudWFC8LFb0u9w2GvavvX
	KeVCY4OW5newuYFS94f4hTRcX17MhDfBoFd
X-Received: by 2002:a17:902:f70f:b0:2b0:5075:96fb with SMTP id d9443c01a7336-2b050759903mr1467765ad.2.1773527761626;
        Sat, 14 Mar 2026 15:36:01 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([14.139.242.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56ea5bsm81538615ad.5.2026.03.14.15.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 15:36:01 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: add capacity ceiling in deflate partial decompression
Date: Sat, 14 Mar 2026 22:35:58 +0000
Message-ID: <20260314223558.33094-1-singhutkal015@gmail.com>
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
X-Spam-Flag: YES
X-Spam-Status: Yes, score=3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Report: 
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
	*      [2607:f8b0:4864:20:0:0:0:1031 listed in]
	[list.dnswl.org]
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [14.139.242.98 listed in zen.spamhaus.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2691-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	NEURAL_HAM(-0.00)[-0.683];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 06EB628F560
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In z_erofs_inflate_partial(), the dynamic buffer growth loop doubles
decodedcapacity on every LIBDEFLATE_INSUFFICIENT_SPACE return with no
upper bound. A crafted DEFLATE stream can trigger repeated realloc()
calls, leading to unbounded memory consumption and an OOM crash in
fsck.erofs or erofsfuse.

Introduce Z_EROFS_MAX_DECOMP_CAPACITY (64 MiB) and check the capacity
before each doubling. If the limit is reached, log an error and abort
with -EFSCORRUPTED via the existing out_inflate_end cleanup path.

This also prevents a theoretical integer overflow on the left-shift when
decodedcapacity approaches the size_t limit.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/decompress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/decompress.c b/lib/decompress.c
index 3e7a173..f87efd5 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -240,6 +240,7 @@ int z_erofs_load_deflate_config(struct erofs_sb_info *sbi,
 #ifdef HAVE_LIBDEFLATE
 /* if libdeflate is available, use libdeflate instead. */
 #include <libdeflate.h>
+#define Z_EROFS_MAX_DECOMP_CAPACITY	(64U << 20)	/* 64 MiB ceiling */
 
 static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 {
@@ -281,6 +282,11 @@ static int z_erofs_decompress_deflate(struct z_erofs_decompress_req *rq)
 				ret = -EIO;
 				goto out_inflate_end;
 			}
+		if (decodedcapacity >= Z_EROFS_MAX_DECOMP_CAPACITY) {
+			erofs_err("deflate partial decompression capacity limit exceeded");
+			ret = -EFSCORRUPTED;
+			goto out_inflate_end;
+		}
 			decodedcapacity = decodedcapacity << 1;
 			dest = realloc(buff, decodedcapacity);
 			if (!dest) {
-- 
2.43.0


