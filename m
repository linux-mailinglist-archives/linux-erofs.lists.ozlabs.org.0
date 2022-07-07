Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6856A9D9
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Jul 2022 19:41:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lf3cQ3qmvz3c3f
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Jul 2022 03:41:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1657215686;
	bh=Ky8YyT0iejjtKqnlVAFhBeXW4JQJ51oQQIsiWnnYzzQ=;
	h=Date:In-Reply-To:References:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dUMrDsCsK0ltjYATT2L2taNQRbizQZ0s7HfcxQluTIUyR+so7FFCvzlNbIz7AiuJE
	 QxQpeIonlU/Qu+brMfxHaxterv3tX0BOj+9pUb3XKAobbMNYr2W5kdg409fsvmSdRA
	 FGDm71MdlyBwX7WqntKNkE4viyEZFjDIf6Y5+81D8dzCkMH28b/qxWcDprL2JOvCcX
	 w2qrMbs0/gWX7GRRSo46Rf+UDzChBQEf6ggJvDpVOumz9aiHI9I2SZ0i442WRn6jnP
	 KvyighMcdFA1akPw/+qzxUKHWMtJR1bOOfn1RZQQ9eHbcaYLsBZAHtIDQRn9YZ8kj1
	 VWk7DrR+oMQTQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--zhangkelvin.bounces.google.com (client-ip=2607:f8b0:4864:20::a49; helo=mail-vk1-xa49.google.com; envelope-from=3trrhygskcyqzhangkelvingoogle.comlinux-erofslists.ozlabs.org@flex--zhangkelvin.bounces.google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=Bo0vS1sR;
	dkim-atps=neutral
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lf3cG5Znxz2ypZ
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Jul 2022 03:41:16 +1000 (AEST)
Received: by mail-vk1-xa49.google.com with SMTP id l81-20020a1f2554000000b0037443bf4bb9so1696387vkl.7
        for <linux-erofs@lists.ozlabs.org>; Thu, 07 Jul 2022 10:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ky8YyT0iejjtKqnlVAFhBeXW4JQJ51oQQIsiWnnYzzQ=;
        b=yZ2yAAxs6hzF7osFEyZzb/R+ovQsFmlRCbWzVTyAFpoFDaJ9voG2WHNAe3BDxoOxC0
         6o1orwxRn0gCdVvnCW4aPmVxa+EJGGxVWiMXyTrb2kNgeDxwt3ihf8BAh/9IKW8vZnG8
         d9rk1XW9CJ22z0ufuZTlE/sUc5U5UlhnxpycG5EV/KmYB6ggGHv2KB6OzgzNyHb7yV1U
         YDpLlRBPMhbPcv7T/aAtwTh2StgYLT7EKFyCsVRL2EEoFwIX7h8Eo+Io9gVU5lXzrKhS
         HIiibI9rI5ituDgX0hp5axAJran/7Rtufuwa4pgnXZ3RMujRN99aS56W/CEfsv28Hllm
         ELxw==
X-Gm-Message-State: AJIora8lCQ27OpRQsZRKia+nKeISY7u11UrdbcOJyP/U2mEJajWwqmdo
	+7ZktkeIp3oG+s98KkQ/Kqwr6E+HjodPcsdvMzIsmUUPGGKcf75V6OJ8J+C9u/Ay1GCw8jubuTG
	WYa9ocK61ZtIKZDXBLr01ayaTxs0JsRl9QIt7QiGZYwOaKF95gH7nF6MHosMOos2CvLOJskjNiU
	Fs062dtcs=
X-Google-Smtp-Source: AGRyM1uBSlSPhen24nKdCbb90puNnwwzCLGYfrSDwELqPQzu0+x0GqkLNvMC7cSRFAlzmWA500E25htGcHO3/n2qSQ==
X-Received: from zhangkelvin-big.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:1f4a])
 (user=zhangkelvin job=sendgmr) by 2002:a1f:1d0f:0:b0:374:448a:dec2 with SMTP
 id d15-20020a1f1d0f000000b00374448adec2mr5531801vkd.5.1657215669376; Thu, 07
 Jul 2022 10:41:09 -0700 (PDT)
Date: Thu,  7 Jul 2022 10:40:58 -0700
In-Reply-To: <20220704101926.0000504d.zbestahu@gmail.com>
Message-Id: <20220707174058.1577159-1-zhangkelvin@google.com>
Mime-Version: 1.0
References: <20220704101926.0000504d.zbestahu@gmail.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3] erofs-utils: Make --mount-point option generally available
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
index 0d0916c..2daf46c 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -67,8 +67,8 @@ struct erofs_configure {
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
index 71ffe3e..c8ce278 100644
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
index d2c9830..deb8e1f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -51,8 +51,8 @@ static struct option long_options[] = {
 	{"blobdev", required_argument, NULL, 13},
 	{"ignore-mtime", no_argument, NULL, 14},
 	{"preserve-mtime", no_argument, NULL, 15},
-#ifdef WITH_ANDROID
 	{"mount-point", required_argument, NULL, 512},
+#ifdef WITH_ANDROID
 	{"product-out", required_argument, NULL, 513},
 	{"fs-config-file", required_argument, NULL, 514},
 	{"block-list-file", required_argument, NULL, 515},
@@ -105,9 +105,9 @@ static void usage(void)
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
@@ -323,7 +323,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 10:
 			cfg.c_compress_hints_file = optarg;
 			break;
-#ifdef WITH_ANDROID
 		case 512:
 			cfg.mount_point = optarg;
 			/* all trailing '/' should be deleted */
@@ -331,6 +330,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt && optarg[opt - 1] == '/')
 				optarg[opt - 1] = '\0';
 			break;
+#ifdef WITH_ANDROID
 		case 513:
 			cfg.target_out_path = optarg;
 			break;
-- 
2.37.0.rc0.161.g10f37bed90-goog

