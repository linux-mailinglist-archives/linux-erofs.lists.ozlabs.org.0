Return-Path: <linux-erofs+bounces-519-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC620AF90F1
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Jul 2025 12:53:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYVqC5HCqz30gC;
	Fri,  4 Jul 2025 20:53:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751626407;
	cv=none; b=m1r/SmDt9BzHH+BCn6M4YUfWnhzC04jV0QPFH2KTlw5y4IiGrveA/TpEC4MBpvC7CBlxlKghcXeLViXmSdSV8mmXacNSDkYCZstJpGOd7l5yTHt/XwKa6JA0KseY8ZNkXImjOwAo2NKqvkETyfJCAvyTTC1qkUMsKbAvPgDtec2wA3rpd0/2kBTH4K8d6NZG/JVR6blmlBB29puKMG0e4jS/sVlANxRYOATgCToJSLMsqyFwfC1dl8iAPF6Hr11b0ezEiGNW/x5XKWViiK3V2E350iJ+AtPmeXV52XjqLcTLuyzOVaZYYtGyrTxRhafX4fEkYT8ksiDgw+WYl2Zq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751626407; c=relaxed/relaxed;
	bh=TYUfGgVQKxjeNoqTBMQyIM1QXOFI8iFSnNKeX8Ix47s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CcI2JdD2yzujo+GQZmOMDcM1pLaEBpPVvEalO+cNA3nC4yo78SMVdPX/gdkh+rjTi08o4UQQB+MMK9XWr+GGWJJ9fzmfR6xJ17E0dPm4+Ls0M122qENqVqcxPrNwUNe9VGsKCoU0A4g1u/bja7lotk/FRIAkIHNIeaPF+oX5MSSflJe/anGqmsPLsS2LSGZRGfiWt2f2UNQGNGumfNdnrvpdl97HKMr9x0ZWm1oP1p0iU6wfgvfUSsaEeIn9GVCIcLLwUZDXPo8b1sITHN82vzLymdGWK5YmeUJUerP9iqqsjHc6JNPu6/CSUfecw6CO9Jwf6Gltq7+sUITF1SE6tQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EM6oywZ8; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=andrew.goodbody@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EM6oywZ8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=andrew.goodbody@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYVq95Cngz30Wn
	for <linux-erofs@lists.ozlabs.org>; Fri,  4 Jul 2025 20:53:24 +1000 (AEST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so8746335e9.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 04 Jul 2025 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751626399; x=1752231199; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYUfGgVQKxjeNoqTBMQyIM1QXOFI8iFSnNKeX8Ix47s=;
        b=EM6oywZ8ddUEmj8+RBb9JPxum9ygjCIg5dviiiomSBzQ8io7gxpgIf66kC9iSAGpGe
         xME6+kVyV2Wfbayea4WY4A52Ig9qmzTZ/JBAewXaLu1CZyWxpacVkVS8CmPplfP26hN1
         PgLcQp7sgF2rYYV6k9eOLmCpwly5bpVyDF3yGjpW0ELGhBshwj6duGtn5AvQqxwaC8sw
         C5BNUjQiy5RAqBaX6mGWZiAZeBbF4//xkc4cGXXaxj0+lRjlb491utez3pfo2m9OSt+k
         uVL3rReYrbxP/xMZ+nOKkVqHE7WhmbM6tkptYJ3tlmKwiykkFQcNt2kjJGLLUKnVUMZj
         UbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751626399; x=1752231199;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYUfGgVQKxjeNoqTBMQyIM1QXOFI8iFSnNKeX8Ix47s=;
        b=ix/X+IA4LsWzRrUQE74QhP6xzHr+ZdqU97iG/eo9d4mO1T8bW9WfUuNgw/aOmjb+V/
         Em5s38fJJqR8iFB6ND3k6iqutY5WMVHdH5SL0Pzw8mpef70PtOVIqV0hrsCdNYdpxPaN
         RwOv3UjX6SYsyT4+GcFCCNttoZsxw2q/wZr1OS3n/nCf9HzYsrIInBedxVQYn3ZA30Mg
         dvYnrZQCiC3KqoK8X6t0S9v2hIa24UvJf6E0amOVd8xGsUI44IERqjwvZONNfsdgJfjf
         Mu5UD3AHCQo16nxUiJs1weUzojVqsy9NPAkzt8dzBkvZeZ+C69Xb24BtlGcsSAYQNaJD
         oNug==
X-Gm-Message-State: AOJu0YzmF51D3hpO2L8zZlrKLt9IdvIUFzdqa7Q7yxBQIhuVz5lLF0iP
	uKJ21krEoNsbhXkbfaeeBUpKktwSzkZMwHpRoi3g+0XzyDdz6xyawO1onfDeWzhUOWQq/A5YZjr
	6DWOy
X-Gm-Gg: ASbGncvYrcAZWKx8/fk2mygITR0YmbTYTFKb2wE2jqsbwCSYphWQBEp3ljxMw6Zys8A
	YLOTjQoNvb+VLVFVne9gkNRkuptS5/kcAU3beEpcDmt74QWk4TMH5GmANDHvet3ouzck9AbR3hP
	h4DAWUyYESQOVfwB9uygyx5QwGW3677LRtb58ZZMB3UoWcbIeKkDt7tQg//15/DvP8wCCUSACix
	RTT0KZ5nPqPbunreuRHx1Fx4L7DwSwwH2TqPYUO6OmC4NNGugHW+Wfvxo68FJ/epuhwZ9DGYdHC
	j2PzjUoyIFd3yWOiZYTNS9YXgOeoVwU5Jeas1rqlh7opMgbaMsxQtJ2DJEZ2Fmo5ikOMYzwkQkE
	4PbiT+j53EPjotw==
X-Google-Smtp-Source: AGHT+IHumStWARKzwTLDqj3gsQQkKaFeOVDjsrI8sZ0pzfL6/B1IPNJbdgB3aKVC5ZDfDADStvqK9g==
X-Received: by 2002:a05:600c:5292:b0:453:6146:1172 with SMTP id 5b1f17b1804b1-454b4e6e64dmr18293705e9.3.1751626399055;
        Fri, 04 Jul 2025 03:53:19 -0700 (PDT)
Received: from artemis2.elfringham.co.uk ([2a0a:ef40:e07:801:2854:bc73:8076:c06f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997e367sm51506035e9.15.2025.07.04.03.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 03:53:18 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 04 Jul 2025 11:53:18 +0100
Subject: [PATCH] fs: erofs: Do NULL check before dereferencing pointer
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-erofs_fix-v1-1-956be16f32e9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJ2yZ2gC/x2N0QpAQBBFf0XzbGsJi1+RtNYs82BpRlLy75bH0
 z2ne4MgEwq0yQ2MJwltIUKWJuAWG2ZUNEWGXOelNrpQyJuXwdOljHFTrRvTOF9B9EcrqEa2wS1
 fsVo5kL9hZ4z+f9L1z/MC91MXfnQAAAA=
To: Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

The assignments to sect and off use the pointer from ctxt.cur_dev but
that has not been NULL checked before this is done. So instead move the
assignments after the NULL check.

This issue found by Smatch

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/erofs/fs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
index dcdc883e34c..db86928511e 100644
--- a/fs/erofs/fs.c
+++ b/fs/erofs/fs.c
@@ -11,12 +11,15 @@ static struct erofs_ctxt {
 
 int erofs_dev_read(int device_id, void *buf, u64 offset, size_t len)
 {
-	lbaint_t sect = offset >> ctxt.cur_dev->log2blksz;
-	int off = offset & (ctxt.cur_dev->blksz - 1);
+	lbaint_t sect;
+	int off;
 
 	if (!ctxt.cur_dev)
 		return -EIO;
 
+	sect = offset >> ctxt.cur_dev->log2blksz;
+	off = offset & (ctxt.cur_dev->blksz - 1);
+
 	if (fs_devread(ctxt.cur_dev, &ctxt.cur_part_info, sect,
 		       off, len, buf))
 		return 0;

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250704-erofs_fix-77cd80979cf6

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


