Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF8034B418
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 04:50:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6lGg0gypz3btg
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 14:50:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616817003;
	bh=xpKRxQ1nym4KNjqeSxdKbTuSsk5hiF4ck9LaGFFFvYE=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=oezCwuq6IjzZhR0uyZiVXu7EMRlOD2xGxE+4xKWpbiy9UAzsjLzAh86uEHH/68U7F
	 uYeE4QjQ0IrcgaUvOKfQZDIntyi9qMrH1SwzeE5RBxqon5LpWjaYzfxALL3AM7DRut
	 Cb+xhOsQ2v+GzoIDpo3INL97aAa+Rj9Xo6Bxh3o5efTTpgZCH2G3bLsqvlw55CvsHb
	 9TjFfD/8hwwzJ+70qdZJ7aulH5DTlpqKi/BWAjUL8NmikZBLBOx45R9Y37cUgZKZot
	 7HjD8R5peZhpNmerBCLvv3CyOMpKoxs91MK8k1Uedm1f+F3Dc2PE+mvzD839tyFl4W
	 hb49Nk7mVxOnA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.84; helo=sonic306-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Af0X2d6n; dkim-atps=neutral
Received: from sonic306-21.consmr.mail.gq1.yahoo.com
 (sonic306-21.consmr.mail.gq1.yahoo.com [98.137.68.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6lGZ74W3z2yyb
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 14:49:56 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616816991; bh=AZyjOMs0JAv/04m6cOjSZJVcc8/temhTLDUFP5U8Tq3=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=gH3kfWdQ7ef+NA/8U3MxM3FUkV6L80mf8oQPifDcFydKSMA8OIRGLxKIaHUO/KuFVwkKqfzuGHG/euXXkK+YkrvvJ6kcRn65oFm2UheKS+JcVTJe0qU796AeyFeLafiXywpwzK9neBPKq1g/fPjqkRIdUC+9iedBu0btG2w2v8RmdlI3OX/BSpImBvmBOT5HezgXpd4b6hM6pLSh0XDIT5zzW1Kun5lGRUUYadBkJDAByt0W+k0vW8JYk/rqHaBpy0z7DY7cehKiiqa7A3lgiuq7QkJLVcv4bjUmM6GnO6si3ibWyVH6MBuVtaEoeRk3n5hapO8AE9oWFSrl2vPWcA==
X-YMail-OSG: YzRLW2YVM1nkvdr8YXHatVxlnNFtnmZnNtNF_tBR4AmQ7yDGOgwDf2w7uNXqqU1
 TBOsu3.jKol5P2U4S18n.5UM1nR1W8asIedeZAoAnBLLt283sOgMK1fxNE514YYdmaNs9N.l9PRB
 RnD186XYN5FQPhvxBWANSSva3CJMFSmOMJ520jONRXaexe7WnwPAThsai_QTk2J4I3KC37UqgkcI
 r229GNQ0C0435K7KrE9XP9J_anH1FA4CU0H_._3KWMC44LZxNYgqzT.K2uF_CKh2alKDpPbYxVrg
 sieLnmTrvc88IzmJ5lL2DLPPmmF5avvkXUSB6ZbWsAI42KkWcN9nC6DBxDeLPQe_25h4hUfRiD46
 H3VAQVM2pRz7wbHAqko4tfqKohUTZ3nHnbjSBWE9Mj0fSlVu6iyUS.KNkBIn3tWd4Rsq5bd770Qy
 S9DlOTMWuyT7j9NFG.kKYlFIFPMRFIltOnEzgJxFV0hrU2PQW_ziGgqVeoiH61mNDY4rBvbLSyEh
 CIyuv2IE8p4PUAAPC5W3BbxnRRA3TfsMPEwFVkM_r8eVNN0UPpZF0loxE.MZSQEjfftS2eoGSkgJ
 1ulzV3L6qgKcZb9WMZAV1sc9YrehRkmapxXnNugUmjPRkc0u4dLpyrsM_P5E69LG.CVtRzJrioFu
 It69BVBApjZEFGqfbIXNxn4f3ot2_JkMPffdGVxbU2MTygGROsAANVkc6Kk3I8Z2tkP1BY.Xso5J
 XqWgStjac2aGvNvVUhC2OKI1O4OIq.dGoim.KOhaRil0QM77QvYliia9FRP4CuCybZzyspu_1IIY
 SxHswc5DIfjLJH2pgKphlxtpSA3N67kCEr2BtswDGGuwF5O0KefbjFbNkyT5D.Kylvid1BptZ_B5
 hrjtAEo1t_CeCuiY7DsSkb2Zjksb66aa54s8Hbl2n7op8NUERFyAb6LquXZZv.bBj48PwnJ4mm9k
 kv6A4yy27auwhzk53QlhpTyLnKtcNIX2JARnLpZUXmT8g6D0.B3sQPbEb6zFSdT3QDD_Y8JTegiD
 E3etToCM48.T6S0WdwB2Gg0m._Ps2f_rQJOs3AYsRnWFWMjSAE1TRW2aoBPSlasOsCchjY1UyXw6
 Fi07YsixVnPiIPSJXCuIew0GJ_zWibSTjyaerAy2bxyST6SuhAQE7cpVEQXjApzfevlArmopQRZo
 EhvQLq5ma.C2mwHG3SfubYbI5.sZuWx4O8ugfZSfiLIKWg84VE0w2gkP2.1n0kG9M43ewK900X9n
 ZXc01CSbgcXSWjZopQuStQFZ_6pn2ZE15cpzvSbHlxYPXQvcDS57H2DPhTPYKJ9rzHlvL44QRsK4
 KW7X6L1tWw6MmqMgxHvoPzHfCVJLCf2hetpxcbHP7Xxcq7CwAQGjjeVc11wDD4d21bOXbql3.Lql
 Yx7ucBiXZCv47gRrXzY3h7O7oMebSSqc_XGWW8jSs4Ubl8i3ewmjNleVRishrw4Md4CLkQt8bHTc
 tyCayjOijP6tu6ryqI.ZcU6I9YGw7kafLAajtlTO20SAjYwbYh0Bramc8u4NHx6AMdwKcBpMvK.j
 5RXi.2u2FnRw8lFtdEXbAEyI2kM6d0ye0YzzhtQm1oT4FTMwIf2CKx1cQEX2u6WeR37I.TN2cBqK
 VSnWIe_pCzLGptBxRUgn0Fhzgzea3um6pP14vqQajqOkpENTPq9qQgCx_iH1dZADzrInOJBiOpSU
 06tC.l6ygrAsACo68P2EmVD9rHdovmFiiIYdpaTHrIitFlgfVSDeRvB1qN_UhJ_YRGZw.mv3iar1
 nbWUudx5b6aV7P_QmeHCEkIBqsrTPXAQAA8Y3_4Kfa9PGeUIFlMw8zodQ_4letvw6NAIymeHz7tU
 v5wBqf6UGo44wdxV6X2ACHTNOQh9tzSpCf4e.1rWEnJ2fKHaDJtuxAcp0VcsjS3KtfB31vdzLgCD
 bSgu.dcNN_8KMFoQNULb3O_QVN1fzkeP45bhFoIDWDGOT2RKleADOqq_5gQ5MG_Df0QzJw3qPf61
 78gHuA0DgdR60myhEv3eds_IxHPGojyV7ARBjfozzdOqNeybISGUhmbS5EEGkHtT77hz23Sldn8H
 MyIsqlL7FfuHOelg8MPv1dowCD2wHUuooyF9jTrvzjvVR3YMDDPxztYkdNoZxZI3peyJ8OWkRwit
 YN1NVhrHjSvWwKmS0lmkbi7UsBToDvMl08zzwWX23cmp0hbf8DiUYM9jRtLo4QmTjmZlY8FVNB_D
 rL8.s4nD4Q.dtns5jMuzhM9hdzkO5MG8Sn1G0GOUluvyvBcE7Vv.bLzop_icm1pkwEuMGdvhnOKe
 Ox1x63D_MDfSqAlop16tlP1E3XIiz8soCeCJKCTwU3lpUtPLOeEGjK3OLsXtbOle2cGm_4qa_IZO
 gxObgzNf065MIpMso2wWN6QJejCE0IS4McM8dtI2fKeT2ESi0US6cWQIBrmQ2zmQH.uWzE..flax
 JmfZ_IegxJZX5DjgPFlsvxn.TrD.Ot4mQceSuY4Q0kHm0qeSmel16iPRm9M0My7y29SuNfVNk0RT
 yMJ8TsFNDhwzv4ljbUGM2l9iZWwmxYDXBCX_e6_7GXuntgCxMN0YlW7vvaHmv0zPszt7m7kd4gV6
 5Hl91exXgv0WgoyKAayULenSVZ3P9p_bt._jgSyxCMkVJKKp1wNP30eGSqFQG.YoCLAhUNPuyguO
 kCxOjqrUD6qIieJ4LaK2WEQ--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 27 Mar 2021 03:49:51 +0000
Received: by kubenode529.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID b79f63fb2a60f2e9a0e41858735ab882; 
 Sat, 27 Mar 2021 03:49:47 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 0/4] erofs: introduce on-disk compression configurations
Date: Sat, 27 Mar 2021 11:49:32 +0800
Message-Id: <20210327034936.12537-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210327034936.12537-1-hsiangkao.ref@aol.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Hi folks,

When we provides support for different algorithms or big pcluster, it'd
be necessary to record some configuration in the per-fs basis.

For example, when big pcluster feature for lz4 is enabled, we need to
know the largest pclustersize in the whole fs instance to adjust per-CPU
buffers in advance, which will be used to handle in-place decompression
failure for inplace IO then. And we also need to record global arguments
(e.g. dict_size) for the upcoming LZMA algorithm support.

Therefore, this patchset introduces a new INCOMPAT feature called
COMPR_CFGS, which provides an available algorithm bitmap in the sb
and a variable array list to store corresponding arguments for each
available algorithms.

Since such a INCOMPAT sb feature will be introduced, it'd be better to
reuse such bit for BIGPCLUSTER feature as well since BIGPCLUSTER feature
depends on COMPR_CFGS and will be released together with COMPR_CFGS.

If COMPR_CFGS is disabled, the field of available algorithm bitmap would
become a lz4_max_distance (which is now reserved as 0), and max_distance
can be safely ignored for old kernels since 64k lz4 dictionary is always
enough even new images could reduce the sliding window.

Thanks,
Gao Xiang

Gao Xiang (3):
  erofs: introduce erofs_sb_has_xxx() helpers
  erofs: introduce on-disk lz4 fs configurations
  erofs: add on-disk compression configurations

Huang Jianan (1):
  erofs: support adjust lz4 history window size

 fs/erofs/decompressor.c |  35 ++++++++--
 fs/erofs/erofs_fs.h     |  23 +++++--
 fs/erofs/internal.h     |  33 +++++++++
 fs/erofs/super.c        | 149 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 228 insertions(+), 12 deletions(-)

-- 
2.20.1

