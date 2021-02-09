Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD8B31568F
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Feb 2021 20:13:57 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZsxv2564zDspj
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Feb 2021 06:13:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612898035;
	bh=ksydrLS8UwRLajoCB4fDkhKi8NVQtT8YW+8+KXKJgbc=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=T2BRBrWve/mZCyDaCieF2w7cknar1XC3fEcJOqNeb/Cd94+ER3eHd8p3jfrziyejV
	 eF/pLd29kdaBwszWiWbU8hVbdMzxiHe/oLxnPfZ+qZX/gDXFivArJabMBU3iiUUzC/
	 7avDbM4ppItKCrabfF1PDt2Lemyz4oog8vf3WzyjzEYy7guu7zD0qpdWmPGRIMxS2d
	 sm0HMuH/KEcFZBLQ38zmowSFIqS+IS7To8YwVaeJdQDf+5UuWjP3zpmmChNhGdopPf
	 a7cGsFbzxqxhbpXm+YUhCNpu4moLol10O/BCq90V7NJynMZekejViU7cEkEY4rX2PB
	 MCvGLhrj/Of+A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.30; helo=sonic316-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=UI94Pi7p; dkim-atps=neutral
Received: from sonic316-54.consmr.mail.gq1.yahoo.com
 (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZsxb0vDKzDshL
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Feb 2021 06:13:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1612898012; bh=z6Axgwdyd+vTsyyrN2uR7txvmspDtWY2tOhfR+9I3ug=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=UI94Pi7pG0y2nbHklNo9hfZoP6HxMG781IFgPhOOjiCWlVvmNCx9kqUnRUlaTZ7zXORbjfCyoZ6x0h/lHUBrzI5nGmuQqMsNK2As4HTzKEV1W52HAqwIPNLbORuFLScueCgceiMbjNkHOQ5bCP8QG3P6LGAequGJnbc26H+s0iM0mBbd7Cac/Hdi4Qs3YhR660sRhw4Up6Mg7166SN8xiXGlkhxcy1nwzV9bNJ8u9r9ARtzPLasKJtwl+WswTTl+bXAdyrqodiu8Pn3HgKPSwD9Su458+P/lqpdC5c7N54idGoRnEMOwOi+DluwXys4PvETNReRilFNRY8f7r2HXzQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1612898012; bh=lK971ZsYDmnWKan1JYeDffHIlr+QHNdGEjwrT5QWNQy=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=JX0cjJXgO4QcPuRz7JoHYF00T6JxOuksC+vchuyyqCQ7A0TE0agn3N6Y7102YmnibyXk2FUQq/cwSGm+AEgczSRqkcCSyob2a1ZyMhkXeCNWeVdflO1nKapsTzHISadWlXt92GZAtFl3eiFqJ/LK7jNNNjiqua/mZmndDY2/yodBkxk5tsCJRaIpMRjKHy28EKhmMVn4XcHpV9GhP3LTxfYFrDEGf8gwf2SLEye27zZFyCVAzIzpo1b0kdKVLTMavdLfDwT/rQ8iisU3YjtJ1UfTrM4EpN3OUuYGOJBWWhIs8Y7XPDAv+GjQ9PJi1KUBA+5hYrCyNBqR/RQC96oFaA==
X-YMail-OSG: npf.oxsVM1nyW8iyyZ99vi.sjMI9jlNsj4e2hie2FJnGMxRAMrpvmoh0sc4d92g
 rEA9NrSey03xv.T.iLiyjBwxgZE4aYJqOrEBC5e5remanGxOVenPEkAWkmgmstxpQqhZsOwl6O5V
 czCkz_j6Ly.ujKvHWKDvM6xa1N7bzcEy3kFGmfH5N17QUG9pgf9drdSTy1UZ8AEIwWakD64oc6fL
 DsA99EMZLo.swixm9fs.w8th2VZ5SlaPVxXsE4yUKgTPwMwfCwX4S8smS_XAZj7A8bgTSG0Y2rU6
 kCME4Dc_RGMDIMY2knK50kipH8NEwv7XK4Ml2OeGCKJu8UZwBeP383R66lyJYcj6q.tqGWHGwiTF
 6IRvGH5nPRDQAO4kbIooEplzchPZecAWqbW2Lsa6DerN6_mTV4WnTV2o72.EAIpFEBIQVjOkbyho
 4pEbINSVFqT6Pd0.EhT3eLVJ4cok8nIeknpJBrceN4nTq0dFXM0TPVSi9391Vn5xcmi45rJZeDWP
 IedsJXLvr4pL126D7XL9740rFErcvlSBOPjGs.w878k4TZGmwe2mfb4xKWXjgRGvY9b6hXRibVIb
 SDXCxli1iwBUe1cg8GDA8eNUi0F7ImIqceNoPFdhcejtmKiMvCod63HggQvg8KNpT3hf5RewbKCN
 VcMHCKWf90x.Pm8V00q7Ksk84iNTzk6OTOYBKwPXPTgUUz5OZREEO2UTZwXOoegUluBigzvwn1x9
 4pWnQDfPNIzuB74qyFJp_ibSdhXpVqZXwbMdwEXyB1j9gOVUCijNmZM_MnfwNOrYjeXonM5D9_O7
 mhzqMgYdwiB0o6wI2TE_Q6FX8xt4rXJALpcbff4N3LbEsNUxk9pNHIU1qmz60c8rJQ69c.n_d9Ur
 ZA1OvrkUaVhXXZqh9QVmmYZJ9AG2zr0AhTK62ovtZjpnxUvsE6D0BfFIItHBD4ijN9QQK4pWUZUU
 v8bXuQO.QHUYhetzh44EBcKrhZjzHf6Nt7An4DD9zirEdUA8ET0zxKlkmbJEfzrrUGJryO4BisF8
 A._bLou9GLY6D.zZZSLF4KqcxxQ5ztuk9w8ZCD4MdmPiz6eyb82pyBKRWvooNF_KZ_PJaosXAqg0
 lzC82nhUshYpCaKeBa8YNEPS7kO8GubYsnpcpxV8Sun4hL_mF70J7PdFTev3IHxEtA52FOKU2W9M
 bVh546XoMnRX_gNkqC2dx6kjnVKmYUdvzDJZPQZDOCTynD0uRczjKDOoT7MB7tu96gC59Ipnwk5J
 TpYaN1Q8zxfxEdlGTTMnr6cfn5Gx7yxqgyxSsCQID6eZSDtPlLGdzY3Yo7OOMhgli9..rbakquBd
 8xYuTOF5jJjP2mD3NWu1rdZt4ALGKmYqrRcHetVs5zPpO6jq8cPYZe2snTkePd0_DzJAVLBQKY9O
 k9jCwkkikGdeXITgg7s2Snze5u4blyP3yMsrdL6h0pGI97TCoP5CSRxwUPHAPAZHC04aRnQsBu5Z
 NENdIbf3_UXSBE5VHXF29EFb4mvYkeNE85PwFlasoQ_zjqrmnOS0W_hinNtJ1qk05iK3fO8wgLAb
 XEf79vhhN8E5mLqZxYnyTeCytfAZm7osZVfCPEYcdAkJucvror9cCuiUMzHnk6ACvaSX1ENOJoJP
 NJp8rgEhyypLKCTNzuQAyVEjqIkt2KrVivJ2j4OgzfUukHO32FPqkpuPzKYh8hQgY1LbV4Jbt_iG
 fy9qGDOni_KHwg6QkIn.J_7rvffS_LueHdLZL4yTRn0.YLwh1IP9mNhyHnFLO7iogO8afVmLFcwz
 i4keJAU6ligqGMtFSMXGJQahbmUcfKrWbeQg9.jfDXxU6tTZHbOs8v552g_YetMJAIxL8g97P.pV
 czC0tLguYEiiDA6MN6PeAbmvuLDOVa1dMsgCwboQxRD7QxhVMmz7EGBTkhaoNg1IpgvFG94q3e4v
 Ak13fAdGBpM1U9jOfFZGEPyo3mATWNIFfmZbrN45DJ1HpIXXyfNzZQ2D8hmJwUu4I.qN0YgaCPn6
 2b6AGvvKBG4eEx5MWSz8gzj9XGHMk8mwI0DQ3qnd3ZY89gTD9g39om0wwg26s8CSQU1TGeKYmuTb
 6_6M2640MaloxlwQFDFrRpiRaZnzMo6NbhHFZuDdepZtH6P61fRxhdWlcJDYHMMuAuJiHvKHEf1y
 56me1bEGQCQMZM2NkXOtzQ8FF1zVsbxeRF.pO4fJ1zfTBCrwZ7WMOOWouks_Pa2xTtuQW4nUFIH1
 5HCXELENhgIy_fNiIAA0C6hWXNqTTQC6j_vmkrFwRySdUmrLbGpZpYRtqakP9GnbDmynE.JSjMUL
 7OOie0NHnCLcvjPB8OL1HtIt.Bzb4doejGY_nEXfxKTrVqUTLyBwovT5tUGNgmcxkqegJLVKzbZT
 DSYV9dBwS7BQ8EaTOadwEawVOsfIw_9e6jsgyx5iZt9NBX5CnpiPzNC26S0sWhyVQTJr1BG4dS66
 onQm5uk8yibnmA2DYD5Vv0BSwdEgrn15nvnhbDyfV
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic316.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Feb 2021 19:13:32 +0000
Received: by smtp417.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 012b4af943bcffd954757582ae3c0073; 
 Tue, 09 Feb 2021 19:13:31 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: don't reuse full mapped buffer blocks
Date: Wed, 10 Feb 2021 03:13:21 +0800
Message-Id: <20210209191322.8902-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210209191322.8902-1-hsiangkao.ref@aol.com>
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

Otherwise it could cause data corruption since erofs_battach()
doesn't support full buffer blocks (and oob would be misjudged.)

Fixes: 185b0bcdef4b ("erofs-utils: optimize buffer allocation logic")
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 40d3b1f3f4d5..e8840ac5dd31 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -155,8 +155,8 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 				  struct erofs_buffer_block **bbp)
 {
 	struct erofs_buffer_block *cur, *bb;
-	unsigned int used0, usedmax, used;
-	int used_before, ret;
+	unsigned int used0, used_before, usedmax, used;
+	int ret;
 
 	used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
 	/* inline data should be in the same fs block */
@@ -177,7 +177,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 
 	used_before = rounddown(EROFS_BLKSIZ -
 				(size + required_ext + inline_ext), alignsize);
-	do {
+	for (; used_before; --used_before) {
 		struct list_head *bt = mapped_buckets[type] + used_before;
 
 		if (list_empty(bt))
@@ -203,7 +203,7 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 		bb = cur;
 		usedmax = used;
 		break;
-	} while (--used_before > 0);
+	}
 
 skip_mapped:
 	/* try to start from the last mapped one, which can be expended */
-- 
2.24.0

