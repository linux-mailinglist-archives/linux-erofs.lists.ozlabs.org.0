Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E06315690
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Feb 2021 20:14:03 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZsy01BVPzDvXx
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Feb 2021 06:14:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1612898040;
	bh=GjYcNzTuldtu1qNmi4W0w+4XPlkCpfPzOx5g1nKzLOo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Dv+BZZ/p2kwhdxA2xO5Q4wTg36/bIZsrAPrIAm4tN8bfHUWtwxPhpSrDUkW8isbSa
	 6R9gEP+E+BcL41JA8vRTx3yx+ZBPvY3UJlZz2EUS3c8M1EjEmSguY4gKeGdNoSW+sR
	 OnwHSNDhWUiM5ZLVa9Ze6rVrRZS8zEO16ni0ihy5BmLWJxujM7SBcFf8aRXKqwpB6q
	 HHh6pbjTJd9pTEtSkYGYoxb/xx0BHtbbSrXNXecQcCDpJdYBeWP/vs0QJgiql+yyff
	 ZqBSbCRLQ7w7Y7ukMoCskxBAkKBW9VEB/R5yKUTeSwnxOZIA9CDTZn/U5emeQ2NrQk
	 k+YdPp+5MNFog==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.147; helo=sonic310-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=XPiadbWb; dkim-atps=neutral
