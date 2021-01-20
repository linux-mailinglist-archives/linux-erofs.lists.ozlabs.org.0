Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 019F62FC6D1
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jan 2021 02:30:56 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DL7JY1w51zDqlw
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Jan 2021 12:30:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1611106253;
	bh=tgV/h1YGy5r2ccHvxZklhljGMIVLcDolxMHWr2OZue8=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=ikZApgD40fEBelr19XGdHZAkcjTjRlbd+GTpjqANjGTResjiCair/CNN29iQwfLcw
	 7xrpuQ/wT+q4TBfZmDUXp01qck89WeZsA9g2V8s1PC7omBKx/cYdxJcikS9wRXhW30
	 vNDAKFu/ptdy2H/yd6KVyUDJZ5CsgZfUne2mLBDW8GfTSg2dBc7YXKhWph4V5y7tmg
	 OREIKshOpuhuZaJcaFVagSPQ3WMc2loS9bj4e5CTIKcfIxiZmm2a99qIaDo2Q/UBts
	 2s/X42rGns16D3+aR9piA6gJdyTmzSERuR4gjzvlCs9BBZp+jWUuigYU49Kf48M1pr
	 9IJaDZ7rxAZmQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.206; helo=sonic303-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=MjZ4X4M+; dkim-atps=neutral
