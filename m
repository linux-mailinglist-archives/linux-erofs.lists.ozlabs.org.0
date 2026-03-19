Return-Path: <linux-erofs+bounces-2847-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKA6ICrwu2m1qQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2847-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 13:46:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62262CB527
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 13:46:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc56S50sbz2ynW;
	Thu, 19 Mar 2026 23:46:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773924384;
	cv=none; b=aTui4u6v7HdTjb/yEDflHcfAoxyYfS4VwLXMT+YdSvIVMT/SkzABGTcH6QbhMVxd8bgHThr3XXm9Q57epx+2v7HBSyGmDdvzGe4BiMNGZ15UaO3L86opKsw0iymXux570/i99LINKwue6I/ZUGu3gkiLBUv/yKNILh7hzrrki17+p4OfXinYpkeuBsmYZKYT78qnt25AXw93FxS9bAKRKFMU/PndkLTZ8Q6t9WrFHoAkHbYqPsKv8sEo5YDQ5TjWlXEvw2rZb6i89LJxwTgxooOioMHaZwh0IEpdwiEWeA65sgO9HCzQqPXFYnK3V2KQhk3aJPXx1Ey0HTrQ6QV6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773924384; c=relaxed/relaxed;
	bh=fAG2luJkX4J4bz7jFU3CZc/r+PYOsZHvj5H6b+VrVUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZW9+ktexbpL5LIKOVtIQYs3BMR0uGgQ1eWfBeiEEiWbu4i5eiHkz1M2ehP8al4QXEGnXTbVfgCI55SKcubhPWxI+82YhC2TpBu1Z00Q8yGLpjbAcMibAghydnWxZ+IrBvNoJMybWFH3y2/vOiNSMqigmr594DaG/Yf/42rTzzkAuYPTeIyzd9FjX0kmFmkbvOsRGpZers6H+V1AnuMMTIFO8/JeRVHvUiE+VIBJWNwDXluRM7gnjdIw3djQUXFDDZ1HiSmubnO/rBVh1FYORCrvSKUOOaRG1YGeR19xUXRj01SecTrCKmEBYWeFllFtz9CdYzxnSsAJNV6UZ6tughA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I66zMCLO; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=I66zMCLO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc56R1f7xz2ygT
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 23:46:22 +1100 (AEDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso43604766b.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773924379; x=1774529179; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAG2luJkX4J4bz7jFU3CZc/r+PYOsZHvj5H6b+VrVUA=;
        b=I66zMCLOSY60PeIvMJUGye0hmqVqRZfbR/vpuoK+Pjt4cMjryoT57aITSb07Nw/V0V
         nvLV99qb5l2lbik8F1sKlATROXzYkh0DD/VdqqnnfXb/NEVWTBlcnIp2cCx8G5zp2ZeA
         bKhaGbM1Cp5JZFFai6Pm2WjWd9xzAr7UFo310rUNM/EXjQDmxQR/hKWlJysk4IAK3k94
         V4jmb8kYq+N6WEFM9CgwT4PCaxkiV1LUFUnJKQMApdCG65h7ceEq1QPCcmMVHFP/qzeI
         0zzQ+GNPmkh9AcDCOO2U6oj404WwOxjaxhRlymJE8YYdGegK2xYCU2Ol7ZoVhj67XS81
         dDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773924379; x=1774529179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAG2luJkX4J4bz7jFU3CZc/r+PYOsZHvj5H6b+VrVUA=;
        b=GIuMg48tlSonDFnG0FLq8DbXs804UFoVa3pUp1r1vFMBMgqwu+/R0P1uhM2pYqw+r0
         fucMC9ixrFeai+2U4tXv+3Iv2sEkLEd3/roFEKIsRzVCZ3pcAkwQs45upecisFMHGQtR
         xkk2vehTppOtsQNqxlmyEWAy1nJCRr0G/LJqWlzlc7KXKSs4fMuf1jiYggSYBlllcoTS
         hQFWrnZDlXhWSP+GzyLaG+JkYl0mR7Hhd74Y/Qs2LHMAhXWFxBNagdDoCYrLXcCcxo5x
         6KGvR00P+TM1+m51VLEROjn/GGDIfyl63bhMQDQhIKXAEoNRHZy3y5G2Bdz7kQDgkavD
         e8vA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ul6XShotjtIyY6xUMaLgpK3L3Sq04j7kWlv0XXSK0ST/7GTPnvO2k5jWL1LmG0roR+zvFvkxshPuzg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzGNB5Bm86F72hmbz7jGvSTIHSpo+gFSefvawEYkTUw/M36yUFq
	XBdQ9hC3uuh8Oka5CIzj8IrGOuSs/sFxj0ssTs3EIU9O2asxoEARgeDj
X-Gm-Gg: ATEYQzxKPhAwR4jHmnVleNVi/tWCiN/LfFQulcJA8/kYXUbJMCwZ0OdlaqXYB1YbPOC
	t4BUMKIXQmNhqzkiZMDFHsYaF//9SZODIjXk8zkY0EtHFrXHqVEuELHpKav5qQpkOVczN7EgBl5
	ojxqjK6j9t4ZglO0flZsvb6zRnCPXv7BSUOlNO1dSPQn4lunNDRUB/TSGQujRnPy6zihrooUYbB
	or6yZD4X1+db3xmi+hLsxpjBG/xEcD2ZNaq+11xWWlFosWGqqMToZ8/N0GFMusxMaivr0Q7whDH
	KkEv5V4MkvvY/szf7N2v9gb2u29EKa2lijnlQ/ro1Kq25KxsoTrYdkEgBZoouMqJvcyBb5RBrmv
	sVhcttV05lGwYvLgcV2ljO2sjzKAJu+Ln/3vOH+uN6PI6EkPbzzx1inBoo1FH0zpnyN388ehKAe
	xeuftcnfGSuCkEb9pKIm2kHelge+ZkZiFLBjjRLSblIT4gGo5fbun5ZQVDR5ZVjdyBWa5R6Hw4t
	3Yjqzt1hpXBDdjfJaQq7ZZ58ZyU
X-Received: by 2002:a17:906:eec7:b0:b97:3bbe:e42b with SMTP id a640c23a62f3a-b97f4a7c85amr459473066b.28.1773924378353;
        Thu, 19 Mar 2026 05:46:18 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-769d-2f77-d166-4700.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:769d:2f77:d166:4700])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f168c141sm430902766b.40.2026.03.19.05.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:46:17 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Paul Moore <paul@paul-moore.com>,
	Gao Xiang <xiang@kernel.org>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Subject: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
