Return-Path: <linux-erofs+bounces-2803-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OTCAidwuWm8EgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2803-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 16:15:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B12ACCC4
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 16:15:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZwWk32Q8z2yfP;
	Wed, 18 Mar 2026 02:15:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773760546;
	cv=none; b=LAotsGhUANrMD0KHKgJdx9gVYvn8MRNG4sOrhefqVqcbjVJFgGgnlAN4QucwVbnGJItTSq7LwG5wk/rgmNvcoEkMH0ZcAp3IKRB4ZfgMo4ve2u1ksBWrcWLtz/ATzmm4U6BuaKIb6wC27BGaCo2Zy4FKSmGyIGCUap8IrOtCoagRWOKTZZjydAvE5s387eswpDA/vEETGhzvDVyg2ibHsuyx/ZzukI3TiCLeULb6iu7H1vFm+Xa1iPTWJJ4/XV4ZpOD4l/Q0yiKDBWBkVl1l45tKC6LWVB+WpprXktAzxqnmYgXJXMQgvJiOIXtzquPxz3nsg8e7/x0wcRWab55lEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773760546; c=relaxed/relaxed;
	bh=pRNSFmQ8xmM2uVtdfq7TC/3v+Ec/xL65DhTmviUxyeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4XVqGr/7MP6r82ZFNYMA1SOedPeh+KOag3IL2hkWJJWd1yttDqG+hGsXtlUVMBLBWTc5PEmVsY+BPDnolPKP2kL382OZIW0ZVbcDN1ZnWAP8lEb+BCtE/EYYWNyPslqDSy+N4fbVwo592uM9goD2+sPEVe+JwtCccjozFRZtnVCEL2/D5l/5HYP4SootQlNTxatIOw157vrxZCyr3NVo8u1IMa6Sqdo5hcUxNT2YtRkFTn7HPQMfUG98WW/6HskjBZGPjcHRSESNjlwPuW7BcakLH2ixt+560lvFElps8AVrueuAD+U7Ya8m0PEiCiCWQs1V3VUW89v4Oo5NQBYIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RFIxJiu1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RFIxJiu1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZwWj0r2Nz2xVT
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 02:15:44 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2aea8c13d94so11361595ad.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773760542; x=1774365342; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRNSFmQ8xmM2uVtdfq7TC/3v+Ec/xL65DhTmviUxyeU=;
        b=RFIxJiu1fVjixh65H14ITdHSuXwg6JHLOGpYFJJku4id+6vfJhifOp72DZty/BlXpA
         HgtkGka+c8R32S4xiep/7ti13INAtsktksiLj4vXsUWiwF4VIQIaLIq1jhnhrq5bcsEg
         1++hl1DzzdpeGdGQpmdlOJShCw1BmHGOegPTMff/8ubaBtLhhFWo2fqbKOlsRXqX7moC
         T6AZzTkj+VzY2uIAifFoPm5ZgGu0c7yRahdcmjSOmW/FcT1qVEvn4k3xQhiPdUGZ04AB
         n6hezRNzabt1yGQPMBtblT9/F8u5ZrIyxzFlbtFMJ+y5qYKVhifZO2qZNBAPpENBQSTL
         nKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760542; x=1774365342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRNSFmQ8xmM2uVtdfq7TC/3v+Ec/xL65DhTmviUxyeU=;
        b=dlWtERn6ea1si9mfkm0c9VlPCj3knyt6rq7oN1jBfTqHk9ZUTAyLr3ftAx55C2SD0x
         mTMRvNmui61nlB8yeTK66pvmQ+a+nlNVW2hhlISZzP1HX9nl4sMdz5vQBvzv4D3VFhFW
         RRtxLzM5HSH/QEmOEKg3Btu9NKoIC4vMFNyid1SpCQcrP5kOM/0qqX9FW5U3SLtmdXZQ
         T6CXagpoHw5QNTUnDxbtYx7yV6tmY7NFG3+Sp73dbJe/2x1bGTgkK9/TKShtkf66B2KI
         izE9EnjuNZx5KSayD1Q2koNaZun0+OnWcywtM2lgXoFh6igL3IGSXycZWYeCngEZqOii
         wd2g==
X-Gm-Message-State: AOJu0Yz7pSxvLeSBtQiQdscyn1xnXPAVxfOqdEjp+L9PRtVzZIi798fz
	DMfURdUTdQ7StrkmyMDOGSPuNMLny+7xJCKHLucINwdmwPAqxH+rRI0PiVN9drPX
X-Gm-Gg: ATEYQzzJThgj/c1EIGBPHNvnEoYM1xfpIDDPbSsbPmPItnTzDtupjf3qJpnvS6CGfYQ
	UobyDAgb7E56l8XCyZBPTyOd9g//+5UW6rkgXd8bTmy+HqnHZf2MHcHHYH5MiQl1WzyXhzknoHb
	izL77hD9XxEOAnIcLB4ha2TQwJ3iAIu9zoLe1p1iz4fXuSSJqJap/8KRJG1bS8WHQDlVq60J5rJ
	Ol++nU3wURcbeVk+WVWBMeel+sSMomXC7w4wNe+x6xYA5EscnzBmv/t0HR2Vzi429d6Gn5pmSoQ
	LgJtL7VgMw9spv2is4Y2J908pZmLjAgkXX0lOFNG1uFxZDH7HpsZi1c82tJhQjoznkk2Nk2rBew
	4irDWb9Xp2fZjxpkMuWFRfeRol/l27X8h0daqSU4bwjjNY1dEvhhBwQ+OYkaaMARBiWqZC53s+q
	thPd15qvkh4tR0gYh5iRrsQeAREpiM5/9j9rOq5XRRXn1AqmpZXUyY/iYJnTwDAxTLrXIM+1BKL
	PPCxPubDAyXda2LA0HJuIBYVJPaovF+oytO
X-Received: by 2002:a17:903:2449:b0:2b0:52ad:2b6b with SMTP id d9443c01a7336-2b052ad2fafmr59519445ad.2.1773760541686;
        Tue, 17 Mar 2026 08:15:41 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b05f0ab2b7sm74399655ad.39.2026.03.17.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:15:41 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v2] erofs-utils: lib: harden h_shared_count in erofs_init_inode_xattrs()
Date: Tue, 17 Mar 2026 15:15:14 +0000
Message-ID: <20260317151514.3529-1-singhutkal015@gmail.com>
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
	*      [2607:f8b0:4864:20:0:0:0:62c listed in]
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2803-lists,linux-erofs=lfdr.de];
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	NEURAL_HAM(-0.00)[-0.876];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 131B12ACCC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`u8 h_shared_count` indicates the shared xattr count of an inode. It is
read from the on-disk xattr ibody header, which should be corrupted if
the size of the shared xattr array exceeds the space available in
`xattr_isize`.

It does not cause harmful consequence (e.g. crashes), since the image is
already considered corrupted, it indeed results in the silent processing
of garbage metadata.

Let's harden it to report -EFSCORRUPTED earlier.

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


