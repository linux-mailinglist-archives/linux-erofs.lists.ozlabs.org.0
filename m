Return-Path: <linux-erofs+bounces-2901-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3M8RFolFvmmvLQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2901-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 08:15:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D62E3EED
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 08:15:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd9gT2PTmz2yYq;
	Sat, 21 Mar 2026 18:15:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774077317;
	cv=none; b=DfFf7dXCYYNg9ZDqXEoQugpZqgZuutf2nzg3sanA8hmj41Tyw6PYUJJk0LSlvzjGaY9A96yHK3vzB0gSsn2cqpdLN1Xp3kudNFeb4XNxAiEtTD7PfIXbTDnPC2t4w1WcaZZypnCnGqRv9j92i+UuR1qaLc9+SAZ0GR+g4a8zY/3iJCg5VgAyKp4do8EvJAQJYdNLxQ7Lursf9AO9eP/tanhom5OuWGKkxPufj+axnL7tAX1vm66wTyrB3gYHbxHvPWe/KImFtLdGb4e4fTMxk6q0eENHHvsdv83LCucnmEjtsKuCvRznEfSjZY26NvqWlwwTU6y/4Y4m2dCOlYRIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774077317; c=relaxed/relaxed;
	bh=GhG13AC4zG/L57+MMvzKS/NAj9qzbT5mH99ZUq+b/Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDaeaIH4DhZHtzuNAo6/YtuLsdGFwdP1uJXNoOEIpN1QxhQQqYccewxaEV2IHL5LAECJPuHfcwSGex5Wv/xeXF7tGiAhkFXgrq5BPBktTb1ukJN7RWP1qRGwqxVMXIyIuMVfmk/flsFGJiC4ofcQUZ4yI+Qha2ULOViSA+1W73skwkU4BB4680hSf/9wZe2a+hGVpYyIAsnQIBF+iArwdd9zLz1nwwo01YFnPb1j5xLnU35OIlCKMt/ycnRsgFN4o4FM3dK3Gh+xz1uisG42OGVw5DHyuxOD4fAp4tCSk3/TrwMhX6nlph2NI9yx5t1pXQlI11ROAffE3lArGNSW3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WL8keJaD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WL8keJaD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd9gS1KpGz2yWy
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 18:15:15 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b07069e2efso14625335ad.3
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 00:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774077313; x=1774682113; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GhG13AC4zG/L57+MMvzKS/NAj9qzbT5mH99ZUq+b/Sw=;
        b=WL8keJaDWU8accMQtIaFknrw0wZJzT/LIvOW0ACX6TCXPU4NmxWOk0wei7Xn3U1+Tt
         sKuhnqIcZKBv6jcfKeUA8ftOxd6oIhttscwwqhiukjoTyfIUO5CFzbn5McULCqrVOSrE
         qCdvet4W5AOeeXEZf86vA+NtTxfZx3kDRk0mxceIPKc/XgNyN2jZwgnmxSJZTR7KEWCA
         UhlDg1GfIAdMrAy/kdGk0HpbofA9CwODNKGh1UNm8Ac1OurzogNqtZAlDUn2zfzS7mjZ
         gPsX1aLfmjLEZJoE2/yPsuH6V0n2J77za/0MhVd+kdAUov3NA9pA4jcJhwC3fijUgnYN
         0t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774077313; x=1774682113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhG13AC4zG/L57+MMvzKS/NAj9qzbT5mH99ZUq+b/Sw=;
        b=Ub7A7wx/tItZF7JsGn9QOq3alBhVI7aXM7lab+ESHHwQO1PlFAM5MV6fCbvI7R+hoX
         udMx6qvviqV2hp9TE7o7VENpEj7szMoruN0uVRaZVnbEF0k3mg1fOjhXNUvbgYCNhbvM
         dEn9riu2eVZiZeEpAboK9ICPBlT3c5+sjOc0Q+tJsvjn5Z73C5nHEyD+CsKn2+1W7ROM
         vBfL8YsWsPTX6uWSf0e8CMq1cUlP1ylFzU44bHKejJzE7zomzi6NtUkqC0niuO9AXenS
         jZn/r3KnMbNex5oKWoyHGCAY/gU3MlOslOG0d2Wp3YWpnjNqpDT3UrSXSQDA43OwE8o0
         wZHA==
X-Gm-Message-State: AOJu0Yy/tBKAcdK5O6cmJ3H4kxu+eJxWc8LsEZqvlyYd6xLOAiemuwtw
	ByucD0PVCK2UNiSvEBNKD2N+o6/QdGtyD/TdLhzM55+oL8+maFJyDWxNxxQqjA==
X-Gm-Gg: ATEYQzzaqc4/M5we8AqymVw1/lR2CqbL0axe6JxL9rAot7YCDYGRrVca9DpK0vYgKjY
	4L6qviA+nFa2FIvChC6o/HiKlj9g+X5ZV1KL71pCGJG80VnZif69lzkb0QeWWhjzhcGBMEAsIqr
	W/VaMGkKSNynAVtp1rjCh0OSe3PZKjaQ6oWdv1Pz5OXBf11IxaHXQrQojqO6j9yrwvbZtYKdvGE
	CuKTrbvKq2oLUp5IZBNq8KAZhrsyCQZUO7rr3BAukADCFbjaoKcfyFTB8nVe8PFfWNC9a78EWU0
	KQHof1zh2itjduZNH3qRRPO/AmsavgzYkXpfucmfkRLixiCYjUtw5AEfwA3hgDENn1/BF9tQCvL
	E84HyQWozbhv5FCW6+w9SvRnVAKgK/XtMC8QJHICR6adqemGJxYJDXMZ8qXLHOtZhkJZizhiE04
	orX4397oRMuc1zIOVsKP/Ws/iLpBKYdUtCsVCNsG4=
X-Received: by 2002:a17:903:41cf:b0:2b0:5cee:c405 with SMTP id d9443c01a7336-2b0827ffd1cmr54270665ad.52.1774077312621;
        Sat, 21 Mar 2026 00:15:12 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4081:8886:a7dc:65bd:726e:c12b:67e7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354bce3sm53452445ad.32.2026.03.21.00.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 00:15:11 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH v3] erofs-utils: fuse: add missing return on getattr error
Date: Sat, 21 Mar 2026 12:44:55 +0530
Message-ID: <20260321071455.1329-1-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2901-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D79D62E3EED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

erofsfuse_getattr() calls fuse_reply_err() when
erofs_read_inode_from_disk() fails, but does not return
afterwards. This causes the function to fall through to
erofsfuse_fill_stat() with uninitialized inode data and then
call fuse_reply_attr(), sending a second reply to the same
FUSE request.

Sending two replies to a single FUSE request is undefined
behavior in libfuse and typically triggers an assertion
failure or crash. The uninitialized inode data may also
expose garbage values to userspace.

Fix by adding the missing return after fuse_reply_err().

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 fuse/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fuse/main.c b/fuse/main.c
index 82aca8c..b634782 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -265,8 +265,10 @@ static void erofsfuse_getattr(fuse_req_t req, fuse_ino_t ino,
 	struct erofs_inode vi = { .sbi = &g_sbi, .nid = erofsfuse_to_nid(ino) };
 
 	ret = erofs_read_inode_from_disk(&vi);
-	if (ret < 0)
+	if (ret < 0) {
 		fuse_reply_err(req, -ret);
+		return;
+	}
 
 	erofsfuse_fill_stat(&vi, &stbuf);
 	stbuf.st_ino = ino;
-- 
2.51.0.windows.1


