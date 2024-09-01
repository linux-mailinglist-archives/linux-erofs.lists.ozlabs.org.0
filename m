Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951C96743F
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 04:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725159525;
	bh=sEYQaVWhtcXYrNgMjfPkzqecGeZhydezmlfqmaFonPw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=TaWEIzAeYq5/2gdVrJcaYgHWqJNWEST1Q2Gg87JuMCeAwptEKYjJb7NN9bdgjCc8D
	 CmSOcOWWk/+7O0pbMwM667UZYN0e3Yrq9nk7uBv6iT60sMqTGL8dDrLgifDk2W85jg
	 EshEC/kbgXMxf4PMi/VAXvvyvlsyXXZROIsRVnfJpapdLsWrzQ+kg2BCXH3tZOyvFI
	 jnqLbNdF+0XSg3MlHytK1J7Ug6WWk1Sc4Wd7U22ZdRr0NphUvk4tDJWbhuPSPsFfmZ
	 lcZ9nJjGTUrLgHDP4BL3cGLfcb5bJWUx7pEqy//Lf42FVAEYktsrdtOZlA+ZDrseCh
	 qrmEMkw/n6exw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxGmj5M6Pz2yjV
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 12:58:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.205.221.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725159520;
	cv=none; b=KucnEFsidWrqdSpsZsv7v1lFHQy7IEGdTTwpTI2pw8kIEvpBRANCqqJB9PdbmJI8T8vAsNGC2ivXpLaghe3XnzSZRk6WIF+ZVV2zv2NA2X4LE0+jMm4/cnhQcQByxGL1iKhjsbnUm7HLh8xThFsI1Fi9qY6dkN7TMifsdmiwtH+BVqVbN29TWER53KTLFP3zLZYcceOVy3DiT3eWlDmjFe3Knc88pUywSUmX09yNsgMEyPslBLeCkw1HrkUlbv48SM5wHdBVf1V4pyeciHZp/81bL+aGdMRyvhJV1cLMAz5d7iNf+wah//DQHjn+qzAUpIVZQtcV4OS3Stlyx0Swpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725159520; c=relaxed/relaxed;
	bh=sEYQaVWhtcXYrNgMjfPkzqecGeZhydezmlfqmaFonPw=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=SXuRzmQYF7H8NXlwIZF4kq/qCFlGx9dF4oF+WgHDCr6JGSoycnVU+Cw+RrejzhXnkdp1OsnZi3AdaEgZXXolILcEXPOsKuMPvzaQEKIsEqvttbLHP18LDHYNA3rNwICXaqceV0D3hmxfqWAg/j0ernG7LrJLwsAggk0j1z+rw8crgdkajGIg2P0k97P4gT+DVfEXOn3e1URhi/xyovWbo1gk2Acn0Qbdo9kxe64ZHhCI+fOxW/fgw+JTDKtQql/M+gSewSzlN/Ib0VSCbQgcmNfF8xeylz/cnCZe+G70m1IJHr1HoiUMXqqpTqlJLE46JjBygmkuvtFIfiWOYjRKiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tLq3tt7K; dkim-atps=neutral; spf=pass (client-ip=203.205.221.233; helo=out203-205-221-233.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tLq3tt7K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=203.205.221.233; helo=out203-205-221-233.mail.qq.com; envelope-from=kyr1ewang@qq.com; receiver=lists.ozlabs.org)
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4WxGmb08Qsz2xLR
	for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2024 12:58:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725159508; bh=sEYQaVWhtcXYrNgMjfPkzqecGeZhydezmlfqmaFonPw=;
	h=From:To:Cc:Subject:Date;
	b=tLq3tt7KS9gk8VXPWCjZ5JkX3s8H+SxI4cTw99HiBh3OIbF/WTt225YcaDSzBXoLs
	 nAGYBoJmKexqIMNyfldkyjCAiqQ4p/jQtaX3EqigFjvxxrthg5gunSImW5gvy+uV07
	 6OEa1AhoxyXC+O2Dw8eGmjzHWlnmPPaw2QLcEjZY=
Received: from kyrie-virtual-machine.localdomain ([115.156.140.10])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id E563A462; Sun, 01 Sep 2024 10:57:22 +0800
X-QQ-mid: xmsmtpt1725159442t3ke13z21
Message-ID: <tencent_6102AC554A6662684C1830E6276FF924C309@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3yQdgsnGFebaclwe9UD86J+MlV7COJJWZbzpn6CN/HdxASchGGe
	 klChr4+AzC34kaA7C5a8OSQXQc/UMUqjRFBi1r5CsmAB3dGsgVPzGKONZR1lB3Sd8yDMFEjeSZ56
	 E3jeQvGzzDvdpjnYkAnNWzOdcfScgKV/cpyEt5BxMzkD5tdBqwionRSJc+Yg8WQe+quF5J9AHte5
	 +VNXqYvDZK3M6JCOy3gwA18FE26q2ym6zkIbnP+gXjo4uNEy7zVY8HqFyIun4d+rkA7U9zLQ5gHp
	 wqGrIIGp0yVahshWPeAh9Cc3EBM200bj40mfbDTSo3so/Ib8paHvHxXxWrQ4ooOlU8UtoFhvyad5
	 F+nC/Z1FkW7Heh7bGzSh+4IFVgcGYW9WniuL8fImokxVS4tTFZPwvRQlS+bEPQ9TNPe2gnqdQYi7
	 VH37PWoCipJGTJRnM0b5P8NZEAq/uBVpy8rJGfYi5Nty97gYwARwGLo2ooqdCXGBilqBCEGpl5T4
	 RnI+hqnsafhYV0RwNm+xd1q/m3E+RFAiC6MmZq3sfYLJ4ECCjBhApok/zt7Zmy8gt1mhVDxecvdL
	 zDD4tzLzqfaJNZ23ayzpP69LcEIGEQ0xfez4Ck/ByZKLPSfpdlketKvSjzIycLiA3lsOeIW9lLi0
	 1U3ty9RL7z2aJ5HFfZWRTQn6TuWFyCBUJ812gsoQ/JomCw2yb/be20axh+9uEq2aeuMxFDvy9+Ar
	 d/JkivHD3EnOLkNPtyfVPL0hjVlBltVAoWknoxSXW/MVhr0NNYIfXwnk6SFzZ0nvj89Uz9/AMOi0
	 Zz68T/FKKEXeCpSXb07oKR30h4sQ6c924X/8ED1TVTt5cpef+s6kCmBcTZu25M3zMYYpzctgXWek
	 6/D6/aVeuLxzPP2EWGu9QixaPx0QEqDMeSD8x36Hqui4A/FgCnpj05Csbx6hDOPtDfXrMJKOPnsu
	 px8t7bGUhJgtqbgMU70PRk7f0FRqhq3pgoRQlw28SAlDQwUZckDA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: add fssum function for fsck
Date: Sun,  1 Sep 2024 10:57:19 +0800
X-OQ-MSGID: <20240901025720.2114485-1-kyr1ewang@qq.com>
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
 fsck/Makefile.am |  3 ++-
 fsck/main.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 5bdee4d..b7f0289 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -4,7 +4,8 @@
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = fsck.erofs
 AM_CPPFLAGS = ${libuuid_CFLAGS}
-fsck_erofs_SOURCES = main.c
+noinst_HEADERS = fssum.h
+fsck_erofs_SOURCES = main.c fssum.c
 fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
 	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..abc0a06 100644
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
+		" --fssum                calculate the checksum of iamge\n"
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

