Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DDD2DCE0F
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Dec 2020 10:06:55 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CxR2N4dVXzDqQt
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Dec 2020 20:06:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1608196012;
	bh=ok18z+EpJjoiFuAE8aeO0/67hdJaAQUEI6YLCxp8/hw=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=DLXYK/+pl2w52UbPYTEXKLdMYgSslOeJBGMycpQD9rEsxCBd1WOcnTsd/C2FmoIv/
	 MI9ZEVtmQjBOT91MwRyt0hkP0CJ3C5z0e4P+qqyxIT4Fs7fG3zkvmPwMeNEuDEv9P/
	 C++sjJeSVnevFZOHhZZTuv4UrfQNRGaudsO14SinSPE3c1XQwHYSz4Qb3zbWf6gREd
	 +sBhtRpDDhvOGKzr/UJ7Q5mgwSQh1GwkStPle3nL46ER0tlBbpWnPZNezko8u3Lpp+
	 V7pDodVY6B3dZqC/X9vzMF4d9EP9uOgnfAweWpCgu3Tx3caIUtmJBvCAV5kfiPMyy7
	 bZVTlg+pDvA4g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.82; helo=sonic306-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Received: from sonic306-19.consmr.mail.gq1.yahoo.com
 (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CxR2D02fdzDqPv
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Dec 2020 20:06:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1608195996; bh=C2yVReNdHDa45D0g0PxriJivI/gJqPUWfChXjOwr09w=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=CtJBZ1bAJNp8cCa40WUkU34jPkXwT9Uw9v8yzthwFaQC6snzuRKC7HwoP/F15QmZ90ggELraWjF2wk2WTTJO8JLxIswZbrEusVkjv8f8+K43xy9OQzTt+Lqf8dLFjCl1HGCXTwmT9ew0sbQ9SoijZikMmlVtzC0+Zw8QvkSep8MDuPQ6EaA6jVN1tQTKg89/2MobneP0o2Ar3lWpf/hyEGVTlNfvRozBnYkFBGWKP3IW2A3AqYyWOwN06Vd/8bk8OCvx3QQdWmpdFkKiMrjPerJtrGx/3LdDY/Op2AheL9aOSR4uEH70iU1jyO/8c1E7BLmK6M1N2+uaIb5GSPxdew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1608195996; bh=TkStjG94p4Uoc3x+bUSpnxunDD+V19ypmag5/VCTX9Y=;
 h=From:To:Subject:Date:From:Subject;
 b=JccsUcPkF6G+3h/LUassax3ckmBmU5lKy9EpMgXK2wTy+mkUfeij063VGFRSFenTsuHYxHlDsXKonAy4FxeH82BupoXBF0EFNDGnaiqEIoDB9fqQjxAgqSu53LMBjv5oN72VpZVQ8Ywk3AhdxxXO97GBvOVIump+0rUgyYVJMh+qX3DRpSsQd5ov7gvccxYDgO+sPghLjdArgtmIz7RiA6XY8oQq81YAgStafUah1koAJy0YfaSX+MF5s/ra6xmpeP3LimYio1KaNIgg1YJa4pFHtM92lKxBtdiKeg90SBe8INPF5ISaWbwNhD6Ffd1OGEYp0wRVuxP7D6l7IZ4SGw==
X-YMail-OSG: RoQ_YXUVM1lErLmrkzPuxmbeCsCvXakccBUV4Oj0MD0B3_H9FZnh0vofLotYJWb
 sjPVtNC3syaIR8v.2H1xvqy7szoKExj0Hs8GnJDyBg2Q0GEkccoQPVeMzKlxnIO4Eb6t30Zmk_FS
 hxvObHrHI__x7oHrTJnxcrB1ceDnSgK5OI6d0c8ZMx8WUZNrEygSURBxGwdTY.BFoMW4G0tnf6Dt
 gPjhlmsomechRN1JXd0gmHBBplyYZ7QXp94ArIAIZW8XPftIo_j87qCPixzAzPbT3ytYSVIZBNcr
 RP.osr.pRy10nDgtxIx5jtoNdllFAN_C9DGcpv1cjnTUpN7cqwJSkNh4R7.HtRKEKPp9Oais6p2o
 5g1dJ4xJUUpgwu9X5i0N6Gw_70nWe1f10jrJ5DolxsweOyOQ2b0xPhhje14kQ6n67Cy3atd_aL.9
 yB.7HQ7NnQnzdcyAkxpigdncp3UCSbV1bZe1Z9bEa0psdX3mQUOpg8Dp7l0_4FkXrGPJwn9gC80G
 DEBTHQ67Lu_iCGydDaSxr4Cz0wfSkHqpatXi9K41th5onm73WjgPaXnYgukLSaBOAV1NWscmd8LC
 .uE.NzAuQuI7Hh.wbrSHvlqblZafOlJ2POEnEOu6GKq.QolMPYz0Lmd47ONUwPhl7MFWGpuAGWmp
 QxCQhXoyLrPpADa3TjKktutBLVQ0QzQsfWDUbCFIDD4dgyqYlxQTxN1LL.0_piqXRmQQU1Xz1Dtb
 TmossJAxguIWmsvFc9MDzIr6DoCgwO.rRaE5a6ebOJNL3wdQTi5fiqvVF6DIT21wFivLHpgu0utY
 iFi2ooTcD._8of1WIhVrwI.lurQ8t4mrv6sCGNHJm2n15jg3TREBwphKHelQbp69BHltixI8nPo1
 M.sBFfLRPfGGPrXaawKhq2VAUxL_5FRSfrLz0nLwWAIBePTFnjZNBVJLgKtFOjQ0q26yZh5y8CBu
 GymWbDqZ_zSF8wu2ulGzi5zQ_t3.z7uVOHWVfrvGElfpzKFRPRxSSD.7ACmA7OMsowKR8Sqq6H.X
 qGR8jGqAIU.n5R8EjLp1GjPU0xVLRW2awDWvoktBb_n7Ae7ryRs1NOx09RYein1B8pL9g38qs0w9
 BnTQJ0kMz7Df7bgNJF8I0wzBwYJEqeUUTG0QL8dqMoawopWQRlENEFg_u_sZVAtzf0rsAQY09OjX
 hujFGag_ix1bHxypTzcB3NsV.KxxJe10W4jwpxDTeM_aAFgNizzWbbZNt1rxdGVBO4Non74D6VRa
 jybxDOLL8HE2YM1h_CvzTIjszo3GrdP_rWLdSYXgqFXao5hihllIjVMdKrlA_0jYuiTUbZ50dt6q
 RweQ2wFh7TG_zq0DSqYPbx10AERSlDBCq7t.P9GG0wfBsoEY4ykzDiJXz0DoCWxQwDAeg.6bIRk5
 RxZkblZLduCPjow_2SaOcGFJ8VF8hLvRlU8gZdqK.w2l6_jq1fuTkKhBdGwGA4Rg7xsAiSTyEsoB
 dyXDX5I.IhlGeNs6_jfymCaB0WnFDcD2b0AkdkSZrHAr4IBIjcy.hiJBCKJFJF0O.CNNOnof4eFN
 UaDr7UpM3xDhX5a8XV.Q0K7iBWBxwBb.fRvVtPuKSolsgqiB.dFWV1ZQf55SBzd3wkiswMjDZcdI
 WoBoy0jt.cPYDxO6CwL4Wm7m36D3nL5MQ03ZDx_umk1NlPi4mU4iS3r.wugpgUb6tt0.Xa2T_deH
 fWTdr83YQsIfVPD298nLaRQiUVCYZ4Ng.y4PXKHM48lF.V1TUN5h1.Q.ddye3i2MvsJLe4yc7P7u
 88v8fHp7slFwPICg92NR8OBKb6my6YA1fCGTUSwkGYw0Osv_xxSrN.C2t4km3c116v7IVLHMcJM8
 7a7a._lkQKOiSe5Iy_8XJCUOkpi57gtgbZAgkRFvwRd2JsEYndK49YW4B9wI7AYHVKNKf8_0ZvE6
 3PKFnybs.VBIyAoxLt9AMg7QTttfvVr2ALvyP1QRdtoPhzxy11GlTeyTgVrWC8P4hmJDamSoMhSR
 _lJImwo2tIaYcI76O.DfzQTJqgK_73LAXkpbk0Bzu0XXeTWb.GWN3gMQyiKab46bZRQaBuom2urh
 2LjMO8BLibigwGhKK5tkOdp_D1RSRRmfu5ZUhE6G_QkKnObMcZ39ZAutXY19FBzZNKgIYGBYt2iC
 LiYcs3cCnXAnTXMHYPoUbtMEQRmnWNoVYJomhBPNzW3FUTEFMrgvoym1PAHEVM9mtxr4.QaCdxqJ
 djiuVgjTtJ1SK3NpFYdOpOcvCu_sDXHAo2GtcxbL0NYN9cZd_D5.Iw4t2idI9r9tDoCZzsimptce
 g.M8V5DFh4W8PAvcnQ0a7gDPuQG658RmHe6pKM5Z885kmeNt0jmUGZo_VzsYsNHA1FkatanNaoFZ
 AJ5GRvizdY44T8Evw9fzn.ft4LNv2k8BoVO_a5uZpB9kjA38-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Dec 2020 09:06:36 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 955717531d44e0ba6e91fa5ed46b28d7; 
 Thu, 17 Dec 2020 09:06:34 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fuse: disable backtrace if unsupported
Date: Thu, 17 Dec 2020 17:06:25 +0800
Message-Id: <20201217090625.22738-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201217090625.22738-1-hsiangkao.ref@aol.com>
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

From: Gao Xiang <hsiangkao@aol.com>

Let's enable backtrace conditionally since it's a GNU extension.

Fixes: 5e35b75ad499 ("erofs-utils: introduce fuse implementation")
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 configure.ac | 3 ++-
 fuse/main.c  | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index d5fdfb8a3d17..28926c303c5c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -96,6 +96,7 @@ AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
 # Checks for header files.
 AC_CHECK_HEADERS(m4_flatten([
 	dirent.h
+	execinfo.h
 	fcntl.h
 	getopt.h
 	inttypes.h
@@ -147,7 +148,7 @@ AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
    #include <unistd.h>])
 
 # Checks for library functions.
-AC_CHECK_FUNCS([fallocate gettimeofday memset realpath strdup strerror strrchr strtoull])
+AC_CHECK_FUNCS([backtrace fallocate gettimeofday memset realpath strdup strerror strrchr strtoull])
 
 # Configure libuuid
 AS_IF([test "x$with_uuid" != "xno"], [
diff --git a/fuse/main.c b/fuse/main.c
index 1e24efe110c2..c16291272e75 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -6,7 +6,6 @@
  */
 #include <stdlib.h>
 #include <string.h>
-#include <execinfo.h>
 #include <signal.h>
 #include <libgen.h>
 #include <fuse.h>
@@ -168,6 +167,9 @@ static int optional_opt_func(void *data, const char *arg, int key,
 	return 1;
 }
 
+#if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
+#include <execinfo.h>
+
 static void signal_handle_sigsegv(int signal)
 {
 	void *array[10];
@@ -187,7 +189,7 @@ static void signal_handle_sigsegv(int signal)
 	erofs_dump("========================================\n");
 	abort();
 }
-
+#endif
 
 int main(int argc, char *argv[])
 {
@@ -197,11 +199,13 @@ int main(int argc, char *argv[])
 	erofs_init_configure();
 	fprintf(stderr, "%s %s\n", basename(argv[0]), cfg.c_version);
 
+#if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
 	if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
 		fprintf(stderr, "failed to initialize signals\n");
 		ret = -errno;
 		goto err;
 	}
+#endif
 
 	/* parse options */
 	ret = fuse_opt_parse(&args, &fusecfg, option_spec, optional_opt_func);
-- 
2.24.0

