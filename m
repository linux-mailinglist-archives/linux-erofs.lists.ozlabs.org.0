Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE72290F07
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:18:06 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrrW3hGfzDqTN
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:18:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911883;
	bh=bfGMDWWtYzsrS9JPdWAj3Fzyn2YMuP8s/aBTlrdAFvU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CtrfOfEH/288ZCvs6Kd4aPrCb3fHiAp1foIoN0662Q/FnKrUpvMrnF9k6y8ICjD7Z
	 pzZrcJ/5rM412KG4RuoOWhjiYkhIfs3q7ZNRBfbszTNotE8iNQZr8RC5g+5693omGe
	 qDi8WJxKhSvshB81D/ELQicbQpiHtKOi7Pn34G+s/2mDWhbO2u+RvjI0M3CE4v+piY
	 OzrNkJRP2zFZ3spsvIffkqLs/qPpiEjI4ayh+xekHKfD4wpRMLjs9i8to8wQQIAgMD
	 3G5uilv9jTOGL5A0TOQPbBCzTQMgN58NhQFxrCs2pt6YjVNyBaQhYyqAdTDtCioxSQ
	 LYHne6+CIIk3g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.84; helo=sonic314-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=Q7md0FSD; dkim-atps=neutral
Received: from sonic314-21.consmr.mail.gq1.yahoo.com
 (sonic314-21.consmr.mail.gq1.yahoo.com [98.137.69.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrrQ71k9zDqyd
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:17:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911875; bh=Di/hcjyyZvwswG2hqMBFktdESwkRoV98lY4hTgwdi2I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=Q7md0FSDa1rEhpmMtgKPRQH8/7Wlkbbw8Qhmbd+0ZOloQyVpDjFo6C1H7ngUw+hrlB5dzSQP1J98V2xpPr1WFpjz9RBj2nNRiF1SKqgIs1oU1YjKVLWEKm95q0DgTQmPaoodTVeGSxDi41PCNMavD5hmv/Q/6e652pwByiP+/Ggm6Nf92/ePmmeSBzxWXbnQ6073biBk8KIsqx/DTfguDLgmQTfiGR5i4QPTNJYJMr49lcZvF73ObxAP+EqS84/tRWCf322y5KoaTzFqGAOEAzPWTQr+WBU+kif89qwyfhqFXMCUsL7k9mhfYrHH7Rvg0xlvqw4qtFM+Bzs+6t3tbQ==
X-YMail-OSG: Zm9WITcVM1mFS8qOQmWReJxgyoqmP1fxUQD7uACgdbtuQftVVl4qD6MpJaS9YgI
 zm55raW3pNiZ5K0wmSXPQlSFDWXWSEzalKlU3fP5P70O2.VM_lDpWySaJzD_9g04pIS8CI2QIa43
 TYfFxvRIv5Qg4GHUKBsjO4ox58STmwuIn2rtACC9zPhDrA4gUt8bAn20ZspgL_nldmegDo4mURwG
 Ha0ptJoyELBAqe5otMT0SNc9dg3neLgEUlfhqo8vikxBOPplm7L_g_Iex8lUYq5Fz7Zfwll_YyXS
 QSPV0lBuOd5R3zzzN0JenLBEdk0uypd5UBuq1t2ECAPwyopRupZFscmv_Gus0dgdu96Sb1AGx.ak
 qRRnLu9qKPwevwTEc.wfFg9.lMDmJy42zee6QL_um4cOMgO4d2uWAtTSIlZqSTuauZMBco7n6o1k
 Oa8rf5LchVX5.HSeLq9wk5OPJ.6MrqsFYKwPn25wyb9c2W0P6Vbv8nxhtvD.ur0lZZUew1UH3mau
 Cot1a_oLm57bpQNnQqWHLn6s9Kqlwd0J1Ski2xDYrybQoLq6hBAnXtv54hgUCHJtKA8.PKhX_guy
 RsKzOGgOVrovOZ1LlSYUkMMZvHwNzsZHRxuBWJkmg135Ef6.JbqQmmhNkn4ChQRhyJGBxTKbsQJN
 L64a4x5ZDUHI2U8aQIJlMPluQ.q9yXNKXMSsopfOGwdE3EqkMYAOFXHOcmLUPb9FCAUksY_90dbU
 4zwYuhnwW9ZHsUek0xwsrD57dOZJyaJH.GgpiSDi0eu1IC2x.0yD0rQCJmVzPRagdJw3kj4A8KKc
 HAYZHmglc.Fl8wtohlNiflENqSx0iiIJX8Bk.TVgwnX.au2x7D3kxxauOUlUnAkAyh7P7dFO6BsE
 iza5ehk.fWOAmM.6aiDkVFGam25ekVgsgVSPbRKG1SKjUVTkApJ7wyN8DznxEq6L8G3RcExuUxB5
 J5IzJOp4NxnJL34.fQpmUe98OyWhmefkbgCspEMtII1rHpGzkGoLZGAllDMYzpdxxmVVzHXO1rew
 D9uEY7XaHWHDeuwDHXUWMeIuizQrk6TvJhAD1oHKSXAT2jcNavQzxHTNb35UmN6ds5dES_xtIqIE
 _bp5uuYrVM92Ik633wi4c_Y5Q88Vrueo5lXYS_v3u55Gl3O0ZH5DqeyjF5zZ4vkFTgbLEV.aRQUx
 6D2rKL5sU7kcvFsiqvS1WXCggezZUNELCZIvy.E6Cuh_xeS5pfONlEGINQ05Pz4g5QWB0tasX19w
 eKVE6uBuMFI3ZauLh5P2tdNriRhEOlD4.201JuBMuJzr1jVIHktXpw_xoqgDlBPojmbYkSAp4cEj
 joU4hiyPfs_cd7TILHRW5niS25gFT0u.4y4BFCG8RrvfcChzp9dEL8pg42KbKFvOnDXH8669GqQm
 TgA1NfM7Euo6lH78191sLkRbNMw1iV3P.CL1u25mERcZu5ADu.H35Vnlsp487c.z2yx60ugrsl.c
 1kArbePeilj1NSruPTIMblXftZGQYjwTlBCoN7JhO6xFWQvjX
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:17:55 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:17:52 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 06/12] erofs-utils: fuse: drop ofs_out
Date: Sat, 17 Oct 2020 13:16:15 +0800
Message-Id: <20201017051621.7810-7-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[ let's fold in to the original patch. ]
Cc: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/decompress.c | 7 +++----
 fuse/decompress.h | 2 +-
 fuse/read.c       | 3 +--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fuse/decompress.c b/fuse/decompress.c
index e2df3cea78f7..4b7cf3211319 100644
--- a/fuse/decompress.c
+++ b/fuse/decompress.c
@@ -15,7 +15,7 @@
 
 static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq)
 {
-	char *dest = rq->out + rq->ofs_out;
+	char *dest = rq->out;
 	char *src = rq->in + rq->ofs_head;
 
 	memcpy(dest, src, rq->outputsize - rq->ofs_head);
@@ -26,7 +26,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq)
 static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
 {
 	int ret = 0;
-	char *dest = rq->out + rq->ofs_out;
+	char *dest = rq->out;
 	char *src = rq->in;
 	char *buff = NULL;
 	bool support_0padding = false;
@@ -66,8 +66,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
 
 	if (rq->ofs_head) {
 		src = dest + rq->ofs_head;
-		dest = rq->out + rq->ofs_out;
-		memcpy(dest, src, rq->outputsize - rq->ofs_head);
+		memcpy(rq->out, src, rq->outputsize - rq->ofs_head);
 	}
 
 out:
diff --git a/fuse/decompress.h b/fuse/decompress.h
index cd395c3d6b3f..5a3e2356dc1b 100644
--- a/fuse/decompress.h
+++ b/fuse/decompress.h
@@ -17,7 +17,7 @@ enum {
 struct z_erofs_decompress_req {
 	char *in, *out;
 
-	size_t ofs_out, ofs_head;
+	size_t ofs_head;
 	unsigned int inputsize, outputsize;
 
 	/* indicate the algorithm will be used for decompression */
diff --git a/fuse/read.c b/fuse/read.c
index 3f2e49c390de..06ca08587e7c 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -135,8 +135,7 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
-					.out = buffer,
-					.ofs_out = sum,
+					.out = buffer + sum,
 					.ofs_head = ofs,
 					.inputsize = EROFS_BLKSIZ,
 					.outputsize = count,
-- 
2.24.0

