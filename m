Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E155D2A0571
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 13:32:05 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CN1sF5QcZzDqw1
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Oct 2020 23:32:01 +1100 (AEDT)
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
 header.s=mimecast20190719 header.b=NBOlJuq+; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PL/+icVu; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CN1s413gBzDqkf
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 23:31:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=C2zFR/89Gfij4ddocT0gX7ckNBVVfpu4PsnOHhSFzk8=;
 b=NBOlJuq+dJXljXh093gK6LVmacK94rwBZkdDpQpeo3fUSq2RTfzNFBmww37mN87rcE7/KO
 bqbLdJdt3kZRa4sxmvWvRX61Jpvq9VPPQFL2EnNm9I+CketKEQmbrwdEyYgr2ibBKbIgEA
 e/lFrJ8puKYgmvXZ2nW48AkPbxHj9U0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604061109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=C2zFR/89Gfij4ddocT0gX7ckNBVVfpu4PsnOHhSFzk8=;
 b=PL/+icVu8pQYCnfaQc5X6jKL2uJ7Yeftp32yoSWxSIdemtrJBtcN2a0g3Ig0y4Ck69nQMP
 z6PPSt2OzIXV5u5ba0M35+GcWISEZzf4iMRe4TFNrac+3H7HQIuaFEMYOZxbDejgscGQRZ
 GVHTwgtnz9e8drji3EElsUsssLZrkcA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-AKqdRUVTNquiY-mHkz6J4w-1; Fri, 30 Oct 2020 08:31:43 -0400
X-MC-Unique: AKqdRUVTNquiY-mHkz6J4w-1
Received: by mail-pg1-f200.google.com with SMTP id e16so4548759pgm.1
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Oct 2020 05:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C2zFR/89Gfij4ddocT0gX7ckNBVVfpu4PsnOHhSFzk8=;
 b=kpgevhKagBdT54OCT84T64vc1w1nut3UX0EGF7oHcQWxCoWEB9E4Q6Fx7CPsneO5Y6
 DvYjhio1CA/i9eo9MfmvNSElZCzSsRmq0l1hlRmiKsZxWBnYTsX0WaqyaMQwuKFKu1jn
 QzmepCShyvxqldDsSj5KFuewEyWYFupe56Se3r2h2ktuhI6V9KN2/22Xyd7IsWKP9Sty
 rkDaksia0X+bcXJCzHudnGIWftD7jHaNINfCcsFOl1HXvc6EfwHHDUyZdHEGiQsNVmha
 uQzj8tKNsBHxo3oQJilcgEZzIZoG2fA2EYbsCnXfoNwi5U26M/vuHtycktU67fRMYnT9
 5sXw==
X-Gm-Message-State: AOAM532JLX48O1E8+Ik40I3vVLO1B2iXuzxfXbLEw0Dp+uGEpL2uteND
 tLvqCL+sb1J/oxmdhbb4P3nXoJhetTHluNvb3gMp2ZCA6wfeAX2k2wF87dC17nCNp7dPgZY0sPj
 Vh57vtzMkEIJ/Va8K7u6+e1Tv
X-Received: by 2002:a62:7695:0:b029:152:3ddd:24a3 with SMTP id
 r143-20020a6276950000b02901523ddd24a3mr8682780pfc.2.1604061102557; 
 Fri, 30 Oct 2020 05:31:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6x09uf8UxE7ju7U5JsLva9ECE1OiU4xcY/9/3anOe+9xAwxgkgEOHo1qf4O0yctfv9XHkCg==
X-Received: by 2002:a62:7695:0:b029:152:3ddd:24a3 with SMTP id
 r143-20020a6276950000b02901523ddd24a3mr8682761pfc.2.1604061102348; 
 Fri, 30 Oct 2020 05:31:42 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b128sm5415458pga.80.2020.10.30.05.31.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 05:31:42 -0700 (PDT)
From: Gao Xiang <hsiangkao@redhat.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs-utils: support $SOURCE_DATE_EPOCH
Date: Fri, 30 Oct 2020 20:30:18 +0800
Message-Id: <20201030123020.133084-2-hsiangkao@redhat.com>
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

