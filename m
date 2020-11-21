Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id A372D2BC1F7
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 21:11:51 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cdl1d0s5gzDqlF
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Nov 2020 07:11:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605989509;
	bh=iFjcFjehXx46ybM1Gz1W4GL8gAxyhR5/OFq7xXHr4GU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=dVtRmGXlUDUk5Re6UPDxpQqlvredxM4HfndU6XXWiEjbge4rCpdy7WAoiR8udeZHi
	 X+4TOOfkkOS/ysKtFv5fNRb9rhGFKTWu0o/uDLS1mpQtoxVsUmhrXEhRPsft3PgmjZ
	 CXFdM1YrFCM9vqaY3v3BwWEN2C68JhuVFI9A/guYe7l9LdZeFkyJeTDmZfp4q6xW3/
	 9hj95wZ2c7IsQXktNPejWZ0Kbq5OpKDXWSXcNS0mU5LdLW/+uJZ8NLAuS2unVF+enj
	 m8SRKMaxVJVzap9uCPUY26y+dP0SyZmbyJxb6SAa6LeNtmw1dzCpvaVRghKUTPJZYD
	 7WeypKMTs9KSA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.147; helo=sonic309-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=iEmYxYRP; dkim-atps=neutral
Received: from sonic309-21.consmr.mail.gq1.yahoo.com
 (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cdl132cmqzDqYY
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Nov 2020 07:11:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605989475; bh=hS6/tmUfo9N1yXvZBSN+cIxbm0LM/25U6yQtaiuXofI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=iEmYxYRP2OqUcdfwIIseUWooAUx27NuTBmGBzN0Vj83xmsEblZZ8xpdk5iANaLj2mH6L4GqEp55aWSgQRiixmwQjMkKUfwPmIKKIV7K5YMqCG3eZ6rv+XG2eVTiVXiimRZsGdI285mpQV0RASgKVtj6dhWjxG6IrkJ6v1t8euMjO5dVC1J5ApsXagMcd/e+dcFwHewLX2j8qnvAg4nfQ68c9yx3qr6DpXgO44O+eyRskljOB5hXb+laFBEXbzLmJcqENIYb95+caWdNr9aJ7SHrNAtqQgjLwieQ8Q94IEie6ci8qBoBF9TB8drs6ZKic01KAfsnAjXUohke9EjQdpg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605989475; bh=mhigCxR5OtkmT1G1DFo8CxQV86JuEz1IMofJ83kG+ou=;
 h=From:To:Subject:Date:From:Subject;
 b=VnpZNc/D0cv13pXg/OQkqnjXAXKqFyPooRErZuyEaceZ5Rj/i2L6uTmbdE4p/zumhiFmgE2xe5KqDofdHriHqHztpG4KedKsmuvmyoMFf8YIffhvF42adqhbQmmBLU1ngM+EzmWl3qW++WF0u479mf3sZsSMNPn7hwQIdjEGX7lHCiUcHa3ewaygpor2o/mdFrqi+01iAeKoe7GTUunnvPvd/mannwvP2DFU2FZ0vAI9v7Bj0JVFTn73Add8MC6+XZOEIIiTXwZqIgSef/odzw3Z0LXoA27Cbk1sECc1FykBCeiaFPXjrCGcLY1F3208ovIbHQe2kQTkQZQYaCemSg==
X-YMail-OSG: Rt0WkmwVM1mc_g2wrYytPfmiXiSgeYNlJCjRyBuHhgRnECDsQeplsBZ2yVPHOyY
 DPfQ.FFADkIzpUmRsed4F3zRpqG71qzN68XzZ91Q1wFRTB304Y0pElPPe7keDjZPq3qr_Y3Ppe6Q
 aHCAAqMVWrkwKSw6aZHXadr1h3ITatM6kywBAQ1CQLQLSjYxJ.uJ.g2KHlJaRlYAeonY.WNsCL9a
 aOgQqAQitRG1Say2Q2CxhjZwyO6nNhf8z2j_K2ljVBGFvQd_WxrR80h71mVt2xgi30ydKiwlko9c
 AyAGGkIEFVSwE203vFFqxjNOjgYRTBFmhFjPKi0kVWL3VSqMo9l4qwTiMo_RNloej7RaeHSRDPz9
 rOCqRr.g.8sqEsebAnZlOFw9Rd6gk4nzxLnB5LIEr9w92dpt0Gq66OS_d0moxZDt8y_sJP384R4x
 dZDnG5DLHyZvf47qsV897D5_gluRsAEUGG8EPIyVGJ7JQebt34aRIOmzppisWmGsS6Iq6Q3aNkLX
 Mp3ec8e2tvLE_laHIFtEmh1Tr49jda02W6hGmFUDauhr5L4.c.hNIQBYU1K5epO4X32cH1RKQ9AL
 .LIP6vAUutwRTpfvt5ye3fL9HlsbK7AvlkHG8KRGw9vGPTeOt5x3j2_AbIPRlT8u6XKEoWHzTiOX
 22kRxGYaOQk5WYEFbOCrPIdmaiEsY_Bf7M77Cnk7vsrI0oif6snAl5OMSjjSEfBrOBV2eEmWNVgc
 3rlmKBL2wPIkGWjDqOkz3vs2Z1prmykHF7nB_NHEWgixbPteuIwePBPPyBERSBoiDcskTHJ9tl8w
 opsDMe59t6ObGoMGGZI.j0JT7Jk6AlWGtV_Y9uRvnGAiebvTmisVcCT.HkyueN6fNuXhJUEUKGEP
 h2DlNxqyaRNWmoBJQR11Hgy2YWiem3NS39n7aZBQh4TI78mj1SWMzVtNjyLA9Ques2V_Sk3vZ1XZ
 3egKxit1kkawiPUSoTEhbkmxyeqjLU3FKGMID5ix6rwqxQ2CZcj9qF4_VqAlRqDQHAMvE2Cfpt9r
 YHUqBvi97jXBEmm1lQCjOZSJaNmEpdfPGHYcvAfwINyWGLtOD2cXZOlq3p9OzwLs6hYJWlFIIKHx
 KjbENRYlRRrHpU_GrsfQye0fpGw7.DK2i40F7KRhHu3B5k3Q8_9EcZUBpJXVRfbdbhvWOm9bh4qu
 ZH7Yif1Zkhqma4V5v_FVnkoWgmRcxVL7Tbk_TuXj1Gk9_0LoWQs98AjAe16DexH9q317lH_DtgHM
 aSKU_oj_cWbWBBwJwnRnf0jzMGt1b0uQdMnKXJK9qV2Ana3jH5rrl7BNQ6q2AXwr72ZazmJJT4NQ
 5JULIncNTZWUGRhHGtjQNTz.ml.yo1GKwka24xou9PktOCVsAy9wwlTrQ8hiZcVO1EjdA3eDEol.
 qyxvMpVTcSVxk72tj_5BbBqEee7snTrRMwKbU581tdNkJmCrdTefRntxG34Ee7Ou5sety0gutdR0
 vLlOzmCVo6Ane4mo8pFVsozzrjHd.mpd1yRRrDF3XfigccZxD5fh6gn011Q8l9vhm2KybSZ19byV
 RjPKu8nYZ6FpEFjIRntuGYa0fRiMJcmXc1XTFOQPRL_ieh_bHI5T4abnhWRYbDMcqeaMeZlMQ1KQ
 tI5ZCy9TaWI3aZBl5wMEskE4AIv.wufc.ew7p2BZ0mVoEkjpD.Hui4eDPskQFwgfczeetLUZJdCx
 E5bv943LCp8eIggQom2aB4YHkh4A1LNRAWRL1_RU8pMJBBH6Y_NzBNQawtclObiC7P0gqNUi1YuF
 P3l.4WAT02A.0lbn_lQHu1.OHkAalbf2Zo9Zsk_PzVek6nhDtt8qLJsEHF1yC49q4ZnsPjl_bsIe
 .ragUEGw7PU6pMUP7x_ZdkWNOwKvO1OCWQ3FuVq6AyjypMidyg4w2lc0qjUOzQsFJqZlvhMBW0LB
 c3T4NApbyeAjotR72w8m0CKRmo0j03mMAEMYibYjkNrfe5sofI0rdA2nu4EYdNlxGyUB2SYdx5W9
 0C7eDICLTZT6D7g.HT_Nvd6f0rKdfH5__E.MfPLMKWzJr5BU0y03HI6qAG98tl_hvAhXiUQELiHx
 sZJCtsNE4uRyShgofH_7drUULo6P12JGr932J0Z1O5IyyVs_JP.cCLgJkVGHBrRhk4xbAPMcBMhM
 snXyPF1j0uErYALHpxN8QMU3eAPBkawELAbi2kS8TFCtdciG1CLPkKTCOnSrVd8qf9XhW1GD0Lr0
 Se6TacFsPe5BT1PDnI6OiEimAn1cncffRslfteLkgZO_2YIkysGHZWx5wOUK3FrE7EHKv0RBntee
 4Y9MzvuoJdO67i8CqL6TSOnQlWQncRlewu0FYbQISLAW0DtaGq8_wZMcaL8DfdwfCekrFS5UVLJ7
 a8eJl3dZJFVOGI8QzuHt1pDng0v2w9NOHJHbYcPubEfFpGHnjWt8JCUtAcAJk0.gtB_GXznfYnDQ
 T39E93QM72qWSqYpfkPfM8gbni7IxGEy68BhEZKD.IbI7iRtYuwFgjK8ujOe_cUxYhBD77GRFPh7
 3.R3pd1iCOy1_H50LsP514xo5KFN7DZ0qjnvgQixHV87ZZtTxCrIghe85HLkrT3HuHqrm1E1CTDC
 _MQq6igBFRnaGTvMgc0ksnQV0XFaGmdwwEtxOTxdKTWMdIWnBv4K3MAwk0ftVmzec5qNi._t.nhb
 Ll5PLqRDOOc4JVr3iinFlNZ2oz9g479qojZxELR.9HxeTh025Ysa_wcJ3gdD9RCRUWIeji5aHnLr
 6B4rq3902_WNFtE21REW1JUR01Ce9FR1u9BdPcrv3vRE20mlTZFhAni6WXccjd8SEG7QXBugGeFn
 cVkow4njIFxfdCAZvpVz_BVlzTXwuY_majYs2f0y0Pwpvwi521aUWAKxeSTpmNWnw3PkK75z5VMt
 Vi.qgDm69eaP2mqIHlF9OG1erNTy7
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 21 Nov 2020 20:11:15 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 6070243ff164391bfc53a248c45d6337; 
 Sat, 21 Nov 2020 20:11:09 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/3] erofs-utils: fuse: support symlink & special inode
