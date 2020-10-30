Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCA2A057A
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 13:32:23 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CN1sd1DtvzDqwF
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 23:32:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=eDeoLIwz; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJC7QVCv; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CN1sC5B9QzDqdP
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 23:31:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=187N4HLvRGBmlX9g739pFadIIoCfBhGsKSC+fXb9oF8=;
 b=eDeoLIwz/HU735kt0H2J5g0dqV93GLSzJKguPbG1CxHV75ZKcpk4ZOZQpR7q+DPaCjgf3I
 SaQ/UZUAscWOhBn15qm6fADznIiD9u4QfPa7qaErnd7W4xXciRnvt+smW6pTmHfxzPGkwL
 8ePpmJThi1J3jzJq/9OvjRZUmys9lFw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=187N4HLvRGBmlX9g739pFadIIoCfBhGsKSC+fXb9oF8=;
 b=RJC7QVCvvve55QiFEx3gQMW5qat0WPtFt79t7cub7djDpG2u/JOK6bV13UP+2QLvZ3cT94
 fRmG427+yC7rQ7pIHeBpVCuTol2703GqB9VO0LFGkZKn6KinvMkFjS9OTIb5C5XyvxMsJi
 PvxMoKVao1d06frKh58X8pmyvFhu+48=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-gO8KuAJsNeKfn8QkacWGbg-1; Fri, 30 Oct 2020 08:31:54 -0400
X-MC-Unique: gO8KuAJsNeKfn8QkacWGbg-1
Received: by mail-pg1-f199.google.com with SMTP id c9so1548847pgk.10
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 05:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=187N4HLvRGBmlX9g739pFadIIoCfBhGsKSC+fXb9oF8=;
 b=OiromBxAuYtfzIKzrt+SqU+B7XHkmpBCXMsgZCvkw4Gh6Ng1ERFaW8gzyuF8k5XjJl
 PScMEkeOQOjF/jPufQWr/HHXEK//fAqjFXmxtcUc9ZhEJ6uM8+BnvIrnFO8xzxE8mRqi
 3GsJjitj9HCWiK6mw09EWgMcTIn5bGqXgW1GBiRSNSJRK63d+bGIIhUI4lG+OqJ+lIx+
 Ui5r8PTX7uCJsY8xM6OTnB3UkYLPtIJRQ59upULtCe0R9e1fVAbqSM3dbIewj+zhgTvC
 Qo0oa7rZY9vIBJfWepMkNKzHqni1zVKigYJ5fr+BIxXVtSBWv6ciTG6Ta9tCdupz875D
 cykg==
X-Gm-Message-State: AOAM531xahHDRUZv7+27buB933YLN2XocGiwzNf2mJjvkxJQWTDJxxeP
 DxKAd7FSjaBQCTEgPo8J1Ot4JorccdnKpDFpeTCOy+Gcoo276gVxEhuqsKYeGMV6/ZXLGtH4FqF
 nzdeV6jfwpfs0m4YrRF0b9rUZ
X-Received: by 2002:a63:1844:: with SMTP id 4mr1903613pgy.95.1604061112796;
 Fri, 30 Oct 2020 05:31:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAdDvGc7ydH3ItFUEq/8GO6+1zqe93rhh9LJ63+1d1DTRbxHOE0dTvhRlE8bKckt03+P4fUg==
X-Received: by 2002:a63:1844:: with SMTP id 4mr1903597pgy.95.1604061112607;
 Fri, 30 Oct 2020 05:31:52 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b128sm5415458pga.80.2020.10.30.05.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:31:52 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] mkfs: add option to use a pre-defined UUID
Date: Fri, 30 Oct 2020 20:30:20 +0800
Message-Id: <20201030123020.133084-4-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20201030123020.133084-1-hsiangkao@redhat.com>
References: <20201030123020.133084-1-hsiangkao@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Usage: mkfs.erofs -U<uuid> <imagefile> <srcdir>

The filesystem UUID can now be optionally specified during filesystem
creation. The default behavior is still to generate a random UUID.

This is useful for reproducible builds.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 man/mkfs.erofs.1 |  6 ++++++
 mkfs/main.c      | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index 891c5a8..dcaf9d7 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -52,6 +52,12 @@ Forcely generate extended inodes (64-byte inodes) to output.
 Set all files to the given UNIX timestamp. Reproducible builds requires setting
 all to a specific one.
 .TP
+.BI "\-U " UUID
+Set the universally unique identifier (UUID) of the filesystem to
+.IR UUID .
+The format of the UUID is a series of hex digits separated by hyphens,
+like this: "c1b9d5a2-f162-11cf-9ece-0020afc76f16".
+.TP
 .BI "\-\-exclude-path=" path
 Ignore file that matches the exact literal path.
 You may give multiple `--exclude-path' options.
diff --git a/mkfs/main.c b/mkfs/main.c
index 0e17314..c63b274 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -66,6 +66,9 @@ static void usage(void)
 	      " -x#                set xattr tolerance to # (< 0, disable xattrs; default 2)\n"
 	      " -EX[,...]          X=extended options\n"
 	      " -T#                set a fixed UNIX timestamp # to all files\n"
+#ifdef HAVE_LIBUUID
+	      " -UX                use a given filesystem UUID\n"
+#endif
 	      " --exclude-path=X   avoid including file X (X = exact literal path)\n"
 	      " --exclude-regex=X  avoid including files that match X (X = regular expression)\n"
 #ifdef HAVE_LIBSELINUX
@@ -149,7 +152,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 	char *endptr;
 	int opt, i;
 
-	while((opt = getopt_long(argc, argv, "d:x:z:E:T:",
+	while((opt = getopt_long(argc, argv, "d:x:z:E:T:U:",
 				 long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'z':
@@ -200,6 +203,14 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			}
 			cfg.c_timeinherit = TIMESTAMP_FIXED;
 			break;
+#ifdef HAVE_LIBUUID
+		case 'U':
+			if (uuid_parse(optarg, sbi.uuid)) {
+				erofs_err("invalid UUID %s", optarg);
+				return -EINVAL;
+			}
+			break;
+#endif
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
 			if (opt) {
-- 
2.18.1