Currently, we use -T to set a given UNIX timestamp for all
files, yet reproducible builds [1] requires what is called
"timestamp clamping", IOW, a timestamp must be used no later
than the value of this variable.

Let's support $SOURCE_DATE_EPOCH as well.

[1] https://reproducible-builds.org/specs/source-date-epoch/
Suggested-by: nl6720 <nl6720@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 include/erofs/config.h |  7 +++++++
 lib/inode.c            | 15 +++++++++++++--
 mkfs/main.c            | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index e425ce2..02ddf59 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -29,11 +29,18 @@ enum {
 	FORCE_INODE_EXTENDED,
 };
 
+enum {
+	TIMESTAMP_NONE,
+	TIMESTAMP_FIXED,
+	TIMESTAMP_CLAMPING,
+};
+
 struct erofs_configure {
 	const char *c_version;
 	int c_dbg_lvl;
 	bool c_dry_run;
 	bool c_legacy_compress;
+	char c_timeinherit;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/lib/inode.c b/lib/inode.c
index 5695bbc..fee5c96 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -729,8 +729,19 @@ int erofs_fill_inode(struct erofs_inode *inode,
 	inode->i_mode = st->st_mode;
 	inode->i_uid = st->st_uid;
 	inode->i_gid = st->st_gid;
-	inode->i_ctime = sbi.build_time;
-	inode->i_ctime_nsec = sbi.build_time_nsec;
+	inode->i_ctime = st->st_ctime;
+	inode->i_ctime_nsec = st->st_ctim.tv_nsec;
+
+	switch (cfg.c_timeinherit) {
+	case TIMESTAMP_CLAMPING:
+		if (st->st_ctime < sbi.build_time)
+			break;
+	case TIMESTAMP_FIXED:
+		inode->i_ctime = sbi.build_time;
+		inode->i_ctime_nsec = sbi.build_time_nsec;
+	default:
+		break;
+	}
 	inode->i_nlink = 1;	/* fix up later if needed */
 
 	switch (inode->i_mode & S_IFMT) {
diff --git a/mkfs/main.c b/mkfs/main.c
index 6dda9e3..5c41fc0 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -198,6 +198,7 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 				erofs_err("invalid UNIX timestamp %s", optarg);
 				return -EINVAL;
 			}
+			cfg.c_timeinherit = TIMESTAMP_FIXED;
 			break;
 		case 2:
 			opt = erofs_parse_exclude_path(optarg, false);
@@ -381,6 +382,33 @@ static void erofs_mkfs_generate_uuid(void)
 	erofs_info("filesystem UUID: %s", uuid_str);
 }
 
+/* https://reproducible-builds.org/specs/source-date-epoch/ for more details */
+int parse_source_date_epoch(void)
+{
+	char *source_date_epoch;
+	unsigned long long epoch = -1ULL;
+	char *endptr;
+
+	source_date_epoch = getenv("SOURCE_DATE_EPOCH");
+	if (!source_date_epoch)
+		return 0;
+
+	epoch = strtoull(source_date_epoch, &endptr, 10);
+	if (epoch == -1ULL || *endptr != '\0') {
+		erofs_err("Environment variable $SOURCE_DATE_EPOCH %s is invalid",
+			  source_date_epoch);
+		return -EINVAL;
+	}
+
+	if (cfg.c_force_inodeversion != FORCE_INODE_EXTENDED)
+		erofs_info("SOURCE_DATE_EPOCH is set, forcely generate extended inodes instead");
+
+	cfg.c_force_inodeversion = FORCE_INODE_EXTENDED;
+	cfg.c_unix_timestamp = epoch;
+	cfg.c_timeinherit = TIMESTAMP_CLAMPING;
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int err = 0;
@@ -405,6 +433,12 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+	err = parse_source_date_epoch();
+	if (err) {
+		usage();
+		return 1;
+	}
+
 	err = lstat64(cfg.c_src_path, &st);
 	if (err)
 		return 1;
-- 
2.18.1

