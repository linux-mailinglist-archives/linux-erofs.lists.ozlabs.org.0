Return-Path: <linux-erofs+bounces-2798-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLqANutKuWnG/QEAu9opvQ
	(envelope-from <linux-erofs+bounces-2798-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 13:36:59 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3302A9FAE
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 13:36:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZs0R6tx3z2yh4;
	Tue, 17 Mar 2026 23:36:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773751015;
	cv=none; b=iDHTEi79zLskK4fnqrvsLTH7YKYmiL3sKVvTHXnnDJ+qRuwelGnmngeaQcyG/o2l+9Mrs7FWZV1JnGm0QNwxW6CDFKwoSXopMeu2li3CGFd7WfE4yycx4CbjqqNduvFK2SPe20a3liyZyI7gsZNPVoplyZwyfuHEmdeKzuDwgwLsEp1nHXY09Rx9aIwRnrWU5+HNYeABJtM+/eezSCC0THDeOMkVfUxJsIFqcrVpBl8Ag57/eMqwfxxf3nHQ1jRCYa8yy7dQKGxusuURW6FMWv8YKvkYs2PBVzp1ptmwjGxBg4935snbr8FhiuDiha4hoVBm7OaaNVFliZ2YG0+/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773751015; c=relaxed/relaxed;
	bh=pRNSFmQ8xmM2uVtdfq7TC/3v+Ec/xL65DhTmviUxyeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAoV02FrV5phqMZdeBr8NQyNHWE43ITFBTs64AM84PDT/j3/gQG0GoK4O4xVAWoGEaEQ/Ud+Io1zlk5Gu7N6y185b7lgb0CXSV7DMJI2nGHeL6b/9DL8FwwGsUPK7Fya/IuoSNaZPFCSWU0klwPtMmxwItUkZ529O0Kxav5SrHGJlcjuS2pRe7XbI1ZkZKydRT3h8MSWkv3EVCOPvR3AHdI6hvsWxgzH1VXvjPUbw4SqmkTC6Bwz73PLW9cHbtQJAadoMPO5w+Aar6sxMHkx3rKA1MRSK5O0uhvvlTj79clQd32XUdZpFh0hhY233wn5ynC+1zp2iaiUkYTObuAXtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WbYmg5JJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WbYmg5JJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZs0P6gzTz2yfP
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 23:36:53 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-358ee55eafcso327738a91.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773751010; x=1774355810; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRNSFmQ8xmM2uVtdfq7TC/3v+Ec/xL65DhTmviUxyeU=;
        b=WbYmg5JJGTg+GdqzN5Q28/i3/6w56r7Cxsoldm4UUpouApi2xh2ucxEorCdN40PHMI
         PBEUeRjBOlUdo+8JQBnh5GTs+tJGECq+sgMJT+8ofV/nsYdS6vAYfjDHYSoqcTwTdFPo
         P666u4CJJWs4PnayJXx0xw6q27eLyjI5d4suBtNXCDbGMdbSMA+9kUAD5c8QntDN2MVB
         HmeUk6dVEBZ9MS6aDg9EaqSvfxnLZbU67fUajmcALxkrhp0S1H8TxJPX8Ve4DpAJm7Wy
         kc4uHSsXcsCBkTq8mCD6LZuYPDyvk2rbkpRbfHdXWCu5bEr428UXjQAG7/TbkoIFxpRH
         lzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773751010; x=1774355810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRNSFmQ8xmM2uVtdfq7TC/3v+Ec/xL65DhTmviUxyeU=;
        b=oNvo3zTxtjifLsNQdcDchY+wstilKeH3DN/0iTPfoVFn6Zrh70Ntsn3SLTnuKN4ZOz
         Vh6GxZ70EMQn6q7nMB0/eBLWFDcFuUJgoQRpu87YAQauCDnJUpRU7v+Nk7NSXVLqPl1i
         htZ7RxjhtbRt4QHCEhkVsTLa3HWEm281DfXdVHAfMxffxgIW88nUfl0YE8R7fWyKw4By
         qWhxSSe5C+Y4/hjqJaXkUyEW+Uyz2AJehu+elav7ZYaAaqElR1NE2gnJLiKgL7Jl3s4h
         GlYhNWyqwy8j6r3j34q0Hp751d4KUa6dHAnHnKC2NUshZsWCoUMBOnbAQvLsOi26E0xE
         UB6A==
X-Gm-Message-State: AOJu0YytAr39multjPnQlFe1vN3wP0GSLrvDvx6xTw9KFFAGBnbp+eYv
	AYJ+msv0UEyYkqNpFeyMqL6WIlzuoki44U0IjZn99z/9NBkw8SrL+XPaqb8OoHSL
X-Gm-Gg: ATEYQzwmMSc8g78OayOM7WjI/C3ajpkRIwOMQnPC0+G8H7tQIXZQ7b82wWnqvCrUGkP
	HctW7+LHPJnf8fKhUZxLXXwfhtemYdzI+YDUBplJJcMHp6tr5ty+v/Lv7DW4hy2lDGrpUq1Xg3M
	yYXcQAJewuf6aQdkhNrM+obdCJ8ZW7p+9Prfu+eJQcpqTU98W+idSfpZ2iplWZZXIgXXPUL3iFT
	G1UQl414vx+d5lAS+Tx6e39GOaATdgnXyR2xZoas69LrZvuuayQhQexzXA0ULWCAmfeMQO7F/2F
	bbgFgfpmLgIup1ZV6IGgUG6As/NcOzxh3/lT5djvIdJolAnA0M5OyatsTQoyNZWwKHejdP2KzJ5
	u0wZiqbr7prgksjyQlxxSQ4JcBJUXaMyuJEyMzQus+d61P2ZbOeGnjxDfwD+bfoHmGocKyQ8Ky5
	X8ONTkZx4P/0Vy0QcTV/r0zgh2jUZcJ+Fn2EDCOlUR9FGvsx4RbIxeAhn5CizuydEV1aYDaSjOQ
	8TdM9DC4+6F4QyQ9P4bcOvvXe8FMLPTRR7j2JMFEXq9jhA=
X-Received: by 2002:a17:90b:2f84:b0:35b:a241:ffb2 with SMTP id 98e67ed59e1d1-35ba24201bcmr4451251a91.7.1773751010510;
        Tue, 17 Mar 2026 05:36:50 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada470d2sm3946308a91.7.2026.03.17.05.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 05:36:50 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@gmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH v4] erofs-utils: lib: harden h_shared_count in erofs_init_inode_xattrs()
Date: Tue, 17 Mar 2026 12:36:39 +0000
Message-ID: <20260317123639.1891-1-singhutkal015@gmail.com>
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
	*  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
	*      [112.196.126.3 listed in zen.spamhaus.org]
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
	*      [2607:f8b0:4864:20:0:0:0:1030 listed in]
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
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
	TAGGED_FROM(0.00)[bounces-2798-lists,linux-erofs=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-0.546];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DKIM_TRACE(0.00)[gmail.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: BC3302A9FAE
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


