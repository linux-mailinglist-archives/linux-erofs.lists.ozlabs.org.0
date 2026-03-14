Return-Path: <linux-erofs+bounces-2693-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aUJSFQbrtWkV7AAAu9opvQ
	(envelope-from <linux-erofs+bounces-2693-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 00:11:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBA628F746
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 00:11:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYHCP5SPFz3bnL;
	Sun, 15 Mar 2026 10:10:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773529857;
	cv=none; b=D0E7VXly7OuClvnXGOCRsAUaVuEikXJr5ZUlocCvYX4WteaH4qyTqqWsVkwquhkxp/KqH6oVzSDVf4LTCQcFkDfR7i4RnG3feHkIdmprfvAB81rHXN13njcI04B3YRk/woCGvU6OlTJqW0o1txWMoicvO8rvWOvryxU9ka19vlWMfUIEusFGcjnY4beRyo0fRGCbKI/tMbsk1fWNzqXSWtTGiGDwRrTp48kEZuF6rDQASXNkBLXJO+ImsAHAIyhcWRp6LriVNDbI0g6TFxBZM2ZJ3PzAXjHAlRfg/rXhYMC9Np8F/j6YvUUecB/KFN4D9WB7UZHwXNYDSIPSvkoiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773529857; c=relaxed/relaxed;
	bh=ZD+yPwiFTLWp+XS44N5kwp676uSgGpjBJ8xSo4vo2O0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FeNbmf9EFi4jSzFR6EbxfKyZSjAajiAmeIOULv50JqSPNznSpXsmm4rBy4MgpAYYPCpTSBw0cuO+lL/6fDJOQa+wPEqktDTFaGrHeilybT+SElhCmWo3JNOcKZ5wrQBO95buEWJjU42/MLlYvi38MQEwjVz1+XC7ZEIO0WXWA+q8ByoNIgCZ36txFRUqH3bMapaE4Aan5PoKnJQJLU4m+orRBijt7XQe7PB6kz3+iDLeTjr7yAL6QdDIQLh5eUWl7bzbcIL66M0eqmyDRO3ec2M4ezuAbar/ek9Y5n35lSpJPlsTI8vbjvIxOJSoI7yhuIVb26e8BHDGj/0dYA2UUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Zx2sUoLc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Zx2sUoLc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYHCN4bXsz3bnD
	for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 10:10:55 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2aed1955ba8so3925725ad.0
        for <linux-erofs@lists.ozlabs.org>; Sat, 14 Mar 2026 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773529853; x=1774134653; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD+yPwiFTLWp+XS44N5kwp676uSgGpjBJ8xSo4vo2O0=;
        b=Zx2sUoLcHQ//s36599+QtAPskvoBTSd9/Dlk+TfRrAN0drKDMHzYffDtnMaOaQoeUf
         94TlUd8MEAS+EFTyX8g2EfJP7ohtBBQMtFL7ljlKlDkS3FxrZsCpPtECd/dMhzP7Fvk3
         agW8IOBkhQZ1/tibEUa7XeiMeR8ryan1XjF2I4q8GKVOnumL07NuHTbj/x51zYkWeWad
         MwAv3J+lWeIdewVDWC9pkZGID1UKIfiQn+NofLXBCcBFwWYr9zg+MCGhtHz6K+/6k8fm
         K+OtXiHrp2JR0Zca5p64oDVG9FUjR/sEVrmWnubh7dTsh8VZ1JdXDSTEXZ2cDqWjFg33
         ADoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773529853; x=1774134653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZD+yPwiFTLWp+XS44N5kwp676uSgGpjBJ8xSo4vo2O0=;
        b=ryWVzhpDG2zIBMq6Fu/MUC+W09Ezu4GI8oFKo9jT9Tk93WCrCm9NCYLVwZd1wMs32b
         c6uy4zeHOWRkdrVSrZbasTpL2oT0ohMBLMk1CFtbKmWlAlQ4xAus/DDwFRCL8Na6MAp0
         9cYKZ0lcb05bvWamGDjwmkJcNnO4PSXXv21qGaaGQ729BeonjikxMxv9ZlMvjguqsTSY
         zkKAUnP3jUNE46arGJbz/hqZKxh96RaFxbf+rdqLacC32Frgs5+V8FN/do8dhZN0AQr7
         3xLVmZ7XU54U0yK06dMApNpWX+WpwlejJU0n7C/1YolExx7AT2qjY4EnSxsIwd0qZPVe
         UoMA==
X-Gm-Message-State: AOJu0Ywb8XxVHe/Jw/mXn8sZOctxuho3FsH0TFPKyInK2LvvfFp2sjHc
	WCLu3K5JkfLaIGWc0rjm+kHzGDI95ljonAskKOmQD0rZub8cdWOuSAqf3lmKanvK
X-Gm-Gg: ATEYQzx9HsWgBWGnY2HAq43IFZoTrWEka/FNAcbMPz1bi00nX1yYr4/Fhpl+A6bOR8R
	+RwGh6+J7kDLnZ65YpXsNBf9ejxbVvtAeVvr5TmJRLuP4I+3LOmuJrVAKOxumDiHAAUpdevBeP5
	4FraqvufM9MdSPJ+Ax5FKaMvoHJtShqi/UzjxDEevTmbCpI8qJyfkUMvOU5ZifFIG+x7EO1goQj
	sMnAeqiACOeJeiYXb7/SLNxLLA1Czydj+2TYmAjO9dXMhczxWIjwoEG/6SA45bM2mEJSF4CY/4F
	JGTjAZHOByWNOgQUt3sOUbPY4r60WuBKRIaKQsxRZE9ranrNLWcgDc93PWaj22/nUHHU1/ffYte
	+Lx12PIGn8IEB1OdfWlMkIfwJI3r4z/08uLbwH+GEtPYsFxJFanwpprNKy4+Nijj+PWp9o4QMSq
	avbcDT8817ipVXbqs9ZvSK8bK7lr9PH8+U8e6CrFZS2EWhChD1Grhkr1uUPZiFzM2chnumueM26
	5CUc6cpS9Oyl+78eL4lECmSSIrjNTILW+1o
X-Received: by 2002:a17:90b:3dc5:b0:359:789e:a9c2 with SMTP id 98e67ed59e1d1-35a21c8c098mr5041896a91.0.1773529853484;
        Sat, 14 Mar 2026 16:10:53 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c740000056esm235105a12.24.2026.03.14.16.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 16:10:52 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix missing NULL checks after strdup() in tarerofs_parse_tar_header()
Date: Sat, 14 Mar 2026 23:10:44 +0000
Message-ID: <20260314231044.42243-1-singhutkal015@gmail.com>
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
	*      [112.196.126.3 listed in zen.spamhaus.org]
	* -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at https://www.dnswl.org/, no
	*      trust
	*      [2607:f8b0:4864:20:0:0:0:634 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [4.30 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2693-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	NEURAL_HAM(-0.00)[-0.060];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,eh.link:url]
X-Rspamd-Queue-Id: CDBA628F746
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


