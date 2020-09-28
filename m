Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id AED6E27B711
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Sep 2020 23:36:19 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C0bS035vwzDqPC
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Sep 2020 07:36:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1601328976;
	bh=2kUnqqyNOCSxHCyA0ZJ6wnqYZBX+/JSFEE1D6Q70Yfo=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=bfwqXIdPzo9nA7k2axaXvso2KPqrAjW9u2BKoHu+KL+JYrzfXSKOBbhbWR8kFiylq
	 6BLjrRgjg0+fU+sl3xk8BbhxHkq+4y5lOZoKHLBBjswoWY5XhgXxCyIpJuLzFUeiUH
	 C80Y85wpJg6P9945mIqgRzlC7BaIavz0+gNiy5Anolaymw7xbAvgfsK77/hrK3TdCi
	 svFw5KTeHGfBD7lvjQ4ud5fuL7CAwU71a7h7YgAO6R7Cp9MO4JOsDtLXgPg3JxxuFX
	 yISnmH/RPOCkpMiDdRf/Z577xcaM3eRgQjWu+PUZ12Lpxg4uY3qmFEtYzo+a1uNYI0
	 CyqYP1DjiuxLw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.83; helo=sonic314-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=mhigu0tA; dkim-atps=neutral
Received: from sonic314-20.consmr.mail.gq1.yahoo.com
 (sonic314-20.consmr.mail.gq1.yahoo.com [98.137.69.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C0bRq6hqNzDq9H
 for <linux-erofs@lists.ozlabs.org>; Tue, 29 Sep 2020 07:36:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1601328962; bh=rfrvzT6yKpIEUy1r+bHlvIaoKK07guh05ELArj5pTQ4=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=mhigu0tAjjVisw1BkIZ/IIagQ2ZYPvtT9dI4YsbA4WU4el6H3AZzfOgmOs6nS1LPqOceOdtMIFzN7nEKD+zB2i6UBPnMFs9vRAqsMfjWkQNxq9jrPpLUnH/KIDLak/mJISRDePI2HntIQA8S4fWgJnMrbglEjdNvKb43z8ENmXmmfmNSegxWPf5EE73NeNV5TCcrrfAeLvnAGN74L6Wbmgp0V32FGI22Efa8kvqDVH9tNau2HO+XFYsNbgc87rd5OeIZ8Zdye2rgjz6tfDUndfqrjYamdpK4q2TKyt80RFrLRZ+t6oS9Bfkq5xJRlwur+2oQ9WF7JBbb/tevf+w3Pw==
X-YMail-OSG: 06wvAZcVM1kTHS8mzXdPTx5HfrRDtcbmB7K2i52g_33V.59eikyi2.b98u8iFpa
 7INI9tRz..ItrQufuYXb6t7EAroY2wn0gcljEpR2snOH9iGXucXyHpQHaPN0XW7jfGkgUy5.RqvT
 5v8CdLNTZQ4Gcn56FMd_XH5RFhKAvQmPFjsyooz_VBi9ns5Nl3FPVx6ucQWT2UKYbHmrnNDVJcCC
 zBXwKa_bg3dTP1bw06unjUXii8YVr__qQNQ.j.RFC8LtnPbOeOdlpyDy.2cxLM0AOUEk_ks7wXJq
 D_6Yqqa7ZrUM0S2LhYNJhGYrFOeRpSHvCHFcxhQa7vTq1i.hCQJcSI4wcegLxHevtMmKnerbqwfC
 aETEgX5U9jeW3RukXza.t.fgchzlWmJ8I8rwBzAe5MQW04VO4b6OWPMY3G4iKLymrQgC_StTOSFJ
 jXpNhr2xylnkIKwayKkiNd7rHhRKyV.5NdgzCU4LUXXmMZLsvViaPoTD7mMcWO3F.YhtqVOGt.Fv
 pBv.HQ4uyiGFZwDXgz2LRPcU8VMcoxBHnlqKv1ihXof49icvvPQ09djAlaTq0gCPk02wpkHB85F5
 dgH4BRMZZdw3LnBeDrzeFhd574cbyz9AjgzS0Sd8jjbF18tEabE_rD59LVn2P.lb715.tUgpWVuV
 IcwHkSdfHtTO1Y6dLKLLSUOMksIQ1dCLl.8TO_DRf4N1Inqr7kOkaWMani4gimEo.Qk.rvGJkZ35
 UvFfTV7AsTcrg7CibrDegP1ref0oyTa5zgTlZbS23_2pLuSAaa9hUV971rsm12ezZzZTOerMl1dm
 Aq5Ol2j9tmHlNjkyswUg.OOwsBG1OHTZIsyICp5GPEj88k3wuXN6rUOvTI0LFYDn549Sp.kTgp5V
 CrF8F3QKidnwEmM__cPE5kSYYzkdkv2zkOQbB2uDJiokuDCZAVdIspEhBraKoJiKCZYIvfPkYA2h
 PcGrY0eOb4lFiQdHSmV9wpRdqGln1haCA2ENA9vx2P2oi3YtiThjpWbdtDdmyJWNH.t88QIpIguz
 rM30hQa1ID67HeDjzMW9.vPWabhXImSFHow3Mrv8uO4RWx0hnIsJdkbqQK5BgXeF1j19jW_8poUJ
 c_ERWha5pUBavT3BM9aY8MStfWre32ete.tSHFU.5NAXEkQyImx_9mL3HK0F5ln7xtclAQdoJyZo
 vGml6BdacBDokduYuXU7vw8dxFN3rlsJm.PYFtvwTtUZ_aD78CwboNcTFAmQvohcMqASYC_tqzk8
 .kH2rfMKD8ljMer_Jkc.B.1EvQXC8ts9Dz6jjfDVyibWBIve0rgtl9qsXc_Dg__UJFgOBkdbt0aP
 TpY8FdVGlDZFjAugM.f17auW5SSE9a81NWPz7eN0UJzCJZt8QKXWqRmTpSOD.bPLZM.8DjppEMF3
 RcWWezFXB30gRKtLkL1G1g.lU4yZiB6zTfBeh_9WXxHtRG_4TVXshw4fASae.RpcoRFj6l.1adsJ
 mHbnHp.0smdee6ddVqrF_vcvlRosjj3miJmw_qMiJmUQ-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Mon, 28 Sep 2020 21:36:02 +0000
Received: by smtp423.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 20389fb495f180cf0a8dc34cc16ae2db; 
 Mon, 28 Sep 2020 21:35:58 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH] AOSP: erofs-utils: add fs_config support
Date: Tue, 29 Sep 2020 05:35:49 +0800
Message-Id: <20200928213549.17580-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200928213549.17580-1-hsiangkao.ref@aol.com>
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
originated from:
https://github.com/hsiangkao/erofs-utils/commit/e30bee2993d35350406ed8b0e0bfd6e580edc734

with some cleanup, and haven't rebuilt with
Android environment yet.

 include/erofs/config.h   | 12 +++++++++
 include/erofs/internal.h |  3 +++
 lib/inode.c              | 49 +++++++++++++++++++++++++++++++++++
 lib/xattr.c              | 56 ++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              | 29 ++++++++++++++++++++-
 5 files changed, 148 insertions(+), 1 deletion(-)

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
index 769ab9c716d0..0986e4674d81 100644
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
@@ -352,6 +358,52 @@ err:
 	return ret;
 }
 
