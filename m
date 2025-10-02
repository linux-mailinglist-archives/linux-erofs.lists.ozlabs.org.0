Return-Path: <linux-erofs+bounces-1154-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 55846BB227D
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Oct 2025 02:38:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccXvc0M4lz2ywC;
	Thu,  2 Oct 2025 10:38:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759365483;
	cv=none; b=h2KSPr8Y2lVvup+11lanNsMfVksEIhbk3oAFXpBUMcres695EjoOXCvnGRGbyWjolh1QrpoyZIFr4fUP6JwVwpjOrR4XZL5+Zy0a/xsd2pZ5SnDjVbqhSq71s9JDkhN/Bc4CikBwoQ69knwiugVRGoEuNpDgRPXKYZb3ABE3+zj3/TdoNY+gX701qOqDfS8aZWRO5SKhyHNTIFCP4KWEAh2DD3at5q5fiR4SQVWsmhUubduNhtI/CHIzkoM2gvwNbo1yt22YLtDyGW0AJ6JlFrRoWsO+qP88BAnuhQ5P8PjmoFNzT/OmF9BQMfm7rh3kH4BSTjEtdhuksiEnqnjAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759365483; c=relaxed/relaxed;
	bh=GAUupEuzVOMefeE52KqZR16H11/x7nMsRgJ0H2ZVsEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LnNQcdNz6Lao7M/1L93z6gXm4FNZOTd8fuM9fOX3nUasciPz1vn5Y4eRNwnWm2g7N2H6/RxqOJHbSbMFdk3Yvz3CozF9XTWi7QN83/9ApDUanzjRyc2FWYtofj5kYH/Pvv2F2O8w84N0ffvkkLWFRI0EQRzaNyo1ThkmKlfbqvZHGZ6/M/BpUSgz4wFewbwxKScbLuGTwVdXDNUik+jZiDf9R/bWEzaZMufuTWDnNIYwQFCXaOxxye04x68u7f0wfgXy17ZBEnBLiLK6aaLc1fcQ2Hv1sgtNXbDa+7HN7EHxy+QrHF4YMvnIs2ftpD/ehqoHuixZMq5P8sOG4FfoGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BGYYTGMh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=BGYYTGMh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccXvZ1962z2yr9
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Oct 2025 10:38:00 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759365477; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GAUupEuzVOMefeE52KqZR16H11/x7nMsRgJ0H2ZVsEw=;
	b=BGYYTGMhSdnnaA1LfWaFKf8nrC2FiOcHX9RcB30+V8xMNxIlMHB0sDtRECSdNVrntK6MT0yc/DCVf7/RJrOn/a+QE0vVq0BBD9/4OkSsmansB1v+dS4sZf+QdWTfl/64ZQRQNFdcg2CBF5AVfoLe7cWEL0WvLJzU93/mRIJsDdI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpGE1LH_1759365471 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Oct 2025 08:37:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix s->pos_in >= s->inlen case in kite_deflate_slow()
Date: Thu,  2 Oct 2025 08:37:50 +0800
Message-ID: <20251002003750.1125137-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Do not clear `s->prev_valid` if kite_deflate_tally() doesn't fit.

Reproducible input (base64-encoded gzipped blob):

H4sICJKM22gCA3R4AJyUR67cMAyG9zlFLqBRelunJ3cQVGibeLJkiNS00wd2ejwPILOb8n9i
/zFaaK3Uw/TQdmoWS8w9gfU0mxEKtJ8CEzzBYXrwl4o4RbM0SDAcpje7/7Dufj2/euFePDMZ
Sz+bsXQbkMlmDNFM4BM0Q+wb77gBPPcGdO8fhnGGF8+EAU+1JcIrCOXr2zI5XcjGBANJK69l
NKn2kAWPbwG4B1JIzR89yRjsGONe/fjpn2NLMGgR30ZpKy8LkEaLV7l+WwHN49a5YankWAnN
gdgzrJw62Itnauz9p6/vVIgaIG49sj5QrPUOwWF1Qy+RsRZ5MzeHcBlnoX7I1XNRiU2s81yL
JqFbRpYxSI3FIw/Zj6TQr6vUSeQt+vOxMdd451jPYFJS6/npEWiqhSlssNzYAigJvXTQoBcX
IGnfw4WBTn4Ryvtaj8EEhZEvsjUgyBBlbduJRXaAIwGrfWqHKaxnXYWjz/+L0gJRyC48NfBJ
dUobYWjyDZLZkcJgxrc4CTnPdcboTpjAxdoLQxORv5oyd4azDmmn9e53jM+5Ri9+anVLEwjW
YnXQ5tk3/LdhGVV7seabQb2+e+zPFL57+uFgYy0DbglBqwO5f78nCH0U2jnOsFNCa6UKU7+t
3UTSdzzN90i/DbkTgFBBuJsAUgYAYaNhPVkMAAA=

Test command line: ./kite-deflate foo 512 9

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/kite_deflate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
index 1b273a4..f9eb3fb 100644
--- a/lib/kite_deflate.c
+++ b/lib/kite_deflate.c
@@ -1111,7 +1111,7 @@ nomatch:
 static bool kite_deflate_slow(struct kite_deflate *s)
 {
 	struct kite_matchfinder *mf = s->mf;
-	bool flush = false;
+	bool flush = false, eos = false;
 
 	kite_deflate_startblock(s);
 	while (1) {
@@ -1163,20 +1163,20 @@ static bool kite_deflate_slow(struct kite_deflate *s)
 			s->prev_longest = matches;
 		}
 
-		s->lastblock |= (s->pos_in >= s->inlen);
-		if (s->pos_in >= s->inlen) {
+		eos = (s->pos_in >= s->inlen);
+		if (eos || s->symbols >= s->max_symbols) {
+			s->lastblock |= eos;
 			flush = true;
 			break;
 		}
-		if (s->symbols >= s->max_symbols) {
-			kite_deflate_endblock(s);
-			break;
-		}
 	}
 
-	if (flush && s->prev_valid) {
-		(void)kite_deflate_tally(s, mf->matches + s->prev_longest);
-		s->prev_valid = false;
+	if (flush) {
+		if (eos && s->prev_valid) {
+			if (!kite_deflate_tally(s, mf->matches + s->prev_longest))
+				s->prev_valid = false;
+		}
+		kite_deflate_endblock(s);
 	}
 	return kite_deflate_commitblock(s);
 }
-- 
2.43.5