Received: from sonic310-21.consmr.mail.gq1.yahoo.com
 (sonic310-21.consmr.mail.gq1.yahoo.com [98.137.69.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZsxd4nPPzDshL
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Feb 2021 06:13:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1612898017; bh=/bDDiH8kby6wsz0JjDj+U87pYlYw6lxQOTlpfQ0d/zg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=XPiadbWb5s2U/viK7Of0fJ79t0UVLeK6QWsIymMhmSnASux3DA1CmAmqylpzzlYuEciljqupfCnQ/FPXXwwaJpgSKFy5UsYzS6koKoE+GuJ3mzU5Px3wtUpy1BiPXD2QwmUzTNU7/eyChTo/giz+xFN9DwWqZHzUm/z2UJE8VNU9JizMBKgWLXPCjdCL/+h8HxU3nh2zAl7fRh+9Se39grkUY9rMj1Fhf1F8vnb79WiB0ReMO8e5DkScBjL+eXX17sFnF6IGizmWFhmyuTXFWhIzaleOLDEaoMv4yXPP3WKzjZ9dodh+svlX+E1MwYWx+JBCWm5Q276hwmkuUEmS7g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1612898017; bh=tMlt+auDcq5zlrDmZnukQgXNOfXl9yp3CbD4pavfgik=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=c8q1X+/EHzHE9IKaERZHeo/CU0o9nk18AHpHiRF8ssdMQA8siNqiXgPvElVsaDegX/zztL+lOzVcykTac5w4k+93wWQh2R4dpdiMkGvRTUhu4ltWgBD50W0Nczms628cUHT7xSN3EIzKutoL6YMgbdrBqzATF0YCU5qcyftQ16ikfpgrIPW7aYGNxjZdaDjM9GEFaE7OFLe/zWED6gTtacm7hG0eGl8hjxbJbTPqTjRLZrigUldxFTcCtXaf+MEXAFvaIoVe/HLA/uMLUmyKMzF3bGU07wU68p+KjvfXls2UBdD2lsS2/iS+mI1ipiEBPor+G46pBSkwyCl/Ttu+LA==
X-YMail-OSG: PJioZiUVM1nLfsTzrgs099Ib4KZxxxl32.EYHcLJSg1eX4hgPkY2J.POH3SdOtZ
 Qo0fQ353BvPlUyLwbjShlADdMZF70qupmBJCwQZEWOqU9VKrQ5awR6eGM_C8xaTWlGUsctl5smMu
 4B4RcyInbjDRtCCl1DJnMWae4brMppsS78rEBqxX0btu_Uif2uiZnihbCyS5j64b7xZqNI4ExtMk
 jC14J8Y0ncp1HMc7QHso1Jv5Zfa3WxvIayIzHF4nP6a_NCkDaOhvru9axDDl7v3610GrNgNOKMBu
 kW4CXdJ.5cVWsXpNO0KaeVwpJ3VNAmWkGPrsbupVVgy7UM_k7k52WwWcXQIMMhJkW5R6ntw5xojL
 hh12yETPNjPMeD3B9L7XJok2KT2m3Fgg96headBf3mOZel2rIb6Z8yYeAmx.HgXalbhsjXj68nM5
 nNcmNTGJvtdaIpsz1Bxes8QC.Eol9MztvQPd4m_eE_WBtzpTHk06RO.nGVJoVz24InxLJ0xNNW4I
 9QcCQZoKn2Xa0IaoZPscdCvyWK8z2r7me7b1T2uTsUrR6xsfnC1K.PFt96AJ.kTjDg5hCrdRVdhV
 T.Wn4dYjxx0twFnmREf_0WnS4OhQydHQR1Qzrzxrirv9txr2zPQD4gGRjh.iSxZPZPgsCw7Y4ihz
 bXKwRFIY5cipJmCBrzUtBOeF8NdTlFmF_tkpMTw2XPZMx.hCIVofpyZwSn2mCkORzosuSCcEx4Bj
 x_jRuHPaT3H14MKikzQS4Yz5SuLUfBskXs8oa_fTs6ECTIkJvOoIoeZCyj9fflQIo2NUzhQbm6xx
 kNQyaq.n9ckGk6wwbKnYXtU2uYf.0ap4omTOp9B1ZO_CeHQS41cJfxUHk3sQgBHjkwnoGZZJmX.W
 X1dLI8_2mfYaYwh1r9B3Fl1X4jNWZwP0gSR2x_vrQa9q5hmPG5fm0dX6DpUlJwKtKSRaZnUZKuGn
 IqoJ9ky_aeDQQsHr3r7Sr7ym6z3r4.crFY5GvD36Z_fzz0gVqcBqc58PPMhRKq_p81P7CI01N5Z8
 Hs1SAibgi6yC1y0v8Muj_CV8aQPQh6YrCkRedISC3W.DEvWhcksaZ5IZCtiLEqvwQ54NUsXuYRvy
 1qygoq081.A2xmvGB546DXg1t8qKYMoz09mAwM7V0f6A0SaER1tGjdDnHk4EkOB9DTjmD10AK73j
 Awar4kyigLgP7cOic35uPB_xdk0CqS46lMlK6n6WI0hZV0BHF.FZe8eZIxZJM3AM9QddJ0hFUsu6
 b3KWGoSJxgdYXfpyGhXxFGDixC.H0OpI7STNvQJ05I0UUOWJ9wO5IQhEERo5LOLd9HjPTnrWGpUV
 V3lOKRAwS0wUb.bp3AP2hWRXDQw1SxVMlT7PQWj99oWkqjD9hQBEDEWuB8IT0Z9PRvSFFp3pvMai
 QxT18Yr.hmblYi5oN8VAMA.GmNzrB2oCv0HjoOUvhH2zydn2VZxF6oT5j.7kIyOp8scut2TkXEwA
 bGzF07hRWM87tvLPM_ykHqNAfjjYrexO6HNu_7BoYF_r7a4ZCGLTuopxMOsHvwuza4Nzo05tIswI
 BkK1EVOL4qc2ny6cvw7PUZmIaRy2NkoajkRkNm34dqOQc4gXe8814wOoNKiKKVAISesEy2dO1GW5
 Pc63AGyeLKlJ8m4VOJLrfaeUCwE.0.4ZTUjF2ynsX8hSA0fNXcG4J7gHxJp8sSD2ZfwaPb2.Lh31
 69kf6.Zh7sJu9BrbrEwsaFQCB_mcmpjRmKN4vsMk97LIKfl6Ht5oNBOPfhExtMuVTBmuLocw6Now
 bjNrDVlJ30xfgZPQvF1doMm_ImvgfReQw4toWwrVnQ0rAJEy4.NSuUoJlht_9HoTJSyiYuSzDg2R
 1HKcD.ei0DbRSdcOUwcbC3m_MIlALdygP9C_OcEcM5I78Hd36uIz7cHC8PnU8gFFGUXAL6UOQNGO
 32c4kF3JwBoavFPMYRuAWw.5LYT.vhbY2xFkz0AikRnh1FTa2_vDLJbKkaBkJMEHBZ2siyWsqiWb
 3pW24Rs9fV1hCYiDc0jwAQULACMZM1xfxCx3m2e9UZ89N2iHATUscaLAvvJ7OlxOK4_4kv6GAQaT
 oSxXYGfki6D6r3mxFkONP7lvKOX8ctlClzjg4bBaLTPjdLuX.Kagn9NUte6jwDwYsjorgrGvgKfw
 OCMqe3TwBowj8NPkJd73NpTKYQcioo7bNgV03x5qKorpwgnnUIxFWrSxf_DhHwo20SDcaIPzw3pI
 XYEniB6ko5pT0lIFpUbi0hDY7gO2mXeeiU5.suOAplZHLuSUQAVC73JkcquG_e4Alf4jASDNmuYp
 oAxNF6rTm4qMcxAXMht.bLQ.D4XASCLx3.Johl_TxUYGQ2beQr40rTWl_O.NIV8GbpJMpZdLacNI
 g5NZ08dkmRlcMj8G9uiQAXu40hs5BfN8WPmXSF8_wCwhlkJc6LxfOAdSnKs7S3B8BRO7BT11.VYm
 l7_TQCYlrf2cUWgOXWmu8e36nVhbwRZIU91.MDyM9HuYYWULj1FfEe4n2AHGRvnE-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Feb 2021 19:13:37 +0000
Received: by smtp417.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 012b4af943bcffd954757582ae3c0073; 
 Tue, 09 Feb 2021 19:13:33 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: more sanity check for buffer allocation
 optimization
Date: Wed, 10 Feb 2021 03:13:22 +0800
Message-Id: <20210209191322.8902-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210209191322.8902-1-hsiangkao@aol.com>
References: <20210209191322.8902-1-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@aol.com>

In case that new buffer allocation optimization logic is
potentially broken.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/cache.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/cache.c b/lib/cache.c
index e8840ac5dd31..c4851168ede7 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -186,8 +186,13 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 				       mapped_list);
 
 		/* last mapped block can be expended, don't handle it here */
-		if (cur == last_mapped_block)
+		if (list_next_entry(cur, list)->blkaddr == NULL_ADDR) {
+			DBG_BUGON(cur != last_mapped_block);
 			continue;
+		}
+
+		DBG_BUGON(cur->type != type);
+		DBG_BUGON(cur->blkaddr == NULL_ADDR);
 
 		ret = __erofs_battach(cur, NULL, size, alignsize,
 				      required_ext + inline_ext, true);
-- 
2.24.0

