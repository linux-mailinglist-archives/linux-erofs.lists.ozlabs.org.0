Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A8343413
	for <lists+linux-erofs@lfdr.de>; Sun, 21 Mar 2021 19:33:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F3R8C4J1Gz2yRV
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Mar 2021 05:32:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616351579;
	bh=5NT1AvVCC0DpiG7Qx23E8he89GP36QzzaoNJbXBzx1c=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=KS7YgRAH+mMDRwDAJKgYT3tke96JQ4c7gt5CUqa3VmZH1dogmkLDvYGP2vB3ZTdFL
	 Bbk6Jp19QEt63Bazw+7M74lH6GuiOY6+xr/7DOnQryUXdH6Ifkf1woTrgN4JHMOmqI
	 foizdWOnQRi5a/xyCVI8VqHBLMsbLmqR2P1QPSHoXf9/l9I3LDPdms2ZeOLXDazMZM
	 zvm+Ss6JG+SKpi8bB83Hca4sehXwuCc2o/vx9GqdYyB63GhKtokyQjRvpbr/U2UC4Y
	 3kUKmzm3LhHycYLHETGBQqvQChAwskCN7J+GuTTzrvDwFs4oXnzJIgGfAFaxzDc+oK
	 MqwOaxjgIuWKw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.147; helo=sonic309-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=MLJ0SRdg; dkim-atps=neutral
