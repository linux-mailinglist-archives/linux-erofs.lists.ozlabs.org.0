Return-Path: <linux-erofs+bounces-3181-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPAwDYFSzmmjmgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3181-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 13:26:57 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7303884E4
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 13:26:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmfhF5hLpz2yfl;
	Thu, 02 Apr 2026 22:26:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775129213;
	cv=none; b=RqzNJqPWySNmxLaI8jZOkFWMb90ysE7HPL3AZtWmdb30TvXa4CcAP85tZTBVs+txxbow/jBuJaFO1zibTqeyf8Hnd0dM3vnfjKj0zS2xQIWc7395gPWmRBCDMAtNEifPESM2t4D8alim2KfyqZxztkyQ3n7Js6kTz8urEzQROSwu62qB+1j3x2WAKvrkOsU9FSb1D8OAVZ6fFWQBotit2P0iJditY9MRSErw+JlOz5c3t1XICKnVyDuRKcJDX2EWYkzALmyfeg5/v3NpIfCW4OQt/oJTf6CmgvP25OPOglI8R3jAnLua/NKyC9dOQJebklw7/5507ykImB4yXOCx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775129213; c=relaxed/relaxed;
	bh=lz6EReWCALlg0Wbk9CI+y6wxWsPfs1dd3YFTyhoTEyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QprhMvdeZcVn9uNqjv+PBExrU89RVqhfEcw1o3gFcdunCo5B74rDBUOPGLbhTCYunssi5g+4qqYGVUK1iUsogy790WBfXC3Qroo+EqWDctZW5RURZLi2ZYj+yK3PL9NoFFvbYEaHPTtdKSDf8ZvEKPuzDAl1AmdQdvwpdOPVwQ/kOnGAlvjH/XBuosLBOJuJQmDA/goH7gb82fFFU2YrtLCNZx1AZBPHDz3nzKdHY6QSeuCGHq4Ne370GvFWbqfVPwtRgCNaFE8XjfSRyPt7NV/bIDYyGnbIWtpkt9GXJDolQI8Ir5hkJAlbc1snhFSj6LsOyU0f7KOZXLFL7zPvTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ey1FU/FB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ey1FU/FB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=deepakpathik2005@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmfhD67s5z2xLt
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 22:26:52 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c736261ee8dso260541a12.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 04:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775129210; x=1775734010; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz6EReWCALlg0Wbk9CI+y6wxWsPfs1dd3YFTyhoTEyg=;
        b=Ey1FU/FBU7n8Uqt3NlrqzsWT3HLiBDkfDA29pQzphuqNGMk4j7YkN48On8U+cfriSR
         Gq3ftmSIQHs47/wGwfbCUAGKtPymnHf0Bmathwn2skueYLhn8/gp2wsX8xzneP/PgtTq
         62Yb8JcncxmcUOjqx5qMp4JojpDgKcjIlNV+umNpOR4AT5GGHTl3WM8PTnh9ZuzlNOLs
         B0pjyJmSgBw4N1mpOypGGlISUuOzSx94hq1JqYu4HHmRxss9Bx9Xb7qs3DGBoDKuQ+uo
         IYeWgeVssriLW0J/guGo0tLfCWetGmFcDRF7RuBXi4PU8eMyb6oiUG+142m4Vdr/F4SS
         /m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775129210; x=1775734010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lz6EReWCALlg0Wbk9CI+y6wxWsPfs1dd3YFTyhoTEyg=;
        b=CNE2PpPO9+qFgd/lMaqY8Fw/80HvFKp1aKPvc/MO4TD7zGNViYKa0GH0rSYYPStYHx
         DszMeOjKT9aA0K515VVL6j6brwjcnj0yFuFN2xLqEhBZlkdGqjKnCpL5sb8YVt3yQvXy
         jiqlpAeo735dUIOM6Wh2te2AoWQQUFF+y6LJq/IuI+Fn6p6+3OmY7jVBQ5NbxNcSJzId
         BgyMiJf3E+yDO0E/RjytU1OEX0AEUCtzfh36cvkn7w1HZ7K6Sw0bk1TT5CoX7qDqiEz9
         U5K/1ehrdbxz/sB2zK+h1iXYJsQTbxU5mEyV4dez69irhHIG9l4loA8wU/lSyc1aMmE7
         JkKg==
