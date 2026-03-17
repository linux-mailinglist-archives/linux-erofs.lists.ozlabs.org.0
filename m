Return-Path: <linux-erofs+bounces-2794-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAt3NJE7uWmvwAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2794-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 12:31:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C952A8D09
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 12:31:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZqXt2S5Dz2yjm;
	Tue, 17 Mar 2026 22:31:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773747086;
	cv=none; b=MFdIwV7nbufpfV2ZCnlvHH+6un4hyNxGd45RDuZOIdAVU8pVEI7NdspMrdnUIebiEk8Xb4Pvheba2JqpjzSusO5XyRLlVaR1Fiz8vmXQybeW23L4UNWI7Ftp+rj85owbDLudllNzcz4DUvlaL6ImlkqUCAlckCAlHlNQRLj5V/HsDFNEccKhV80qvKHR8uA26Ct2Xc6HuzIRWWK2X/AoSPUWwVFwJFDkShsuxJZjz40M8S0Rge9UeYhw43vwfOPQyjaZX1IOoMPCT+C5xFwJMkmMPVnEftXA/EB8FvqX368Ix2LcMIcjggpCBrtzZAFsKBfsveaG+F6A4/1a0irXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773747086; c=relaxed/relaxed;
	bh=xSy6sa0+9PbGciNrN1V6nLAo6fr6mLFfOa8lnmjZkWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAwqrkRlImgY9A677UM/fMegl49eHK/HRcZxOjtJDmmTcRP9lhxcZYI1NjTQgRsF/+uFFCtku+qFKLGC6rxERiYAaz3l/uyClJkTeT141Xjw6Un8XrxtQmGLjHsrykClEwMVzwoBvJFYYRQJldSxcZwjZUK3AUngMk9k3VN1gmHgkpto8QG+yflLh61ArRZKS1c64bamiO6WAa+72NG7W3sQcF9Bb4MHzTwQt1MuVNtY98ledUHbBP+yW3Wo/az9hz60p3z5zfkYItJABhFU2sXLRIfQX4IoK8pbTgk2KmNa4DwZ9uq10sibHEjy3VSldCVuRdKNmAxW2+oqMu5zQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ww1v8Aor; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ww1v8Aor;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZqXs3BYCz2yjN
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 22:31:25 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3597822d6d8so352439a91.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 04:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747083; x=1774351883; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSy6sa0+9PbGciNrN1V6nLAo6fr6mLFfOa8lnmjZkWI=;
        b=Ww1v8AorcOgIHbygb7uKFdaBFVGJ8kWUP7Gkx5wUWbkIoy33RTKiB1KsJdrnBtp+aV
         Z6D4AVX9mjndkoiWz03QuDtr1m0SgHm579x99l9G8hO6b0elrEE1bDMXvyaZ6iRMnFIf
         6U+aLJjrinvwVAeKwUy0sSixAtttJryxyOjk2IOPgwXDi5usN7JLRS99m9s5jGrtNHnw
         uFK2GChJDVXu+oUMlyYQQJdFZXgeVmbhS90RkDgsIBLcejHap5sfd+na8y4wlpizUYoM
         TXutNKqWKJcMkFmc8REkOpAgOK5Jgv3jTv2VGtWyIcg5Tb7F1Cfg6OAc2UfFx6T0bnqy
         DOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747083; x=1774351883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xSy6sa0+9PbGciNrN1V6nLAo6fr6mLFfOa8lnmjZkWI=;
        b=a7+8qxoG//f4vpD7GZj1sq2Ikl4iYk9hv/kiCXfdFtsjm4hXQv0KSHJM8+paqZJ/Oe
         DbEgktcOlTL7xX7qaHxakcJ7fusJcofizzYE+NMVI0LVx6XjjeRwnBemnREyef+SgY6I
         CSEvLFin092IhyEjxDFJ2SNK1+lh02TlJ07BZppfWNxdGNB9W688cQ6I+FeWIFg5k+Ei
         TpBfzqzit78E2/MBfCqVidy8f5GJaDxOlqzJy+VGuQE7DrQ2Cp1T2LuUVbb6G0oPtH8u
         Dg0xdxLWLfNf5SUBqlGUErIMOjFSCkOvzA42EhDEIvHkRXie/Uqu7jjoh5Y9fVLnpiTa
         SDXw==
