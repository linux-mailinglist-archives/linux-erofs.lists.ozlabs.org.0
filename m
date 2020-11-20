Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFBF2BB1A3
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Nov 2020 18:45:02 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cd3pg59ymzDqHZ
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Nov 2020 04:44:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1605894299;
	bh=v2j1hAAWDRJ8BCOp75r2eI5J3/TyBjD9DqngQFwz/Ck=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fvoyenkHDewOdN4allRstMVL5C7M1alYRnaYv7AfKGAJFes0qEKo6c+Ksoa+6LAru
	 3/BEYiID7JVDMQosltcm2enxLPf3lD31U/8lp3s5wP+VY7pWkoSiN7GWg3AfmzEYAW
	 S3yV8x8E/d0HRJdDmvFsx720sAciaxTGromXXoLBBZ7cLTqgu+7acGnAJLZgkKtuJI
	 pQUnwxryWgr05TGipwAFAJqcd18qdUn5G/hkO5i6PGZrKywkg0F/A/bSLUhD4EJW5C
	 1/i3oQJuBEAVlqpbhRFXI6nKA9kMl3u9vvsjLiSvqFrppKCnA1bBJr4htF8UlzA8fF
	 arZKee6TCel0w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.83; helo=sonic305-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=gTeQ5gV3; dkim-atps=neutral
