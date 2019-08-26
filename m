Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A12329D2D7
	for <lists+linux-erofs@lfdr.de>; Mon, 26 Aug 2019 17:33:29 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46HGHV48skzDqWw
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Aug 2019 01:33:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566833606;
	bh=WPcLqBr9HzvVct7VvJ5lE/73KjntQp5k5kq9ne/yros=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=CmWKe+Xp097SduL6eiUwdWYZmBhBMuVqtlu+J3tGi/k0V6B7yinCf9FoVHRKzEArG
	 BYwOlekKDPlc8m9O0QmGqX91N2MpueYJPRjitr+TWw64UAOzgj0CjfPmnAAFLNrMEO
	 vNmSPnJeKK3aB7kXRS3F3SQoB11Gw9jbLKcmhMihUPulQAxPz8PvwKGjA0m/YMG8Jx
	 Knb59F5jeOJ6stx9/XR3PdB+jtYKoOwFtG/QLZgr7hc1rluF8ar3E1ewBZmT8yLa6x
	 yGYJQXQWV2E3VD8EYXet/zTDT/uczIujN8D3FZc/N6D1Tm1G0aNivbu0pbOUCoOu9A
	 /wb41R8Yp5OWw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.145; helo=sonic314-19.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="I3qxZnnS"; 
 dkim-atps=neutral
Received: from sonic314-19.consmr.mail.ir2.yahoo.com
 (sonic314-19.consmr.mail.ir2.yahoo.com [77.238.177.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46HGHM36X6zDqPB
 for <linux-erofs@lists.ozlabs.org>; Tue, 27 Aug 2019 01:33:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566833591; bh=qz6sG9s2jSBiRtVLK+t0nY4ldmBT+6BoJCYgSXPyocY=;
 h=From:To:Cc:Subject:Date:From:Subject;
 b=I3qxZnnSDkGXvVzYg3IIss3za705wnr8jqqE6xgqfnsS0BJ4IP7mMuChDoOhHgDsWtVLrRMWm7aQBdDrg4AsxAFVfFH5qpcTzOzcze4mvyqgXnZOj0FEgyLxdKYpHv+J2N4NG7RBncwePpEtXZWToZRLO40b0C4YKKzvBynJe76JJa5biW70A9x+n8argOUMtKzkiJDe5vf2kcegu6mraQEKgdyNevRZER33SSgyujykBFnH7yWR1dS7EoUiKJ1QQ4/CzlwahmqqGbHYYVqx5ZNyn31svqmL0zYH+LkNthtRccVbLstdK3sOSFY6fn0EohX34zHQ5tx6OSuln+T9rQ==
X-YMail-OSG: a9sdTH0VM1n2F_NELl44BLjgwiIW5D_ofwwlB0NH86wMKInA660AlTJd4m0UUau
 swJAMR0gEV8Z5qMPnAz1kuqa.5AMN.02D4VKaCpxF03.HVa.JsDUsn_woRKxw3qry4537M3bs0dF
 I0aHPeZkDpo6TjFpJ3kvtXbSIQRmy7rFABrEOIyh5ElngmrcBQNp6Y7uE2OHc91FANrTd3RpPRRV
 yTb5ypvSRwC2hhg5UTDEAG6Bt06CdevN9nyJm.Myzy3IjT8GIi4jpShgjEEJ_64yrXZ0s82GjgWw
 9oimQv8ywnsn0qal4AE59QDsLQQ9xdek_9WX8UcXYpykTpw.4b6Fzeks6mm7TyMzp5ArE2diFO1.
 fG1b.T_VaLMDUFVLJEAxdcjIhMpvZnC8B5OXXaZANJG0W_BnlAwsOtw.rqnrADGO.sW6LpkzlZkU
 0sZ8rv47OSsSEbwj37RvLd9fuzFkwfGr_9WUqKdTSsYtoKOJlLMUzSpht904mCApcng07lWRzRnj
 _vKYTUF7vrlpC4dwj8EknBdiVdwcCoAQyDuNxlRy1QDvAnyfZ3JQ1bq0JxDEeAeJ.Uk46C_KthiL
 zZTBc1L6IOClRyY8kiWU7EqGDZ8CBX0Wu_UO._tKqbgpXMtbHQALtDIa.D.8Zp81kbgNEh6.Wca0
 CENhMm5lHPGEGI2e.jJ4N22WJKZ_jNBeuOPtnSpTjuLH5mWBYJHeKoMeezPnETnmGTKbpqBSnJoe
 EGKYT4.vdCqMJzyjXo8USgMqe8XIMkdCxJwMHXuuRdIxXMIMCOyKfHqYnZjicG6OVrdoDv6ZgYET
 vdPN4PsUm3ETG2_36fy_Uov.J6UGCkZgYQcQHrD4SjUUm0Q_RVMJPO6LlsErorC7PQHzs50FRiOs
 im47dqCVr5vPsGgcZ6Yesawf4LJQMWGE9DS8erlH5OLtNAMOyp6x36wa27dMEbTToPiMrt4Qrapk
 Xl7P5ALmsfWpez_sr_cGXYUC38naTZdodaZkiUefeS8kA.S827lrUHeX6Bm.sLhostuKqDbwnnFT
 tWNx1i5p.Km7D5UizRjDhsk69HX0uRDuxOowOucWFgaE9GjPKAejuWUUZYziNuJ7J7OahmAMimOk
 puXNlWX9XNxvhIKYmMKa2rhu9iJEQKbzfT9VhLCQSUfcKYX6w77L_1fMn_DkoH4RVnx_7Y0T4MI2
 LKOlSpYiRehtAphs5j2tAcNGQbC9aHVs6UU93APjbw4BBT4C2MnyzyVVOt0D1gN.0XJ87azYgt10
 Q93LtLygSaLo75aa5yPG0cdbY0zzGIBPF3g--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.ir2.yahoo.com with HTTP; Mon, 26 Aug 2019 15:33:11 +0000
Received: by smtp410.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 019bd98dbbe63a79be20e4fc3c20a9bc; 
 Mon, 26 Aug 2019 15:33:07 +0000 (UTC)
To: bluce.liguifu@huawei.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix up "-E legacy-compress" option
Date: Mon, 26 Aug 2019 23:32:30 +0800
Message-Id: <20190826153230.14892-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
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

"-E legacy-compress" isn't parsed properly, fix it now.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 mkfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 75e1d47..5efbf30 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -34,7 +34,7 @@ static void usage(void)
 static int parse_extended_opts(const char *opts)
 {
 #define MATCH_EXTENTED_OPT(opt, token, keylen) \
-	(keylen == sizeof(opt) && !memcmp(token, opt, sizeof(opt)))
+	(keylen == sizeof(opt) - 1 && !memcmp(token, opt, sizeof(opt) - 1))
 
 	const char *token, *next, *tokenend, *value __maybe_unused;
 	unsigned int keylen, vallen;
-- 
2.17.1

