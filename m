Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8827BC4C
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Sep 2020 07:14:24 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C0ncY4jLMzDqLM
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Sep 2020 15:14:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1601356461;
	bh=En9RRrD50OTQHjyZ52STrW15BSFRvxU3LRB/WbAdWUE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=d9lm4HThf3HFk//86NrL7dhnzfYGk7az4x2gS7cz0hyxVUoJMWK3JMi84SE+5vOUY
	 alD5yWqyuqDRrDkDef5BluKSPKWJ8oLNl4WeZEr2HUcMXjvBiJ7oLVxh9quxdPzS9Q
	 CbqlRHMp77qWX9WEaVFlyVZB5gFnbyC7JaMDDYXIcSS07wK5a7KDloFshQrgumSGCq
	 LeluKSTAYVccd82xN2RGoYuuXBF1xb1Cao011NOi2TyoREr+Or3uOdWOnEGrU9TOo8
	 rRMw1ZyGGV4WR3wAALJgL1vujyMT7yaMXD8VEndeZh1qBS5+jCKLfYNA572xNnVTeD
	 OPQmLPUEbCh1A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=74.6.134.42; helo=sonic307-3.consmr.mail.bf2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=UOFrPkEv; dkim-atps=neutral
Received: from sonic307-3.consmr.mail.bf2.yahoo.com
 (sonic307-3.consmr.mail.bf2.yahoo.com [74.6.134.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0ncH5L70zDqRS
 for <linux-erofs@lists.ozlabs.org>; Tue, 29 Sep 2020 15:14:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1601356439; bh=bgroKHkgLxOGROeK2iAWmrhhGpW//lwsr7p8kkKX1/8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=UOFrPkEv3oq0z/6zQ+Uq075HlwGe6FiNf8XnwsMX6B+EuG+6V/ujZF9VqGHoaTuTHpYHroTjiw0UdLlgASZ8iFQWwmsC8i9ze5pVb+zb+BHr3IofIIK/YIs65P/QOGl/Id8EPa+OFpCZq15Kxuv4z/G69hRF162MT2FyIdzM0nqHgHPzgoDnh+ii6i3JdHzXyN7JvheT2eofPr9ZRYdH3q8NlAOWt6G/0aHkrcyDiyyqK/2LmCoAHOI/lTkJ7HxIJVDvpQuGJf96u5HZMfXVEpnw0ELMviSx6KhhmNpKo0p5oHuQ84nY3/UiT1TZRihbjXcOufVbKWfRze/fHhLeAA==
X-YMail-OSG: EGz1CBMVM1k_.iKfI9XYKYOD8JCqgipz_oJc36R2QAzhjjzAHdSCKQrD7VQczJX
 deYbC5x2v4ZwOmp1QkOUoN4dazIw.TVaO19iyuwkyRrimJjGLzw9vRBS.aPTcnFIIBMxWd_sLfmy
 LNcCPwKGXBvPg8B1fqStBcTfdT_0cJVXGdD7K4jdm0JwyjSyU6YYeffDik4CV5rEYZIfIcRKdq5b
 sruOcMzp2qqBU5n3IgDp.n69uriW4jrZWQJUQ_cDMEibsY6hltT_zHDRHzZBw6Vn5PXHaGGl59Yk
 ha7RCFo2oY6UQmCCaX4hXLHHVc1p6uHMqVuetbleauKqXkVy6mTYONJyeB77mV6ZPOwD_f7FmxMj
 _cBXInOIKo61Ey4AjyuEmYVCkE2wm4r.oj2ZBOo.95dj4umEWHcOMWbAX6dtbtzcjf4BNf2z53xe
 wtuvWmpg8Nvlv34SXhagjbDwfqQDQRC0XxZ2DuPgYfCEmVwo.YjJ2F8u5FZ4_QMRAhPPwMrMDhMU
 U8CbmsJd2umHjlAmDptaSSWRl_f3nhKjlHQxHH8XNcrErsWwOAmqWMFhVTc.ErFtjoWXI0koYpNI
 66uEd5pe0M.j.tI0b02ipZ_zVaR9Yy4fXKQQsCy_T633SrARS9HGSoLU2MjmvM3JeFOrC86_Vaz.
 JVTjnKxVA4_0NcGYl3mRLna3Q6BGy8QBVOqVLJsdD1n5r3lfkcPsKEmw0JF4FHGPdNGQUX9EGVRt
 a0ELBobWOSWzma7XM6RUcYImXvYIL1_17x_ZZH0O9e17Bwr0sQS_OT5IEin5SFzkfBcV514eFX0l
 LsIaCCM7c3fDCHRvLMnKSiAuGkNjxhbdAt2h6a0Zk4yNC0dj_Fhp7Nt8RhwSvKyKDxn7idGnes5y
 wLiWS7Oh7aaaSqKIfUK18z63PltgEAEzf81kTFAMFeV4NA6qJxu5fjZR3b0PS2YK0cgXi7y9.238
 jdMSV3BwMY1JZZVfClFgfJkL7hkKQ65VaLEF7hqw7zWIQW5tZEX5Jj_WXDHaeIwQHfGcTKrHCVg.
 m5ABmDO6vZ5_HdxeH55gMnTeKh4.31.l69TiJ7JeNHNAhXYiT4JmXZcWRN5nQm54TUiwe_AMa00l
 9uwLKrn4NUNsSl8eOFn90GD.uf0_uDVnc5DvhkGx_82OO6AEayS1ExRrt5agDstJiVdhbseV08hG
 5daOzsdbS5AihZGSpQl6TQsOycivyxtZ5bqZATdm8wXLIwcUNipUNHUGcScEKc.LGafDylqrKkkE
 T_arU6JYrTvTV9hRInypAgPz0GRmzKFPMrUyUHpZxYGtMpmfzJvjwrrnUrkMrtgUVISPRlcIcBx_
 K48iolDSro_h1PhTUNiA1ZYPtkenXoOKktqypDkFoZWpo_rZ1m7jLYuB8Afiz0e6_vuZAbAb7Se8
 iV1N5q3Hs3fa7ZOJlQEBkDLUKmCViq6IKb3DSDlunw.Zs.CYGZJgmxlg9WMCubvZYYp0s8XvCw5K
 Y9jFUWHUQ_f5vA65DatY5KvEz9246Q9Nu_ZTh13q86jxxZAiQO0mVovuvENI3szOagaYcI.sU1R8
 hz6dC
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.bf2.yahoo.com with HTTP; Tue, 29 Sep 2020 05:13:59 +0000
Received: by smtp418.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 4354cc514133cd59613c22c5b8d4c80c; 
 Tue, 29 Sep 2020 05:13:52 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] AOSP: erofs-utils: add fs_config support
Date: Tue, 29 Sep 2020 13:13:02 +0800
Message-Id: <20200929051302.3324-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200928213549.17580-1-hsiangkao@aol.com>
References: <20200928213549.17580-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

So that mkfs can directly generate images with fs_config.
All code for AOSP is wraped up with WITH_ANDROID macro.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v1:
 - fix compile issues on Android / Linux build;
 - tested with Android system booting;

 include/erofs/config.h   | 12 ++++++++++
 include/erofs/internal.h |  3 +++
 lib/inode.c              | 49 +++++++++++++++++++++++++++++++++++++
 lib/xattr.c              | 52 ++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              | 29 +++++++++++++++++++++-
 5 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 2f0974900be1..9902a089ab46 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -17,6 +17,13 @@
 #include <selinux/label.h>
 #endif
 
+#ifdef WITH_ANDROID
+#include <selinux/android.h>
+#include <private/android_filesystem_config.h>
+#include <private/canned_fs_config.h>
+#include <private/fs_config.h>
+#endif
+
 enum {
 	FORCE_INODE_COMPACT = 1,
 	FORCE_INODE_EXTENDED,
@@ -40,6 +47,11 @@ struct erofs_configure {
 	/* < 0, xattr disabled and INT_MAX, always use inline xattrs */
 	int c_inline_xattr_tolerance;
 	u64 c_unix_timestamp;
+#ifdef WITH_ANDROID
+	char *mount_point;
+	char *target_out_path;
+	char *fs_config_file;
+#endif
 };
 
 extern struct erofs_configure cfg;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 41da189ffac1..bc77c43719e8 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -127,6 +127,9 @@ struct erofs_inode {
 
 	void *idata;
 	void *compressmeta;
+#ifdef WITH_ANDROID
+	uint64_t capabilities;
+#endif
 };
 
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
diff --git a/lib/inode.c b/lib/inode.c
index 5013184e66bf..597cbc7fc6dd 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -673,10 +673,59 @@ static u32 erofs_new_encode_dev(dev_t dev)
 	return (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
 }
 
+#ifdef WITH_ANDROID
+int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
+			       struct stat64 *st,
+			       const char *path)
+{
+	/* filesystem_config does not preserve file type bits */
+	mode_t stat_file_type_mask = st->st_mode & S_IFMT;
+	unsigned int uid = 0, gid = 0, mode = 0;
+	char *fspath;
+
+	inode->capabilities = 0;
+	if (cfg.fs_config_file)
+		canned_fs_config(erofs_fspath(path),
+				 S_ISDIR(st->st_mode),
+				 cfg.target_out_path,
+				 &uid, &gid, &mode, &inode->capabilities);
+	else if (cfg.mount_point) {
+		if (asprintf(&fspath, "%s/%s", cfg.mount_point,
+			     erofs_fspath(path)) <= 0)
+			return -ENOMEM;
+
+		fs_config(fspath, S_ISDIR(st->st_mode),
+			  cfg.target_out_path,
+			  &uid, &gid, &mode, &inode->capabilities);
+		free(fspath);
+	}
+	st->st_uid = uid;
+	st->st_gid = gid;
+	st->st_mode = mode | stat_file_type_mask;
+
+	erofs_dbg("/%s -> mode = 0x%x, uid = 0x%x, gid = 0x%x, "
+		  "capabilities = 0x%" PRIx64 "\n",
+		  erofs_fspath(path),
+		  mode, uid, gid, inode->capabilities);
+	return 0;
+}
+#else
+static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
+				      struct stat64 *st,
+				      const char *path)
+{
+	return 0;
+}
+#endif
+
 int erofs_fill_inode(struct erofs_inode *inode,
 		     struct stat64 *st,
 		     const char *path)
 {
+	int err = erofs_droid_inode_fsconfig(inode, st, path);
+	if (err)
+		return err;
+
 	inode->i_mode = st->st_mode;
 	inode->i_uid = st->st_uid;
 	inode->i_gid = st->st_gid;
diff --git a/lib/xattr.c b/lib/xattr.c
index 769ab9c716d0..b9ac223cc746 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -196,6 +196,12 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		unsigned int len[2];
 		char *kvbuf, *fspath;
 
+#ifdef WITH_ANDROID
+		if (cfg.mount_point)
+			ret = asprintf(&fspath, "/%s/%s", cfg.mount_point,
+				       erofs_fspath(srcpath));
+		else
+#endif
 		ret = asprintf(&fspath, "/%s", erofs_fspath(srcpath));
 		if (ret <= 0)
 			return ERR_PTR(-ENOMEM);
@@ -352,6 +358,48 @@ err:
 	return ret;
 }
 