Received: from sonic309-21.consmr.mail.gq1.yahoo.com
 (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3R871Z4wz2xy8
 for <linux-erofs@lists.ozlabs.org>; Mon, 22 Mar 2021 05:32:51 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616351564; bh=NfVtU2QVpQqfqCUuFeaMmv36lCPjja248jyLjJAjQr4=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=d2QCcVWFgbd4Rc9kuyDJBbUjX9hbvi3+IwIDJbLTwYj8b3UJq768WAARQBA/LwWv/2GaQiG3GxOmPpRtOSbb8Y4qxeg6C2Cp+2q8yMtlrxJR7e2FuvBR7jVkfDUsZrg1cOGKq0+sLRIao6n9ei2TnqKwA6wFLm+DLFXZnpUfMEpY2gSqL1gyETs75B4io5WS1FWH99v2khDmOCguLqgng17iY1oj8I6I4HbWy0d71uYZD4BurlhVPtl7xarqBseC/kVgWrgPIixfJm9LbON9558HiYGB1hFzSyKV4lmOwvIHoID5vzKoHL9FkPX8Wm7NWwY1por050WTrptIvRHLaA==
X-YMail-OSG: hwLQye8VM1nJ381WQiaK9flY5zGriAc5scDjuvcrjoD.QTejgA7xVLMN1sjnEb_
 qK8UQwoo47t2zTwvJPBSZQyG3TzVwJyqAryYbMH1a5dwJNdMWQmplNe5Ve8ouacVw5uPI3STBjUd
 pBX5sCJ0SIKPy3RP8.HkePGJdS9v75gGvHNDxs6tz4jlhaCZmuCr1ZjlR3GCrD9ePwDsacPCUfXb
 EOApNQWyPzS4oJ_RDaAOJBY6500_GOj8xfzudXD43p0AxgQf7WqGaKYP_QQD3u2SIkmkk0HOAhh9
 jRB_EszqpDUSnn0Bn7J4RtDUzXmtAR7NPYynDzbHZI4OQ0RRftWzz7.NmBLsxf5RhlmJik0q4y7Q
 RiICzIrnASXZaPN7U04gQA8q5hOzSzdZKz5j.sSRodJ6OvwUfFmA9jE_W841uIPzcHtHM0XQQz8c
 QRdZ0PaNio4BSm6CaTbVS4wYqdLka8EdAdswshr.Rg7aTg.zmzln4kdxbNLNCG1t3WEHYa.RHMVZ
 RNpVY_6nBoTEFxd_kJBObBnoYeiZ0sUHB81cbGY2Xed6ev9TnzP5u7TUhTdIpmWbPHwjyHIYoGRv
 pYI04TcKm.sdgVYwYL9mrNwfXelWwBH6Ll9FQ0o4oyXc5U2fjqPsD3OTjkiTtc7TzlPtk4dv2JKf
 ZtFCFvjIaJY_OhpLrIia2jTT8HQIBXQKThcIYIUqnNI18h6.EwbigGw_.qiTTB7cxDzKL1uOc6Ur
 ggEi2qKOCJJum8rAHRu4chz8Xb8dFWp6YoDlHZxTQ._T4CDbbggdnOo73SZjVYzoOt8uRZhD_DN6
 YDbhKZCgGEwsAdd0d2.s5ZgBW87yWiXQaxR7UnsQZjHPBs2gFAUxdmwIYgjVPQplQ5FOIB0gKVCB
 jH0gmVwOdzowYLhuOKkAkJoSAYGZkEFbj6jZpLKAFGmQ0xrjAUTsWYqxIYjzIqJ5UxYfJZh.PCmi
 6dJmcmh4PaxOQQ15ULbV7ZkZXDT6N12_DIry7BPdLgX47NlEe9nbmGk4UNqlNquDy6rUEXlNUMT1
 PQiFtf5MmEyqEWx_51m45rZ1fBtT8fB187MGl9vT6MEg0uuatMhK7n9xxYxsYVyy0RJusC.OOVFD
 xDeUfmEIo466x8kwZVfO6195n3VcwSGLlSqWwmSPFGu514WuvqQhgOCmudNZRzOvQT5NWTJopyp0
 i0ztTdwC38MPzMPmdi8.5Dw9gPBU9yFt2SiaonYD_UsXFEwBxAovGzTgJPqcDcAbucDkRB_v_R4X
 gfEkvxsPtzt2a3kDBH.S7FauVwQ8_NSs8z2IWXtlV_MHNBazoEhfLLoJ2Ci15TcFRGNgMmD8CBLy
 p89L8OKJ9CUNGCGq9JEElMuKm8bqcU0wnaLS07o.rsNniUSNt5.QDzdLawEnAdSd6lh2McA1jTwx
 .sbRJhMLQF1HBcVL1Mobf_Ouvt4FyI4JL9PndZgnVEqiDTp4XBXhgGch8Wi9WyqKpfev76kZFOLL
 qmlfR4Y8U3p6nJufYED0G7XPL2gPilvA17IV7W2yUJwmgkDxIYkA3Xt2HWjFjaeQdPf9AbvB9nTr
 AbZtfaITV6qJKDLdwhJlAQUGgni5yKtddTi2Wm5ONk0JbNE8rDfyjIpIB8N90CRnAYhJrlilq4p0
 rRie2pVT6GdXJmYHRX0VqaeN.xYB2mQ3v98CP3ZHGxoFYE4IfUO8BJaKGV6Heu_wX0HAIt5n5mOC
 _YMrhaWaoU.nGOxGoGf9jmBkSHbDW.6M0bhPNzSqLMCfzV36zTzWQpYiSZ2tjmVYnnE_U0cae00t
 nxEEEp79dAqQnk2thG1vx2fdc_KzduR2J8g.z2a9JjOpHpu7WVx.EDa6Z6Myz6KkcD0InjdQulH4
 G6O0tC71YivHWtixxOVKnemb6SFkJQ5sXf8eT7CzovCq1CZIcfNnyU14f7xUm46yyft8cCnNIM8X
 1Bkdrwg14UxMm4tC_TTYzb7AYDJOW3b6Qpw1JhI8EECZ8bHKXwW2kf1pl_taaz5daQqu4NnkWfb5
 Po.W0bSCQx.Dtm4xLuRUqXw2Z_QiEikHtIpoKvPnYGUO4Yw2haKkBRAFzfyd07rE.Wg2xh2O9JKr
 nijkMpMV3vge7_VQUgO3LBC2Z9XBk9wtpFeUD6g4hBsY4JdY5qgVYbrOS5brOuLbIJw4tqF9kN00
 JD2SXqbMWKSFFJFccoXprb2nujtBRf6qOaEb06C1aEjBgx27GSPDnmYRmJhw0YXcvFW5xcr5_UBv
 hpJkSGG0miHj5H4bBbHMvqzWhU58BBd1SpE.wPpxiVbznYhxYiI4BfkiUlDJ6HMKgENeuJoRkPtg
 B9IPdpviqlUArgySkmhX6AvZXZABmmJyzPWCilzR8i4MVdMI6QXzsdy72J0DRZzLEljfqPKjAl5V
 SbDlTfCmPGrb.37KBNcRyHd2NMp0EJbuX2464nVtN1NwI8mfbXuERpnYU0Vz7gWgamwsDGvfPSoJ
 rEkwKdBZKMfVJ8h8iU64nK6a0a8r0VSDJF87xaumERIkmpfrpIT4d3ykIMzbtU4USF42dO_cFEvZ
 xvORchoePnuimayJpeoH.UverCZGSLJnhClFvx.yJk0nzaEPpjT0-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sun, 21 Mar 2021 18:32:44 +0000
Received: by kubenode506.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 4ad1b36e7e2e8805f0c9a4fae9f83cf7; 
 Sun, 21 Mar 2021 18:32:40 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: complete a missing case for inplace I/O
Date: Mon, 22 Mar 2021 02:32:27 +0800
Message-Id: <20210321183227.5182-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210321183227.5182-1-hsiangkao.ref@aol.com>
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

Add a missing case which could cause unnecessary page allocation but
not directly use inplace I/O instead, which increases runtime extra
memory footprint.

The detail is, considering an online file-backed page, the right half
of the page is chosen to be cached (e.g. the end page of a readahead
request) and some of its data doesn't exist in managed cache, so the
pcluster will be definitely kept in the submission chain. (IOWs, it
cannot be decompressed without I/O, e.g., due to the bypass queue).

Currently, DELAYEDALLOC/TRYALLOC cases can be downgraded as NOINPLACE,
and stop online pages from inplace I/O. After this patch, unneeded page
allocations won't be observed in pickup_page_for_submission() then.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
v1: https://lore.kernel.org/r/20201022145724.27284-4-hsiangkao@aol.com

This is a follow-up of previous patch, which can tolerate ro_fsstress
now. The principle is that DELAYEDALLOC/TRYALLOC with new managed pages
indicate that I/O is needed so no needed to downgrade to NOINPLACE
as mentioned in the commit message.

Post it independently rather than mixed in the upcoming bigpcluster
patchset thus make it easier for users to decide to backport or not.

 fs/erofs/zdata.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 7ab8a4e3dfcb..cd9b76216925 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -104,6 +104,12 @@ enum z_erofs_collectmode {
 	 * |_______PRIMARY_FOLLOWED_______|________PRIMARY_HOOKED___________|
 	 */
 	COLLECT_PRIMARY_HOOKED,
+	/*
+	 * a weak form of COLLECT_PRIMARY_FOLLOWED, the difference is that it
+	 * could be dispatched into bypass queue later due to uptodated managed
+	 * pages. All related online pages cannot be reused for inplace I/O (or
+	 * pagevec) since it can be directly decoded without I/O submission.
+	 */
 	COLLECT_PRIMARY_FOLLOWED_NOINPLACE,
 	/*
 	 * The current collection has been linked with the owned chain, and
@@ -186,21 +192,25 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 
 		if (page) {
 			t = tag_compressed_page_justfound(page);
-		} else if (type == DELAYEDALLOC) {
-			t = tagptr_init(compressed_page_t, PAGE_UNALLOCATED);
-		} else if (type == TRYALLOC) {
-			newpage = erofs_allocpage(pagepool, gfp);
-			if (!newpage)
-				goto dontalloc;
-
-			set_page_private(newpage, Z_EROFS_PREALLOCATED_PAGE);
-			t = tag_compressed_page_justfound(newpage);
-		} else {	/* DONTALLOC */
-dontalloc:
-			if (standalone)
-				clt->compressedpages = pages;
+		} else {
+			/* I/O is needed, no possible to decompress directly */
 			standalone = false;
-			continue;
+			switch (type) {
+			case DELAYEDALLOC:
+				t = tagptr_init(compressed_page_t,
+						PAGE_UNALLOCATED);
+				break;
+			case TRYALLOC:
+				newpage = erofs_allocpage(pagepool, gfp);
+				if (!newpage)
+					continue;
+				set_page_private(newpage,
+						 Z_EROFS_PREALLOCATED_PAGE);
+				t = tag_compressed_page_justfound(newpage);
+				break;
+			default:        /* DONTALLOC */
+				continue;
+			}
 		}
 
 		if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
@@ -214,7 +224,11 @@ static void preload_compressed_pages(struct z_erofs_collector *clt,
 		}
 	}
 
-	if (standalone)		/* downgrade to PRIMARY_FOLLOWED_NOINPLACE */
+	/*
+	 * don't do inplace I/O if all compressed pages are available in
+	 * managed cache since it can be moved to the bypass queue instead.
+	 */
+	if (standalone)
 		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
 }
 
-- 
2.20.1

