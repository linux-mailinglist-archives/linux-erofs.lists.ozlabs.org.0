Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9D1FC760
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2020 09:28:34 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mxWN01ZTzDqsN
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2020 17:28:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1592378912;
	bh=QhOv+3eSK5V9tGxPa6TKNo5lOD0amIUernJk6wGS7Mc=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Jq68E5RkHo7HwjsmK2S3ieGpIakdTjVfLysg0qXQs9erS5WJi/cEdtJzNlPAQ8c9V
	 eAhi6TRcvHrXtWUyzTKKbgToXWZvY+DjGxdMbh7UOe65JzHuY+r/qXueWyhoxo4KPg
	 0aX1o4z5Zbq7ar8FX/ADNdWkz3SaW0MMM9cy0nBGgdpF/i93h7pbHes/eLCtbBmxlI
	 rTrOol4Am4ezGvdXFB+R33CKlnYGmK9Vj/S1NFHIqL99X2r0471fiCC1EzFJmYEepx
	 Fkl0QKl0dGW/sb7ZRxXTnCWdTeYa51muAdyp9G2NHsnjazrdBvPZnNXotXxFHyHOQq
	 f3Pt7v+EoDxaA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=74.6.129.40; helo=sonic301-1.consmr.mail.bf2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=mfw3C5yM; dkim-atps=neutral
