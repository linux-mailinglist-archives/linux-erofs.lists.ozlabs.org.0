Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E935AA689
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 05:48:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJkQq2Yrxz2ywr
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 13:48:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=uoOW6bcl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=uoOW6bcl;
	dkim-atps=neutral
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJkQh3dcVz2xHw
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 13:48:12 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id x19so729542pfr.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Sep 2022 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WSGy8JuZtB1pyuGGOt6vRdCmNn8tUcEetPk/ksDWFKg=;
        b=uoOW6bcl6RtfcvUNGAzF3eBXUSnhzNeqa2/5IKqnYGuPXVG8r8nlL4wxGRe+sk3M4Z
         IAdtYQ99fwooUd3zbaqWKtPFMGu2L4bOH74p8eK+3u/ueKoYT6GjvaPShbc7hrNparsf
         Bx5rllYY4/mskWSF8BAgp2zsWJxV31F8E8/EqJ0VERaxF8qcN/ykemcRfWEd3G1t0AeS
         DytOCSWfSsmj3STRD59JDeFG8L94o3TW/2LBy8+gOW3pXQXIi9HBLKzCf4XM0JT2VpXB
         eXSIURVZvQ/Fk8O4Lakcn0UZ+Ui7amN4YMzPUgioUHTLubgjACQM0psnzql6AQXQbIDm
         zRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WSGy8JuZtB1pyuGGOt6vRdCmNn8tUcEetPk/ksDWFKg=;
        b=Mkpg8+GTVl+3iukiG9U574v7GBMKMwwo/SbXKox3kPZnM7FKhyxUzyjLtv34kqHmS6
         h6Yiv6pfPWCYpGDJamAptu0dFR+fp9rFQmkb+lHDbKxRNgCaBOoZGXsFEWTXY9L/rIJE
         jeYD2bE6wUDSfhhSxYco9pNx9dIPAXER2tAPAhdOat0KP/ahPV+A2Y1cJ54wJU8K011G
         UUCkhW/y0xpbMk4qM8RXxGIkZcKk6wz728Vu4orc3zxZHW4JTeKl0he9eV5cG+FaQJrU
         jkXbJ5ZQdfwgQBsALAvCw8lkXcqTLAdiFtwllPVw6X+MGYuTlbfgCOLBPHRFlFjk5R8t
         bR0A==
X-Gm-Message-State: ACgBeo37le6nZc0rfLzLvh0T6w5k/WlsrwQyrHrJML6NdjB8+tZv+JgA
	3hs7rDG0YVxEYlAwx61UCKsOQKwpwoUmKw==
X-Google-Smtp-Source: AA6agR719fHTfgbHSij3HF/dWARZZDG0+3rBj8Dvp42dtKJaHuVEh8AKkoiefZfPBZysg23ZR7hUtw==
X-Received: by 2002:a05:6a00:1353:b0:53a:80d6:6f72 with SMTP id k19-20020a056a00135300b0053a80d66f72mr14721169pfu.32.1662090489857;
        Thu, 01 Sep 2022 20:48:09 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm376152plg.128.2022.09.01.20.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:48:09 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V1 1/5] erofs: add 'domain_id' mount option for on-demand read sementics
Date: Fri,  2 Sep 2022 11:47:44 +0800
Message-Id: <20220902034748.60868-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902034748.60868-1-zhujia.zj@bytedance.com>
References: <20220902034748.60868-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-fsdevel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce 'domain_id' mount option to enable shared domain sementics.
In which case, the related cookie is shared if two mountpoints in the
same domain have the same data blob. Users could specify the name of
domain by this mount option.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..fe435d077f1a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -76,6 +76,7 @@ struct erofs_mount_opts {
 #endif
 	unsigned int mount_opt;
 	char *fsid;
+	char *domain_id;
 };
 
 struct erofs_dev_context {
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3173debeaa5a..d01109069c6b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -440,6 +440,7 @@ enum {
 	Opt_dax_enum,
 	Opt_device,
 	Opt_fsid,
+	Opt_domain_id,
 	Opt_err
 };
 
@@ -465,6 +466,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_enum("dax",		Opt_dax_enum, erofs_dax_param_enums),
 	fsparam_string("device",	Opt_device),
 	fsparam_string("fsid",		Opt_fsid),
+	fsparam_string("domain_id",	Opt_domain_id),
 	{}
 };
 
@@ -568,6 +570,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 			return -ENOMEM;
 #else
 		errorfc(fc, "fsid option not supported");
+#endif
+		break;
+	case Opt_domain_id:
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		kfree(ctx->opt.domain_id);
+		ctx->opt.domain_id = kstrdup(param->string, GFP_KERNEL);
+		if (!ctx->opt.domain_id)
+			return -ENOMEM;
+#else
+		errorfc(fc, "domain_id option not supported");
 #endif
 		break;
 	default:
@@ -695,6 +707,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
 	ctx->opt.fsid = NULL;
+	ctx->opt.domain_id = NULL;
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
@@ -838,6 +851,7 @@ static void erofs_fc_free(struct fs_context *fc)
 
 	erofs_free_dev_context(ctx->devs);
 	kfree(ctx->opt.fsid);
+	kfree(ctx->opt.domain_id);
 	kfree(ctx);
 }
 
@@ -892,6 +906,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
+	kfree(sbi->opt.domain_id);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -1044,6 +1059,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (opt->fsid)
 		seq_printf(seq, ",fsid=%s", opt->fsid);
+	if (opt->domain_id)
+		seq_printf(seq, ",domain_id=%s", opt->domain_id);
 #endif
 	return 0;
 }
-- 
2.20.1