Received: from sonic305-20.consmr.mail.gq1.yahoo.com
 (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cd3lp6gLMzDr3N
 for <linux-erofs@lists.ozlabs.org>; Sat, 21 Nov 2020 04:42:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1605894144; bh=VKc2OMbt7r/ZZlHL0Joim7lgh4flmqrGnOiNgulY+y8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=gTeQ5gV3d4RQx0m08uXITbfcsyHZUDjlHtrVAUrygOq6vJ0xrFiOzZTqA3tgX+WgTKohsSSEkBXSpUWx7gbGgcUpCPUKDeEJ0BSi/9kJEsbQqfWcnZeI4YTpSGVWcKwN4REevan9yobuH0FCi9Xma+pGf8j2pexIPLP7d8BcNy3fX7MMaLpVtHFMMcZy3xPfhGzNS9YS83nRFaWpUUQDZoRTss83jNDqINyc5A4QyLxvKj/nQk7XvWl9w37kp7Obnq3jGdWMe66XXx/SoZFBVI/NEcejCRJYyjcheydA8uldFZodmMmECsuiZSZxc2a8Le0AzzxFJ8UdVnsPq/1itw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1605894144; bh=1YG8ezAsvxqMwesTDHxUwXfG8myj3XKW/3ZwB9gSVDQ=;
 h=From:To:Subject:Date:From:Subject;
 b=D4I7g22kAtAA6nLVcYHzI1VnX0Iy+VhRcUX3qtVscmaWvi7+XSTjXh78KzdKRF4bj0sufR7DTyqzTmD6rUPFeYlUd/rzPIiZatVQObezwbyWSE9/G09DRo+UOGRXLLNWsq+Cl9CvFOrvQ1g9Hgv+BBSQfb1terJkRW5R/yUoJ7rZXu8FXGmlu0uPker/lMIdmeXgKCZhIP+6POk28WxOxXMylnefEMif5sGr/AZJ+yxcvfIkuKOEpNCyGtYo/+KqDh1+qo2jVg2e5dG+5to4NFl8WRfBHgWfHCIRWVpeuezeeW/YSRJnaC0BnxFHM10IihNfB2pLHg6EYfKMzRXgng==
X-YMail-OSG: O2DaPMsVM1mBWe44ACIiP6iUaupelpfrpbxwA7wBtedZRTbaqYHj7nzVICGLM5k
 CTlml6uQ.8hCjKsDnubP2WS00AfFg3opd6.P8ojOrhyP54HK0Q_qvOwd8V23INjFIkf6AqvfPe7L
 sAisnrPOuYW5Kw9u6TBaQ9FCzv.csSiQycV82OmEPp96VYPowdBKRvosMpHQmD3JHR5nIXPabB_z
 2VZBZCjzz5kyKhez.uwhiOleFwPzi4z3hPzGmRJxObGmpDpWZZnn9VT4hnBcvAu9.tEbCmal6zul
 WS.K_FDubwk_WNDaH.3njPIr2kZPs7mACHm1Kd66sgbIkso87BqRy4Pfa9D2_KIsa_TT4uD5GnAB
 MNVOAvPsAnPlRxwL6ZCuffaTWbQPCp5lmgQo_zsKp_Mb.EOaUqAP_ouAYHeh.BfqOqR7zBMtD7an
 LVY8.pGOdxSaIqpR_XUhCjqri8MT_SMdFGx8myEIOCauVhVK_xJme0aQiP7DW8e5Mg9rO0Hj4N0A
 40tU7a6JoYYU2DrTr4YoatCqKd1asvVw.nvvmb_FYzF5ZoMQ9Cb_OAtwGNO3NbA4D90hZY6Da3NY
 iP8Eu4AtB4LtBB0r_Z1lQdg4fSZobxryHz9EXFQw1qtVOM8KSp4rCz4e2.FZqWqFrw6RraNGhQIh
 JisaoAW98p0yTn9wrbgUEesrM..At_FXUrRk9xVVBBg74M1AV8WkOQKTDsTGVHhgAjEwwoTIIvUF
 qPUyY5qZs5.cs4DZvodJ9xbgLQYW8Whg7a5jvWJ9A_3BOAYDomtJ1iA1gKKWbAG_s3bBKSey2B0p
 .ZUcU_v_gyununIJqINMZojJZQWNKIuvLKScVRB1K28rAkdw8y6WexcKkmWCSj5APNo7pJ9RKWUl
 VK1X7vDeQ4Xo2DiNSPvG6ZgEiyPHn20K4syVmXzWA7Yw._6Zr1H2_evOasUvw8ulmeievJQkffFp
 F9_eraW1qEN2TecrJrVlVUhMozAhyyBHu_khCBzrJcOG9ni45pEZrV3e_ZgLR97JSKRPzfaKBuU.
 bskciactyhzxz0OY4mjIQEChjzbSqw7op6rnE6f3hgJp8uwyOGP7_XMDI0Z5Je7ResKoeq1hz8WH
 HW3mOD.iK5auJhhzyMmogTa8uEBP30mEDwHULPuPT.o_f3lIGE0E76SaoNi11_rCVeaRyVXSoyLo
 pT2NgIXe.JSDgk72aEeDz_PbDaJrZzFuaDLoSKx2EsjtbI_Autw7DsUs3STSloy_TohyBQs0FtTZ
 JCXhpETf1FXrK233rlAJjlJeedOVN6ogdOEH05SHZjLxxZMmT3VGZPNWdstdlysmwiJJ98z9aabg
 ismj.Ly_0DESyowz7NraT8FGqLtUb_8RG2dk7nM5H.lm1MHVsRxDmKTuREiH5qU_UFwnI.uh717X
 4uryga8EItn_54nAniKvctLzApEBj2HJb8Kj3zGNIvvx67CUJX4A6oTVemxDWUUKN5cYtuCpCTSn
 Vg6bQaORwROESvNKCLeBD_dqGz3egja0oV8rB23OuR8ZpYlsSlNY4Lsybj6k7js6sPuHPXd39tSA
 33C_viR1hNrpifmrVUw_QNVQAWgAD_EG9SkTcVriYcVaMziOCOWAirVWuWFrlj5.VdXXX9bjthvJ
 L8.o.vQnKQjyZ0jIk4zY7kqNgLhEGGJJxk1_e_0xEAgbQzwP_0rLGrNZTuoD2Za2pts9JtvcJsON
 cI6AT1QrehENRi6BzXsxqaCfG9dRK6eBZW9t_axy5C53hOmNjN9VfUV5a3t6n4ekk3T78Dei8emR
 ncmghrl4QlzLONRvBEDuWI3zwae1WC5KzM_yVsBftlMpVm2AnKUQDl0M.e.F5SaTwerPtL8_sT3a
 duoR8sdEQdoPTIsa0IscOvOj1DHAORVrsGrVnSyEtms728b3sKAK_KSDk18T_OZp3shyebJFYMXK
 X1fIBuy7YHE_b.ctzkXONzNgzVxnj2fFU8lXGzzw1Gv.yYL4o5ln5GNfYQMWdpFKisratV94T5PU
 gpv8V13kfZgnSFijMULi6IscCILdHSTvbpnTFirKaafCEB.i6Bc0bTShJjRU2ASm.AeWa8FO1Hfz
 ggDHnDkm0HOel3dudQjT48TepjPAuS4wrHsKYW.TBqvvLwf5NfOD9Bn6h.EBgcqZTT5SrgLvzfTo
 EOZiRLa9RMGXgactRRegAQ9JCoVJ4hND5mJz8xXE9MTV_TSudsfJuPXdsOWTLWlZeUmUfM_1aC4l
 yLlZV.KLmYKF0fqFN7MHaQV2oyQtuWbug5SkCvjRN2y.LJvGozMHH1Jn7uqy1VPsFzJ.lSJBMqrL
 8oWx3tERkx0ss3YPmIQrJ3_MoqX_a92WITBYm0xDjXFS27J45DIiMKCcF_J7YROHOOKtOjaLnJai
 z9eIJTWwklwq0rIWmxvzKHIavknPtQLptUMy8sJ.zA7pWxqRXUIrBn3qkMHd7NaQGcO9jeh2gRaj
 N2SnyQliYZYdRbe75s0NUek8Ctx3dPkWRG0RGVqERhqIVI6x4C9ffClAshEpcF4i1TnwcLXFQXUn
 3dJEDzBI3j4xPI5gbrnI.ejRzaV_cAWLrnqY97hui5R0uZxmsWDv0PkqPcC0fWLkCZCTfy7ONEGW
 moMM0G3ZdSmhJ.bW1VOZHizQrO68VFxp_x0X6xm3YPY0fkd44aNj_dzRqNwjiFfyTbDQMreavlvv
 2MKRJVUNzoCs9UkXJZ.wix5j5sPkxRkzMw2tN4aZ2oSie1g99TDfGuS5phjF7rS1PHALI1V2Ova_
 VfXFYPcCTgNJmMybQbPFyT__sFWlPoDvBf2ICgX3imwbmUxxYyiLChxoLJKTcT.rZWnPvyTNaFaI
 70R20Y3HjkZV293OsCm5vOGJC9VCm7O99Qg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 20 Nov 2020 17:42:24 +0000
Received: by smtp423.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 2f08c2150b87ae58ff1849141a8a4a3f; 
 Fri, 20 Nov 2020 17:42:22 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: fuse: support symlink & special inode
Date: Sat, 21 Nov 2020 01:41:45 +0800
Message-Id: <20201120174146.18662-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201120174146.18662-1-hsiangkao@aol.com>
References: <20201120174146.18662-1-hsiangkao@aol.com>
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
index c8e9aa37082b..37c49bd04b9a 100644
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

