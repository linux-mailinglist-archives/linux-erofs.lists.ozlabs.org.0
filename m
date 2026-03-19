Return-Path: <linux-erofs+bounces-2842-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL33BWHNu2mXogIAu9opvQ
	(envelope-from <linux-erofs+bounces-2842-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 11:18:09 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6030F2C9597
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 11:18:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc1qC5mBwz2ykV;
	Thu, 19 Mar 2026 21:17:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773915479;
	cv=none; b=lVO8EYpTcZ4xaRg7gSgvrNLGozRDf97Cf8CpY//41xOpuiOtDsOJ+W6ucxpq8jiBqQ/9TIH5bMwLluzTYk1YMjqiAWmOVLXD69Z05+49NsZx78ygEU+2Pvh8dpDLNWzwN4UXeazohDFAPMsun4w5KI8IAiVHdIrzEqGy1FOnJsqtWJDihgtNOaqGgJuBoDtOUgBmXqZg2VtuZ91pbzvkT55wbHnETNO2HZuk4Bytn1TRtdcE2K7+a2zIGcl9CKEa4CjT8fwlGsrLrs27BRbHouF1SIBw9WYhj7gxFCLmExeJqGFQeqDYkRkXonzfblKT35nC++nkabTVG9uGQxJoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773915479; c=relaxed/relaxed;
	bh=vRkQl+f7OeCCxs7H8uFaIYwleU7Owu29PO6jjz9SomE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJOCAzkvtIH9wxxf5cGMwVmWFOFJ5YNzArQ6CH3GZ0haYKrctVdQWreWSzwWVzh+qc6Kx4PI6cd5Q0tSdnJRS7Mf0iB5Yj2alTBBKZw3u/7ke0Cy/SLaFCLco5e72fuRJygacpV6BAXExvoX67MF3tiiMI2/93dWGGxxr8JeUjIN4tvWOTok2NeotZYbvQJ7wxCRKJvebAThCJOLx3cbUVl2BQRFy9JSWsRqdHyIvWVp/2i9xwgPkfAkRk478UJRfBVaMmo1O8V0LKzwkEYaM0a4E0+dnmS55kL9M6jqxWc+Iav5W7eqhL1Fmyed4hOqCqk02+E7aukCU0zJxr5TyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=U+BYTuNp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=U+BYTuNp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc1qB1DpXz2ygT
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 21:17:57 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2aea8c13d94so1767795ad.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773915474; x=1774520274; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRkQl+f7OeCCxs7H8uFaIYwleU7Owu29PO6jjz9SomE=;
        b=U+BYTuNpwWZl3EhDwNxJ1e1+Pd9SUEhRGA3/vegyYDEZwMcOZePgUEGqGLn8YMIrdD
         oV7LjqNuzeUY5S6jPwEozmEeudqIZG1pz7SvVlZ5MtAHsfQkWRNufySOv4oAMFxB0+xl
         UKn6wBOWjBK7quMphhjkfVvSchYHpNoh/tRO5BX0ZsNbthMEw0cPslj/Ia1lAipV/O2t
         Aw1EYJWMPcY2nCdG8Y7+HPBkBxHxKthqsBIUQacy+M2BRmHIWsnErtS9fzuxhVMhrvYP
         B93UMFqPTCwEaggre1X+p5FygEPdK4nc9D7Tq5GtjwW6O72T70GbtcippJq54XyrD9bY
         BlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773915474; x=1774520274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRkQl+f7OeCCxs7H8uFaIYwleU7Owu29PO6jjz9SomE=;
        b=KmhBsXL0cHnLIVa0u3I5zWgRJrxiwtNBg571wF28SnulnUezj/0Dvsz28+iOxSrjaw
         TCW8pi1FyYnU6tcir3EleuQTmL4nmcPF8Xc8FI8yXM95LOT7hGDmijk9VcQ1Cm+rFA9w
         kBMnwuB63zIV2kHMBS01lZVv70IXyfBz61i/+ktix3W60aYPVVAGcHNu7QCvx3OTMlrd
         otrO8kW3WPoULg5gEDcibi89q+QI9h6geMleZRSjpbBTkJrcry1uE06o/rizJKonowBL
         EEIxAt6WZ5TUbNKxvIldTVYoqfHUna5vmI7gu65kUu7qcAlOWFucJW3w7+wzE+GXe+0f
         PyZA==
X-Gm-Message-State: AOJu0YwLIwHCOY7f7vs4asyuWqGQNqCj8UwlkombfLL72lld6URcQcJW
	fSG0d1SCL33P//OsdNS18ZtqScD24GOET6zs/VHu1oEjsaIoycVx+V0nsxOikw==
X-Gm-Gg: ATEYQzxmSNkaeIJvUO93QBWA327PmQ0OP5AHD9NgWvmk4G/WNnPskcSxwm2SekrXmeH
	Yhf+mY00Sx/Zg3HmGIcCMxLFs0xWNumTz4f/Da0CH9yjvVgH/gd6DdrqClTY++N601RhwHcDZVs
	bZM32aPE+6frPna8YkRNrKqAQP+NIEUw/P2Va8fzo4UY3UPIU8jpOpcnfIcgmfxrsd3rrsV2oyE
	9S9oNf1AQWrPxsWawV080ABkgVrNAHAONpT80EzRxSQ0Lsn95e6tUFnmeyZirGsGzqNID0i0KS9
	8pzdx5C06tj41P+j8oI4HIoidZ/RDFZ4lKiPApg62WuDF3oBUj2uhcHu94sgtGLlymQz6XVV//B
	bDfgTwzLsMCwZ9iJPybq59/wf+wf14AWx2MWpDeo+QUvXP9G1Xis8louI5xofwQedjPB7IB/7XS
	WzlokDoBO6JlOUKyoVBPHfeoqiOax7Wn1U+8fPv9QAJpkmr/Q2fCCy817wo+whmn5d4+VJ9hpSz
	GvKsqLUkmqi0/5eWa+a2nxD8HQTD5SueISfg4ayKX02AfYi2A==
X-Received: by 2002:a17:903:19c7:b0:2b0:7136:d980 with SMTP id d9443c01a7336-2b07136dae7mr35915995ad.2.1773915474281;
        Thu, 19 Mar 2026 03:17:54 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([106.196.124.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e0b2015sm5152095a12.6.2026.03.19.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 03:17:53 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: return error on ZSTD decompression length mismatch
Date: Thu, 19 Mar 2026 10:17:21 +0000
Message-ID: <20260319101721.17105-1-singhutkal015@gmail.com>
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
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2842-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 6030F2C9597
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ZSTD_decompress() returns a size different from the expected
decoded size, the current code logs an error and jumps to cleanup
without setting ret to a negative value.

Since ret still holds a positive byte count, the caller interprets
it as success, potentially treating incorrectly decompressed data
as valid output.

Set ret to -EIO before jumping to cleanup, consistent with the
existing ZSTD_isError() handling above.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/decompress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/decompress.c b/lib/decompress.c
index 3e7a173..ef1271c 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -68,6 +68,7 @@ static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
 	if (ret != (int)total) {
 		erofs_err("ZSTD decompress length mismatch %d, expected %d",
 			  ret, total);
+		ret = -EIO;
 		goto out;
 	}
 	if (rq->decodedskip || total != rq->decodedlength)
-- 
2.43.0