+#ifdef WITH_ANDROID
+static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
+{
+	const u64 capabilities = inode->capabilities;
+	char *kvbuf;
+	unsigned int len[2];
+	struct vfs_cap_data caps;
+	struct xattr_item *item;
+
+	if (!capabilities)
+		return 0;
+
+	len[0] = sizeof("capability") - 1;
+	len[1] = sizeof(caps);
+
+	kvbuf = malloc(len[0] + len[1]);
+	if (!kvbuf)
+		return -ENOMEM;
+
+	memcpy(kvbuf, "capability", len[0]);
+	caps.magic_etc = VFS_CAP_REVISION_2 | VFS_CAP_FLAGS_EFFECTIVE;
+	caps.data[0].permitted = (u32) capabilities;
+	caps.data[0].inheritable = 0;
+	caps.data[1].permitted = (u32) (capabilities >> 32);
+	caps.data[1].inheritable = 0;
+	memcpy(kvbuf + len[0], &caps, len[1]);
+
+	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+	if (IS_ERR(item))
+		return PTR_ERR(item);
+	if (!item)
+		return 0;
+
+	return erofs_xattr_add(&inode->i_xattrs, item);
+}
+#else
+static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
+{
+	return 0;
+}
+#endif
+
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 {
 	int ret;
@@ -366,6 +414,10 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 	if (ret < 0)
 		return ret;
 
+	ret = erofs_droid_xattr_set_caps(inode);
+	if (ret < 0)
+		return ret;
+
 	if (list_empty(ixattrs))
 		return 0;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 94bf1e6a2425..191003409b2f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -35,6 +35,11 @@ static struct option long_options[] = {
 	{"exclude-regex", required_argument, NULL, 3},
 #ifdef HAVE_LIBSELINUX
 	{"file-contexts", required_argument, NULL, 4},
+#endif
+#ifdef WITH_ANDROID
+	{"mount-point", required_argument, NULL, 10},
+	{"product-out", required_argument, NULL, 11},
+	{"fs-config-file", required_argument, NULL, 12},
 #endif
 	{0, 0, 0, 0},
 };
@@ -210,7 +215,21 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			if (opt && opt != -EBUSY)
 				return opt;
 			break;
-
+#ifdef WITH_ANDROID
+		case 10:
+			cfg.mount_point = optarg;
+			/* all trailing '/' should be deleted */
+			opt = strlen(cfg.mount_point);
+			if (opt && optarg[opt - 1] == '/')
+				optarg[opt - 1] = '\0';
+			break;
+		case 11:
+			cfg.target_out_path = optarg;
+			break;
+		case 12:
+			cfg.fs_config_file = optarg;
+			break;
+#endif
 		case 1:
 			usage();
 			exit(0);
@@ -404,6 +423,14 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
+#ifdef WITH_ANDROID
+	if (cfg.fs_config_file &&
+	    load_canned_fs_config(cfg.fs_config_file) < 0) {
+		erofs_err("failed to load fs config %s", cfg.fs_config_file);
+		return 1;
+	}
+#endif
+
 	erofs_show_config();
 	erofs_set_fs_root(cfg.c_src_path);
 
-- 
2.24.0

