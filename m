Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C9C2A2ECE
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:57:55 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyHN6KM3zDqTj
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:57:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332672;
	bh=L6q4o3m8RtcFcpu1KjB2okjGiy6Pg7AXGxGTC2KFAkI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=KnTJJactGUStlEo37BVn6aakIqOoZCI2v0nRGmU2a38zj6AS4ZnMb4+EnIaPUpL5s
	 8nZT700oGbLsapGFlV3bjy9JUqLj7XqhdoAxpD02GVIt84x5gad2MXWr3SOrawDa+O
	 TiKnF6gT5fW5PuGvxaCNHhySNmHEHeqXZxfqWz3g0OHhjKD+Rn/rLrenKv+a0D2szx
	 ZTZjL8ooUrTNChXDSLjSmO28lFjIxZYIeSG6R92uEBretjGC+JOhIgXq2R/3WwNSDK
	 WQAd4UhGjvn0DciszMES0mWLd/IhD8aHpzkLMbVFlrF6KxpdVGg9qHSnIbxZFExBSa
	 Ra2v7LJIwSR5A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.83; helo=sonic306-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=HmchWBfH; dkim-atps=neutral
Received: from sonic306-20.consmr.mail.gq1.yahoo.com
 (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyGl4dr2zDqTK
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:57:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332635; bh=RlhxLC0gWXo4pOEkNpS9cGl/IacgkWDx+lB7VLG46o4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=HmchWBfHYX5FnpTL3BdHzDGJB9JcFh89TkzZ1g2+/y6/owPsN7QVIusGPMEeY9Qd9HzOobh28qXjn6mo5W9cOp4W95ar9nRG1yJR32SlCDj7GgBkVyIyS73Q8Nwe84no7SMSXtAATZUIlEyardW2DuskqMfRCJJpncopA/8TF21skDXK46OuX63esT6sDkx/yPZUjdYAJaqXXAC536+X6jbXdqkAxRH5+lVqF9AdjtiFPVxgJw0VYJaBnMUXlBDYxbf3DJpcP+B9+j8Vu5tS2DP3pYTJeHbf9bh21BZFmBr/R5t3OTNEeKHOjM6EXM3X0NbxTmicsRAjdO2i3EdYGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332635; bh=OpKlTYnH4TuFT97gAWkA1RKD3zE07FGO6Pb3qyBiWD3=;
 h=From:To:Subject:Date;
 b=qHgf4/BPYGwuhkAjObgwSdEUHoa+r5RU4vgKpTpiz/wXf7XDP/jpxbW5n5uSmJyRen4xMRdlJop6OptErTA4YkGplOkVtX5EKSlwHtYWoM5CIwsF+XxwAZTNQc9RjAHM5fYzuuqZajuquRLAVw4ThFOSmXZfiGeQRsTPSIHN5hLIZndEQl2wIkN4FG77uq+YooEvoLkgtKqcupVWZcbkHEq0H58n4Rmtar9FwfQ2lxUBgn/HCf+CzSbSqImcu/tWBL7AvBp/PObpSwZIyLncvpfnEXDVC53lXZfPTAIDBPFgwoD6yLukAyHNriq/r9W+AUk9CvA2livPlyDxGsh7PQ==
X-YMail-OSG: XnKDYKAVM1nsjyQTCdBSPxO7qMTLqOn1o2yB2td39Kt47h2m2DC0xHaQMCqw1pM
 ZXse9gLxuLDaoabq.FlP0S1mX8XNhsTzj35juBpsTtnnwCZ3itLYQsDTEdhxnikWLHb_PFyKdxu4
 cShJfGONl9Hqw82ySm9VJ6zTNfogldqczTyNS0vb9Stnp9qWKHUaQtwh1msiWNZunrNlzbyUtJ0D
 MgXzXqSXfwrfpI6RziBlKBgyIi_S1rb.PXfOKOIE65wh6j9eDRlJT2nSBEVwg83ikEbQUDoIDECA
 yDV6hgw9PC.mpUICknK3ocg74VoX6Nf7n_m0LWB8Ciu.vyx0MKnd.Wk6GTWuEqWmMDKIxRlDDf9j
 4Q2C26YBobEK2HX7q0uC1CMW4LWEfGuyZVPuu1bxgS1Sg.Bs8Y7rPfGIATr8H1Djl8wBa1VUniR4
 tge3cut7yFA7AG_PTlQHYJ4_hnIb_YuIHO.kUa43GptQlSFlb0Ybw.nRbJV2WE8O6LPUiMoZMwP0
 A33Yse3GoDUmvM_bnSBUeLZ5WnsPyDoYrm30q3BpY4zyI1ttuSVXnN5GKKoAc4lmChf_rVGg12Y9
 LQLcDdvxqRkrp0vimAunxewglLwjpdNVkcAPhx0kRWnS5cDXO_69qP1mVJOsmVO5p2e9WkNMCIaw
 hlZOBu3K6Q69lxa9m0VhxjjZs4kUEoshLl4emJB2RSlYarPQA.v4N6yVWuq6t3fjoHCrdtwN5O0A
 josM4mjMJNFpysNSEusl7rlqZdz5BbnOnIXkOO1zEs8Aa3CtT7fRr19PDZ0NIsXNQBCEFBXI1Dm.
 Uxfr.8x.qYVRZ2nbLNG1xpMdKnguk_D3qjsmc44K6TNjx5ggo05tKBmOR21F8mKwK3yLQO3Z8UAi
 PL9qpxt4cQtR4ep56nQ8lTrpZO__O4KgyEZ_I9N0qohQiWjchmQAf_FBPO6KoMR_E67SR3.3JcNR
 bGXXGhJoaO9M48T3bjTts97KAVLbUYlLNbrEVODRQ8u99iHWhmbagnfzAdG3eJLpYvo8rO_kUsr7
 Ym9U1O1JESA8j8QPCq5gDm00TqOzOjWveP9MIYwFSwF9COHRhUATSaY70TEEoMnQoi_FDpStBJqt
 mFNyJGdgsdyE9ajI8R6IVISMjSwZAa9PK9xbCK2yaYfOWizcxgAJIKM0OJTmAg6QP3RHgSF_0fZd
 G_jPX35oKhAz0tiE1CVpStjFaaKKovgAhi2EfdDblhVv48KBc9zT_QbCLB2r9YqakGZ_VFE85Rei
 xUrnVJTxSOxgez6SglgyeHwFz7D1iwcPvrhBlnzRZxHrEQw22XJ654RLIze9vl0YxVIy9xAx9Xn7
 3XDO31yirRr5SJ_CV0Jq2nCo6T_wtDo3hzcYYx5BaVVUzfZiEvs4HFlwkXbVG5QsgfVWQ0zcLIcY
 LDSvGVFuopCGwKZWuer.cSveBlc9wUXj0Zl14PX3C.NcP1Rii0c9XnNYsEStc3bdUlOf8Q4JLYBE
 ypfKrD6vcqwHpDq1yIG1_y7zD5Df.S6LgISLvxaIMUcScd3s1XEEHDguJmIQPlDhOk2HPlwlKMfL
 4l46a5sdWlp8EVz.9mg1lgntfuDPQe5.Xj505XKeyRaNAdpaq1Iypj3kI06o9i6uSCUejLOV6GUI
 KNgu2SWWnuUL8mGDVC.5vgpIwrcI5YG8tM3PhrEe3QVQVP8piwwngVLLjg28REb6VOh.NurxI.OH
 dl7b4x4JmxiNJlQbRUgoQtasMFAZ.f3zX5vWFHfYP4bc7UNla83a93pr0PqcqJG4ablyUMZpWiHl
 AJm6z9mtFKZ7w25p6fL0z7rEI.1YhLQdBIJ1nQyXF_CaZTRxtOggOIxxs_VYjmX4qEWkEQ0DvFc.
 FGkamY7bdI6EOklttPiXvX9fRNl668DSO00AA.8cmk4uf0fGQEjriWfschoLck1oGqf8d2sYYV7F
 rusEVYZ3ieSZ97jUl_R7EcU_i9I9AK9l_8FYl3XO84T5EKsFYKuGD4vP06EkE5aWeQZpZvibq8bg
 z1zGrkDWIott0PUg8MAqh4tKlio0m5B7WGYS2lRcZ6_mrmR_HgK23nPYvOojdLFfEwBAknFkDxn1
 OECm8oM1eIlTtZG.Y5Y5yBHyOcBH6.Fxy7gnyvDXPsk7osdwOlP5q1ySs86BPxJHvWK6bVs0w6Vo
 hdULWt.JasEMN8G4RgH95mNvYDfC8BIFuuSUNxjN1GBxHhSlC96SCvh.pN2h4lAJrZmXNWXifz_P
 3SsgpSiia91kAmyxCswZmnruMuT_xN9njVULRhr0xjs3QqAtcnw6RcQNcPkqgHT0i1Wy.dpppt.C
 eSdPn3PgYn.5WeVOlpHktPqSNmkYMgx2blyLShXdeaeEdyxETEUEyjIVLOCUpYZn1VZIyQDjyZX7
 kDZCo8AHOzL_ITmg70pz9OHPQ_g7haQ8yCsOPy4HexlVdp1Djj.cuXZzE1quLDkf6rGhzpfmXSBT
 5yYbTA.QrlhkV_MBX8jA_OUDuCw9BTYx0QJLTPvpsjWGWaaXXqzFMQGZU8jS1io3YgUb8YCAn8lj
 Yp5DXu8JjUgsWtANyXcV8OlBJp5psSoAvidVVqnKI.e.UWSDMHt4GwvtWnppx98SAAZYOjn_7WZH
 m04wArDd.bbhrBb09KMaCpIJ0JGqPAU0IUWEOPAOQuxENdOxtcO5Wtac49RxnbfoE.CDDqDuOL6X
 D5Sj3bRrz7a6zN1FR7X__pRRgZ6Lx50PfZ.yNyJqWlxUY5zecMWDBESw-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:57:15 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:57:11 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 08/12] erofs-utils: fuse: move erofs_init() to main.c
