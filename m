Return-Path: <linux-erofs+bounces-2689-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HB/6OZ3UtWm15gAAu9opvQ
	(envelope-from <linux-erofs+bounces-2689-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2026 22:35:25 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0427C28EFCE
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Mar 2026 22:35:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYDsc3FBvz2xQB;
	Sun, 15 Mar 2026 08:25:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773523524;
	cv=none; b=KAy7fL4ZbMRooqgB8XYusfsiaQgH8ij9+0G9dIIu1qK0OpBJ0aRiB4aKio+0N0OdPzlmU1qwzQqCVW6D9s7xMVlNEhzugf0GSa5WFPNb7TyEw/e9Du+ANvNUdE3RY/jsWogghYBUwjCDdprmfp2PehbRvpv+rCP7u6WgYKzTJYvXSupaIVhMM6JWaQTUY9IP0imLMoLYoWA6Y1l8LFHJ4snGJOZvaSDfOLHFB9iVTt4Ae9JYO0XREsSovXHV+wZDoRBeGea0wEa70tlXkWju3mgo4EG5nb+s2O7mWqu2FvQ1FuuXIHK9EwddQJ3QPd8lXT2qmNG7zKydFqPnIpu9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773523524; c=relaxed/relaxed;
	bh=ZD+yPwiFTLWp+XS44N5kwp676uSgGpjBJ8xSo4vo2O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKHUeiNbRE/ZuqNtvPEMpehW+60mFaxhMusaRtovLXpx+TG5JaHkz5xozcsywPlBtpOColtsgJBN3a1wdx9ARioFfVYh3w36TzL2NSCNCm5jUga/seNX++uYGc2Bvm7TMj5PSq0F5QKOEVIsVs1SEm4yvIGUfcNQYm8sLGYNfp5WNa3aS1lhM1Kfj1XWxeFHxi8ah2Mtp6cR0ejnzUgMnMs+punSDWGTRlSI8Ag4L/nkZZX9s16lw51svGJk8BiCZ8eSad0LrZwuqO5iAAy/tz4fPwo5ifqCnn/jDr3UuL9/mr5gMVBAMTgQVGK1a7JfphvkdtpbpGXRIqL9eyEoqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kjxDvBzN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kjxDvBzN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYDsb0K78z2xQ1
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 08:25:21 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35a034ca40cso315599a91.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 14 Mar 2026 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773523519; x=1774128319; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD+yPwiFTLWp+XS44N5kwp676uSgGpjBJ8xSo4vo2O0=;
        b=kjxDvBzNM2hvaCbMmVD6zeTIEA7sEHis8+9EUqkkvFrj97U2pfoETSun5terVpuoyW
         gsBwWQSQ5GT/noUkOz6vNK0igLNFr5WieEU3MpFyVR6WGXqDsmmFmPaMnYy+buJoI4l5
         U21GzGd66GEbwCVtBZAe99HxvD8KQgUP3mC2fxuIbNFeR472ZJLP/LUVDN9vZa19JdjR
         UQdOsZlow0nYCKULrvDxAi3YepSuv6QyACF5Nn1jH70veOSSPDPMadAXKkIy+cRg3w9M
         P6EtM5FbpiK38svGsDMt4OIm+TicSJlADHDsyjrmjMt1EpWy7UGarTUdf/QeKAjd7U0y
         bCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773523519; x=1774128319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD+yPwiFTLWp+XS44N5kwp676uSgGpjBJ8xSo4vo2O0=;
        b=EOm3ItlMmxuViw9bb3M+hNkELIGuOn8vHpCfl3DzHGPFupCL5zxXbANBI8fcLtyb7J
         sMek4PvWmtY704Ipq0bDWuVykziSYHaydWdWTis1GgNewQbHfK+l4cfYvMLtG4Og8giR
         5NtGY3TLM9VdLeezYLB2xjPBIbb76nVAj/VG4BfBrEcEvKHfeq5cliU7NLAT+5Hjqfg/
         ro/g1ND4OAKsSbPJLe7/DFLNdmEczTXjwm1yJ1G0zlSslGl6bUOmMrEe+CGcRvUAPBcQ
         B2R9lDQvr4dC24xZZryuwacHaFL00EfYrQi5Xe8RIL4DekkDM06vw7VoM/VGCLZx6N1Z
         bm4g==
X-Gm-Message-State: AOJu0Yy+aq9fP19hbHBd7mIwuROSyZpmPW6CT44VBWcgZavPNeZp5rLg
	m7JbVxuuZaF9gAsUNShHQCQXevQhNoqxRKWJGEjHiNQvDIskxltOpK8dVjbQrPVL
X-Gm-Gg: ATEYQzxSs7thnM9UL57maUblOM0em7KRrO0Oho7UA+CIVw5q767im+4HQRf2q/e1zvg
	YZQkbwWXnjcnQH9nLPycJx9fYlm2Z5lxylPsVD/TDJSaDLQqM2/EIWNS+vACtqSfmfxHmYn6vxU
	XsM0Ykij8kE7dbgQPtypNCnGcHNrl6rlkyr2ERFo0wxLrJdWmemRcm2nU65Off0bvB6Nrycjv2y
	M8Fl04uWcRL7xxGEvFtyZklh9uleNK4WS50ONIHFP3zDUoDnyIMFE94Mdog0ufvAN/QXlOVcDkv
	8a3nD2SVrF/g0ji87HsooH6eOSMM/SCBEqQ0/KLzbtOfsucl+4LnI0eC1GXqc3I5XXAA/fBOtBH
	8O62wPpi6N1m4X/4ehz8t1C9mj5TXfVjnnEtcJaLNuzPc40GTust6uMOy6xGoIfWNZM4ybn7LRs
	XjlWiI9qDlnVWfs3MJC9UVmlCsnRf2Ibp8eNBoUUWXztcp9RNDZUum6rCVj9Kmjw8HsBRLuSX/l
	bc5aa5/j3bdPjL4KMk15SBoeJ6HOy+eSFk0
X-Received: by 2002:a05:6a00:188b:b0:824:9f50:83c7 with SMTP id d2e1a72fcca58-82a1957b7cfmr5327177b3a.0.1773523519602;
        Sat, 14 Mar 2026 14:25:19 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([14.139.242.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a073b265bsm9769668b3a.65.2026.03.14.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 14:25:19 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	zhaoyifan28@huawei.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix missing NULL checks after strdup() in tarerofs_parse_tar_header()
Date: Sat, 14 Mar 2026 21:25:15 +0000
Message-ID: <20260314212515.15305-1-singhutkal015@gmail.com>
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
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [14.139.242.98 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:102a listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2689-lists,linux-erofs=lfdr.de];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,huawei.com,gmail.com];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_SPAM(0.00)[0.132];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eh.link:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0427C28EFCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

strdup() calls for eh.path and eh.link had no NULL check.
On memory allocation failure, eh.path or eh.link would silently
become NULL and get dereferenced later, causing a crash.

Add NULL checks after each strdup() call and return -ENOMEM via
the existing 'out' cleanup label on failure.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/tar.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 26461f8..0963821 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -719,10 +719,20 @@ int tarerofs_parse_tar(struct erofs_importer *im, struct erofs_tarfile *tar)
 	int ckksum, ret, rem, j;
 
 	root->dev = tar->dev;
-	if (eh.path)
+	if (eh.path) {
 		eh.path = strdup(eh.path);
-	if (eh.link)
+		if (!eh.path) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	if (eh.link) {
 		eh.link = strdup(eh.link);
+		if (!eh.link) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
 	init_list_head(&eh.xattrs);
 
 restart:
-- 
2.43.0


