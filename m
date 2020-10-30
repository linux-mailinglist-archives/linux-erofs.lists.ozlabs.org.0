Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CF2A0578
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 13:32:16 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CN1sV39dczDqlB
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 23:32:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=gHxFywB9; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHxFywB9; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CN1s76xfpzDqlr
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 23:31:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ImcbisUME/wUpYO215n/eqRkrY6XvJiIybIQddtHhdc=;
 b=gHxFywB9dRzB+Owu2hcJJQZm/hfF0ua6rrl7r4xL9L8X+0DCVKootxSXLoL/Fk/SsLIlsv
 YxMXvYE5/l2Q9L3ua7sm8BmWV9YGobc7JPMZ/FO+7D4EyuMtpmyi3GFuGZQ3lwPtNIUgps
 olClejIsroHMaXwHpyRFVPvm62cFuYE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ImcbisUME/wUpYO215n/eqRkrY6XvJiIybIQddtHhdc=;
 b=gHxFywB9dRzB+Owu2hcJJQZm/hfF0ua6rrl7r4xL9L8X+0DCVKootxSXLoL/Fk/SsLIlsv
 YxMXvYE5/l2Q9L3ua7sm8BmWV9YGobc7JPMZ/FO+7D4EyuMtpmyi3GFuGZQ3lwPtNIUgps
 olClejIsroHMaXwHpyRFVPvm62cFuYE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-1OASKpBXNvm1h5zWvpqURw-1; Fri, 30 Oct 2020 08:31:50 -0400
X-MC-Unique: 1OASKpBXNvm1h5zWvpqURw-1
Received: by mail-pg1-f200.google.com with SMTP id b17so4530952pgd.16
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 05:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ImcbisUME/wUpYO215n/eqRkrY6XvJiIybIQddtHhdc=;
 b=KS8HG4r/5j1Xa+9edVip7fV94LNyUlYYt5lr0QZylr6ZMFHcU10vp8QjiBdxn91Y2c
 vt4XrLc5r/vNFNlyDpyzuo9lNKmSuDEIFR+nqKphLHOXRCl8zL4IeHdxhs19AYnd/lB+
 S1XAc7YDChizA8an3v+dG9rBKyCpTbF6bwVDUawY8un2ZMbPVomfLowN//iGWrHFhzBO
 HjpJBX/zhkYi1AO5z5yBytRFX9m/2nUQDkvqev517Ep29QDJG9+VjQJEhyRZOyOJC+AO
 yzcjd17eqrjrGVy8MNOUAec6cvo/EovXaMQMxSCwjEMb4/zG0xevT5JkeXY6ZStd/fbJ
 SaUQ==
X-Gm-Message-State: AOAM531BQlupeNd4ZHyjgnpUAqOpTDqqdqfc7l9zl9j62N8jfwt5/lY0
 7FPolQUE361GlIOd46lIABB0XmcnYt/M0m80qL2MvkiBgw+UjBqO9UHh0NrDREkGnbo9haYDoZm
 Fio9GkwIMmPe2hjiOos2Y6o9w
X-Received: by 2002:a63:2b53:: with SMTP id r80mr1973448pgr.439.1604061108902; 
 Fri, 30 Oct 2020 05:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcKpYxB7v6XevMlQP+r/ra4KdFhvJiBeYQegs90Ym2ziRiJse9Ea70ksf2v9M7biYFhppAJw==
X-Received: by 2002:a63:2b53:: with SMTP id r80mr1973430pgr.439.1604061108730; 
 Fri, 30 Oct 2020 05:31:48 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b128sm5415458pga.80.2020.10.30.05.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:31:48 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/4] mkfs: introduce erofs_mkfs_default_options()
Date: Fri, 30 Oct 2020 20:30:19 +0800
Message-Id: <20201030123020.133084-3-hsiangkao@redhat.com>
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

Gather all default settings, and generate UUID before
parse_options_cfg(), therefore the UUID can be overridden
later by command line for reproducible images.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 mkfs/main.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 5c41fc0..0e17314 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -368,18 +368,18 @@ static int erofs_mkfs_superblock_csum_set(void)
 	return 0;
 }
 
-static void erofs_mkfs_generate_uuid(void)
+static void erofs_mkfs_default_options(void)
 {
-	char uuid_str[37] = "not available";
+	cfg.c_legacy_compress = false;
+	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
+	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM;
 
+	/* generate a default uuid first */
 #ifdef HAVE_LIBUUID
 	do {
 		uuid_generate(sbi.uuid);
 	} while (uuid_is_null(sbi.uuid));
-
-	uuid_unparse_lower(sbi.uuid, uuid_str);
 #endif
-	erofs_info("filesystem UUID: %s", uuid_str);
 }
 
 /* https://reproducible-builds.org/specs/source-date-epoch/ for more details */
@@ -418,13 +418,12 @@ int main(int argc, char **argv)
 	struct stat64 st;
 	erofs_blk_t nblocks;
 	struct timeval t;
+	char uuid_str[37] = "not available";
 
 	erofs_init_configure();
 	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
 
-	cfg.c_legacy_compress = false;
-	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
-	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM;
+	erofs_mkfs_default_options();
 
 	err = mkfs_parse_options_cfg(argc, argv);
 	if (err) {
@@ -495,7 +494,11 @@ int main(int argc, char **argv)
 		goto exit;
 	}
 
-	erofs_mkfs_generate_uuid();
+#ifdef HAVE_LIBUUID
+	uuid_unparse_lower(sbi.uuid, uuid_str);
+#endif
+	erofs_info("filesystem UUID: %s", uuid_str);
+
 	erofs_inode_manager_init();
 
 	err = erofs_build_shared_xattrs_from_path(cfg.c_src_path);
-- 
2.18.1

