Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD05B9B2B
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 14:43:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MSxgl2QHhz2yYj
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Sep 2022 22:42:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wGL+P0An;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=wGL+P0An;
	dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MSxgg21rzz3bvZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 22:42:54 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so22222811pjq.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Sep 2022 05:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dBZRlmedpxhbheR4+YN0HocAk5E9pqe8yTyKp+a8Jvo=;
        b=wGL+P0AnD/GNLjjT24uVsLIZwCjtnS68EAO2WcfTxZFkhvVT/imehV4PqGdD9u11lo
         mHxyBtFq9duyXZIiKcqegXgI67PQGZyv1FARnxfLtJPl//LGhPBirrHxsHZMHRB9DLAz
         Wb7SJ6apxY7SF8Pc2g4Gg9+1s6+QI4I1vJhNBvhqpUPnYW8DdTU5YdGxp5D1QKIZck9/
         L6U90aBZFVaRvvbGZrdF+ClZ5VxK0ZlwgZF9Wnhn6CBxbM6PAoQhJS5v/pkDOz2mIlAa
         Su3CDhC0H6wTECs2IS+AbHhCLSS2SpIfTFUYeIOdDAxrJ+UmNxGT+M5DuFAWmGzDqJWT
         +yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dBZRlmedpxhbheR4+YN0HocAk5E9pqe8yTyKp+a8Jvo=;
        b=0cDx3ZNh+yxozTgaBMf/p0N23s5zmhAfWCvmNI3578g6MGeGlNAoaTJ2za1yP0/ykp
         eEOldG580hZ0byKIFyVctf/oEwvMd10KFzecIoPPFDY9R77R82w17vr4rGWZ8/85QeXF
         RwpO7KCpnO5ijpT4bvqWKvsctPqXgacvneX98Gp2Da1aUGxvThIBRqxeLRkoNwBgc7+d
         xPhmEbDUKh69xtvwNgrHyo0S4lTgsjAuYqn1mrNCH8FsqTPb5JEfXok/gf+O+hgoUeSj
         4jf7UYwDYvUSUxCkHdXQmQRXjaYK3tfWpDKUK/pe6UPkQs25V5ZiITAoyGEH6bQFxBnK
         KFUQ==
X-Gm-Message-State: ACrzQf1R657v0r+2x2p8Tlpl6hJ9grW2oVIsOO0I1om/pcoNA55Y8XGj
	5UjeVkiogwYT+l93hPiV4/vR2L+Q2L6pWg==
X-Google-Smtp-Source: AMsMyM7YeUekbjwUyKbeSAZ971uM0weIsXJ7+N2Y2Xx6JX3tiNRAUFd1xpMZLNwBX63dFYLT7STQeg==
X-Received: by 2002:a17:903:22c9:b0:178:18a1:d170 with SMTP id y9-20020a17090322c900b0017818a1d170mr4343590plg.2.1663245772723;
        Thu, 15 Sep 2022 05:42:52 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:52 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH V4 6/6] erofs: introduce 'domain_id' mount option
Date: Thu, 15 Sep 2022 20:42:13 +0800
Message-Id: <20220915124213.25767-7-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220915124213.25767-1-zhujia.zj@bytedance.com>
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Introduce 'domain_id' mount option to enable shared domain sementics.
In which case, the related cookie is shared if two mountpoints in the
same domain have the same data blob. Users could specify the name of
domain by this mount option.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/super.c | 17 +++++++++++++++++
 fs/erofs/sysfs.c | 19 +++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 24bac58285e8..5e55c4fe6220 100644
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
@@ -702,6 +714,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
 	ctx->opt.fsid = NULL;
+	ctx->opt.domain_id = NULL;
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
@@ -846,6 +859,7 @@ static void erofs_fc_free(struct fs_context *fc)
 
 	erofs_free_dev_context(ctx->devs);
 	kfree(ctx->opt.fsid);
+	kfree(ctx->opt.domain_id);
 	kfree(ctx);
 }
 
@@ -914,6 +928,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi->opt.fsid);
+	kfree(sbi->opt.domain_id);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 }
@@ -1067,6 +1082,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
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

