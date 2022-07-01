Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BDD563CA1
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jul 2022 01:00:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LZVzj16Shz3dp2
	for <lists+linux-erofs@lfdr.de>; Sat,  2 Jul 2022 09:00:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1656716449;
	bh=HuwjnRW93QaNE8gbT/5O3K+a0bBl5BVi+Dpif/BPjII=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Y1WhNbyl11oH6a+Ds3yHfh/3v4kpLW9VblUmlOZWwjzyo6OKpiJI3wrjBYAvt3A1O
	 5JfbfjcE2QxjlLCFmbHgczeWv+7tAsGleQuh0fliyo3+i+HwwfP9R4i7cZxIY3Ng4C
	 IIQKIO2WUeosHWLOb1Ugqx4MKWwFG1e3m3erN+5VO2korluZ/4+s20uL3i4pTEN4rP
	 6kBedoCpSCfXf5RjC1DC0iYyccNAls2MpNOzbbvfj9nmlhElvre46Djy//jeBjH4Tx
	 QDv/VmvmC7w4ODga4L5/oom3/MqWFCnr+pkOXZV3tW1SkE4E6NHe0qEaBxlzOKRU30
	 jgrLrbry/c2Tw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--zhangkelvin.bounces.google.com (client-ip=2607:f8b0:4864:20::e4a; helo=mail-vs1-xe4a.google.com; envelope-from=3lhy_ygskc6cgohunrlscpunvvnsl.jvtspube-lyvmzspzaz.vgshiz.vyn@flex--zhangkelvin.bounces.google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=AO9bc1S9;
	dkim-atps=neutral
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LZVzY3sWTz3bqJ
	for <linux-erofs@lists.ozlabs.org>; Sat,  2 Jul 2022 09:00:40 +1000 (AEST)
Received: by mail-vs1-xe4a.google.com with SMTP id o21-20020a67fc15000000b00354568cfc5dso214042vsq.9
        for <linux-erofs@lists.ozlabs.org>; Fri, 01 Jul 2022 16:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HuwjnRW93QaNE8gbT/5O3K+a0bBl5BVi+Dpif/BPjII=;
        b=BFQ8bw9M3LdHlv2jQZFnTgqs/+7cLMYCBFeHHwME8KDUvd+VQDgkRJN4O4rI+/mw7Z
         PD9dyMlY5y7fMHjrrJae50xXHWGTr1TSxchC66z8+3nPHJ7Qvzr9zyRBRLSokpJLKpfh
         xuSlNOU7BuABg8JFFqWbfHdGcmWcf45IJNS8aOiIY5319nJUpynEDPa5+LPZPigQvhk9
         5E3cIhWWGMTb21o7s+S54nYsyToYUjykVRMszz8ocB6hipJHpBALc4j1RcUs9iFVZ5Ke
         4FC4ELvn3I4mnWreNVhWcIzVkRMV2Xl1S9sY7PNKwILt4jjcWZOVqXqR9IjWOw5OPSNr
         jt7Q==
X-Gm-Message-State: AJIora/cT9DnXtvvs6xkyddRrCctQOhh1l980we60OJ3aGPdSsrCEx/P
	nK635dNUh4IhGgxZJndJ6S/kW6v/iTmfoRxyht7G7+abnIkA3q/emqJ4zGzsG8+829utpEVaGE6
	WD2k4wtIJwdTZQKP4YZguyhU92zyt6Z22LaU+tToSiO1PY8+mJ86mKb2X9PNDsb8RyYMA9MeSCp
	9tEQTrax4=
X-Google-Smtp-Source: AGRyM1skAZSv9DQCjj/KDPb807WXrx5EyE8LIyUiQAvUuK+jQ9difXVUWL3E2S6hNQTHUZZXi6D4Rh/3HQTrU4HOAQ==
X-Received: from zhangkelvin-big.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:ab0:15ed:0:b0:365:f250:7384 with SMTP
 id j42-20020ab015ed000000b00365f2507384mr9458281uae.44.1656716436152; Fri, 01
 Jul 2022 16:00:36 -0700 (PDT)
Date: Fri,  1 Jul 2022 16:00:30 -0700
In-Reply-To: <Yr52GGOwNfl6StH6@B-P7TQMD6M-0146.local>
Message-Id: <20220701230030.2633151-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <Yr52GGOwNfl6StH6@B-P7TQMD6M-0146.local>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] Make --mount-point option generally available
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

e.g. mkfs.erofs --file-contexts=selinux_context_file
--mount_point=/product product.img your_product_out_dir

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