Received: from sonic303-25.consmr.mail.gq1.yahoo.com
 (sonic303-25.consmr.mail.gq1.yahoo.com [98.137.64.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DL7JH1nyqzDqbk
 for <linux-erofs@lists.ozlabs.org>; Wed, 20 Jan 2021 12:30:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1611106231; bh=1r3dKINWGBdHXjMJC1pX7V+OOo+PzIVrin3K6Ha1Jh4=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=MjZ4X4M+hAAdSJrooEMjWiu4d2rqipY0jHYmz+yIcK8EPnsP3kADx8TRVNEU0wr2RDW/7vblTjldHHaB21n2srmH31na0Gj1X7DV8rJesUQZEBdS6Zhr7eLZXgL81XqIy004bTHXKOp7/1GkDYEm0coSLTa97MYYOJDaQTO2i1vmPUuZRwKXKDXefbFnmPqLHXo6BKtksa2/BDy28t6u2iFMWby6AxakOzzrsig8sk+N7etPQDw3prbhMbZZaEoCXu5TiiHKxFkOd9O0Cz92eDANS1UksIb5itJ/aCTMaY7vNWgjvRYfDhI5prv96lI0KrCNNo6LOJ2Es0O3zxwlug==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1611106231; bh=d5jpnRbJVDDf7Yp5j1dV7v6CuALsI1NmlKOiPGhQ6tK=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=t58EtamcG++CecN+E/Um9dbCCY9wKwKDCFbYUAPJkyY42QomyUExPnkcD6ZkYVygYMb0/WFA/3qv0apPFZcHY7/AgDXZWWb0i3ZjAtUtVBF9DsPUY+gPox8xd1RGf8tsagxHZGn7EsCcNpK7t9FupSGfDG10NmWdorsVv7M6GTLVDRrgH2LyOVUpCe069iVcYYRzbyixah4cEZmPf7RezgHvlLp+ssDXgQpgWdmBJkDuDiliv5ryxv6zdNaRduuODJxml5EXoXbuQMO7eYwnEbsWzjddpUFbjZW4C37bgWGCTXIgpFiJZynXYKVGv9IGjEcNoGHeWZjY4gvd7BaUmQ==
X-YMail-OSG: sKJOEZgVM1lAyTFEzCn_PceVGDrRNe6YHKgn2xwF.do4s3dzfXOt._Xe.VboZVI
 OSqXFtq6m3xDh1clCvSyH15l0lZZFGWLgTR.PtQxW9NL8r1jThVAfTRRSf_pd1Mtz3gMzyWeRKhy
 .gJJiIlPJduuSQNJuaSGwDnoHsUc7THCaibnSHaNku6I6xy2GjItRmOO55NaXq.yrbif0v6_Ir44
 OuciNWyAEgX_tH5390.rQzNJNMcX8HgjRo.uqIIw49eGAfZS77KozGzgYsXnV3hFZaX8c24do9M.
 cB2tE9SuauQOOmOLa4ti4SmGe5mEYQLo3RXlyKVlzdrSKkDpnlJUho8DLFTEdtEm9DuQLGa7i6o0
 FGJ7F4PihU22PjJuxp6ywCM2dZjiucXZKCElDDPjw1yax593xVMrlPhh.Eelg1mD088YtViG0aca
 g.OzzH0CKPy6_Zbv08pd8vYk5Pj6QpcWIKiBS89BqmnyAz3sSryYHNVZBnWVy56m2xv5r.QBXUuZ
 UNtgPTck4waSdRAshDjyKTuoakdxPFT0bNJEm7X4Idgdmaoyq7YLNlUoxmaK5m1qU7UbOeCc9Qbp
 H3fns.yQaCjJIS4tFLfMNV8m2_Pe7bW5lxvfp8oWwPxvKJrQeVghPZxOZb_l_xt3g1eZuSDvrCrQ
 6MqYvNOVgss4jWXRAEZPOSlCoDp341_nSiQMNv922niplCtvBRjnzPM7WYp0sYIAOJF5ooB7xgX_
 6ymMExJMdv_fyYG82pfspNDjUoGLGsYDr02Nh9QPE3OFu0uowp98Zwx5RxKIT2nMzeN4wXJpdfWX
 FmOaGwTu5TnEkjbZZpwII7BhC.yyQkk3thMBwUQN4H4QiK9cR8wJAOrtEZqkCt.Zkrcujo_d8HXV
 01ulWjGGQGWFq3pHA0DdEptafpUfYazmqaTbt_9rEloKekCChGPhXj0uW8YEL49Q3.baiXixYfaP
 tATfBNycu15JQSFuWhWK_wrIcmpEvRvCsaBYPTwDqnZaT4m4O5.OEgN9YhADfZx7ElQafPUi4.Hv
 VQCaeN5HzrF13z.0swDv8v7aAZZRx8JUdqZOStFDGCDLsYkf34iw5VeOXwjo60mKlItbbCA518d1
 saJ96SepWbEhUWpo09ay_XGIB1ocsv0I370QEASJp5uEVjUhXH4QqtqM_Ys3QA2EEnRhbzFBw5mQ
 Itb1WdsoDCJtLLOzxeiTF8rWqpOeTGT5RxiQCRm4HM9A9SSzzyeICi5Ws6lEvPnNJOXuxIHn5xBL
 oPKktdT01tqh7.4ms5gmv.1AVtCWQuhsTTPtATSJUCUURf7A7gsZ2AYo5kGJ1qow1Zfec.Ul6dlc
 ZrDbOXOjCxieB7W9evK2p4KB8Y0vSWM0cenNQSwVnEGGE5OMji9ySjlLg7saAzLRyhZfvKAIN2Xx
 OtAkXdQVwbaq0q2VFr_lIe6GfnekFtKGhuc9ZMtxtpNK_qJPHZfKftc.4QWMxOqDNKjSEy4fOUCt
 S1velAKolpDKgXiKvZeNcd53k0Zx0V69.ko8Jhsx0VJKVdJp8YR7xa.VDmLOLJB8kmFuehGhwjJq
 tC9AM5v6EiLz5GwWy3VTp.LPeXoJ5gP1G.Gmaygx5cZ5ML1n8rWrPI6Xh5m4Oqibn_VWzsSo2Rs.
 EEXzZjymu8wN4wBHMCt0ex5X228sWlvnpJg4TqyWbIh_3DLRsKin495ZLaf9BCVHTTDas7KFcpp3
 ntvNw26FFjMxUkumksgDZ2KEyTdeYr.YQkrYrpW0UH9Rsu3fnWMdRpI9ZsAT7gliFs6VaazT0Onk
 BRgTgFBujBVtDEfTJnRzn8v5WShM2V1uMlTgkr88la2hLv8iusbgOKI2Vj6EFfPwlS6O10UBG0lD
 0EHi1I6O.KBGLxU_xlXMJsDRU_eCch9ydigIrbXsllajimNtZ2ATUsvFvocEORn5mbUZD0jWX4qa
 CJcndGxeU6EOPy4fhYH6EfUN9WCYsJpmYucw4PGol6v9e0qBOfb3Sk20bxct4ZEPOnNMwIaAtpDs
 LIcg0oOZSO9YiCxaFzK044J4Nu4PUDaF4LrtOhSz.qrymWyolPnUoR0Vk6tVLgUrvqbJO5NVQtct
 NV7lY7piIwDxiYkhDXe_UPofGODlFItvY5AABedUQ6sYoKQ9KeeySX.bPz7VJBB3vRNfLlG3SxBy
 .EGa8163mZpMLbugeus9cU5jEOmiv6mTRugQvEuHakXwBLqx9DY7jn0PDtAjG653sa7bgB2rOFhu
 Lq722CQTldGpa4MgnP5B6BKeFEnK14v7H1kb4m.8686ESAETGLawgQp3lDBLatae2sGsO0pnyOx_
 g6p.14IDtSTTSB4PDJM2jac3WfUWdl9CYy_Jzpf5bmMVtZ7spXdJFix.s21sjBjKavLY_Jqx29Q1
 qoOSakQDnrP7Vrj9E2KFUPaEsqqxh9rZwxQ1VkOgtuIYLhTItXh9cxeeTPG_8z9UMjrK_7I4L2Wq
 eyXHci_X6ATfYDDk4xOpocGjLx1fel94WhamuW6WMy992uyEdfsbkaeol9.h0vUe51ZEVcr9BMVh
 .A37WCmZmiPIVcyHDXLo7gMBkDlADElhc3LNoeyG1AYmVhFGW69qdmOHLSrDAyILXoYYtMefeEPm
 SlxyS8nMllEtFu.6IdVPGRNqFDUWy_tO8HzfR0Jc3VEsar9eRcHHtExOWj_RWwCKizmghnrHZ.XA
 S60NGB2dwVEhT_1wrcf31chfeGi9LpZq1QMVymHLsO5CafQHZvXR6egL0cRqIcixAcV.vK8Y324.
 LhRwULBVBxiyqdu0KVw1tEgyN3HTYOV75ap9jT5smOR4Xg0GD7YlTW8Y-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Wed, 20 Jan 2021 01:30:31 +0000
Received: by smtp402.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 167f1fbdd5ea7ffcc74dbd0fe3b1581e; 
 Wed, 20 Jan 2021 01:30:28 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: fix shift-out-of-bounds of blkszbits
Date: Wed, 20 Jan 2021 09:30:16 +0800
Message-Id: <20210120013016.14071-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210120013016.14071-1-hsiangkao.ref@aol.com>
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
Cc: syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

syzbot generated a crafted bitszbits which can be shifted
out-of-bounds[1]. So directly print unsupported blkszbits
instead of blksize.

[1] https://lore.kernel.org/r/000000000000c72ddd05b9444d2f@google.com
Reported-by: syzbot+c68f467cd7c45860e8d4@syzkaller.appspotmail.com
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index be10b16ea66e..d5a6b9b888a5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -158,8 +158,8 @@ static int erofs_read_superblock(struct super_block *sb)
 	blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
 	if (blkszbits != LOG_BLOCK_SIZE) {
-		erofs_err(sb, "blksize %u isn't supported on this platform",
-			  1 << blkszbits);
+		erofs_err(sb, "blkszbits %u isn't supported on this platform",
+			  blkszbits);
 		goto out;
 	}
 
-- 
2.24.0

