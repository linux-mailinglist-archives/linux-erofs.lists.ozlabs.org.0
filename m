Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F7A96CED9
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 08:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725516047;
	bh=+FW4uWV3KsYQNjcmHOkTPMyGoi7nb0utfin/jBmQE9I=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=YPa6ukA8gTkUKgItpo7uCxVYAJ6Ra80AZu/b3mo2VbLVI1UaJ5dYbGPXnNJbYpyRw
	 mzTa2HTlhtwjYGUW8VcZrhiuia6f3HpKgiHirhjK5Y0aZAETxiwy+NLTmdrndaEC1X
	 CFvpS3H2b0dZQsQSzWpfIV0q6XZi/HOjcw0XYB28SrXxZI6WvxfWNbcJc1TkAtjtrA
	 egKLIArG3C2vaVQnfTs0adg1dK92x/ArgJF6Mo8ueGW8pUce8BhBFges+eGVoD7RsC
	 /f8ZzgsRBW86bnX69thx2xu/57z8X7Z32uBHWwQ4adGPaIUaVcHwaZW6CJw9R6V5YG
	 TyXVrGMJm4iCQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wzpcv3TDcz2ysZ
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 16:00:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b49"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725516045;
	cv=none; b=IdZ8iLYu6f+DM8N9WlQPc/gy048flUQP3kNKcXeBm1zS49YB6NxhdperDmqxneLsCE+H6LVj50M0Dg32u7eSpdwHFxAYgpRz++4ZzEtedEWKwhtDCDg/EabaC07OQbqIM2dHAUFdzSHeBaBMXLszdi5+UBLRn7gsko4TCrz9K5cRPUvajkbGMNfb6GuJGYEEfbHq1wtvsryEaWEnQmdDAEVxL3woGginlp/0jHCRw31cgwf44o0X+WreQoD1ZbCCiROiXbc+etTxGcx7JSSwxN/hPup08Ui1iIK/MfGEqKK3WufkgkT3q34WaDrX11hN5i3CGBQxv+FMRRfhOR0jWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725516045; c=relaxed/relaxed;
	bh=+FW4uWV3KsYQNjcmHOkTPMyGoi7nb0utfin/jBmQE9I=;
	h=DKIM-Signature:Date:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QAykiwWm/DuGzVmfrnt1MSLfhfSWnbjVApYoMDKaTPTHvb09i7MlUHjI7yhxkwR0SOItOlVB9F/NHv9x2hoTJ6SH2DiOK5Pk2WDAfXDhAid8GdmZgjg1ll8Lej8GJd49knBdpyxGbmOg+SqguxkppjGMYgFW4DDltsoynbN2doE/FCEYyqET4f5vmGxBGKJbBL2nm51k0NiHcX/U3ctZszMad7WCLC0sekuL8lX19TMdFWHE/peSE9c2E3VUAWM3/V5lh8XKDPrxtPwFAU5Hzwh8vdmhJSpanD1uhv+v3cPnUdTgqxvi4iTXNQ8kWMUXkH2lnxzBuBHZtShrFGhhJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=PbfGjb/v; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3bknzzgckczsaexsxibdlldib.zljifkru-bolcpifpqp.lwixyp.lod@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dhavale.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=PbfGjb/v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=3bknzzgckczsaexsxibdlldib.zljifkru-bolcpifpqp.lwixyp.lod@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wzpcs1DnCz2xr2
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 16:00:44 +1000 (AEST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-e163641feb9so1153157276.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Sep 2024 23:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725516039; x=1726120839; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+FW4uWV3KsYQNjcmHOkTPMyGoi7nb0utfin/jBmQE9I=;
        b=PbfGjb/vUWfPGmwmUO6b5jDo74aoWKEVPvXT/ghBGtQd6SKpFMrkFos1p1kcV2Y7yY
         XwixyeJf8YQrN9KB/aENni7nY6Y8tiKalOFIy6vmyY5/XgZ35EMLOXC+HCe2LgvYWTob
         9eaeJbk3pdkC4NHnZA7XJRq/vgUdz6NrrIkuz/A0eIGal6qaJzU1vKjr0+k5FdESZv+a
         hjYnDUwingRcXpLFjdxk1xeVEdjxTUEtoYIONv/udUS5+TI8Npf9yPRdnNokLsEFQc6N
         cvN7HaZjlo5aHd6g9cZnOK6hTqLwruczaB0cSdEwDrEw5whg1vMOjlsX1yKtMAT9fg7e
         5RHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725516039; x=1726120839;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FW4uWV3KsYQNjcmHOkTPMyGoi7nb0utfin/jBmQE9I=;
        b=VCW7BvrrcKCYH0OsDi7Q52L6QvQbhVdStHqHBZuAxD7kweCoogQPE6c2fvV0r5M3W/
         NB20kP+FhKy/rkNgFKEyAitonKqHJwKWfUMtrExHY6vnzTIZQb3TlJfJ6dEySUCot7oM
         EfrKSzpF/RlPJXKF7su7hhiL3BbUCWuc7WyAMlNZ8mnkL/ujX+tjMxhu9TFVit1VcIom
         QGcmpBx9UgqnOBqwlaanOtIYCVUZTnk41OX2/eDGWm+DZzkawxZl64qSL2ae5XAjo254
         Db7E04Yb+PY0JHZVddywS6ELToFWvXi1DlS65MSMBYIcSYnPcsfLi8qA0dan/B73dPw5
         ePqA==
X-Gm-Message-State: AOJu0YwdRu5G2WwAvJw6lvNpFIsUEACJiIyfIKn+YVZ432Ka2+65yAZp
	HyAZ+09alKo0sXTvThYnussHPXWlA+j1BeC9G9eLPT60YwLBPCBF+F+4D6s+Lzu1gJaroOnq47D
	h7YWCyC9H57tQ0SibgeoxMjo1rbE/AGSmMgIGLJ15VdEvqSHgbLrN4qZZLcMhY4QBpX+j0k92vj
	yUEJnXPaJCNg210hCOeJn+Lb94gEZZW7HV2afG2LRhWOCQcg==
X-Google-Smtp-Source: AGHT+IE6/jdtxwjYePtJa/mQtCjuubAXd488dazZCbWcyNhof90+G/ZC+ClSd80iROQFjFPidRmr5wz9iYxQ
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:8304:75e2:42b7:538d])
 (user=dhavale job=sendgmr) by 2002:a25:83d0:0:b0:e1a:7eff:f66b with SMTP id
 3f1490d57ef6-e1d108a6462mr49795276.5.1725516038160; Wed, 04 Sep 2024 23:00:38
 -0700 (PDT)
Date: Wed,  4 Sep 2024 23:00:25 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905060027.2388893-1-dhavale@google.com>
Subject: [PATCH v3] erofs: fix error handling in z_erofs_init_decompressor
To: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, liujinbao1 <liujinbao1@xiaomi.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

If we get a failure at the first decompressor init (i = 0),
the clean up while loop could enter infinite loop due to wrong while
check. Check the value of i now to see if we need any clean up at all.

Fixes: 5a7cce827ee9 ("erofs: refine z_erofs_{init,exit}_subsystem()")
Reported-by: liujinbao1 <liujinbao1@xiaomi.com>
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
v2: https://lore.kernel.org/linux-erofs/20240829122342.309611-1-jinbaoliu365@gmail.com/
v1: https://lore.kernel.org/linux-erofs/20240822062749.4012080-1-jinbaoliu365@gmail.com/

 fs/erofs/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..eb318c7ddd80 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -539,7 +539,7 @@ int __init z_erofs_init_decompressor(void)
 	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
 		err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
 		if (err) {
-			while (--i)
+			while (i--)
 				if (z_erofs_decomp[i])
 					z_erofs_decomp[i]->exit();
 			return err;
-- 
2.46.0.469.g59c65b2a67-goog

