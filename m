Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B632F81B
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Mar 2021 04:31:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dsqry0mh0z3bct
	for <lists+linux-erofs@lfdr.de>; Sat,  6 Mar 2021 14:31:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1615001490;
	bh=WTZlgHwHuNHyiLsLmt9SWDk/mGiniogRMSZlyd7d8fM=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=g2HTdhpNLmZZq/NId0tDrVXuLzuIqEchfmWbia4ndzfZtjFnGbLIHKDinrQ68oYGz
	 YdiKGrb/5O/TrbpO92603RIgbg47RHXT9fuoxe/mzw9SkHocO5jrD/jRiKsKY0GwsJ
	 Bw+cGLsK185xZ6bxgFlCgfUz+Mc0eQHNgXyD/FrktE0+IlaBlOUK2OVTEXm74HKSIw
	 16LZGZTnrnRDA1iX+XkMy1HVpX5fxeyhFw3kjdPy60+9KJJMDkiWp1lIVS96uBrlet
	 qOmOCGdaMUfAEQ10FfoBzu99IBTWYrPirB/+NPDBsWkoxdNxgp+bq6OYL1ee9bBUjD
	 3kb2xpa7/PuVQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.146; helo=sonic301-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=hncvcM6n; dkim-atps=neutral
Received: from sonic301-20.consmr.mail.gq1.yahoo.com
 (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dsqrv0PYvz3cY7
 for <linux-erofs@lists.ozlabs.org>; Sat,  6 Mar 2021 14:31:24 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1615001479; bh=aDP9hoUWWtjTXddygbmtgV//ajj5q2yzYYx7eDIq3Qh=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=r8LXzZcJIJVB3rqkJfBVeHUNbpOOWg4n4c+XpLWAoxASZZB6imS97m/0mQ3NHs6EdUEiqKH8Q5HPUYgGS2jgCbie6jknBinswtwp6tucHiPmbZAFR+0Z4mpJFtp4rhCQTr+7YE/B2L6NNbw/u/uUGV4I4s9MEC8H7kP2aXEePdN/iAxWFbnbt09+di2eSbi/p/Vbcd2P441SW0VWAlG8UIMIJTtVX49B0U2ZYY1euxDM0hx6bXIQyB35OHOn74Fsfrz0Yx0gsFGvkDaLdH8R1vVfIaaGBpU+K7rlVNe+/7WrBEMu0M0fK3m1+skNqI9qOIndxPnI5Wr4Ubeu/kH50g==
X-YMail-OSG: LnWTSOUVM1nNdolamUzakgDAu0NT54k0MlqEnvf9HYxrKql8XIWEZQnEaS9eBLV
 42ncWhRPD9SoDnOlKzDrEbESU7olmzUhVuE8J1PK3unfhsbZtZ_4ug13bfIu.IS5Mut83uQ1BLQn
 H5usCdgK1K8GDb2R6KNpnQ4STMfeyZpAi2umAe3MKz.DByDyhgp8cnUSjynUDj0bpyYkqzNvHTqs
 EMI_gBKO7w71HDBoSXO3Dc.he7qPuTQVsOtGVac_Ai_aKQFdHc6Ha7L_p.sbkUUIxgAF2CPcA0ae
 oH.ehLkSYIWZRU_xMZNZ3z0NZM4HiP4RttUZtupPZ4A7ZYKm5g0j0qZjV_4N83CjeEUGYmWqFZyX
 LvkWzETvPQf_PD_KzjhTxivh6nVafGUcV9lIaFxl3yl55z5qSU_o6eBBljy11cvog3DZfE04Ahh_
 yLQGWpLvMTJY72WGSxTyc_.dskkl.N8nAp.mkS6YfdgNo4zALJIuTjV299ITsBeY8Y7b07wDzMIZ
 eqwFJg_1oIqo4AxDWpeukTzoTPs6jzoQcaEoMzer2C4GG0wBEt0vdjUSYnBEmFCCpQzvfRofBbrP
 pdX5sTLmo0QWtx69r68HgoA4vvrrQhuAiQeKyiU.NGQMvRAQgkUkgkc8eLKuWbCySOrlJSw_GpoZ
 B8kd5ZRMlAOrerj306fh_v2Hgwp29qWALnWwn4SDdmz1484kmtejHyuBp6abaQd_jZ_cblGNvkSS
 zzPHdJzztNaAxC8kSyCw4KmKpXJ6HTrTwT9o1o0EwBtN22Jb2lT6WD0MBKCnjHxiULtSbhZfxIZc
 38Duqv44l8sI.95DQ1FzxFINDqeFWAi91BzceGYH.Hpol_AYcTQNbAQ_yiPrs60hiD9aIl2dTBWZ
 pYNZqES2kVwvQSW1UY62Pm2Gh2qroZx2BzuX8V0c3RE6QumvPvvm6FjPkfcd7w9d42Iz18Su5QQe
 xy.Vde0Uywm4M4KbDYDVmj2p62WBjTbQiDAZzk__iA7rURlx1U.pYX0i7st7sE0QOdlibTD4aVut
 ToNzIcg2Xjfwk7eNyFDZF.CiJCTWU5RGq_hJt_d4D.z_LiCHANEh1ond_ODNgsQ0P.qTZldMfY3M
 HbHuYOspLIjFlKz7.1uVnDD4BnOz6KkYXTjUB7gPyjtes1czikg2vEv9dtxJLnMvHxPnapCqBYdt
 a012c4Yd.lsE5nirV6XKK8v4jUYsPlr7jmNpuIU0LXy6RreexEv.Sb1k.jLl4iagXlk_sGksDsi3
 wmUx6TudOE98iEY6V5qqYojxIXJ6FAi9gHkCfVO0SXMZLZ.hxUKkKoUmqtbR7gpyvEqiSmxTthWA
 p3bCV.SYBmGH_xTxS1W23akUDypK3dxJaxyQUogOoU6M8q.6OcjLtjC.ZDeKkSIMqjsoCugf51Ty
 KpiZQncpJvctFP6s.yqYp1g653and.DnS.PaZdVc2krlV8Of93yDwHTIgW8eeSzlv4bxVE9mjawN
 _K81k6.0nNIXK3_Ew2N_TexmHDX_Kbu5Bv6ybp6JqhgHXYuxOgN9sQFZMsHwieMrZfjslNTXAVFO
 kq.N9aJYTiCMt5d0kpSMKyyIMLecrsRWdnqBqbMlBArEBHmQ0KxzWKkZuk_HEL_t6ba53qaUOzqA
 uFbAPGcvLqTX0Ksm3SxKT7QAe1BsO1LGu1JMbsJ3.gdOnC0WMXJ6e8J9_X6POfRzf8bV0lueZnkI
 AXnXQI61cJeK.jBP2xmWbBQipnhSugp5PXkViNr4rVT7v1lD5FDgidGO96UYqZfeIsjWac24CR6x
 ounqoU6wZzTau0rKdqTELYTopPAc5M.S.fDvMegPUJRdX1DuNAPcICOX4j9p3bmcgFfol20bVv7_
 OpZQOSJCkwO83jEl_O_TKB97MTXylptCtehtSD8xoAm34r0DZkhDV_ON__OuaC3U_cVjMGeFi8Aw
 qwwPib_3f7YdGzUkNUTDk2i19fxexOszcoMsIUXxSTOYkJs6WGvtOWS8IqLvLLWSFJhATdTkzHvK
 tM8Cl9zc5fPRqedzWlIEDjDBEbgcGUCpwLl39232cVO0VqrpO8p0zSMFZmclWWLgKe0PCNARl_EC
 pc3TN2yU9OqIeQSsbOIsYOlMQRd25.2FUe25ivOWYm5ZAaHcENYhdGIdcFCGiKk_.54jX3VwY65M
 HZLwFySN0tsPcPIl6AFFvSkvAR.e2wuvsElNbQgGgiHiJkCZqIsq9W3I391tbL6cpkeUgWAYf3kX
 0KQLqsogFXyhQqSnhSprQA_MhqqDpsPhRfRSVcRDyzCQGREbT4usEz92mJwyDmANX8.XADeAWQfQ
 UDy5h01lvkGyLPRI25VPLuj17_D4FohUGKXNyttOTPSHZQ0rFng4hRY83hLFTX1WOHwnHJ4KwwNI
 NXm5IIZgNBnkxiM6jc15a_46bUhvll7Tp0G8IkB.vDxBeEfRrznmadurcEowYpGoahxBjngr1lYV
 Idi_v8w.vXRLPqqEMkSi_IX_S1imHPgpbKRdY.Ga9Np2qFPOhIUNwUACHxwt2T5GXWePZI.oataJ
 rhTjLfjGNm6J8fvOmfgNnR4hKDUv_w9pfCXekYAt3xaByaZF.up0HPUju7CfyCCu_N5zHNWQnJGv
 3jGUjbClTM.lRVYo9TJ7JGs.kAh0ytmqtpHQhqJuA3NZChwdT91UEpP22o6z9C32fD6KVRo1N5d3
 cxgqSt1l8JJWy0tyCkor8.DXyZJn1
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 6 Mar 2021 03:31:19 +0000
Received: by kubenode570.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID ba4481e697bdb030390431d4eb2e8ed0; 
 Sat, 06 Mar 2021 03:31:18 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: fix bio->bi_max_vecs behavior change
Date: Sat,  6 Mar 2021 11:31:09 +0800
Message-Id: <20210306033109.28466-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210306033109.28466-1-hsiangkao.ref@aol.com>
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
Cc: Martin DEVERA <devik@eaxlabs.cz>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Martin reported an issue that directory read could be hung on the
latest -rc kernel with some certain image. The root cause is that
commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
is set as actual allocated vector number rather than the requested
number now.
Let's avoid using .bi_max_vecs completely instead.

Reported-by: Martin DEVERA <devik@eaxlabs.cz>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
Hi Chao,

Could you take some time on reviewing this patchset in advance?
I'd like to upstream this regression fix asap since it has noticable
impact on 5.12-rc kernel.

Thanks,
Gao Xiang

 fs/erofs/data.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f88851c5c250..fa25d0eab5de 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -231,14 +231,6 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		goto submit_bio_retry;
 
 	*last_block = current_block;
-
-	/* shift in advance in case of it followed by too many gaps */
-	if (bio->bi_iter.bi_size >= bio->bi_max_vecs * PAGE_SIZE) {
-		/* err should reassign to 0 after submitting */
-		err = 0;
-		goto submit_bio_out;
-	}
-
 	return bio;
 
 err_out:
@@ -252,7 +244,6 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 
 	/* if updated manually, continuous pages has a gap */
 	if (bio)
-submit_bio_out:
 		submit_bio(bio);
 	return err ? ERR_PTR(err) : NULL;
 }
@@ -274,7 +265,8 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
 	if (IS_ERR(bio))
 		return PTR_ERR(bio);
 
-	DBG_BUGON(bio);	/* since we have only one bio -- must be NULL */
+	if (bio)
+		submit_bio(bio);
 	return 0;
 }
 
@@ -305,7 +297,6 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
 		put_page(page);
 	}
 
-	/* the rare case (end in gaps) */
 	if (bio)
 		submit_bio(bio);
 }
-- 
2.20.1