Date: Mon,  2 Nov 2020 23:55:54 +0800
Message-Id: <20201102155558.1995-9-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155558.1995-1-hsiangkao@aol.com>
References: <20201102155558.1995-1-hsiangkao@aol.com>
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

(will fold into the original patch.)

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/init.c | 10 ----------
 fuse/main.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fuse/init.c b/fuse/init.c
index d67c7f0dd298..a5694beaf519 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -83,13 +83,3 @@ int erofs_read_superblock(void)
 	return 0;
 }
 
-void *erofs_init(struct fuse_conn_info *info)
-{
-	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
-
-	if (inode_init(sbi.root_nid) != 0) {
-		erofs_err("inode initialization failed");
-		abort();
-	}
-	return NULL;
-}
diff --git a/fuse/main.c b/fuse/main.c
index fed4488081d8..30e4839bdcb4 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -13,6 +13,7 @@
 
 #include "erofs/print.h"
 #include "init.h"
+#include "namei.h"
 #include "read.h"
 #include "getattr.h"
 #include "open.h"
@@ -115,6 +116,17 @@ static void signal_handle_sigsegv(int signal)
 	abort();
 }
 
+void *erofs_init(struct fuse_conn_info *info)
+{
+	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
+
+	if (inode_init(sbi.root_nid) != 0) {
+		erofs_err("inode initialization failed");
+		abort();
+	}
+	return NULL;
+}
+
 static struct fuse_operations erofs_ops = {
 	.readlink = erofs_readlink,
 	.getattr = erofs_getattr,
-- 
2.24.0