X-Gm-Message-State: AOJu0YyLH3mXxyJ/vy3Q5XqyIThz0iKUgKluljLxxajWNqd40pd8XllM
	+4gIUwYuyDpzqpjdmYB5d8rc4b+p1gMQ0ByfPZ2PuYkedKvUgQsN3VaJMdh+s266
X-Gm-Gg: ATEYQzyIGYLSpe0V5ESDopf+7Htw2B/bi1pvLYV6uedmXpRL+kGIOmOkyVCLqdVbRWI
	TymHUCQDlvf/pnYgjZkrmP/rQiUYwgHgc+3keBxJ1QuwmAlWCuyKecNSdW0lzK8kuXqne3QB5o+
	HsRxYLyN+RXOzIlzzZBjY0v6tKncPX3fvDavrDoxqHru1MmXxZdqXniDclqDo3IRAc+Zs/N7HeC
	nnX0Ux2SRkpbmBC2JG36EXEIeFmVptRJiIiXATl4oPFZgWTy2e/+761qAXFEathQc7SYKj+1Arj
	qu7UpQgxpW61qameydSCefRmXImGMMVBRjFxsrwg9eM0467fdM1WJj0w74ZGJ6t04mDIEn3iU8U
	tgsP3H+nEBXMjLhAqh7diM7sTq7uyZJzWouqnNmOOuAFnXKAFU6/p+q72PX/5D145p36OZiw/rz
	y3fLFWoASSSgcUESCJ/S9BnhT+6NMo5gZ+bIK+n28gES+A1w8QmY5oOIqci7dlVQ==
X-Received: by 2002:a05:6a20:72a3:b0:39c:4c23:a175 with SMTP id adf61e73a8af0-39ef77161eemr7177421637.45.1775129209501;
        Thu, 02 Apr 2026 04:26:49 -0700 (PDT)
Received: from localhost.localdomain ([103.181.15.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491fedsm2995356a12.8.2026.04.02.04.26.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 04:26:49 -0700 (PDT)
From: Deepak Pathik <deepakpathik2005@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	xiang@kernel.org
Subject: [PATCH v3] erofs-utils: lib: fix fd leak in erofs_metamgr_init()
Date: Thu,  2 Apr 2026 16:56:45 +0530
Message-ID: <20260402112645.49711-1-deepakpathik2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401194000.1-deepakpathik2005@gmail.com>
References: <20260401194000.1-deepakpathik2005@gmail.com>
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
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3181-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deepakpathik2005@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4D7303884E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In erofs_metamgr_init(), erofs_tmpfile() returns a file
descriptor stored in m2gr->vf.fd. If the subsequent
erofs_buffer_init() call fails, the function returns -ENOMEM
without closing this file descriptor.

The caller erofs_metadata_init() handles this failure at
err_free, which only frees the m2gr struct. The fd is
therefore leaked with no remaining reference to close it.

The success path correctly cleans up via erofs_metamgr_exit(),
which calls erofs_io_close(&m2gr->vf). Mirror that behaviour
on the error path by closing the fd before returning.

Signed-off-by: Deepak Pathik <deepakpathik2005@gmail.com>
---
 lib/metabox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/metabox.c b/lib/metabox.c
index d5ce9e3..86a7083 100644
--- a/lib/metabox.c
+++ b/lib/metabox.c
@@ -32,8 +32,10 @@ static int erofs_metamgr_init(struct erofs_sb_info *sbi,
 
 	m2gr->vf = (struct erofs_vfile){ .fd = ret };
 	m2gr->bmgr = erofs_buffer_init(sbi, 0, &m2gr->vf);
-	if (!m2gr->bmgr)
+	if (!m2gr->bmgr) {
+		erofs_io_close(&m2gr->vf);
 		return -ENOMEM;
+	}
 	return 0;
 }
 
-- 
2.53.0