X-Gm-Message-State: AOJu0Yx1ZItiwI8/QySrCO8zDx9Q9VurrCG3IHMA4T599FTEpU6YY7Rf
	wjylrtHXVgDxS5x/072vlYpXzfFOGcO4xXaCvFvWUgcsRAlE3LKQR1PylTu/rl1J
X-Gm-Gg: ATEYQzwa1MowwVXhCjUa52sw7tSszFzKMSWIDxny/z2A+ykI3UkBdCB8Aic4B2zPS8s
	HM8o093vS4XJ+Pc9Ac1+Z4F3yFpsBZ2j9Ofuxu7IWI3IipN71fYR/9BkQs5I7LOuaTfhOAc9D/v
	1drAnWG0t5TSTqJ+rCekzb5p39Qf2NxFCODw4gxIHH623HcbjtioOC3SNx7zKuPMEJS8nDC4gMu
	AA+aTsHu0GFDBZKjMkolJL+bFCfxY5o1td5USpjgkI1uiB1fkjAbX/mwoWFwPEgSiV/FIwVy0+l
	aBYPlxZW0V0G7enrb7cvslFwlclnr5WkeIqoqYL+KSv+hk7nHy6VUXdyAr8JBcqYOR5TBRA96cA
	h/K0NBAFaW2XQs+heGgLNGE1yUS88dtRTDfMdoSYVEF1q/Mfo65vzEsL4dgN2PoyOPv4xOZIGNs
	vyGbshZRRDKTT+dDai58HkHDvPXJlJlEm9Gll3O/PwKdshsPMbSFwPRtmEjwsHAJ5y3iT+szI7d
	9O/XDtE9A9MhiCp9DegeB5+P0/vM7gYCHYYGGOhXEb1RFY7
X-Received: by 2002:a17:903:f83:b0:297:f3a7:9305 with SMTP id d9443c01a7336-2aecaafcd01mr104979815ad.6.1773747082903;
        Tue, 17 Mar 2026 04:31:22 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([117.203.246.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b048527a19sm97753385ad.7.2026.03.17.04.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:31:22 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@gmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v3] erofs-utils: lib: validate h_shared_count in erofs_init_inode_xattrs()
Date: Tue, 17 Mar 2026 11:30:21 +0000
Message-ID: <20260317113021.88187-1-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <PASTE-MESSAGE-ID-HERE>
References: <PASTE-MESSAGE-ID-HERE>
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
	*      [2607:f8b0:4864:20:0:0:0:1033 listed in]
	[list.dnswl.org]
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [5.80 / 15.00];
	SPAM_FLAG(5.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2794-lists,linux-erofs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.471];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: E0C952A8D09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

h_shared_count is read from the on-disk xattr ibody header and used
to size a heap allocation and drive a loop reading shared xattr IDs.
If the value is corrupted to exceed the space available in xattr_isize,
the loop reads past the ibody region and the malloc is oversized.

This does not affect system stability but results in silently
processing garbage data from corrupted images across all library
consumers (dump.erofs, erofsfuse, rebuild).

Validate h_shared_count against the available ibody space.
Return -EFSCORRUPTED on failure.

Reproducer:
  mkdir testdir && echo hello > testdir/a.txt
  setfattr -n user.test -v val testdir/a.txt
  mkfs.erofs test.img testdir
  # corrupt h_shared_count (offset = nid*32 + inode_size + 4) to 0xFF
  # then: fsck.erofs --extract=/tmp/out --xattrs test_corrupted.img
  # Without patch: silently processes invalid shared xattr IDs
  # With patch: returns -EFSCORRUPTED

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/xattr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/xattr.c b/lib/xattr.c
index 565070a..9d52a18 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1182,6 +1182,13 @@ static int erofs_init_inode_xattrs(struct erofs_inode *vi)
 
 	ih = it.kaddr;
 	vi->xattr_shared_count = ih->h_shared_count;
+	if (vi->xattr_shared_count * sizeof(__le32) >
+	    vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) {
+		erofs_err("invalid h_shared_count %u in nid %llu",
+			  vi->xattr_shared_count, vi->nid | 0ULL);
+		erofs_put_metabuf(&it.buf);
+		return -EFSCORRUPTED;
+	}
 	vi->xattr_shared_xattrs = malloc(vi->xattr_shared_count * sizeof(uint));
 	if (!vi->xattr_shared_xattrs) {
 		erofs_put_metabuf(&it.buf);
-- 
2.43.0


