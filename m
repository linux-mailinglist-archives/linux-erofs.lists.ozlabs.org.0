Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C05AACDF
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 12:54:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJvtY0n08z2yZ4
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Sep 2022 20:54:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=KfcOYHlp;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bytedance.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=zhujia.zj@bytedance.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=KfcOYHlp;
	dkim-atps=neutral
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJvtS2ZkCz303C
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Sep 2022 20:54:24 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id jm11so1441738plb.13
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Sep 2022 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=KfcOYHlpWUeIQt9wkes3QakVS8YddcaWQ6Bp5getgWzzyA5QFGXOB01D4Byg8lDNNW
         QJg3+kZ6nXoSJBy2v3dhYD1T2kqsSGg5SQiljr0FiaoOuSKdsR7f/X1KTvjGyVHQ+bIC
         O7ISw/1864yQHYOFSpM7dVvue4o8mdxEbkQacl82pj3Ul7D7y2pAcmVL4dJcWuepptl3
         0nGPQwcoFuiQ3GnBeI5ahRZjWWn2SLY8uhs3KHX/7rCbDGiR2l1kSFm+8or5p3kYoAGu
         /AHtra/ixW7Cx6Q/R6PZaQvT8b0cU3bezv/5Lkle8JRQb3GSnRLu1sZWWMxph6Jo3Yt5
         1xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=PT9vkCSlPS2WQa7ZFNnPCe4i+k7rBaOcUPMRNIifsB3BwQBF6cL6SdDlCydvfDzzui
         Kn5AlPHsKe0gREoMLThlZ3Efsm39bKyi1If9Vk/MHbOjb20eroGJ7vbYVjLfTGr+DIxH
         +yFRwzCfLta1j49LVdHxBo+9K+wcG4BGP6q4VRmk9jk6fkmI0wy67ktxvomrWH1ZhqNQ
         Ci6qaPsZC+XKfvu03vAK9WnbWS3H1EKVEa7F5AELq/2nzhDyD3adZmzRUZ9ycam4Yixz
         K63UvQx4Xoww98NjksYQFFgO/kTZxDeaQc2fJ/3dpb1w/OBq8I31B9ri2ViAWUYeE3Yp
         cvXQ==
X-Gm-Message-State: ACgBeo2lUQ0wAM1fBbRxqL2GhLe7BEKG/P5bGzfmcMZ4QnAL8Zep6o4Q
	BLd0BrNmNLq06PfBwMgabu0lrg14owr+6w==
X-Google-Smtp-Source: AA6agR5CbDJIoLJsxTWDazQnnhaRRZ4gyoM6tAijLRSZKvM0KW8YTXmAGSJZKg4IxsUEjuUkRPQdzw==
X-Received: by 2002:a17:903:1106:b0:172:9801:cb96 with SMTP id n6-20020a170903110600b001729801cb96mr34926139plh.91.1662116061708;
        Fri, 02 Sep 2022 03:54:21 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a63d944000000b0041b29fd0626sm1128681pgj.88.2022.09.02.03.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:54:21 -0700 (PDT)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH V2 3/5] erofs: add 'domain_id' prefix when register sysfs
Date: Fri,  2 Sep 2022 18:53:03 +0800
Message-Id: <20220902105305.79687-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902105305.79687-1-zhujia.zj@bytedance.com>
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
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

In shared domain mount procedure, add 'domain_id' prefix to register
sysfs entry. Thus we could distinguish mounts that don't use shared
domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c1383e508bbe..c0031d7bd817 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -201,12 +201,21 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	char *name = NULL;
 	int err;
 
+	if (erofs_is_fscache_mode(sb)) {
+		name = kasprintf(GFP_KERNEL, "%s%s%s", sbi->opt.domain_id ?
+				sbi->opt.domain_id : "", sbi->opt.domain_id ? "," : "",
+				sbi->opt.fsid);
+		if (!name)
+			return -ENOMEM;
+	}
 	sbi->s_kobj.kset = &erofs_root;
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
-			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
+			name ? name : sb->s_id);
+	kfree(name);
 	if (err)
 		goto put_sb_kobj;
 	return 0;
-- 
2.20.1

