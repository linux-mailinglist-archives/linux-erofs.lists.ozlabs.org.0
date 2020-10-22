Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF42296144
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Oct 2020 16:58:32 +0200 (CEST)
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CH9Tq26SZzDqnM
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Oct 2020 01:58:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603378703;
	bh=qV2byjeQqm0Y5uJUXi6uR0t1KdGPCrZdU/rxhJR9Xv4=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=IJcG3/AM/1f0prNmu7Ej+SQ6d3oZe5xEViFQJ/E0A6JMJGf2DgSHO7Hg/NCpCZKTV
	 8gllIaTrkMdbB1HiDPFmzoo178MOITeTrHgohRhyRPV3YdqLW1NzRFgrg/gF2LACjN
	 2YdTo0131SDJvReOf07YaWU72olRCdY289sMSVYU0BuNzKNgeK7r0e/E8Y/8VuKvRS
	 c6HfTlPYshUk8auwR5ku9qTPFIy9IL9uP7IGry3oxUqTHxN42hgmvx9yvqeVsNrl+Q
	 3OIfAnDdPQtpygqJnDZSXShpzwAvktne8JdsIv52GhrKcqoiGH4/epgHcrQxMUL+t3
	 7o5HlOCjAPW3Q==
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
 header.s=a2048 header.b=KPVI26Pf; dkim-atps=neutral
