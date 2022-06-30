Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E281F562108
	for <lists+linux-erofs@lfdr.de>; Thu, 30 Jun 2022 19:15:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LYlMH15SXz3cgy
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jul 2022 03:15:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656609307;
	bh=OJK5Aq3wptvvi2FaL91ME/MM/CFSh3CnjuRQVgbcuhQ=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=Ja4JWW1Jx6Ttxy01OOtvJxUxxtlugaJewZbXLBySfN33wyEWl/zCo4auDvZAB56H5
	 vUdBpp0OOTzm1cQz0G2E0PA3t52ZK80F2MoCpUvJoh7tupvTl/KPDQE03jRrePPq13
	 KpCtwz6te/LonwNMg8lex7I5CnjL8myPv4NC8biiKnxaTB+kDBzMnhJ39+Ta2A2gI3
	 7liG1H683Cz4YS3FD1xWuSFLvKXHfolHnMyioeuU9AFGG8n+I5/Y9RUyl5ZYdcnkfY
	 lsEBgNhR3FHouFqpwZSWRtnDPHq/wkWNslmp1HSnkzNkdwXAgfYHHvDhxn9t9LqHhH
	 Gu+F7/WEh8d9Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--zhangkelvin.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3ddq9ygskc9qp70d6a4bl8d6ee6b4.2ecb8dkn-4he5ib8iji.epb01i.eh6@flex--zhangkelvin.bounces.google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=UvTiCKlh;
	dkim-atps=neutral
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LYlM75bWTz3bnd
	for <linux-erofs@lists.ozlabs.org>; Fri,  1 Jul 2022 03:14:57 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id s194-20020a252ccb000000b00669b5702413so17150716ybs.22
        for <linux-erofs@lists.ozlabs.org>; Thu, 30 Jun 2022 10:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OJK5Aq3wptvvi2FaL91ME/MM/CFSh3CnjuRQVgbcuhQ=;
        b=FnF6y+cKrjlL2M/sFLqOjGV/76xvsgySppaSzCsP43Wcu21ubB2ZuU91Z+3LL+fzvy
         CTj4RuAxDwF/X6DDK1pkEnhQFZpd3PaC8d5fc2Gja8RMcKC1fWePRw2tZzwx5uh91Xji
         ZS9ejqDXUzcCtRTt0fzTT6yu4te+myf+ZGLLufkim62nfyzigLxiqjz0LUUW3lbs9e7I
         EIUg2qwj3x+TIbg8KTMB7xoZRxwU+zNHvI2AkcdPZlCM52R0enQr45oLOKy3Wj8OfaG7
         AXbOhAlcYqucYmM2ltb2PlIiMqVE3mYX8S15D7ZaqRuNbFpnCmoWDA7pzAO4BRRAI9vt
         hNBg==
X-Gm-Message-State: AJIora9LHXk2MzAba7RIeC1BAcOMTTc0sy6QJgbCqf/dyGCHnGNOLQ26
	C1aLvSxLhLaOcXnCf36IDgKv/aNSxNe57Ri1geqonmFPIGWZxwHCqImgueQxymC+gqryxGp+Ash
	ea77+qR9TQVyPi/oSV29PmLnbS+P9mEMh3rr/1D3T+iaFkU6AhFTNBpoGS+rhsMlr7qyt1baTbD
	zEARU7sMs=
X-Google-Smtp-Source: AGRyM1tBf9cqbzar1lrIXSqtqqqb1yegOssw1PbwA+i7XeKbNcrHitiTedUnQuewuSEVmP8eK0mQzsd7Tt1SZBtY4Q==
X-Received: from zhangkelvin-big.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP
 id l10-20020a056902000a00b0065cb38e6d9fmr11190423ybh.36.1656609293146; Thu,
 30 Jun 2022 10:14:53 -0700 (PDT)
Date: Thu, 30 Jun 2022 10:14:42 -0700
Message-Id: <20220630171442.3945056-1-zhangkelvin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v1] Make --mount-point option generally available
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>, Miao Xie <miaoxie@huawei.com>, 
	Fang Wei <fangwei1@huawei.com>
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This option does not have any android specific dependencies. It is also
useful for all selinux enabled fs images, so move it out of android
specific feature sets.

Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
---
 include/erofs/config.h | 2 +-
 lib/xattr.c            | 2 --
 mkfs/main.c            | 6 +++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 0a1b18b..030054b 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -65,8 +65,8 @@ struct erofs_configure {
 	u32 c_dict_size;
 	u64 c_unix_timestamp;
 	u32 c_uid, c_gid;
+	const char *mount_point;
 #ifdef WITH_ANDROID
-	char *mount_point;
 	char *target_out_path;
 	char *fs_config_file;
 	char *block_list_file;
diff --git a/lib/xattr.c b/lib/xattr.c
index 00fb963..cf5c447 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -210,12 +210,10 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		unsigned int len[2];
 		char *kvbuf, *fspath;
 
-#ifdef WITH_ANDROID
 		if (cfg.mount_point)
 			ret = asprintf(&fspath, "/%s/%s", cfg.mount_point,
 				       erofs_fspath(srcpath));
 		else
-#endif
 			ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
 		if (ret <= 0)
 			return ERR_PTR(-ENOMEM);
diff --git a/mkfs/main.c b/mkfs/main.c
index b62a8aa..879c2f2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -50,8 +50,8 @@ static struct option long_options[] = {
 	{"quiet", no_argument, 0, 12},
 	{"blobdev", required_argument, NULL, 13},
 	{"ignore-mtime", no_argument, NULL, 14},
-#ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
+#ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
 	{"fs-config-file", required_argument, NULL, 514},
 	{"block-list-file", required_argument, NULL, 515},
@@ -103,9 +103,9 @@ static void usage(void)
 #ifndef NDEBUG
 	      " --random-pclusterblks randomize pclusterblks for big pcluster (debugging only)\n"
 #endif
+	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 #ifdef WITH_ANDROID
 	      "\nwith following android-specific options:\n"
-	      " --mount-point=X       X=prefix of target fs path (default: /)\n"
 	      " --product-out=X       X=product_out directory\n"
 	      " --fs-config-file=X    X=fs_config file\n"
 	      " --block-list-file=X   X=block_list file\n"
@@ -314,7 +314,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 10:
 			cfg.c_compress_hints_file = optarg;
 			break;
-#ifdef WITH_ANDROID
 		case 512:
 			cfg.mount_point = optarg;
 			/* all trailing '/' should be deleted */
@@ -322,6 +321,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt && optarg[opt - 1] == '/')
 				optarg[opt - 1] = '\0';
 			break;
+#ifdef WITH_ANDROID
 		case 513:
 			cfg.target_out_path = optarg;
 			break;
-- 
2.37.0.rc0.161.g10f37bed90-goog

