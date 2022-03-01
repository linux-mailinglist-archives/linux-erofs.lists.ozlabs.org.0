Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DF4C8202
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 05:11:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K73jK0Sl4z3bmP
	for <lists+linux-erofs@lfdr.de>; Tue,  1 Mar 2022 15:11:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1646107909;
	bh=TjmJU6usLCR1C28r7eAYn1wib0oSmbAsfP7t2GJHvWA=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=Bbv8iAjzt2Z8ihJq0nB8Lo14u0n7M7YBYDxk9Pmb7t2ZJQDtHd3IuFRH7jxPrRamt
	 LMBgBx+PJIN/LQY6k8AyREC0mZy31W/6MSiLXN7j41AlkStoPvUDHyzlyKdNhmprWZ
	 LcBkUBpTyz4DbOxxFHpN6CF/GSeXNyB/TGBhZEb7GEe5sQ8iuGB3ikZvSG/nlaOPY8
	 JehGkSt7FmZaa3WxiJka42S9OF3gBSxT14fABIVdGYwmhY+o0JZcLx4vFVGfnmIoB7
	 9qugy5iA7ABTocbtIIWYWmDTwWKw92CZH1uJQx5yBg5CA9yZos+yot+ZZUuAXa0epU
	 qfkBMUsWttvtA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--dvander.bounces.google.com
 (client-ip=2607:f8b0:4864:20::84a; helo=mail-qt1-x84a.google.com;
 envelope-from=3_pwdygckc8uo6lyop2rzzrwp.nzxwty58-p2zq3wt343.zawlm3.z2r@flex--dvander.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=LMUrgw/c; dkim-atps=neutral
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K73jD6XR0z2ywb
 for <linux-erofs@lists.ozlabs.org>; Tue,  1 Mar 2022 15:11:44 +1100 (AEDT)
Received: by mail-qt1-x84a.google.com with SMTP id
 e20-20020ac85994000000b002de4c01eef4so6403662qte.22
 for <linux-erofs@lists.ozlabs.org>; Mon, 28 Feb 2022 20:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=TjmJU6usLCR1C28r7eAYn1wib0oSmbAsfP7t2GJHvWA=;
 b=NYQW8EJxkdNV23RxLKH+yMEti8++OFgJpggYRf78BXPnoB70Yw6putooKCnjd7azJh
 tBiO3fh//1e2tNzOlvOrOTUdyEU4GzhuXBT1PSPwUYVSp/QhEeItYgpHj3KZ6scOfxyx
 MxDkgPdyJ5wjePuyllUPiaRi52nQUCtGufDBaLbC0QGYd7rQeKwfqZI8nZ+O/Gj3BE6L
 kX9gW1XXtNOvGk8kNuaRDEYfu0X7L9fedxxm2JJw7fDLS83pxotWafeiaSy2Vjr1ankn
 3p+Gn/luwcb33RgBjlHCrlbsCakGO7tqRE97d5pQX7vi/BTYdLxNjPmQOfCjMMsNizdW
 7uzA==
X-Gm-Message-State: AOAM532+sGCHOXfxurFb+VE/sSu/ntM8uAWA/fxdWRyl78CGePB8y8Wu
 gdQlNYUop6VKb+7QC6IAabOvsyBCEn0c+z3BWHlOI8lkZdrrDpteQ8AXMWOLUo/hTz8y6GaJ9bI
 0wff1lqFk19hh+wt8tt57tSK5T6U23VLjzSzXjMetLNw44Vkts6hBdgNJqeDvEhmoJBje6kLN
X-Google-Smtp-Source: ABdhPJy7yoYV+W4QvF5ei5Wowj2KkeXY7XamjnsHxiuweY8ajOuQ2JqGuoVY7ofFXTp3SaLRXRRPcrYwNDxo
X-Received: from dvandertop.c.googlers.com
 ([fda3:e722:ac3:cc00:14:4d90:c0a8:2862])
 (user=dvander job=sendgmr) by 2002:ad4:5ba8:0:b0:434:66a8:6cd8 with SMTP id
 8-20020ad45ba8000000b0043466a86cd8mr2229481qvq.4.1646107902516; Mon, 28 Feb
 2022 20:11:42 -0800 (PST)
Date: Tue,  1 Mar 2022 04:11:39 +0000
Message-Id: <20220301041139.2272220-1-dvander@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] erofs-utils: mkfs: Use mtime to seed ctimes
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: David Anderson via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: David Anderson <dvander@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently mkfs.erofs picks up whatever the system time happened to be
when the input file structure was created. Since there's no (easy) way for
userspace to control ctime, there's no way to control the per-file ctime
that mkfs.erofs uses.

Switching to mtime allows this tuning, which is important when the
timestamp of files is used to detect staleness.

Change-Id: I9cab662398bedc43d6d68ae798912f33360814e3
Signed-off-by: David Anderson <dvander@google.com>
---
 lib/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 461c797..f0a71a8 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -806,12 +806,12 @@ static int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_mode = st->st_mode;
 	inode->i_uid = cfg.c_uid == -1 ? st->st_uid : cfg.c_uid;
 	inode->i_gid = cfg.c_gid == -1 ? st->st_gid : cfg.c_gid;
-	inode->i_ctime = st->st_ctime;
-	inode->i_ctime_nsec = ST_CTIM_NSEC(st);
+	inode->i_ctime = st->st_mtime;
+	inode->i_ctime_nsec = ST_MTIM_NSEC(st);
 
 	switch (cfg.c_timeinherit) {
 	case TIMESTAMP_CLAMPING:
-		if (st->st_ctime < sbi.build_time)
+		if (st->st_mtime < sbi.build_time)
 			break;
 	case TIMESTAMP_FIXED:
 		inode->i_ctime = sbi.build_time;
-- 
2.35.1.574.g5d30c73bfb-goog