Received: from sonic301-1.consmr.mail.bf2.yahoo.com
 (sonic301-1.consmr.mail.bf2.yahoo.com [74.6.129.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49mxW903Y8zDqRL
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2020 17:28:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1592378891; bh=ru9RH7ikNyj/x48cS2YclH0i9ns/cJ1jgBc8E7LhItU=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=mfw3C5yMSo2f9NnpILQoBzkpHOXP2xUCvxqF8J2tjADMT3ZnUkH0FDlHtKxR1b2aQIa9TqjIN52St1JveDMitZ9bLztB2OKNJzP+FUdC9Osd4DcrXvSwZPH4ptt3Z5yq0en53mMNT6mLO4jK7svswc2Sbq6kGEPrZrMUBF2aIAuxjEbhHmU6ex2na2jwOMfplEAqvNyZ3ZAuncJsTZhQScBdGpSz+jHeE9R0vm17SbhcQBbWPs18UXEMFDqKxld9BVEq4zs1X1hvvV9Uco7QXLrhz048dK7Fi2ZcgWBZZ2TsBN2xCYqUDeflw4M6/0hXEjTCDgMeej/XFBzzedq3xg==
X-YMail-OSG: rpmPM_wVM1nlv_jSff3cc5Mz.JhavPiAqNwpcJPrl9lBVq7FzppBjTUzSlU_U3Q
 yH0sQ.rvz7z1G0ozu63btUbAWR1X937PISFt1yh5Ou.4SwDti.VYf3cFvjySTuaR1k1MTMjbHuHN
 oHT0RQPjS58NU23uCqb__PrLAfsSpuor41QQud.Ejmc1Sxx6cWWQWcO8MRfftkfIF6HRwNiRvPB0
 gduvgZdchrRXIhYJyVeRai6dmNLyPv58LB1uMNkaLR.zLDdbKvoVDHqgD8RIx2ALlxjfcZ9QY0CS
 59VC36jZDx9maqnhYZc8oJTkPTijSnB5_o1ninOm5J5esELx703.rcORnIPDHMTQ2eGcihwJavQo
 cqY3WVh.vQjfPTc1USib9d_sBb9yieLby28pQpDzK5m0vE3He2mubzZ_W8iegMq.liGfIs82Q.ja
 yryjDg3gfb9M4Ux22Li6s0C_1NFUP3m97oKgPBqzwyCToVPkswcX7.X_B3aabS7yUE_52dkj1uvL
 se663g3mvpH5MnRe6SCFiqVULV8aHhjxsxGp9XTCz2sZjt.I0ezdiCBfw8k_uMcLLtzxXIssqFaX
 wo.cnFgmSRUsIGTay.ALg6TTb4KUfxW20g5jVeN0VvsPc5VNNFAjWFH2m10oVmRZnCiHYB91mhfr
 ZMlRBlBLUgrazvycYbAxNRZMppukz7xw.y8NOFNa0Mab9676LabscNoWKGm9D97kQcpB.amVv.AF
 vX4BgskzHgHGuh95kRwGepmiREjAhzP_Ag.4jFHrG50f5q9M5eWo9vnvIpvDAUWz6ZOtwEWVL4v.
 FXItlOR0KQiQquiJDJ4F9sN84xaY9QqMX_DHwAetutfzUcRBy7npYKeGqzhMqCrUhcqQV3hiBc7o
 tNDUisGWjBA7QlAe07zdLhntGXEnDc0Dz6DdLTFRkhaKYc4JeQSyC4ARqkaHykVdFoCNoDal.gnC
 Q.PWU.dijPT2iSZMWZHovY_KxUFALuDgtulMoHhcROHCxDSzhmJXZomVq.W.1ZmqtS2n8YYA18.Y
 j0ZdaTd51mOiM4q_p9efd11BsTOha.RSkrqmpOl_QXucc8js_GFMfkIQtmxk6WOfVfEYi.qhzrZC
 3QkojKf4x0zWyMsnXcb2MQ0yZopvhr315z9jy4VRU3.4fUwpiaVIf7bDmGs3iIcrvfT_KJmtf.c1
 1dPG1S7ySxchvNiAVzLFRCVZ9F276_V5PU97E1p.6pcT6Z.tpNdWnu915lTUnJMPBRqSn0eye3P4
 8PEPkcP0S7ffug8rynLFe5VE0s7BgObIfQn3OV25HUgn77pS.aqpQQWRv.psLTk9VhYtxlgTqec4
 SNCluWji8ecogK071pSe4NovNOQ44bRR2VY42MscuapZ.kpkhsHHzihYqN.XqiorbIAC2Y2Lla6V
 nAbq63XOHBaV6Dk8U274-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 17 Jun 2020 07:28:11 +0000
Received: by smtp413.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID a80268c6b25d608660288644fb7285ad; 
 Wed, 17 Jun 2020 07:28:08 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: pass down inode for erofs_prepare_xattr_ibody
Date: Wed, 17 Jun 2020 15:27:44 +0800
Message-Id: <20200617072744.7979-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200617072744.7979-1-hsiangkao.ref@aol.com>
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

From: Gao Xiang <hsiangkao@redhat.com>

Instead of several independent arguments for convenience.
No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 include/erofs/xattr.h | 3 +--
 lib/inode.c           | 4 +---
 lib/xattr.c           | 7 ++++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 2e99669..9e2e1ea 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -42,8 +42,7 @@
 #define XATTR_NAME_POSIX_ACL_DEFAULT "system.posix_acl_default"
 #endif
 
-int erofs_prepare_xattr_ibody(const char *path, mode_t mode,
-			      struct list_head *ixattrs);
+int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
 char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
 int erofs_build_shared_xattrs_from_path(const char *path);
 
diff --git a/lib/inode.c b/lib/inode.c
index dff5f2c..5013184 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -827,11 +827,9 @@ struct erofs_inode *erofs_mkfs_build_tree(struct erofs_inode *dir)
 	struct dirent *dp;
 	struct erofs_dentry *d;
 
-	ret = erofs_prepare_xattr_ibody(dir->i_srcpath,
-					dir->i_mode, &dir->i_xattrs);
+	ret = erofs_prepare_xattr_ibody(dir);
 	if (ret < 0)
 		return ERR_PTR(ret);
-	dir->xattr_isize = ret;
 
 	if (!S_ISDIR(dir->i_mode)) {
 		if (S_ISLNK(dir->i_mode)) {
diff --git a/lib/xattr.c b/lib/xattr.c
index aa614f6..769ab9c 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -352,17 +352,17 @@ err:
 	return ret;
 }
 
-int erofs_prepare_xattr_ibody(const char *path, mode_t mode,
-			      struct list_head *ixattrs)
+int erofs_prepare_xattr_ibody(struct erofs_inode *inode)
 {
 	int ret;
 	struct inode_xattr_node *node;
+	struct list_head *ixattrs = &inode->i_xattrs;
 
 	/* check if xattr is disabled */
 	if (cfg.c_inline_xattr_tolerance < 0)
 		return 0;
 
-	ret = read_xattrs_from_file(path, mode, ixattrs);
+	ret = read_xattrs_from_file(inode->i_srcpath, inode->i_mode, ixattrs);
 	if (ret < 0)
 		return ret;
 
@@ -381,6 +381,7 @@ int erofs_prepare_xattr_ibody(const char *path, mode_t mode,
 		ret += sizeof(struct erofs_xattr_entry);
 		ret = EROFS_XATTR_ALIGN(ret + item->len[0] + item->len[1]);
 	}
+	inode->xattr_isize = ret;
 	return ret;
 }
 
-- 
2.24.0