Date: Sun, 22 Nov 2020 04:10:09 +0800
Message-Id: <20201121201010.24724-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201121201010.24724-1-hsiangkao@aol.com>
References: <20201121201010.24724-1-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

From: Huang Jianan <huangjianan@oppo.com>

This patch adds symlink and special inode (e.g. block dev, char,
socket, pipe inode) support.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/main.c | 10 ++++++++++
 lib/namei.c | 22 ++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index 7a626201a5ec..fd5489829b06 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -78,7 +78,17 @@ static int erofsfuse_read(const char *path, char *buffer,
 	return size;
 }
 
+static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
+{
+	int ret = erofsfuse_read(path, buffer, size, 0, NULL);
+
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
 static struct fuse_operations erofs_ops = {
+	.readlink = erofsfuse_readlink,
 	.getattr = erofsfuse_getattr,
 	.readdir = erofsfuse_readdir,
 	.open = erofsfuse_open,
diff --git a/lib/namei.c b/lib/namei.c
index b05f5c421d54..e8275a42f090 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -15,6 +15,14 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 
+static dev_t erofs_new_decode_dev(u32 dev)
+{
+	const unsigned int major = (dev & 0xfff00) >> 8;
+	const unsigned int minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
+
+	return makedev(major, minor);
+}
+
 static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
 	int ret, ifmt;
@@ -57,10 +65,13 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 			break;
 		case S_IFCHR:
 		case S_IFBLK:
-			return -EOPNOTSUPP;
+			vi->u.i_rdev =
+				erofs_new_decode_dev(le32_to_cpu(die->i_u.rdev));
+			break;
 		case S_IFIFO:
 		case S_IFSOCK:
-			return -EOPNOTSUPP;
+			vi->u.i_rdev = 0;
+			break;
 		default:
 			goto bogusimode;
 		}
@@ -86,10 +97,13 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 			break;
 		case S_IFCHR:
 		case S_IFBLK:
-			return -EOPNOTSUPP;
+			vi->u.i_rdev =
+				erofs_new_decode_dev(le32_to_cpu(dic->i_u.rdev));
+			break;
 		case S_IFIFO:
 		case S_IFSOCK:
-			return -EOPNOTSUPP;
+			vi->u.i_rdev = 0;
+			break;
 		default:
 			goto bogusimode;
 		}
-- 
2.24.0

