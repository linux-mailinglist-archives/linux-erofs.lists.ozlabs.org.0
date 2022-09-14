Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2CC5B86A3
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 12:51:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSHFB2zfzz3bc9
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Sep 2022 20:51:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=05u3YH9R;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=05u3YH9R;
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSHF42BlJz3bkm
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 20:51:04 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id fs14so14151209pjb.5
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Sep 2022 03:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=q3TsfZkeKJw5XNsDWUMmFDs6Gnk1XCvOAhXnXaSVyI4=;
        b=05u3YH9R0psRe49MO2FNU8/5dfjtU6+uA3PESMKlS7YdPzozmMNv6CugV4OxDP/9qa
         7XoEXoB3qcWpKYfZnhvS7qMIKQ6O29eYjYHE2HTXR6BhgbzG6FQpmmwIJzcKbE1d7pvx
         3DGyqwP+3s5UBMrH0K5OXRRcb0SBYu+G1eMuJXb9/ybkkUH41iO6yqo26f7Zz5GC42Pi
         8dzPXef/azuIbsGrG6WIxcrSlwv/r2YMGF2ViVMNyn1ehUXLHrXo0HS9mZSX/2HFioBJ
         fnHgiAMK/irWYa+C5+YiEhjlvG6iI9yoVNpw6dqtXSdpfps0lWx/L/3ePy1N+gMmPQep
         c6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q3TsfZkeKJw5XNsDWUMmFDs6Gnk1XCvOAhXnXaSVyI4=;
        b=xbVqzRwxYDOp6jOilzvBb7qpfuLvXgtwrhQRJ3cErufjNGvIdZkUR2YpYqeBkiZRFu
         KaFDRqDtwxKubjZ1gY7dfk99OoMy9pOreyArMbz2g8KWwXSyeDnxIhntWJZdH56dHiv5
         7QfYgF+bHP5AjJ0BcSAOew6XVEx9P0jAMlZGlK0EM8iEiyVfAYINhlWlnx/ElYtrOdJ0
         fnHPU90RkTvVxF8qCjp0lgBCQXVNYLMvLvAmJkBL2FKjViuCZ/iR5Z1Ys5/Iq2YELauw
         8JCvpZ5ZNTHJ86bD8QzK7ZEfr/bwKYQxrXd4TlBpIfrG6643pGwCuLbZFeYlN+DTQ9XG
         MQDA==
X-Gm-Message-State: ACrzQf1T3zCAgoQlEjFvpSMBARs1jdqsM7+zxmliVqivb0ZpSALSliQR
	th15RmcYHG6MU4wEJzRvxdwGBPM2QcQvz685L/6gNg==
X-Google-Smtp-Source: AA6agR7NDk5OHRM9Rd6OftgJi3/gHYY1TyxgEHCKEeThw53Wb1mA8mROSozj5Sh4+p9vi/4BBbPuig==
X-Received: by 2002:a17:90b:3808:b0:202:c5ba:d71b with SMTP id mq8-20020a17090b380800b00202c5bad71bmr4102692pjb.18.1663152661702;
        Wed, 14 Sep 2022 03:51:01 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:51:01 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V3 3/6] erofs: introduce 'domain_id' mount option
Date: Wed, 14 Sep 2022 18:50:38 +0800
Message-Id: <20220914105041.42970-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220914105041.42970-1-zhujia.zj@bytedance.com>
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
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
 fs/erofs/sysfs.c    | 19 +++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index aa71eb65e965..2d129c6b3027 100644
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
index 7aa57dcebf31..856758ee4869 100644
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
 
@@ -834,6 +847,7 @@ static void erofs_fc_free(struct fs_context *fc)
 
 	erofs_free_dev_context(ctx->devs);
 	kfree(ctx->opt.fsid);
+	kfree(ctx->opt.domain_id);
 	kfree(ctx);
 }
 
@@ -887,6 +901,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
+	kfree(sbi->opt.domain_id);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -1040,6 +1055,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (opt->fsid)
 		seq_printf(seq, ",fsid=%s", opt->fsid);
+	if (opt->domain_id)
+		seq_printf(seq, ",domain_id=%s", opt->domain_id);
 #endif
 	return 0;
 }
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c1383e508bbe..341fb43ad587 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -201,12 +201,27 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	char *name;
+	char *str = NULL;
 	int err;
 
+	if (erofs_is_fscache_mode(sb)) {
+		if (sbi->opt.domain_id) {
+			str = kasprintf(GFP_KERNEL, "%s,%s", sbi->opt.domain_id,
+					sbi->opt.fsid);
+			if (!str)
+				return -ENOMEM;
+			name = str;
+		} else {
+			name = sbi->opt.fsid;
+		}
+	} else {
+		name = sb->s_id;
+	}
 	sbi->s_kobj.kset = &erofs_root;
 	init_completion(&sbi->s_kobj_unregister);
-	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
-			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
+	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s", name);
+	kfree(str);
 	if (err)
 		goto put_sb_kobj;
 	return 0;
-- 
2.20.1

