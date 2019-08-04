Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D080906
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 06:10:47 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461S9r6MbbzDqkP
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 14:10:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1564891840;
	bh=rosWmZ0wayvP9I2/4msDQRhg+clqUJHGApdu/FChTyU=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nDM/5DVblw2iH3uuXH/bUQaihxOF1eKYshJLRPsNMqWFlLMPFLR4r5RKeqGYVaW1+
	 KBgwcJJ3U38JyCRzzQMGe7xfaKTLh2Ezj169HihW4NYFk2/6t6TsNUaiyYjrvAKVpb
	 9a1kfJlY4RiG0fsSoGlCf01SR4tFahB5k/UZPjeGnZnZ3MQ95hA7OYwzZ1m8IfQzGu
	 oPwQF3+ZIc1oTeYBkXAquTBoyymPxMnhCEdkyilvUER1qUhw30XXum3d4iPKGiIGWc
	 98n5rjDcwmLwpc7Ts8yS48SygbIAFbGJOTQtivENTmKqlg+VYHomNlfku34aW9Ikf9
	 /mwv0sEUKYBUA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.178.147; helo=sonic308-19.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="CppbRU1y"; 
 dkim-atps=neutral
Received: from sonic308-19.consmr.mail.ir2.yahoo.com
 (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461S9Y1fVXzDqbx
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Aug 2019 14:10:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1564891801; bh=cWeWof/sA4Lqyn68CX7Oja7MNsCsouLidpUDVYRi0nU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=CppbRU1yIx88mgDwBDMQg9fV/D2rNylCdg8aWS3ZEqu4+Y/61yUiGsV+z+YxrM29aRmrme6kPMzK1NSHIGEpj1J7Kt35Pbd2qT7tPwDcBbmxmIsy0omMQO/UR5I8U16fFw2oQa6cD3vOM7j9uCUXSX/2/FoQM4YmSfq6jeyg0yChrc4buHwEXibBfOkGfvJAeAVQHZEwK+Ba6Z7hi+JsFJ2gHyErA09bZ9lZ8AsT4lNj03Lxp9yVF+nFGr/wV6g7xKaRhJpdernzw3R8j5aEBY1jCOrMpaT9rKYU+uK/7rnvo27QqI4BwsAiCG/zRVbGsdRnod2H+vrq+817h04T7A==
X-YMail-OSG: RV4GqDEVM1nZ1VvVZZONIUsG18S2bDA2szns0p0RUZcNffzLAPzU3XFqG6Cyhv8
 xedUuX9vB.X8v2Mx8HYAeH.5BwZ28y9iRl0C8tUnvv5mF7ntVNrtHF9qCRy4ujuByPrUpuC6fBfK
 9W7SeS3ASKnytgdweh5AFbojSinEpC_baNnQOPZ.5VpTWJPqqCmpeKJgpwDy_bXAHRD2eLt452_Y
 aGykGNz.8o7uST4r8GVeAHK4MSOrHJmlhPJ9rOmx5W_Q28pJ1XRFuOjfjqjCX3AGW9c_phmsBrBM
 VJFX8RPcZz9YvPBEyeFz1teTa4yRz3IE8VGmoZWA0CuN7O6z__ODViE.tiuWYadga7fsp10vPmi2
 peuVr0xVFrL_SUzgAO3O9TeYMloE2vwEeHBlUPOjoL5HPxoYVnL3lDornQyQsuaFKBPSfeScp3vE
 Xd6n8RBRVoXWXS9oZWFxrV35Qk1pzJOJCZXLYzSzCogXZJiC0UDXcaAb8uMk7c3aMSYCi6kMdD2k
 Xci2hAIoG5OUiaeb7v2YMdNw0McpD.m7e2cUxWqRDkbjY4cQd5_VlO_Kxpu5Gdq0.6.UEJmGd88T
 kv65IqYV.VEkbSMSPRoNgz0j8d7m8Yycd9DPvIualzsH.JCgXnFq9jiLJUSTjjSQ.DWL4KaTys4b
 356Sdqo7Q6VnYy.PGCmDa33pvr7DxtnnKnGI1ULaCN7ecv0WxJOmr_hKP0uaxOsUNZrOinwr1wNo
 TYagxDvq_wWjiYIcwPsgdsvJUXEhfHGKXHX3ThYE9qsBnd3FDL3wmQXOB9J5ukVZCI_NPPSIYtvo
 CsxT76KJhmkdjI3G4G63SlBEwOiDP3.7fYwGm9i72XQkeD5vtBPOpU5nm4SVj1p5F5BKaCEBYzWV
 nZEV6o5SjlzlQhksltkfGU3bkLHT2vNP.kxiNFKR8Y4q2gfi0fXkqm03SqKGlDuy.pLzni3lYFMx
 8tIuHze.AyU92O1hVk_UU31Y_72p.XHPYGIqZWEUcrbArUzRQSQsLy0196ksxeu0g4hF7grbAfCq
 DlKshgLbzA_ZMn.S4OUAhgp99gA23vVEAw5uR77Pi5Yl1X4qwbWKbJubHE75NEKfbI817JwfC..G
 QHzriT0p19vcHSig_4fiMCq4fhW0H63twM2rCKLL9xVjiXsBK8T86Rq2sPmFz8myg1db_oaQRqoo
 1wC8rVCW7f_pJFa5vXB8y5laPuADvxPT6No6PmYVi5tapL8MRDCRZVQ3eluUPm5q0lGVGAedSPTY
 d8fL22w6o419_EHs-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 4 Aug 2019 04:10:01 +0000
Received: by smtp423.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID ef67362e88165f4479b5ba9e2ae9a9b4; 
 Sun, 04 Aug 2019 04:09:58 +0000 (UTC)
Date: Sun, 4 Aug 2019 12:09:52 +0800
To: Pratik Shinde <pratikshinde320@gmail.com>
Subject: Re: [PATCH] erofs-utils: code for handling incorrect debug level.
Message-ID: <20190804040952.GA32699@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190803080310.17827-1-pratikshinde320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803080310.17827-1-pratikshinde320@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Pratik,

On Sat, Aug 03, 2019 at 01:33:10PM +0530, Pratik Shinde wrote:
> handling the case of incorrect debug level.
> Added an enumerated type for supported debug levels.
> Using 'atoi' in place of 'parse_num_from_str'.
> 
> I have dropped the check for invalid compression algo name(which was there
> in last patch)
> Note:I think this patch covers different set of code changes than previous
> patch,Hence I am sending a new patch instead of 'v2' of previous patch.
> 
> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>

It looks good to me, and I'd like to introduce "EROFS_MSG_MIN / EROFS_MSG_MAX" as well.
Do you agree with these modifications attached below? :)