Date: Thu, 19 Mar 2026 13:46:16 +0100
Message-ID: <20260319124616.1544415-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spamd-Result: default: False [0.80 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2847-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:paul@paul-moore.com,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: A62262CB527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH file.
Skip setting them for O_PATH file, so that the O_PATH file could be
opened with a negative dentry.

This is not something that a user should be able to do, but vfs code,
such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
before instantiating the dentry.

Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This patch fixes the syzbot report [1] that the
backing_file_user_path_file() patch [2] introduces.

This is not the only possible fix, but it is the cleanest one IMO.
There is a small risk in introducing a state of an O_PATH file with
NULL f_inode, but I (and the bots that I asked) did not find any
obvious risk in this state.

Note that specifically, the user path inode is accessed via d_inode()
and not via file_inode(), which makes this safe for file_user_inode()
callers.

BTW, I missed this regression with the original patch because I
only ran the quick overlayfs sanity test.

Now I ran a full quick fstest cycle and verified that the O_TMPFILE
test case is covered and that the bug is detected.

WDYT?

Thanks,
Amir.

[1] https://syzkaller.appspot.com/bug?extid=f34aab278bf5d664e2be
[2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir73il@gmail.com/

 fs/open.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 91f1139591abe..2004a8c0d9c97 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
 
 	path_get(&f->f_path);
 	f->f_inode = inode;
-	f->f_mapping = inode->i_mapping;
-	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
-	f->f_sb_err = file_sample_sb_err(f);
 
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
@@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
 		return 0;
 	}
 
+	f->f_mapping = inode->i_mapping;
+	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
+	f->f_sb_err = file_sample_sb_err(f);
+
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
 		i_readcount_inc(inode);
 	} else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
-- 
2.53.0


