Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE1967472
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 05:32:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725161544;
	bh=aG6HEi2N+cnULcA9XIEXbapO9ogrsQA4OUSBo5vYsEE=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=ZXYAVZk5bMxI5k+DPt5o39F4K2s2xfVMZFxccWmqBVa49+BWY9yRmespXdMTYaIul
	 lK/TXpIRcLi0tH+PONxxpQjjpBjtYPEPCX8Bq3N5RJpmsDMlCPNnv5q/JcEVqBkKiy
	 PsUF635ivi440viYD4aqZvIR+UhfxLY+eqon+zw1Qrf6yeZ0F7XKv4EuM2TX+Q4igN
	 FIPGp+tuEk0FEqn41sscQCvI71uj3UjkHUsuFf+A1aJeQ37DLka6170wvWQ/mk569Y
	 xplACK9oL6bNnNDkUk/XhGa9s966WrQYrOoqaLFyxSIpxW4dvFva3tzbOtCW8u8F9c
	 240S2q8PcXz5A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxHWX1h9fz2yhn
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 13:32:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=43.163.128.54
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725161542;
	cv=none; b=Y+rlzaDiPmjcbxuaKWyYNKnF7LeSvWP4uc9I13C1MDiKoYHc5OfwpeMgDmAZjV5I57Ngl3qltrGhnL08eKZVD0ahiLpBRaFY/kiNndME+eodr7wcfv4M+K1es+eUxzLyr/6GkFvcdwibhEqaNKFga+WSbaQDk+G/Dw0F3bAmbriu1YZQrIbtoRUWwoHeoiQy5xabpoCIvfdC//sN9TALXqZCB5OU+FknNbSwpVFCcCRVu+9/4M8iaM4PSF/rKsKdwlfK/Qulq/uQaq8XS/OR6/JmhUIV4+ozxjMESx+Ulhdc3tWqY6qw6VTFzsSqMwtg3FPwnyk7+BoJW/ksb5bpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725161542; c=relaxed/relaxed;
	bh=aG6HEi2N+cnULcA9XIEXbapO9ogrsQA4OUSBo5vYsEE=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=e3hRMHzF60XDXICTd22QAQLHGTJwdCTheNXFT1ZhW3zmx22usql25Os9iJ9X4MIORDc8/5XXbU8eTUsdrCVwfBzXlyCaxvXBs2tXdJfqkt+2Fm1crTbHeT2KntI/zRoOD/Z8XP3cxYpEU5GMklvyttZoJgJEn+3WONbYwVxx8WW7XjMmZiAaEbKTQz4vDJP8O6QZ1x7u2jeJRCoJqmkKXtsXY3q0vRlvrUjgtbWX7KB3V1qxAgynB/b/WXFTs1jh4Y/yPiCIYUw3bjZ5QnoQnEfCLzcG6om/FSTKChwGvAAMZTcd9oB4Fe5jY6eAtwOK/P8sABUdB8PfgmZLJo5EYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=czLnZKf+; dkim-atps=neutral; spf=pass (client-ip=43.163.128.54; helo=xmbghk7.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=czLnZKf+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=43.163.128.54; helo=xmbghk7.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WxHVZ1njQz2y2B
	for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2024 13:31:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725161488; bh=aG6HEi2N+cnULcA9XIEXbapO9ogrsQA4OUSBo5vYsEE=;
	h=From:To:Cc:Subject:Date;
	b=czLnZKf+U8WDszk5GObhHeRr5UgMLMVK0VRn0AGez7JuXj9KUT99SIGSrPQ36bvAM
	 Is+yv8qvyod4E2cyVwZTX7v92fvCC+EdraHkAHo0/u6OO7n4L4axKAAAQYIxiQsLig
	 8CHRO1LiGefUpn7j8A2SjOwqnXaNHpuAB53sER/U=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 79AB0611; Sun, 01 Sep 2024 11:30:26 +0800
X-QQ-mid: xmsmtpt1725161426t8rrag24d
Message-ID: <tencent_D2A848CEBCD088313CCE17DF2E49B605E00A@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieIMKaVz11wdc2uvoE1Hpj5usK/ESY1zB8/5czA8Lp4QEJ9s4lNU
	 GAS1T3BNNt1LY8My14qHGPNbdQMY1+BECKpiQ7v+413KdscTXyQ2OvOmtuGX3Qn4uGkhTbtSMCxT
	 lTeHWJPt/a4raWbCJux3OKfi47I5J3OV2/8uXjsdCcnktR5HX9RZ10e4wbuQktKZpJryHnZiB7Xv
	 uXnDffKEMgHdUCo9AGvp6Rx9iiZcLjtcoiCkBnatBTO+VFYycRmlSLDRYPrx9E6T8ubxKBCF/7Oc
	 OyX4dLeaNvvkxL0hwKxz3dlnyT9u/MAnaTwqrK17MlbQ352UQy7kK/5Sr0X5TdXPOLncUkOYxZ/q
	 cCWsGYW+xzWYVNx08z3pcqKY3P5gnQg+wgRvcnGcpbAvOpMDyEj6cSjN9Nfe0py/BD+abIv/gxwN
	 qztJ5iuSVxE3y+mnriT86ez8pvgiv3TI0pmT2k1XORAp+PZmQl46HguTm954jIxRxMFREGgV6hDW
	 3ukyjTT3QZjV8SB0KtI/0nos7IrYtmYU5x1UGLQ5YVJDwr+WXFkQbukmf+9LlYi6pWo4yW2ZZ4+4
	 gdVIiv6rIVNSHdIltxQ0IexdhKdeYJA2xVjsXeTw/HHu6kiTf410frW+whUKVn0wkA9AHne0R6Fj
	 RyN78wp/c8NjdrUfYD53nNOnKddiM2q8qMCSxgB78pdsWD4EsypEmzbsNI3s9XCzRhSvf+0PUuDE
	 qyzUXE197lCOJwsllWyV9C1HyYz3AvVldm3QMaCQtVpPNNAnpVdWcfF4c7+FREbMUiaVwtBlyHUY
	 prq+167S+tKmwjS+oc1bj5Ibb3cdb3Q7ibF+muc1zdSV6quPMAiBK1qT8L3PuceK771jDdoYc2iu
	 1v5FW7khiUKLn37Re3XpRIuBShAwMoASartIFDN9nmXGbRhw2sWkGmEzSn15kA5CktBY3e3evHhq
	 MtF6ZRfxGh8HwjzLopMTFJRKaZC1HFL8dlJRUDMn5Hg/5J/m03/WlQt4FbxYsP
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs-utils: tests: add fssum option for fsck
Date: Sun,  1 Sep 2024 11:30:18 +0800
X-OQ-MSGID: <20240901033021.2124850-1-kyr1ewang@qq.com>
X-Mailer: git-send-email 2.34.1
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
From: Jiawei Wang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jiawei Wang <kyr1ewang@qq.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch introduces a fssum option to the erofs-utils fsck tool, 
enabling checksum calculation for erofs image files.

Signed-off-by: Jiawei Wang <kyr1ewang@qq.com>
---
 fsck/fssum.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fsck/main.c  | 30 +++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 fsck/fssum.h

diff --git a/fsck/fssum.h b/fsck/fssum.h
new file mode 100644
index 0000000..0203169
--- /dev/null
+++ b/fsck/fssum.h
@@ -0,0 +1,57 @@
+#ifndef EROFS_FSSUM_H
+#define EROFS_FSSUM_H
+#include "erofs/dir.h"
+
+#define CS_SIZE 16
+#define CHUNKS 128
+
+#define F(x, y, z)			((z) ^ ((x) & ((y) ^ (z))))
+#define G(x, y, z)			((y) ^ ((z) & ((x) ^ (y))))
+#define H(x, y, z)			(((x) ^ (y)) ^ (z))
+#define H2(x, y, z)			((x) ^ ((y) ^ (z)))
+#define I(x, y, z)			((y) ^ ((x) | ~(z)))
+
+#define STEP(f, a, b, c, d, x, t, s) \
+	(a) += f((b), (c), (d)) + (x) + (t); \
+	(a) = (((a) << (s)) | (((a) & 0xffffffff) >> (32 - (s)))); \
+	(a) += (b);
+	
+#define OUT(dst, src) \
+	(dst)[0] = (unsigned char)(src); \
+	(dst)[1] = (unsigned char)((src) >> 8); \
+	(dst)[2] = (unsigned char)((src) >> 16); \
+	(dst)[3] = (unsigned char)((src) >> 24);
+
+#if defined(__i386__) || defined(__x86_64__) || defined(__vax__)
+#define SET(n) \
+	(*(MD5_u32plus *)&ptr[(n) * 4])
+#define GET(n) \
+	SET(n)
+#else
+#define SET(n) \
+	(ctx->block[(n)] = \
+	(MD5_u32plus)ptr[(n) * 4] | \
+	((MD5_u32plus)ptr[(n) * 4 + 1] << 8) | \
+	((MD5_u32plus)ptr[(n) * 4 + 2] << 16) | \
+	((MD5_u32plus)ptr[(n) * 4 + 3] << 24))
+#define GET(n) \
+	(ctx->block[(n)])
+#endif
+
+typedef unsigned int MD5_u32plus;
+
+struct erofs_MD5_CTX {
+	MD5_u32plus lo, hi;
+	MD5_u32plus a, b, c, d;
+	unsigned char buffer[64];
+	MD5_u32plus block[16];
+};
+
+struct erofs_sum_t {
+	struct erofs_MD5_CTX md5;
+	unsigned char out[16];
+};
+
+int erofs_fssum_calculate(struct erofs_dir_context *ctx);
+
+#endif
diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..051b74f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -13,6 +13,7 @@
 #include "erofs/compress.h"
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
+#include "fssum.h"
 #include "../lib/compressor.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
@@ -31,6 +32,7 @@ struct erofsfsck_cfg {
 	bool overwrite;
 	bool preserve_owner;
 	bool preserve_perms;
+	bool checksum;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -48,6 +50,7 @@ static struct option long_options[] = {
 	{"no-preserve-owner", no_argument, 0, 10},
 	{"no-preserve-perms", no_argument, 0, 11},
 	{"offset", required_argument, 0, 12},
+	{"fssum", no_argument, 0, 13},
 	{0, 0, 0, 0},
 };
 
@@ -98,6 +101,7 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
+		" --fssum           	calculate the checksum of iamge\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
 		"\n"
@@ -225,6 +229,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				return -EINVAL;
 			}
 			break;
+		case 13:
+			fsckcfg.checksum = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -932,6 +939,23 @@ out:
 	return ret;
 }
 
+static int erofsfsck_sum_image(struct erofs_sb_info *sbi)
+{
+	int ret = 0;
+	struct erofs_dir_context ctx = {
+		.flags = 0,
+		.pnid = 0,
+		.dir = NULL,
+		.de_nid = sbi->root_nid,
+		.dname = "",
+		.de_namelen = 0,
+	};
+	
+	ret = erofs_fssum_calculate(&ctx);
+	
+	return ret;
+}
+
 #ifdef FUZZING
 int erofsfsck_fuzz_one(int argc, char *argv[])
 #else
@@ -953,6 +977,7 @@ int main(int argc, char *argv[])
 	fsckcfg.check_decomp = false;
 	fsckcfg.force = false;
 	fsckcfg.overwrite = false;
+	fsckcfg.checksum = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
 
@@ -1017,6 +1042,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (fsckcfg.checksum) {
+		err = erofsfsck_sum_image(&g_sbi);
+		if (err)
+			erofs_err("fssum calculation for image falied");
+	}
 exit_hardlink:
 	if (fsckcfg.extract_path)
 		erofsfsck_hardlink_exit();
-- 
2.34.1

