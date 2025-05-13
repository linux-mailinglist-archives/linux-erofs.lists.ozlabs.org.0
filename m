Return-Path: <linux-erofs+bounces-310-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5CAB53E5
	for <lists+linux-erofs@lfdr.de>; Tue, 13 May 2025 13:35:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZxZCN5zzTz2ySl;
	Tue, 13 May 2025 21:35:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747136112;
	cv=none; b=X1QSbR/20FzawjhbtWFF+JQoK4RV3qcLpifmMzxR1N9+dnD9Vq2iujXd1W+MS8iN80mTDZmYCiBTBKoEFaFeICfeP5Zq0Ah+iKeIiWGsTxwzB7pbKYju4iVmkKXtZcH5uQn8IExPUJgwkWo7UpBxUhqph0yrR+NTOc0oeD67ldQa9ObNFUBjC99eTsnZOkwWvw/CMuoOnduH4J3zHpgyxEwj2ISbQFo3uVcxd+yUDsXBq2C9X0Z6GurADSQXrnCqkmsB1740BRU8q6Y5l1PKZEyaVqan6KA+UrKF0j8t/hp7eezNv6zijnNjerFX86IaczxjPtX52Ih+/xBjvElRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747136112; c=relaxed/relaxed;
	bh=Jba4DpUGCtISxLwKnUHXPhnIZ5zAXzmBV6eVilHhqeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jISavb13nvuaqCvw+oisXZQKY77FIUmYl5i+CG43tiI052oSyqBI6cVZKqeG4Cv/9VPUbZwx7hdJ7y9TaMuZlGpjLDtDAWBkXgcj2rLalER2LG3iNic6D5RCyHqWxM2M3RVkbC0UsSzrXjqJwaEsDay5VUVBA0vJRAmjBx0Q/Qz8PLK3wJKO2wFT3ZDKAKW0ba4mcMilt83PGFNR1ozfbq3pVHeKUjY57rDIuhPVa4KlgGpIfVsy17VF883+uynR57MSpNRKekr6Rf70CYv3pKAobudA67T1T8btYSNfptH3d+kvwkQHKi9961UgdDb5Zq/OMp/orT3kqIHSzxBwSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nOYd1Snq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nOYd1Snq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434; helo=mail-pf1-x434.google.com; envelope-from=shengyong2021@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZxZCN0l1cz2xVq
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 May 2025 21:35:11 +1000 (AEST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-74019695377so4009110b3a.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 May 2025 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747136110; x=1747740910; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jba4DpUGCtISxLwKnUHXPhnIZ5zAXzmBV6eVilHhqeM=;
        b=nOYd1Snqta4QHD7hQb870bNFsQVYLb4lZRUBZC5Gk5JuNgZ/9hEEhK7u4w/WCDHOBa
         jqLYeD8Pefu7Tghsv/EnDKHWvnhtEtBG7bjtlI46+9GQ2bTLEYr9nvb6jdaLojZRc++j
         UUziocjfXmXQv4Y9w/M6we2y1LtRSnHpCVFxacVsZEu90j9NsIU/ongpsLkuEvWtR938
         5Emg7yBwnchKGJ4WYUAwnff2AewjtUQLUlOrovwe4ii0oM4Q+j0XcFUfYaji4cV+VM6O
         7uHoDBaz2U7gBX5s7xPmP0F/EeVWE8EqdFH0yny5U0XCBGm8y1kFU4uBRKscoqpG/g/N
         9Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747136110; x=1747740910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jba4DpUGCtISxLwKnUHXPhnIZ5zAXzmBV6eVilHhqeM=;
        b=cwrY/EGx8smTgEMC2VlbFNcTkSI6CJqxbFoH5BRjf8D2rnyZIGHB1DsVEo2LAdO2Rj
         wkcI4F+laHc+aa1SjYwxyAKs4unz1al3xwSMvU77Tu2uPKjf3SzxrpbcDi+4vevTpYtH
         C1A50/xWT2j6cJbMXd3JsGAjdVEoBRLD+DKP7FKAUSLP0N7rGkGlLI2mXA66bTNf3/6D
         TpkiS+qqSWnuaFQg6c7ADy6zM+MWb96OOvGbN7Tz/wLSdSeynvO80raQGNZm7wRgPJv5
         KYYQnGuYY7n77dDV1RCBk3YuCSIxrRyVm2KZa6K4DwrNjkv4V6sB8DNQQXI9fd7wEKHK
         TwHA==
X-Gm-Message-State: AOJu0YziqgJhVdISSxUYqwTHQm9E5Co7xUCLZSr16X1gLDPkuobk8wvQ
	jh3fCyVPlI9ZdsyeCLoZoTjhnJtOfQ4NzYdjbeeCWgKwfUgS9d9R
X-Gm-Gg: ASbGnctdw7T8QtYWl2DkLTthSRgwz381uyfypMUGyVfBc/sfJiZkHUClyTBlMUrnBB5
	IIRKReqnmXCVmfSW4uQzNHOAKvK4FmR8KYsUBw3Oxh1hxv8Ar3O8AKv4lbrGhT7qEksjkuK3003
	qRXqCn2ZzdybhKrzmVRi7dK50d60HzrDY88uag1K1rEcD98ZyZYL5iwvTaio1sBsfE8tNAxhnHZ
	9EwtF4Faxn4oiaEnQQLxu7SCGuj619c3k9nl7jJ65/eb8qCljYExOhokbStCRZKzW9x8MP1xvVE
	+WOdfmj8YJomu28xZUViBAbZKT3qSCjyIuiwwORbjxmNLszToWvpeYwMhaaa2QG9Ps5g
X-Google-Smtp-Source: AGHT+IHCdscBhOcXBsxUDhzRpJcREkLLsgdZWgL+Nr1JdGlZsYaJTVL+8tpiLRbSQ+rssLLKgUJr5w==
X-Received: by 2002:a17:903:2443:b0:224:2a6d:55ae with SMTP id d9443c01a7336-22fc9185f7amr277714725ad.48.1747136109644;
        Tue, 13 May 2025 04:35:09 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc829f349sm78509185ad.217.2025.05.13.04.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 04:35:09 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	lihongbo22@huawei.com,
	dhavale@google.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>
Subject: [PATCH 2/2] erofs: avoid using multiple devices with different type
Date: Tue, 13 May 2025 19:34:18 +0800
Message-ID: <20250513113418.249798-2-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513113418.249798-1-shengyong1@xiaomi.com>
References: <20250513113418.249798-1-shengyong1@xiaomi.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: Sheng Yong <shengyong1@xiaomi.com>

For multiple devices, both primary and extra devices should be the
same type. `erofs_init_device` has already guaranteed that if the
primary is a file-backed device, extra devices should also be
regular files.

However, if the primary is a block device while the extra device
is a file-backed device, `erofs_init_device` will get an ENOTBLK,
which is not treated as an error in `erofs_fc_get_tree`, and that
leads to an UAF:

  erofs_fc_get_tree
    get_tree_bdev_flags(erofs_fc_fill_super)
      erofs_read_superblock
        erofs_init_device  // sbi->dif0 is not inited yet,
                           // return -ENOTBLK
      deactivate_locked_super
        free(sbi)
    if (err is -ENOTBLK)
      sbi->dif0.file = filp_open()  // sbi UAF

So if -ENOTBLK is hitted in `erofs_init_device`, it means the
primary device must be a block device, and the extra device
is not a block device. The error can be converted to -EINVAL.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 fs/erofs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 512877d7d855..16b5b1f66584 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -165,8 +165,11 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 				filp_open(dif->path, O_RDONLY | O_LARGEFILE, 0) :
 				bdev_file_open_by_path(dif->path,
 						BLK_OPEN_READ, sb->s_type, NULL);
-		if (IS_ERR(file))
+		if (IS_ERR(file)) {
+			if (PTR_ERR(file) == -ENOTBLK)
+				file = ERR_PTR(-EINVAL);
 			return PTR_ERR(file);
+		}
 
 		if (!erofs_is_fileio_mode(sbi)) {
 			dif->dax_dev = fs_dax_get_by_bdev(file_bdev(file),
-- 
2.43.0