Received: from sonic305-20.consmr.mail.gq1.yahoo.com
 (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CH9TH6Q43zDqp7
 for <linux-erofs@lists.ozlabs.org>; Fri, 23 Oct 2020 01:57:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603378667; bh=zwvCVywwXJPAfIYLckNHNuWz6WV1ugE9tkAOhdwuh+Q=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=KPVI26PfB2zvjqVtYl+hsGKEYFFkRf+eH1d/yODVyn2WtY5864tg5tv1jZs88BGYRRFUv7UMtJAgn9oOJrli2z4kxk9FW8U1aeu/v1GCbexQtmwqToI550kDqeW7FitdpHbM1Rnt5no6OMAEbfcbY1UD7bMLJmTdGdqodmxatzEE04UDvRcgG/dX+dvkrkjsuidb6MEexl+vfMxdnpKXOLtJ9kTuDTXMjMHU/ea1BxlF68bfJOwUZy80bn3cLBQTen7tnUPPgOayxndTMz4sb0D4qOZ2V8JoprotPMbtFJ4EKluDs5DGxB3J9rupGnRcrGmh5S81V/1qi5EeVVZn7Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603378667; bh=kTKfwPtRcMupfOfzpbJghKL1mSB1qE5MJA44VBqlRTg=;
 h=From:To:Subject:Date;
 b=Qs3JjbA4fFuSKhEPS5+H1EU0b9INW7Tw3MiIqGeFl19ZK3Y9uIpbe0ZzrAJZfatr8gzr8ZN0bRJM7j04UZWYmx1UT68EjKUm/94Ryy6J0cqhZdZhGlL3CA5OvYogktGb8C5cA41wYq5Jek9YpDy/OosZACKydmfvpMIcLS8U2MqnhX6x0K68Y99gOHs1z4hWZT4S0PJVPgIvh4macgO6CYJWhPr3yH6ju+xH8jXTGOucsQPaiAs1sxyvMURouCeYIy3gPoSXdPHldkUaaq2h1qLDGwDy3gWtlyZkwI7XrokMFGyWLfTbHOt6y2XQnlgPM5qDp8EuOl3SJ2/rln5LWQ==
X-YMail-OSG: fug733IVM1lyEPsuo0Pa6rWYM16GzXzkRydgiJ58pHeDptLq7cjSa5XN5GxaQZN
 ST1KP8o6.KOH.R9qw1EcLvgKxTrLzj.cIxclQPlhWVny2o7KBe1YQCNAgc6lLA6f5HAPwHhmKRw3
 h_1qdm3vk06pqWplzf4rOpOvJlVzV0H1ZpbuESBAZzSenXM76DxED87cKLdiYaoOImR.RxxgryxJ
 TjJPL6lWcs3lMCFe_pj._5x.x.PYa4hISlcykWAMgYMqx7_qqLM2G_9B2L0pSrBnfzuGdV9TEYv3
 jobnezwnb6ghBMwrm55OMxvsr6pZtYt.RE1rLHff5KftS.jsGnh_HCQmt4b7gyved5EDWE.56QQQ
 SN1Z2SCNwUaOQbIOrIqeXrZxoiwY1oaS6m4NBpYXkLw.zpwqt4rFOb7v9PBQk8.p7CB0zg2ifY2.
 NjSruitUMpXtWCRuBsse7W36A8WOu5gPACTyEmbx1B1o7HrY64rM3iz.3AmCPUdOcat9bQLmPFi8
 dkWw1B0_jXJaa8vluTSQ.427Q3vZZMH8ph2VyCktMXyDPbPl405WRnasR8u3WJ9lUVBSrO1UZKRP
 qOnSGU1GMui37SoIebcrLIfmgcd6b729N4SgFQXTfw6lZ7Jjw3G9xyOd54r3RVsCmamZu6F3plpU
 J2SN5ky8q1_6QGfFxuhZ_Tp.UQlAQHEGaO4uo0KRhVA8fjAvvd_P3MxEphhrNQcKMCaF_u.TIuOo
 PdRnA0CDcNMqdERrgTV4dQj1g51p2J7GFQYun4IYR_fo2TaQY.W9bK_4_9Pfwn1PUswk4eu0kmjx
 lt9F.44oxWdmID9gmx0P5gnCWJTuii6PaJxYmwehsJvgRc5q1TUxsI3pHE0xRaGbWcK2EdvrIItR
 NqGFX8bPgSts7IsgAZptSsP70G1YcSxYylypAXZXpqj0ppqxjc.sc69kG3shn5VuJHe9w8P1rtyH
 Lbs1yOPISBdoFmGFDByZ3_UR_0uST9IOxmGGP7qmOM6jOED1mjcPRbFSXXXEVJ4kSwzBP2UT6AQI
 efNbwr6Ss0ebq9c7PopvUYwGR0HKY__RJ5QGcuzZ1iPdxSKOMzS6O80fQCGLUCJSIaE5YrRCk9j7
 v4tRHFfRPkntp7kQGhJVJIiTVvZBh1n89y1yGlusLRq.NkxffBefsv7RIseCzrOwjtdYjPFAZjPG
 nDpNr2ySlDncrpQxU_1PXYUtUkA_SHfqxXBA9ySIlM8gw2lmriZzdwJrJ_VLdVqDhA5OOicw6aXf
 RIMCy4KtVj9vfUVUeaTr62OPro6PV9HrujpQoV23PxTMRvIrdwibOcwTbcC_1pCFJNHCASTO9QX9
 kTWSzRvACdGcYjQaL50c8Vx8f0DaAecPusGzMNSMbGFpmd7x6lyef7xY.OsGRoXdg.MWdlwS9Mac
 rXzTwCKJEbh6voo9NsL6fZZAWrcOiw01l2HQlKlnnk_BEMi_ZqHmjZQqOyEAccSm_cu2.6NDxlOn
 9yWAAfXq88vz7ePnu4293IsmTX7hbPX9QUajS
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Thu, 22 Oct 2020 14:57:47 +0000
Received: by smtp401.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 354b2034a70b817070abfec37b60849b; 
 Thu, 22 Oct 2020 14:57:44 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/4] erofs: fix setting up pcluster for temporary pages
Date: Thu, 22 Oct 2020 22:57:21 +0800
Message-Id: <20201022145724.27284-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201022145724.27284-1-hsiangkao.ref@aol.com>
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
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

pcluster should be only set up for all managed pages instead of
temporary pages. Since it currently uses page->mapping to identify,
the impact is minor for now.

Fixes: 5ddcee1f3a1c ("erofs: get rid of __stagingpage_alloc helper")
Cc: <stable@vger.kernel.org> # 5.5+
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 50912a5420b4..86fd3bf62af6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1078,8 +1078,11 @@ static struct page *pickup_page_for_submission(struct z_erofs_pcluster *pcl,
 		cond_resched();
 		goto repeat;
 	}
-	set_page_private(page, (unsigned long)pcl);
-	SetPagePrivate(page);
+
+	if (tocache) {
+		set_page_private(page, (unsigned long)pcl);
+		SetPagePrivate(page);
+	}
 out:	/* the only exit (for tracing and debugging) */
 	return page;
 }
-- 
2.24.0