Thanks,
Gao Xiang

diff --git a/include/erofs/print.h b/include/erofs/print.h
index bc0b8d4..e29fc1d 100644
--- a/include/erofs/print.h
+++ b/include/erofs/print.h
@@ -12,6 +12,15 @@
 #include "config.h"
 #include <stdio.h>
 
+enum {
+	EROFS_MSG_MIN = 0,
+	EROFS_ERR     = 0,
+	EROFS_WARN    = 2,
+	EROFS_INFO    = 3,
+	EROFS_DBG     = 7,
+	EROFS_MSG_MAX = 9
+};
+
 #define FUNC_LINE_FMT "%s() Line[%d] "
 
 #ifndef pr_fmt
@@ -19,7 +28,7 @@
 #endif
 
 #define erofs_dbg(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 7) {				\
+	if (cfg.c_dbg_lvl >= EROFS_DBG) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -29,7 +38,7 @@
 } while (0)
 
 #define erofs_info(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 3) {				\
+	if (cfg.c_dbg_lvl >= EROFS_INFO) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -40,7 +49,7 @@
 } while (0)
 
 #define erofs_warn(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 2) {				\
+	if (cfg.c_dbg_lvl >= EROFS_WARN) {			\
 		fprintf(stdout,					\
 			pr_fmt(fmt),				\
 			__func__,				\
@@ -51,7 +60,7 @@
 } while (0)
 
 #define erofs_err(fmt, ...) do {				\
-	if (cfg.c_dbg_lvl >= 0) {				\
+	if (cfg.c_dbg_lvl >= EROFS_ERR) {			\
 		fprintf(stderr,					\
 			"Err: " pr_fmt(fmt),			\
 			__func__,				\
diff --git a/mkfs/main.c b/mkfs/main.c
index fdb65fd..33b0db5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -30,16 +30,6 @@ static void usage(void)
 	fprintf(stderr, " -EX[,...] X=extended options\n");
 }
 
-u64 parse_num_from_str(const char *str)
-{
-	u64 num      = 0;
-	char *endptr = NULL;
-
-	num = strtoull(str, &endptr, 10);
-	BUG_ON(num == ULLONG_MAX);
-	return num;
-}
-
 static int parse_extended_opts(const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
@@ -108,7 +98,13 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 			break;
 
 		case 'd':
-			cfg.c_dbg_lvl = parse_num_from_str(optarg);
+			cfg.c_dbg_lvl = atoi(optarg);
+			if (cfg.c_dbg_lvl < EROFS_MSG_MIN
+			    || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
+				erofs_err("invalid debug level %d",
+					  cfg.c_dbg_lvl);
+				return -EINVAL;
+			}
 			break;
 
 		case 'E':
-- 
2.17.1