+#ifdef WITH_ANDROID
+static struct vfs_cap_data __set_caps(uint64_t capabilities)
+{
+	struct vfs_cap_data cap_data = {0};
+
+	if (capabilities == 0)
+		return cap_data;
+
+	cap_data.magic_etc = VFS_CAP_REVISION_2 | VFS_CAP_FLAGS_EFFECTIVE;
+	cap_data.data[0].permitted = (uint32_t) capabilities;
+	cap_data.data[0].inheritable = 0;
+	cap_data.data[1].permitted = (uint32_t) (capabilities >> 32);
+	cap_data.data[1].inheritable = 0;
+	return cap_data;
+}
+
+static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
+{
+	if (inode->capabilities) {
+		unsigned int len[2];
+		char *kvbuf;
+		struct vfs_cap_data caps;
+		struct xattr_item *item;
+
+		len[0] = sizeof("capability") - 1;
+		len[1] = sizeof(struct vfs_cap_data);
+		kvbuf = malloc(len[0] + len[1]);
+		if (!kvbuf)
+			return -ENOMEM;
+
+		memcpy(kvbuf, "capability", len[0]);
+		caps = __set_caps(inode->capabilities);
+		memcpy(kvbuf + len[0], &caps, len[1]);
+		item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+		if (IS_ERR(item))
+			return PTR_ERR(item);
+		if (item) {
+			ret = erofs_xattr_add(ixattrs, item);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+#endif
+
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 {
 	int ret;
@@ -366,6 +418,10 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
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

